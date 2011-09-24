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

@synthesize managedObjectContext;

- (void)dealloc {
    [managedObjectContext release], self.managedObjectContext = nil;
    
    [super dealloc];
}

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
    
    self.managedObjectContext = context;
    
    CTTableViewDataSource *aDataSource = [[[CTTableViewDataSource alloc] initWithCTTableView:self] autorelease];
        
    self.dataSource = [aDataSource retain];
}

- (void)showAllObjectsNamed:(NSString *)objectName {
    
}

- (void)showAllObjectsMatchingPredicate:(NSPredicate *)predicate {
    
}

- (void)showAllObjectsNamed:(NSString *)objectName matchingPredicate:(NSPredicate *)predicate {
    
}

- (void)showAllObjectsNamed:(NSString *)objectName matchingPredicate:(NSPredicate *)predicate withSortDescriptors:(NSArray *)sortDiscriptors {
    
}

- (void)showAllObjectsNamed:(NSString *)objectName matchingPredicate:(NSPredicate *)predicate withSortDescriptors:(NSArray *)sortDiscriptors batchSize:(NSInteger)batchSize {
    
}

@end
