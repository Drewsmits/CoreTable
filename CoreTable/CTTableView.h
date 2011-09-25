//
//  CTTableView.h
//  CoreTable
//
//  Created by Andrew Smith on 9/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


@interface CTTableView : UITableView 

// Setup

- (void)setupWithManagedObjectContext:(NSManagedObjectContext *)context;

- (void)setupWithManagedObjectContext:(NSManagedObjectContext *)context andCacheName:(NSString *)cacheName;

// Show

- (void)showEntitiesNamed:(NSString *)entityName;

- (void)showEntitiesNamed:(NSString *)entityName matchingPredicate:(NSPredicate *)predicate;

- (void)showEntitiesNamed:(NSString *)entityName matchingPredicate:(NSPredicate *)predicate withSortDescriptors:(NSArray *)sortDiscriptors;

- (void)showEntitiesNamed:(NSString *)entityName matchingPredicate:(NSPredicate *)predicate withSortDescriptors:(NSArray *)sortDiscriptors batchSize:(NSUInteger)batchSize startingAtIndex:(NSUInteger)startingIndex endingAtIndex:(NSUInteger)endingIndex;

// Reload

- (void)reloadStartingAtIndex:(NSUInteger)index withFetchLimit:(NSUInteger)limit;

@end
