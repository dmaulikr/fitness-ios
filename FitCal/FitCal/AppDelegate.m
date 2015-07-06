//
//  AppDelegate.m
//  FitCal
//
//  Created by Prabhat Godse on 2/15/15.
//  Copyright (c) 2015 biodigital. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "FitnessDB.h"

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [FitnessDB getDB];
    [FitnessDB getDB];
    [FitnessDB getDB];
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    self.window.rootViewController = navVC;
    
    [self.window makeKeyAndVisible];
    return YES;
}

//- (void)setupCoreData {
//    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
//    if(coordinator != nil) {
//        _managedObjectContext = [[NSManagedObjectContext alloc] init];
//        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
//    }
//    /*
//    NSManagedObject *workout = [NSEntityDescription insertNewObjectForEntityForName:@"Workout" inManagedObjectContext:_managedObjectContext];
//    [workout setValue:@"10-10-10" forKey:@"sets"];
//    [workout setValue:@50.5 forKey:@"weight"];
//    [workout setValue:@"Bumbell Curls" forKey:@"workout_title"];
//    
//    NSError *error = nil;
//    if (![_managedObjectContext save:&error]) {
//        NSLog(@"FAILURE: %@", [error localizedDescription]);
//    }*/
//    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:self.managedObjectContext];
//    [fetch setEntity:entity];
//    
//    NSError *error = nil;
//    NSArray *fetchedArray = [_managedObjectContext executeFetchRequest:fetch error:&error];
//    for (NSManagedObject *obj in fetchedArray) {
//        NSLog(@"Weight: %@", [obj valueForKey:@"sets"]);
//    }
//}
//
//- (NSPersistentStoreCoordinator*)persistentStoreCoordinator {
//    if (_persistentStoreCoordinator != nil) {
//        return _persistentStoreCoordinator;
//    }
//    NSURL *soreURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Fitness.sqlite"];
//    NSError *error = nil;
//    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
//    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
//                                                       configuration:nil
//                                                                 URL:soreURL
//                                                             options:nil
//                                                               error:&error]) {
//        NSLog(@"Unable to create Fitness.sqlite");
//    }
//    return _persistentStoreCoordinator;
//}
//
//- (NSManagedObjectModel*)managedObjectModel {
//    if (_managedObjectModel != nil) {
//        return _managedObjectModel;
//    }
//    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"FitnessDB" withExtension:@"momd"];
//    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
//    return _managedObjectModel;
//}
//
///**Returns the file path for App's document directory. Where database can be stores
// */
//- (NSURL *)applicationDocumentsDirectory {
//    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
