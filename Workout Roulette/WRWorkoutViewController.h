//
//  WRWorkoutViewController.h
//  Workout Roulette
//
//  Created by Scott Biddle on 9/14/12.
//  Copyright (c) 2012 Bacon Wrapped Turtle Burgers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CloudMine/CloudMine.h>

@interface WRWorkoutViewController : UIViewController <MPMediaPickerControllerDelegate, UIAlertViewDelegate>

-(id) initWithCMStore:(NSArray*) workouts;
-(IBAction)selectPlaylist:(id)sender;

-(void) updateMediaQueueWithMediaCollection: (MPMediaItemCollection *) mediaItemCollection;
-(void) mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection;
-(void) mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker;

@end
