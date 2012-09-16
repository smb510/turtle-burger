//
//  WRWorkoutViewController.m
//  Workout Roulette
//
//  Created by Scott Biddle on 9/14/12.
//  Copyright (c) 2012 Bacon Wrapped Turtle Burgers. All rights reserved.
//

#import "WRWorkoutViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "WRExercise.h"
#import "RouletteViewController.h"
#import "MBProgressHUD.h"


@interface WRWorkoutViewController ()<UIAccelerometerDelegate>
{
    BOOL histeresisExcited;
    UIAcceleration* lastAcceleration;
}

@property (nonatomic, strong) UILabel* exerciseTitle;
@property (nonatomic, strong) UILabel* exerciseDescription;
@property (nonatomic, strong) UILabel* timer;
@property (nonatomic, strong) UIButton* done;
@property (nonatomic, strong) UILabel* count;
@property (nonatomic, strong) UIButton* play;
@property (nonatomic, strong) MPMusicPlayerController* musicPlayer;
@property (nonatomic, strong) MPMediaPickerController* mediaPicker;
@property (nonatomic, strong) NSArray* workout;
@property(nonatomic, strong) UIAcceleration* lastAcceleration;
@property (nonatomic, strong) NSNumber* workoutIndex;
@property (nonatomic, assign) NSInteger secondsRemaining;
@property (nonatomic, strong) NSTimer* timerCounter;
@property (nonatomic, strong) MBProgressHUD* hud;
@end

@implementation WRWorkoutViewController


@synthesize exerciseTitle, timer, done, musicPlayer, mediaPicker, workout, workoutIndex, count, secondsRemaining, timerCounter, hud, exerciseDescription, play;



-(id) initWithCMStore:(NSArray *)workouts
{
    self = [super init];
    if(self)
    {

        self.workout = workouts;


        [UIAccelerometer sharedAccelerometer].delegate = self;
        self.workoutIndex = [NSNumber numberWithInt:0];

    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
-(BOOL)canBecomeFirstResponder {
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWorkouts:) name:UpdateWorkoutsNotification object:nil];
    musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    UIView* musicWidget = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 320, 140)];
    MPMediaItem* nowPlaying = [musicPlayer nowPlayingItem];
    if (nowPlaying == nil)
    {
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Workout2.jpg" ]];
    }
    else 
    {
        MPMediaItemArtwork* artwork = [nowPlaying valueForProperty:MPMediaItemPropertyArtwork];
        UIImage* artWorkImage = [artwork imageWithSize: CGSizeMake (320, 420)];
        self.view.backgroundColor=[UIColor colorWithPatternImage:artWorkImage];
    }
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"playlist"] forState:UIControlStateNormal];
    //[button setTitle:@"Select Playlist" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(240, 0, 78, 78)];
    [button addTarget:self action:@selector(selectPlaylist:) forControlEvents:UIControlEventTouchUpInside];
    [musicWidget addSubview:button];
    //}
    //else
    //{
    UIButton* back = [UIButton buttonWithType:UIButtonTypeCustom];
    self.play = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton* forward = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    
    back.frame = CGRectMake(0, 0, 78, 78);
    [back setBackgroundImage:[UIImage imageNamed:@"stepback"] forState:UIControlStateNormal];
    [back setBackgroundColor:[UIColor clearColor]];
    //[back setTitle:@"back" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(skipPrevious) forControlEvents:UIControlEventTouchUpInside];
    
    play.frame = CGRectMake(80, 0, 78, 78);
    [play setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    //[play setTitle:@"play" forState:UIControlStateNormal];
    [play addTarget:self action:@selector(togglePlayPause) forControlEvents:UIControlEventTouchUpInside];
    forward.frame = CGRectMake(160, 0, 78, 78);
    //[forward setTitle:@"skip" forState:UIControlStateNormal];
    [forward setBackgroundImage:[UIImage imageNamed:@"stepforward"] forState:UIControlStateNormal];
    [forward addTarget:self action:@selector(skipNext) forControlEvents:UIControlEventTouchUpInside];
    
    [musicWidget addSubview:back];
    [musicWidget addSubview:play];
    [musicWidget addSubview:forward];
    //}
    
    
    self.view = [[UIView alloc] init];
    self.view.frame = CGRectMake(0, 0, 320, 480);
    
    
    self.
    done = [UIButton buttonWithType:UIButtonTypeCustom];
    done.frame = CGRectMake(60, 340, 200, 50);
    [done setBackgroundImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    //[done setTitle:@"Start" forState:UIControlStateNormal];
    [done addTarget:self action:@selector(nextWorkout:) forControlEvents:UIControlEventTouchUpInside];
    timer = [[UILabel alloc] init];
    if(workout.count > 0)
    {
        timer.text =[NSString stringWithFormat:@"%d:00", [[(WRExercise*)[self.workout objectAtIndex:workoutIndex.intValue] duration] intValue]];
    }
    [timer setFont:[UIFont systemFontOfSize:64.0f]];
    timer.frame = CGRectMake(0, 0, 320, 100);
    timer.textAlignment = UITextAlignmentCenter;
    UIView* titleContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 179, 320, 20)];

    exerciseTitle = [[UILabel alloc] init];

    [titleContainer addSubview:exerciseTitle];
   
    exerciseTitle.numberOfLines=0;
    exerciseTitle.text = [[self.workout objectAtIndex:workoutIndex.intValue] title];

    exerciseTitle.textAlignment = UITextAlignmentCenter;
    exerciseTitle.frame = CGRectMake(0, 0, 320, 30);
    
    exerciseDescription = [[UILabel alloc] initWithFrame:CGRectMake(0 , 199, 320, 150)];
    exerciseDescription.numberOfLines = 0;
    exerciseDescription.text = [[self.workout objectAtIndex:workoutIndex.intValue] description];
    [self.view addSubview:exerciseDescription];
    [self.view bringSubviewToFront:exerciseDescription];
    [self.view addSubview:musicWidget];
    [self.view addSubview:titleContainer];
    [self.view addSubview:done];
    [self.view addSubview:timer];
    [self.view setNeedsDisplay];
    self.count = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [count setText:[NSString stringWithFormat:@"%d of %d", self.workoutIndex.intValue + 1, self.workout.count]];
    [self.view addSubview:count];
    
    
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [ notificationCenter
     addObserver: self
     selector:@selector(handle_NowPlayingItemChanged:)
     name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification
     object: musicPlayer];
    [notificationCenter
     addObserver: self
     selector:@selector(handle_PlaybackStateChanged:)
     name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
     object:musicPlayer];
    [musicPlayer beginGeneratingPlaybackNotifications];
    
    [musicPlayer setQueueWithQuery: [MPMediaQuery songsQuery]];
    //[musicPlayer play];
    MPMusicPlayerController* ipodMusicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    
    [ipodMusicPlayer setShuffleMode: MPMusicShuffleModeOff];
    [ipodMusicPlayer setRepeatMode: MPMusicRepeatModeAll];
    if ([ipodMusicPlayer nowPlayingItem]) {
        //can update UI (artwork, song name, volume, etc.) to reflect ipod state
    }
    
    // Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)handle_PlaybackStateChanged:(NSNotification *) notification
{
    
}
-(void)handle_NowPlayingItemChanged:(NSNotification *) notification
{
    
}
-(IBAction)selectPlaylist:(id)sender
{
    mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    mediaPicker.delegate = self;
    [self presentModalViewController:mediaPicker animated:YES];
}

-(void) updateMediaQueueWithMediaCollection:(MPMediaItemCollection *)mediaItemCollection {
    [musicPlayer setQueueWithItemCollection:mediaItemCollection];
}

-(void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection{
    [self dismissModalViewControllerAnimated:YES];
    [self updateMediaQueueWithMediaCollection: mediaItemCollection];
}

-(void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        // your code
        [[NSNotificationCenter defaultCenter] postNotificationName:CreateWorkoutNotification object:self];
        self.hud= [[MBProgressHUD alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-200, self.view.bounds.size.height/2-25 , 400, 50)];
        hud.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"Creating new workout...";
        [self.view addSubview:hud];
        [hud show:YES];
        hud.removeFromSuperViewOnHide=YES;
        NSLog(@"detected shake!");
    }
}
-(void) updateWorkouts:(NSNotification *) notification
{
    self.workout=[notification.userInfo objectForKey:@"workout"];
    if(self.workout.count>0)
        exerciseTitle.text = [[self.workout objectAtIndex:0] description];
    [hud hide:YES];
    NSLog(@"getting new workout which equals %@",self.workout);
}
- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent {
    
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        
        switch (receivedEvent.subtype) {
                
            case UIEventSubtypeRemoteControlTogglePlayPause:
                [self togglePlayPause];
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack:
                [musicPlayer skipToPreviousItem];
                break;
                
            case UIEventSubtypeRemoteControlNextTrack:
                [musicPlayer skipToNextItem];
                break;
                
            default:
                break;
        }
    }
}

- (void) togglePlayPause {
    if (musicPlayer.playbackState == MPMusicPlaybackStatePlaying) {
        [musicPlayer pause];
        [self.play setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        
    } else {
        [musicPlayer play];
        [self.play setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
}
-(void) skipPrevious
{
    [musicPlayer skipToPreviousItem];
}
-(void) skipNext
{
    [musicPlayer skipToNextItem];
}


-(void) nextWorkout:(id) sender
{
    if([[sender backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"start"]])
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
        self.secondsRemaining = [[(WRExercise*)[self.workout objectAtIndex:workoutIndex.intValue] duration] intValue] * 60;
        self.timerCounter = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
        
        
    }
    else
    {
        [self.timerCounter invalidate];
        self.workoutIndex = [NSNumber numberWithInt:self.workoutIndex.intValue + 1];
        
        if (self.workoutIndex.intValue >= self.workout.count) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Workout Over" message:@"Great Job!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
            [alert show];
        }
        else
        {
            [count setText:[NSString stringWithFormat:@"%d of %d", self.workoutIndex.intValue + 1, self.workout.count]];
            /* Do "Advance workout" stuff */
            [sender setBackgroundImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
            timer.text =[NSString stringWithFormat:@"%d:00", [[(WRExercise*)[self.workout objectAtIndex:workoutIndex.intValue] duration] intValue]];
            [timer setFont:[UIFont systemFontOfSize:64.0f]];
            //timer.frame = CGRectMake(0, 0, 320, 100);
            timer.textAlignment = UITextAlignmentCenter;
            exerciseTitle.text = [[self.workout objectAtIndex:workoutIndex.intValue] title];
            exerciseDescription.text = [[self.workout objectAtIndex:workoutIndex.intValue] description];
            exerciseTitle.textAlignment = UITextAlignmentCenter;
            exerciseTitle.frame = CGRectMake(0, 100, 320, 60);
            
            
        }
    }
}

-(void) updateTimer:(NSTimer*) timerz
{
    self.secondsRemaining -= 1;
    if (self.secondsRemaining % 60 < 10) {
        self.timer.text =[NSString stringWithFormat:@"%d:0%d", (self.secondsRemaining / 60), self.secondsRemaining % 60 ];
    }
    else
    {
    self.timer.text =[NSString stringWithFormat:@"%2d:%2d", (self.secondsRemaining / 60), self.secondsRemaining % 60 ];
    }
    if(self.secondsRemaining == 0)
    {
        [timerz invalidate];
        
        [self.done setBackgroundImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
        
        self.workoutIndex = [NSNumber numberWithInt:self.workoutIndex.intValue + 1];
        [count setText:[NSString stringWithFormat:@"%d of %d", self.workoutIndex.intValue + 1, self.workout.count]];
        if (self.workoutIndex.intValue >= self.workout.count) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Workout Over" message:@"Great Job!" delegate:nil cancelButtonTitle:@"Dismiss:" otherButtonTitles: nil];
            [alert show];
        }
        else
        {
            /* Do "Advance workout" stuff */
            timer.text =[NSString stringWithFormat:@"%d:00", [[(WRExercise*)[self.workout objectAtIndex:workoutIndex.intValue] duration] intValue]];
            
            [timer setFont:[UIFont systemFontOfSize:64.0f]];
            //timer.frame = CGRectMake(0, 0, 320, 100);
            timer.textAlignment = UITextAlignmentCenter;
            exerciseTitle.text = [[self.workout objectAtIndex:workoutIndex.intValue] title];
            exerciseDescription.text = [[self.workout objectAtIndex:workoutIndex.intValue] description];
            exerciseTitle.textAlignment = UITextAlignmentCenter;
            //exerciseTitle.frame = CGRectMake(0, 100, 320, 60);
            

        /* run out of time here */
    }
}
}


-(void) showWorkoutInfo:(id)sender
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Workout Details" message:[(WRExercise*)[self.workout objectAtIndex:workoutIndex.intValue] description] delegate:nil cancelButtonTitle:@"Thanks for the info, bro!" otherButtonTitles: nil];
    [alert show];
        
    
}

-(void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
