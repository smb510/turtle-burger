//
//  RouletteViewController.m
//  Workout Roulette
//
//  Created by Kelsey Duncombe-Smith on 9/14/12.
//  Copyright (c) 2012 Bacon Wrapped Turtle Burgers. All rights reserved.
//

#import <CloudMine/CloudMine.h>
#import "RouletteViewController.h"
#import "MBProgressHUD.h"

#import "WRWorkoutViewController.h"
#import "WRWorkout.h"
#import "WRExercise.h"
#import "MBJSONRequest.h"

@interface RouletteViewController ()<UIPickerViewDelegate>
@property UIPickerView* timePickerView;
@property UIPickerView* workoutPickerView;
@end

@implementation RouletteViewController
@synthesize timePickerView,workoutPickerView;
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
    self.view.backgroundColor=[UIColor grayColor];
    float screenWidth=[UIScreen mainScreen].bounds.size.width;
    float screenHeight=[UIScreen mainScreen].bounds.size.height;
    timePickerView= [[UIPickerView alloc] initWithFrame:CGRectMake(screenWidth*.5-100, screenHeight*.15-50, 200, 100)];
    timePickerView.delegate=self;
    timePickerView.showsSelectionIndicator=YES;
    [self.view addSubview:timePickerView];
    workoutPickerView= [[UIPickerView alloc] initWithFrame:CGRectMake(screenWidth*.5-150, screenHeight*.5-25, 300, 50)];
    workoutPickerView.delegate=self;
    workoutPickerView.showsSelectionIndicator=YES;
    [self.view addSubview:workoutPickerView];
    [workoutPickerView selectRow:1 inComponent:0 animated:NO];
    [timePickerView selectRow:1 inComponent:0 animated:NO];
      
    
    UIButton * createWorkout=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    createWorkout.frame=CGRectMake(screenWidth*.5-50, screenHeight*.8, 100, 50);
    //createWorkout.backgroundColor=[UIColor blueColor];
    [createWorkout setTitle:@"Workout!" forState:UIControlStateNormal];
    [createWorkout addTarget:self action:@selector(createWorkout:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createWorkout];
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
-(IBAction) createWorkout:(UIButton *) sender
{
    
    NSString* timeParam =  [self pickerView:timePickerView titleForRow:[timePickerView selectedRowInComponent:0] forComponent:0];
    NSString* typeParam = [self pickerView:workoutPickerView titleForRow:[workoutPickerView selectedRowInComponent:0] forComponent:0];
    
    CMStore* store = [CMStore defaultStore];
    
    [store searchObjects:@"[type = \"Running\"]" additionalOptions:nil callback:^(CMObjectFetchResponse *response) {
        NSMutableArray* exercises = [NSMutableArray arrayWithArray:response.objects];
        NSMutableArray* workout = [NSMutableArray arrayWithCapacity:1];
        int running_time = 0;
        while (running_time <= [timeParam intValue] * 0.85f && exercises.count > 0) {
            int index = arc4random() % exercises.count;
            WRExercise* ex =  [exercises objectAtIndex:index];
            [workout addObject:ex];
            running_time += [ex.duration intValue];
        }
        WRWorkoutViewController* wvc = [[WRWorkoutViewController alloc] initWithCMStore:workout];
        [self presentModalViewController:wvc animated:YES];
        
    }];
    
    
    
   /* [store allObjectsWithOptions:nil callback:^(CMObjectFetchResponse *response) {
        NSLog(@"All objects");
    } ];*/
    
}
#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSUInteger numRows;
    if(pickerView==timePickerView)
    { 
        numRows=11;
    }
    else if(pickerView==workoutPickerView)
    {
        numRows=3;
    }
    else 
    {
        numRows=0;
    }
    
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    //title = [@"" stringByAppendingFormat:@"%d",row];
    if(pickerView==timePickerView)
    { 
        //Time options
        int time=10;
        time+=row*5;
        title=[NSString stringWithFormat:@"%d minutes",time];
    }
    else if(pickerView==workoutPickerView)
    {
        //Work out type
        NSArray * workoutTypes=[NSArray arrayWithObjects:@"Running",@"High Intensity Intervals",@"Core Strength", nil];
        title=[workoutTypes objectAtIndex:row];
    }
    else 
    {
        title=@"";
    }
    return title;
}


// tell the picker the width of each row for a given component
/*- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 140;
    
    return sectionWidth;
}*/
@end
