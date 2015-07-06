//
//  FitnessDB.m
//  FitCal
//
//  Created by Prabhat Godse on 7/4/15.
//  Copyright (c) 2015 biodigital. All rights reserved.
//

#import "FitnessDB.h"

@implementation FitnessDB

+ (FitnessDB*)getDB {
    static FitnessDB *fitness;
    if (fitness == nil) {
        fitness = [[FitnessDB alloc] init];
        [fitness setupCoreData];
    }
    return fitness;
}

- (void)setupCoreData {
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if(coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
}

- (void)saveContent {
    NSError *error = nil;
    if (![_managedObjectContext save:&error]) {
        NSLog(@"FAILURE: %@", [error localizedDescription]);
    }
}
- (NSPersistentStoreCoordinator*)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSURL *soreURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Fitness.sqlite"];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:soreURL
                                                         options:nil
                                                           error:&error]) {
        NSLog(@"Unable to create Fitness.sqlite");
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectModel*)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"FitnessDB" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

/**Returns the file path for App's document directory. Where database can be stores
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
