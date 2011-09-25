//
//  CTTableView.m
//  CoreTable
//
//  Created by Andrew Smith on 9/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CTTableView.h"
#import "CTTableViewDataSource.h"

@implementation CTTableView


//- (void)dealloc {    
//    [super dealloc];
//}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code        
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

#pragma mark - Public API

- (void)setupWithManagedObjectContext:(NSManagedObjectContext *)context {
    [self setupWithManagedObjectContext:context andCacheName:nil];
}

- (void)setupWithManagedObjectContext:(NSManagedObjectContext *)context andCacheName:(NSString *)cacheName {
    CTTableViewDataSource *aDataSource = [[[CTTableViewDataSource alloc] initWithManagedObjectContext:context] autorelease];
    aDataSource.cacheName = cacheName;
    
    self.dataSource = [aDataSource retain];
}

- (void)showEntitiesNamed:(NSString *)entityName {
    [self showEntitiesNamed:entityName matchingPredicate:nil withSortDescriptors:nil batchSize:NSNotFound startingAtIndex:0 endingAtIndex:NSNotFound];
}

- (void)showEntitiesNamed:(NSString *)entityName matchingPredicate:(NSPredicate *)predicate {
    [self showEntitiesNamed:entityName matchingPredicate:predicate withSortDescriptors:nil batchSize:NSNotFound startingAtIndex:0 endingAtIndex:NSNotFound];
}

- (void)showEntitiesNamed:(NSString *)entityName matchingPredicate:(NSPredicate *)predicate withSortDescriptors:(NSArray *)sortDiscriptors {
    [self showEntitiesNamed:entityName matchingPredicate:predicate withSortDescriptors:sortDiscriptors batchSize:NSNotFound startingAtIndex:0 endingAtIndex:NSNotFound];
}

- (void)showEntitiesNamed:(NSString *)entityName matchingPredicate:(NSPredicate *)predicate withSortDescriptors:(NSArray *)sortDiscriptors batchSize:(NSUInteger)batchSize startingAtIndex:(NSUInteger)startingIndex endingAtIndex:(NSUInteger)endingIndex {
    
    CTTableViewDataSource *theDataSource = (CTTableViewDataSource *)self.dataSource;
    
    NSAssert(theDataSource, @"TableView dataSource wasn't setup properly! You must use setupWithManagedObjectContext: or setupWithManagedObjectContext:andCacheName: to show entities!");
    
    theDataSource.entityName = entityName;
    theDataSource.predicate = predicate;
    theDataSource.sortDiscriptors = sortDiscriptors;
    
    if (batchSize != NSNotFound) {
        theDataSource.fetchBatchSize = batchSize;
    } else {
        // set a sane batch size. A batch size of 0 overrides
        // the batch size and effectivly becomes infinite, disabling
        // batch faulting.
        theDataSource.fetchBatchSize = 20;
    }
    
    theDataSource.fetchStartIndex = startingIndex;
    
    if (endingIndex != NSNotFound) {
        theDataSource.fetchLimit = endingIndex;
    }
    
    [theDataSource performFetch];
}

- (void)reloadStartingAtIndex:(NSUInteger)index withFetchLimit:(NSUInteger)limit {
    
    CTTableViewDataSource *theDataSource = (CTTableViewDataSource *)self.dataSource;
    
    NSAssert(theDataSource, @"TableView dataSource wasn't setup properly! You must use setupWithManagedObjectContext: or setupWithManagedObjectContext:andCacheName: to show entities!");
    
    [theDataSource reloadStartingAtIndex:index limit:limit];
}

@end
