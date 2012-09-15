//
//  WRAppDelegate.h
//  Workout Roulette
//
//  Created by Scott Biddle on 9/14/12.
//  Copyright (c) 2012 Bacon Wrapped Turtle Burgers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WRAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
