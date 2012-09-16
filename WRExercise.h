//
//  WRExercise.h
//  Workout Roulette
//
//  Created by Scott Biddle on 9/14/12.
//  Copyright (c) 2012 Bacon Wrapped Turtle Burgers. All rights reserved.
//

#import <CloudMine/CloudMine.h>

@interface WRExercise : CMObject

@property (nonatomic, strong) NSString* type;
@property (nonatomic, strong) NSNumber* duration;
@property (nonatomic, strong) NSString* description;
@property (nonatomic, strong) NSString* url;


-(id) init;

@end
