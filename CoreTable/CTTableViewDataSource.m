//
//  CTTableViewDataSource.m
//  CoreTable
//
//  Created by Andrew Smith on 9/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CTTableViewDataSource.h"

@implementation CTTableViewDataSource

@synthesize managedObjectContext, tableView, entityName, predicate, 
            sortDiscriptors, cacheName;

@synthesize fetchBatchSize, fetchStartIndex, fetchLimit;

- (void)dealloc {
    
    [managedObjectContext release], self.managedObjectContext = nil;
    
    fetchedResultsController.delegate = nil;
    [fetchedResultsController release];
        
    [entityName release], self.entityName = nil;
    [predicate release], self.predicate = nil;
    [sortDiscriptors release], self.sortDiscriptors = nil;
    [cacheName release], self.cacheName = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context {
    if (self = [self init]) {
        self.managedObjectContext = context;
    }
    return self;
}

#pragma mark - CTTableViewDataSource

- (void)performFetch {
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
}

- (void)reloadStartingAtIndex:(NSUInteger)startIndex withFetchLimit:(NSUInteger)limit {
    
    NSAssert(startIndex != NSNotFound, @"");    
    
    [self clearCache];
    
    [self.fetchedResultsController.fetchRequest setFetchOffset:startIndex];
    
    if (limit != NSNotFound) {
        [self.fetchedResultsController.fetchRequest setFetchLimit:limit];
    }
        
    [self performFetch];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}

- (BOOL)clearCache {
    if (self.cacheName) {
        [NSFetchedResultsController deleteCacheWithName:self.cacheName];
        return YES;
    } else {
        return NO;
    }
}

- (void)clearAllCaches {
    [NSFetchedResultsController deleteCacheWithName:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    // This gets hit first, grab the table here
    self.tableView = aTableView;
    
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"CellReuseIdentifier"];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:@"CellReuseIdentifier"] autorelease];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { 
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo name];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.fetchedResultsController sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [self.fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
        
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma mark -
#pragma mark Accessors

- (NSFetchedResultsController *)fetchedResultsController {
    if (fetchedResultsController) return [[fetchedResultsController retain] autorelease];
    
    NSAssert((self.entityName || self.predicate), @"CTTableViewDataSource must at least have an entityName or a predicate!");
    NSAssert(self.managedObjectContext, @"Nil managedObjectContext on CTTableViewDataSource!");
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    if (self.entityName) {
        NSEntityDescription *entity = [NSEntityDescription entityForName:self.entityName
                                                  inManagedObjectContext:self.managedObjectContext];
        
        [fetchRequest setEntity:entity];
    }

    [fetchRequest setPredicate:self.predicate];
    
    [fetchRequest setSortDescriptors:self.sortDiscriptors];
    
    [fetchRequest setFetchBatchSize:self.fetchBatchSize];
    
    // Play it safe
    if (self.fetchStartIndex != NSNotFound) {
        [fetchRequest setFetchOffset:self.fetchStartIndex];
    } else {
        [fetchRequest setFetchOffset:0];
    }
    
    if (self.fetchLimit != NSNotFound) {
        [fetchRequest setFetchLimit:self.fetchLimit];
    }
    
    fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
                                                                   managedObjectContext:self.managedObjectContext
                                                                     sectionNameKeyPath:nil 
                                                                              cacheName:self.cacheName];
    
    fetchedResultsController.delegate = self;
    
    [fetchRequest release];
    
    return [[fetchedResultsController retain] autorelease];    
}

@end
