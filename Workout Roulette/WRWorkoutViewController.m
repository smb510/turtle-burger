//
//  WRWorkoutViewController.m
//  Workout Roulette
//
//  Created by Scott Biddle on 9/14/12.
//  Copyright (c) 2012 Bacon Wrapped Turtle Burgers. All rights reserved.
//

#import "WRWorkoutViewController.h"

@interface WRWorkoutViewController ()

@property (nonatomic, strong) UILabel* exerciseTitle;
@property (nonatomic, strong) UILabel* timer;
@property (nonatomic, strong) UIButton* done;

@end

@implementation WRWorkoutViewController

@synthesize exerciseTitle, timer, done;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        done = [UIButton buttonWithType:UIButtonTypeCustom];
        done.frame = CGRectMake(60, 0, 200, 32);
        done.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"green paper"]];
        UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 32)];
        [title setText:@"Done"];
        title.textColor = [UIColor whiteColor];
        [done addSubview:title];
        timer = [[UILabel alloc] init];
        exerciseTitle = [[UILabel alloc] init];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:done];
    
    
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

@end
