//
//  CTTableViewDataSource.m
//  CoreTable
//
//  Created by Andrew Smith on 9/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CTTableViewDataSource.h"

@implementation CTTableViewDataSource

@synthesize tableView, entityName, predicate, sortDiscriptors;

- (void)dealloc {
    
    fetchedResultsController.delegate = nil;
    [fetchedResultsController release];
        
    [entityName release], self.entityName = nil;
    [predicate release], self.predicate = nil;
    [sortDiscriptors release], self.sortDiscriptors = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (id)initWithCTTableView:(CTTableView *)aTableView {
    if (self = [super init]) {
        self.tableView = aTableView;
    }
    return self;
}

- (void)performFetch {
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
}

#pragma mark - 
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[[self.object class] tableViewCellReuseIdentifier]];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:[[self.object class] tableViewCellReuseIdentifier]] autorelease];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (id)fetchedObjectAtIndexPath:(NSIndexPath *)indexPath {
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {    
    
}

#pragma mark -
#pragma mark Accessors

- (NSFetchedResultsController *)fetchedResultsController {
    if (fetchedResultsController) return [[fetchedResultsController retain] autorelease];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
    NSEntityDescription *entity = [NSEntityDescription entityForName:self.entityName
                                              inManagedObjectContext:self.tableView.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    [fetchRequest setPredicate:self.predicate];
    
    [fetchRequest setSortDescriptors:self.sortDiscriptors];
    
    [fetchRequest setFetchBatchSize:[self fetchRequestBatchSize]];
    
    fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
                                                                   managedObjectContext:self.tableView.managedObjectContext
                                                                     sectionNameKeyPath:nil 
                                                                              cacheName:[self fetchedResultsControllerCacheName]];
    
    fetchedResultsController.delegate = self;
    
    [fetchRequest release];
    
    return [[fetchedResultsController retain] autorelease];    
}

@end
