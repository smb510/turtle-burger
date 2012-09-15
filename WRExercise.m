//
//  WRExercise.m
//  Workout Roulette
//
//  Created by Scott Biddle on 9/14/12.
//  Copyright (c) 2012 Bacon Wrapped Turtle Burgers. All rights reserved.
//

#import "WRExercise.h"

@implementation WRExercise
@synthesize duration = _duration, type = _type, description = _description, url = _url;



-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_type forKey:@"type"];
    [aCoder encodeObject:_duration forKey:@"duration"];
    [aCoder encodeObject:_description forKey:@"description"];
    [aCoder encodeObject:_url forKey:@"url"];
    
    
}


-(id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _type = [aDecoder decodeObjectForKey:@"type"];
        _duration = [aDecoder decodeObjectForKey:@"duration"];
        _description = [aDecoder decodeObjectForKey:@"description"];
        _url = [aDecoder decodeObjectForKey:@"url"];
    }
    
    return self;
    
}

@end
