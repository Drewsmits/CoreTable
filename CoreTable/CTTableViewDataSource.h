//
//  CTTableViewDataSource.h
//  CoreTable
//
//  Created by Andrew Smith on 9/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CTTableView.h"

@protocol CTTableViewDataSource <UITableViewDataSource>

/**
 Perform the fetch with the fetchedResultsController
 */
- (void)performFetch;

/**
 Configures the cell with the object at that index path
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end

@interface CTTableViewDataSource : NSObject <CTTableViewDataSource, NSFetchedResultsControllerDelegate> {
@private
    CTTableView *tableView;
    NSFetchedResultsController *fetchedResultsController;
    
    NSString *entityName;
    NSPredicate *searchPredicate;
    NSArray *sortDiscriptors;
}

- (id)initWithCTTableView:(CTTableView *)aTableView;

@property (nonatomic, assign) CTTableView *tableView;
@property (nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, retain) NSString *entityName;
@property (nonatomic, retain) NSPredicate *predicate;
@property (nonatomic, retain) NSArray *sortDiscriptors;

@end
