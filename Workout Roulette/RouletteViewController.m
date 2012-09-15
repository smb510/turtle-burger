//
//  RouletteViewController.m
//  Workout Roulette
//
//  Created by Kelsey Duncombe-Smith on 9/14/12.
//  Copyright (c) 2012 Bacon Wrapped Turtle Burgers. All rights reserved.
//

#import "RouletteViewController.h"

@interface RouletteViewController ()<UIPickerViewDelegate>

@end

@implementation RouletteViewController

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
    float screenWidth=[UIScreen mainScreen].bounds.size.width;
    float screenHeight=[UIScreen mainScreen].bounds.size.height;
    UIPickerView* rouletteView= [[UIPickerView alloc] initWithFrame:CGRectMake(screenWidth*.5-100, screenHeight*.5-150, 200, 300)];
    rouletteView.delegate=self;
    rouletteView.showsSelectionIndicator=YES;
    [self.view addSubview:rouletteView];
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
#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = 5;
    
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    //title = [@"" stringByAppendingFormat:@"%d",row];
    switch(component)
    {
        case 0:
        {
            //Time options
            int time=10;
            time+=row*5;
            title=[NSString stringWithFormat:@"%@ minutes",time];
        }
            break;
        case 1:
        {
            //Work out type
            NSArray * workoutTypes=[NSArray arrayWithObjects:@"Running",@"High Intensity Intervals",@"Core Strength", nil];
            title=[workoutTypes objectAtIndex:row];
            
        }
            break;
    }
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 100;
    
    return sectionWidth;
}
@end
