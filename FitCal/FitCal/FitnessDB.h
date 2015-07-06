//
//  FitnessDB.h
//  FitCal
//
//  Created by Prabhat Godse on 7/4/15.
//  Copyright (c) 2015 biodigital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface FitnessDB : NSObject

/**Returns the singleton class of FitnessDB
 */
+ (FitnessDB*)getDB;
- (void)setupCoreData;

-(void)saveContent;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end
