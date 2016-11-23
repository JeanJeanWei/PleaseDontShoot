//
//  CreditViewController.m
//  PDntS
//
//  Created by JJ WEI on 12-09-21.
//  Copyright (c) 2012 Ice Whale Inc. All rights reserved.
//

#import "CreditViewController.h"

@implementation CreditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     [credit1 setFont:[UIFont fontWithName:@"SkippySharp" size:26.0]]; 
     [credit2 setFont:[UIFont fontWithName:@"SkippySharp" size:26.0]]; 
     [credit3 setFont:[UIFont fontWithName:@"SkippySharp" size:26.0]]; 
     [credit4 setFont:[UIFont fontWithName:@"SkippySharp" size:26.0]]; 
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)backClidked
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
