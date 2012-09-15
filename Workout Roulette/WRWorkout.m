//
//  WRWorkout.m
//  Workout Roulette
//
//  Created by Scott Biddle on 9/14/12.
//  Copyright (c) 2012 Bacon Wrapped Turtle Burgers. All rights reserved.
//

#import "WRWorkout.h"

@implementation WRWorkout

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [super initWithCoder:aCoder];
    [aCoder encodeObject:_duration forKey:@"duration"];
    [aCoder encodeObject:_exercises forKey:@"exercises"];
    
    
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    
    if(self = [super initWithCoder:aDecoder])
    {
        _duration = [aDecoder decodeObjectForKey:@"duration"];
        _exercises = [aDecoder decodeObjectForKey:@"exercises"];
    }
    
    return self;
}



@end
