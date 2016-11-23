//
//  SettingsViewController.m
//  PzDontShoot
//
//  Created by Jean-Jean Wei on 12-09-18.
//
//

#import "SettingsViewController.h"
#import "SetTimeViewController.h"
#import "HelpViewController.h"


@implementation SettingsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSettings];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadUserSettings
{
    //load settings
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile: [Com1 getPath]];
    
    int time = [[settings objectForKey:@"hour"] intValue]*60*60+[[settings objectForKey:@"min"] intValue]*60+[[settings objectForKey:@"sec"] intValue];
    
    [Com1 updateDigits1:time/3600 :h0 :h1 :0];
    [Com1 updateDigits1:(time/60)%60 :m0 :m1 :0];
    [Com1 updateDigits1:time%60 :s0 :s1 :0];

}


-(void) animate4 {
    int j;
    if (c4<5) {
        j=1;
    } else if (c4<15){
        j=c4-3;
    } else if (31-c4>11) {
        j=1;
    } else {
        j=31-c4;
    }
    NSString *t =[[NSString alloc] initWithFormat:@"timer%d",j];
    //  NSLog(@"bbbbbb%@",t);
    
 UIImage *img = [UIImage imageNamed:t];
    [setUptimer setImage:img forState:UIControlStateNormal];
//    
   

    
    t =[[NSString alloc] initWithFormat:@"BHMa%d",j];
        NSLog(@"bbbbbb%@",t);
    
    img = [UIImage imageNamed:t];
    [tab setImage:img forState:UIControlStateNormal];
    
    
    c4++;
    if (c4==31) {
        c4=0;
    } 
//    
//    //  c4++;
//      if (c4==15) {
//          t =[[NSString alloc] initWithFormat:@"BHMa%d",c4+1];
//         NSLog(@"bbbbbb%@",t);
//    
//     img = [UIImage imageNamed:t];
//        [tab setImage:img forState:UIControlStateNormal];
//           
//                 c4=0;
//      }
}
-(IBAction) goV3Pressed {
    if (t4 != nil) {
        [t4 invalidate];
        t4 = nil;
    }
    SetTimeViewController *setTimeViewController = [SetTimeViewController new];
    [self.navigationController pushViewController:setTimeViewController animated:YES];
  //  [self loadTimer];
    // remove v2 and add v3 with animation
//    [UIView beginAnimations:@"goV3" context:NULL];
//    [UIView setAnimationDuration:0.8];
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
//    [v2 removeFromSuperview];
//    [self.view addSubview:v3];
//    [UIView setAnimationDelegate:self];
//    [UIView commitAnimations];
//    t3 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(animate3) userInfo:nil repeats:YES];
}
//-(IBAction) backV2Pressed {
//    
//    if (t3 != nil) {
//        [t3 invalidate];
//        t3 = nil;
//    }
//    
//    [self saveTimer];
//    
//    NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile: [Com1 getPath]];
//    
//    //load from settings int value
//    
//    time = [[settings objectForKey:@"hour"] intValue]*60*60+[[settings objectForKey:@"min"] intValue]*60+[[settings objectForKey:@"sec"] intValue];
//    
//    [Com1 updateDigits1:time/3600 :h0 :h1 :0];
//    [Com1 updateDigits1:(time/60)%60 :m0 :m1 :0];
//    [Com1 updateDigits1:time%60 :s0 :s1 :0];
//
//    // remove v2 and add v3 with animation
//    [UIView beginAnimations:@"backV2" context:NULL];
//    [UIView setAnimationDuration:0.8];
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
//    [v3 removeFromSuperview];
//    [self.view addSubview:v2];
//    [UIView setAnimationDelegate:self];
//    [UIView commitAnimations]; 
//    
//    t4 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(animate4) userInfo:nil repeats:YES];
//}
-(IBAction) moreApps {
  //  NSString *iTunesLink = @"itms-apps://itunes.com/barrelmanappsinc/id457616557";
  //  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
  //  NSString *url = @"http://ax.search.itunes.apple.com/WebObjects/MZSearch.woa/wa/search?entity=software&media=all&page=1&restrict=false&startIndex=0&term=Barrel+Man+Apps+Inc.";
    NSString *url = @"https://itunes.apple.com/us/artist/barrel-man-apps-inc./id457616557?uo=4";
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    
}

-(IBAction) infoPressed {
    if (t4 != nil) {
        [t4 invalidate];
        t4 = nil;
    }
    HelpViewController *helpViewController = [HelpViewController new];
    [self.navigationController pushViewController:helpViewController animated:YES];
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.6];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
//    
//    [v2 removeFromSuperview];
//    
//    [UIView commitAnimations]; 
}



-(IBAction) d0Pressed {
    d = 0;
    [self clearCD];
    UIImage *img = [UIImage imageNamed:@"off-2.png"];
    [d0 setImage:img forState:UIControlStateNormal];
    
}
-(IBAction) d1Pressed {
    d = 1;
    [self clearCD];
    UIImage *img = [UIImage imageNamed:@"normal-2.png"];
    [d1 setImage:img forState:UIControlStateNormal];
}
-(IBAction) d2Pressed {
    d = 2;
    [self clearCD];
    UIImage *img = [UIImage imageNamed:@"large-2.png"];
    [d2 setImage:img forState:UIControlStateNormal];
}
-(void) clearCD {
  //  img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"off-1" ofType:@"png" inDirectory:nil]];
    [d0 setImage:[UIImage imageNamed:@"off-1"] forState:UIControlStateNormal];
    
  //  img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"normal-1" ofType:@"png" inDirectory:nil]];
    [d1 setImage:[UIImage imageNamed:@"normal-1"] forState:UIControlStateNormal];
    
  //  img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"large-1" ofType:@"png" inDirectory:nil]];
    [d2 setImage:[UIImage imageNamed:@"large-1"] forState:UIControlStateNormal];
    
}

-(IBAction) vi0Pressed {
    v = 0;
    [self clearVib];
  //  img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"off-2" ofType:@"png" inDirectory:nil]];
    UIImage *img = [UIImage imageNamed:@"off-2.png"];
    [vb0 setImage:img forState:UIControlStateNormal];
}
-(IBAction) vi1Pressed {
    v = 1;
    [self clearVib];
  //  img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"on-2" ofType:@"png" inDirectory:nil]];
    UIImage *img = [UIImage imageNamed:@"on-2.png"];
    [vb1 setImage:img forState:UIControlStateNormal];
}
-(void) clearVib {
    //   NSLog(@"clearVib");
  //  img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"on-1" ofType:@"png" inDirectory:nil]];
   // UIImage *img = [UIImage imageNamed:@"on-1.png"];
    [vb1 setImage:[UIImage imageNamed:@"on-1.png"] forState:UIControlStateNormal];
    
  //  img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"off-1" ofType:@"png" inDirectory:nil]];
  //  UIImage *img = [UIImage imageNamed:@"on-2.png"];
    [vb0 setImage:[UIImage imageNamed:@"off-1.png"] forState:UIControlStateNormal];
    
    // [vb0 setBackgroundImage:nil forState:UIControlStateNormal];
    // [vb1 setBackgroundImage:nil forState:UIControlStateNormal];
}

-(void) loadSettings {
    
    //load from settings int value
    
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile: [Com1 getPath]];
    d = [[settings objectForKey:@"display"] intValue];
    v = [[settings objectForKey:@"vib"] intValue];
    int time = [[settings objectForKey:@"hour"] intValue]*60*60+[[settings objectForKey:@"min"] intValue]*60+[[settings objectForKey:@"sec"] intValue];
    
    [Com1 updateDigits1:time/3600 :h0 :h1 :0];
    [Com1 updateDigits1:(time/60)%60 :m0 :m1 :0];
    [Com1 updateDigits1:time%60 :s0 :s1 :0];
    
    //    NSLog(@"Load----display=%d, vib=%d",d,v);
    
    switch (d) {
        case 0:
            [self d0Pressed];
            break;
            
        case 1:
            [self d1Pressed];
            break;
            
        case 2:
            [self d2Pressed];
            break;
            
        default:
            break;
    }
    
    if (v==0) {
        [self vi0Pressed];
    } else {
        [self vi1Pressed];
    }
    
}

-(void) saveSettings {
    NSString *p =[Com1 getPath];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:p];
    
    //here add elements to data file and write data to file
    
    [data setObject:[NSNumber numberWithInt:d] forKey:@"display"];
    [data setObject:[NSNumber numberWithInt:v] forKey:@"vib"];
    
    [data writeToFile:p atomically:YES];
    
}

-(IBAction) backPressed {
    if (t4 != nil) {
        [t4 invalidate];
        t4 = nil;
    }
    [self saveSettings];
   
    [self.navigationController popViewControllerAnimated:YES];

    //   [self showObj1];
 
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self loadSettings];
    if (self.navigationController.visibleViewController == self)
    {
        t4 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(animate4) userInfo:nil repeats:YES];
    }
}

@end
