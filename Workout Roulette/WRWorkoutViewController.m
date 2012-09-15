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
@property (nonatomic, strong) MPMediaPickerController* mediaPicker;

@end

@implementation WRWorkoutViewController

@synthesize exerciseTitle, timer, done, musicPlayer, mediaPicker;

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
        UIButton* back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        UIButton* play = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        UIButton* forward = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
        back.frame = CGRectMake(0, 0, 80, 32);
        play.frame = CGRectMake(0, 100, 80, 32);
        forward.frame = CGRectMake(0, 200, 80, 32);
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
    exerciseTitle.text = @"30 Situps";
    exerciseTitle.textAlignment = UITextAlignmentCenter;
    exerciseTitle.frame = CGRectMake(0, 100, 320, 60);
    [self.view addSubview:musicWidget];
    [self.view addSubview:exerciseTitle];
    [self.view addSubview:done];
    [self.view addSubview:timer];
    [self.view setNeedsDisplay];
    
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


- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent {
    
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        
        switch (receivedEvent.subtype) {
                
            case UIEventSubtypeRemoteControlTogglePlayPause:
                [musicPlayer togglePlayPause: nil];
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack:
                [musicPlayer previousTrack: nil];
                break;
                
            case UIEventSubtypeRemoteControlNextTrack:
                [self nextTrack: nil];
                break;
                
            default:
                break;
        }
    }
}

- (void) togglePlayPause {
    if (musicPlayer.playbackState == MPMusicPlaybackStatePlaying) {
        [musicPlayer pause];
    } else {
        [musicPlayer play];
    }
}

@end
