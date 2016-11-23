//
//  HelpViewController.m
//  PDntS
//
//  Created by JJ WEI on 12-09-21.
//  Copyright (c) 2012 Ice Whale Inc. All rights reserved.
//

#import "HelpViewController.h"
#import "CreditViewController.h"


@implementation HelpViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [howTo setFont:[UIFont fontWithName:@"SkippySharp" size:18.0]]; 
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)nextClidked
{
    CreditViewController *creditViewController = [CreditViewController new];
    [self.navigationController pushViewController:creditViewController animated:YES];
}
- (IBAction)backClidked
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
