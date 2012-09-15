//
//  WRWorkoutViewController.m
//  Workout Roulette
//
//  Created by Scott Biddle on 9/14/12.
//  Copyright (c) 2012 Bacon Wrapped Turtle Burgers. All rights reserved.
//

#import "WRWorkoutViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface WRWorkoutViewController ()

@property (nonatomic, strong) UILabel* exerciseTitle;
@property (nonatomic, strong) UILabel* timer;
@property (nonatomic, strong) UIButton* done;
@property (nonatomic, strong) MPMusicPlayerController* musicPlayer;
@property (nonatomic, strong) NSArray* workout;

@end

@implementation WRWorkoutViewController

@synthesize exerciseTitle, timer, done, musicPlayer, workout;


-(id) initWithCMStore:(NSArray *)workouts
{
   self = [super init];
    if(self)
    {
    self.workout = workouts;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    UIView* musicWidget = [[UIView alloc] initWithFrame:CGRectMake(0, 160, 320, 140)];
    MPMediaItem* nowPlaying = [musicPlayer nowPlayingItem];
    if (nowPlaying == nil)
    {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"Select Playlist" forState:UIControlStateNormal];
        [button setFrame:CGRectMake(0, 0, 320, 48)];
        [button addTarget:self action:@selector(selectPlaylist:) forControlEvents:UIControlEventTouchUpInside];
        [musicWidget addSubview:button];
        
    }
    else
    {
        UIButton* back = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton* play = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton* forward = [UIButton buttonWithType:UIButtonTypeCustom];
    
        
        
        back.frame = CGRectMake(0, 0, 80, 32);
        play.frame = CGRectMake(100, 0, 80, 32);
        forward.frame = CGRectMake(200, 0, 80, 32);
        back.backgroundColor = [UIColor blueColor];
        
        [musicWidget addSubview:back];
        [musicWidget addSubview:play];
        [musicWidget addSubview:forward];
    }
    
    
    self.view = [[UIView alloc] init];
    self.view.frame = CGRectMake(0, 0, 320, 480);
    done = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    done.frame = CGRectMake(60, 340, 200, 50);
    [done setTitle:@"Done" forState:UIControlStateNormal];
    timer = [[UILabel alloc] init];
    timer.text = @"00:00";
    [timer setFont:[UIFont systemFontOfSize:64.0f]];
    timer.frame = CGRectMake(0, 0, 320, 100);
    timer.textAlignment = UITextAlignmentCenter;
    exerciseTitle = [[UILabel alloc] init];
    exerciseTitle.text = [[self.workout objectAtIndex:0] description];
    exerciseTitle.textAlignment = UITextAlignmentCenter;
    exerciseTitle.frame = CGRectMake(0, 100, 320, 60);
    [self.view addSubview:musicWidget];
    [self.view addSubview:exerciseTitle];
    [self.view addSubview:done];
    [self.view addSubview:timer];
    [self.view setNeedsDisplay];
    
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

-(IBAction)selectPlaylist:(id)sender
{
    MPMediaPickerController* picker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    picker.delegate = self;
    [self presentModalViewController:picker animated:YES];
    
    
}

@end
