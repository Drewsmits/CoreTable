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

- (void)setupWithManagedObjectContext:(NSManagedObjectContext *)context andCacheName:(NSString *)cacheName {
    CTTableViewDataSource *aDataSource = [[[CTTableViewDataSource alloc] initWithManagedObjectContext:context] autorelease];
    aDataSource.cacheName = cacheName;
    
    self.dataSource = [aDataSource retain];
}

- (void)showAllEntitiesNamed:(NSString *)entityName {
    
}

- (void)showAllEntitiesNamed:(NSString *)entityName matchingPredicate:(NSPredicate *)predicate {
    
}

- (void)showAllEntitiesNamed:(NSString *)entityName matchingPredicate:(NSPredicate *)predicate withSortDescriptors:(NSArray *)sortDiscriptors {
    
}

- (void)showAllEntitiesNamed:(NSString *)entityName matchingPredicate:(NSPredicate *)predicate withSortDescriptors:(NSArray *)sortDiscriptors batchSize:(NSInteger)batchSize {
        
}
@end
