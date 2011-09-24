//
//  CTTableView.h
//  CoreTable
//
//  Created by Andrew Smith on 9/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


@interface CTTableView : UITableView {
@private
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)setupWithManagedObjectContext:(NSManagedObjectContext *)context;

- (void)showAllObjectsNamed:(NSString *)objectName;

- (void)showAllObjectsMatchingPredicate:(NSPredicate *)predicate;

- (void)showAllObjectsNamed:(NSString *)objectName matchingPredicate:(NSPredicate *)predicate;

- (void)showAllObjectsNamed:(NSString *)objectName matchingPredicate:(NSPredicate *)predicate withSortDescriptors:(NSArray *)sortDiscriptors;

- (void)showAllObjectsNamed:(NSString *)objectName matchingPredicate:(NSPredicate *)predicate withSortDescriptors:(NSArray *)sortDiscriptors batchSize:(NSInteger)batchSize;

@end
