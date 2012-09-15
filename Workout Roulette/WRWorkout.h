//
//  WRWorkout.h
//  Workout Roulette
//
//  Created by Scott Biddle on 9/14/12.
//  Copyright (c) 2012 Bacon Wrapped Turtle Burgers. All rights reserved.
//

#import <CloudMine/CloudMine.h>

@interface WRWorkout : CMObject

@property (nonatomic, strong) NSNumber* duration;
@property (nonatomic, strong) NSArray* exercises;

@end
