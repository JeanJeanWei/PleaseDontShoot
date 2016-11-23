//
//  StartupController.m
//  Common Framework
//
//  Created by Cyril MacDonald on 12-05-25.
//  Copyright (c) 2012 BNOTIONS. All rights reserved.
//

#import "StartupController.h"
#import "pk1ViewController.h"

@implementation StartupController

+ (StartupController*)instance
{
    static StartupController* instance = nil;
    
    if (!instance)
    {
        instance = [StartupController new];
    }
    
    return instance;
}

- (UIViewController*)startingViewController
{
     
    pk1ViewController *pkViewController = [pk1ViewController new];
    
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:pkViewController];
    [navigationController setNavigationBarHidden:YES];
 
    
    return navigationController;
}




@end
