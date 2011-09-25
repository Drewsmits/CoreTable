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
 * Perform the fetch with the fetchedResultsController
 */
- (void)performFetch;

/**
 * Reload the results with a new start and end index
 */
- (void)reloadStartingAtIndex:(NSUInteger)startIndex limit:(NSUInteger)limit;

/**
 * Configures the cell with the object at that index path
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

/**
 * Clears the cache named cacheName.  Will not clear if cacheName is nil.
 *
 * @see cacheName
 */
- (BOOL)clearCache;

/**
 * Clears all NSFetchedResultsController caches.
 *
 * @see clearCache
 */
- (void)clearAllCaches;

@end

@interface CTTableViewDataSource : NSObject <CTTableViewDataSource, NSFetchedResultsControllerDelegate> {
@private
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;
    
    UITableView *tableView;
    
    NSString *entityName;
    NSPredicate *searchPredicate;
    NSArray *sortDiscriptors;
    NSString *cacheName;
}

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, assign) UITableView *tableView;

@property (nonatomic, retain) NSString *entityName;
@property (nonatomic, retain) NSPredicate *predicate;
@property (nonatomic, retain) NSArray *sortDiscriptors;

// Fetch request
@property (nonatomic, assign) NSUInteger fetchBatchSize;
@property (nonatomic, assign) NSUInteger fetchStartIndex;
@property (nonatomic, assign) NSUInteger fetchLimit;

/**
 * The name of the cache the fetched results controller will use. If set, the controller
 * will use the cache to avoid the need to repeat work setting up sections and ordering fetched results.
 * The cache is maintained across launches of your application.  You can purge a cache with clearCache.
 * 
 * @see clearCache
 * @see clearAllCaches
 */
@property (nonatomic, copy) NSString *cacheName;

@end
