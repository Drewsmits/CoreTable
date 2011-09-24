//
//  CTTableView.h
//  CoreTable
//
//  Created by Andrew Smith on 9/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


@interface CTTableView : UITableView 

- (void)setupWithManagedObjectContext:(NSManagedObjectContext *)context andCacheName:(NSString *)cacheName;

- (void)showAllEntitiesNamed:(NSString *)entityName;

- (void)showAllEntitiesNamed:(NSString *)entityName matchingPredicate:(NSPredicate *)predicate;

- (void)showAllEntitiesNamed:(NSString *)entityName matchingPredicate:(NSPredicate *)predicate withSortDescriptors:(NSArray *)sortDiscriptors;

- (void)showAllEntitiesNamed:(NSString *)entityName matchingPredicate:(NSPredicate *)predicate withSortDescriptors:(NSArray *)sortDiscriptors batchSize:(NSInteger)batchSize;

@end
