//
//  DemoViewController.m
//  Scrubber
//
//  Created by Sunny Purewal on 12-09-13.
//  Copyright (c) 2012 Sunny Purewal. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

@synthesize scrubber;

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
    
    [scrubber setNumberOfAnchorPoints:8];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(void)scrubber:(ScrubberView *)scrubber didScrubToValue:(float)value
{
    NSLog(@"did scrub to value:%f",value);
}

-(void)scrubber:(ScrubberView *)scrubber didSelectIndex:(int)index
{
    NSLog(@"did select index:%d",index);
}

-(void)scrubberDidBeginScrubbing:(ScrubberView *)scrubber
{
    NSLog(@"begin scrubbing");
}

-(void)scrubber:(ScrubberView *)scrubber willSelectIndex:(int)index
{
    NSLog(@"will select index:%d",index);
}
@end
