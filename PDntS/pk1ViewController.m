
#import "pk1ViewController.h"
#import "SettingsViewController.h"
#import "BackgroundViewController.h"

@implementation pk1ViewController


@synthesize t1, t2, t5;
@synthesize soundFileURLRef, soundID;

//@synthesize img1;

#pragma mark -
#pragma animation delegate

- (void)animationDidStop:(NSString *)animID finished:(BOOL)didFinish context:(void *)context 
{
    if ( [animID isEqualToString:@"goV1"]) {
        //     NSLog(@"-----start");
        
        [self showObj1];
        
    } else if ( [animID isEqualToString:@"goV2"] ) {
        [self hideObj1];
        [self hideCountdown];
        
        //       NSLog(@"----fadeout");
    }
}

//------ setup sounds and vib ---------//
- (void) setupSound {
    
    int n = 1 + arc4random() % 3;
    gunNum = n;
    NSString *t =[[NSString alloc] initWithFormat:@"bangbang-%@",[[NSNumber numberWithInt:gunNum] stringValue]];
    
    // Create the URL for the source audio file. The URLForResource:withExtension: method is
    //    new in iOS 4.0.
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource:t withExtension: @"wav"];
    
    // Store the URL as a CFURLRef instance
    soundFileURLRef = (__bridge_retained CFURLRef) tapSound;
    
    // Create a system sound object representing the sound file.
    
    AudioServicesCreateSystemSoundID (soundFileURLRef, &soundID);
  //  NSLog(@"%@",t);
}

//------ END of setup sounds and vib ---------//





- (IBAction)settingsPressed {
 //   [self hideObj1];
   // [self loadSets];
   // [self goV2];
   // t4 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(animate4) userInfo:nil repeats:YES];
    [self hideObj1];
    SettingsViewController *settingsViewController = [SettingsViewController new];
    [self.navigationController pushViewController:settingsViewController animated:YES];
}
- (IBAction)pickBackgroundClicked 
{
    [self hideObj1];
    BackgroundViewController *backgroundViewController = [BackgroundViewController new];
    [self.navigationController pushViewController:backgroundViewController animated:YES];
}
//-(IBAction) backPressed {
//    if (t4 != nil) {
//        [t4 invalidate];
//        t4 = nil;
//    }
// //   [self showObj1];
//    
//    [self goV1];
//    [abort setAlpha:0];
//    
//}


-(IBAction)touchesBegan {
    
    timer_abort = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(showObj2) userInfo:nil repeats:YES];
    if (countDown != nil) 
    {     
        [countDown invalidate];
        countDown = nil;
    }
    img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"flash" ofType:@"png" inDirectory:nil]];
    [abort setBackgroundImage:img forState:UIControlStateNormal];
}

-(IBAction)touchesEnded {
    [abort setBackgroundImage:nil forState:UIControlStateNormal];
    if (timer_abort != nil) 
    {     
        [timer_abort invalidate];
        timer_abort = nil;
        countDown=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
   /* if (engaged==1&&aborted==0) {
        countDown=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
  */
}

-(IBAction)againBegan {
    
    timer_again = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(showObj1) userInfo:nil repeats:YES];
    if (countDown != nil) 
    {     
        [countDown invalidate];
        countDown = nil;
    }
    img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"flash-1" ofType:@"png" inDirectory:nil]];
    [again setBackgroundImage:img forState:UIControlStateNormal];
}

-(IBAction)againEnded {
    [again setBackgroundImage:nil forState:UIControlStateNormal];
    if (timer_again != nil) 
    {     
        [timer_again invalidate];
        timer_again = nil;
        
    }
   
}


-(IBAction)resumePressed {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.6];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseOut];
    
    [slideToAbort setAlpha:0];
    slideToAbort.frame = CGRectOffset(slideToAbort.frame, 0, -50);
    
    [self moveCountdown:-70];
    
    [l2 setAlpha:0];
    l2.frame = CGRectOffset(l2.frame, 0, -50);
    
    [abort setAlpha:0.8];
    if (d==0) {
        [self hideCountdown];
    }
    [UIView commitAnimations];
    
    [b1 setAlpha:0];
    
    countDown=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    if (t2 != nil) {
        [t2 invalidate];
        t2 = nil;
    }

}

-(IBAction)fadeLabel {
    
    if (engaged == 0) {
        l1.alpha = 1.0 - slideToEngage.value;
    }
	if (aborted == 0) {
         l2.alpha = slideToAbort.value;
    }
}

-(IBAction)engaging {
    
	
	if (engaged == 0) {
		
		
        
		if (slideToEngage.value ==1.0) {  // if user slide far enough, stop the operation	
            // Put here what happens when it is engaged
            			
            engaged = 1;
        //    aborted = 0;
       //     NSLog(@"engaged == 0");
			
            if (countDown == nil) {
                NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile: [Com1 getPath]];
                
                //load from settings int value
                d = [[settings objectForKey:@"display"] intValue];
                v = [[settings objectForKey:@"vib"] intValue];
                time = [[settings objectForKey:@"hour"] intValue]*60*60+[[settings objectForKey:@"min"] intValue]*60+[[settings objectForKey:@"sec"] intValue];
                
                [Com1 updateDigits1:time/3600 :hr0 :hr1 :0];
                [Com1 updateDigits1:(time/60)%60 :min0 :min1 :0];
                [Com1 updateDigits1:time%60 :sec0 :sec1 :0];
                
                countDown=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
                
                //     NSLog(@"time = %d",time);
            }
            [self createCountdown];
			[self hideObj1];

		} else { 
			// user did not slide far enough, so return back to 0 position
			[UIView beginAnimations: @"SlideCanceled" context: nil];
			[UIView setAnimationDelegate: self];
			[UIView setAnimationDuration: 0.35];
			// use CurveEaseOut to create "spring" effect
			[UIView setAnimationCurve: UIViewAnimationCurveEaseOut];	
			slideToEngage.value = 0.0;
			[l1 setAlpha:1];
			[UIView commitAnimations];
			
			
		}
		
	}
    
    if (aborted == 0) {
        
		if (slideToAbort.value ==0.0) {  // if user slide far enough, stop the operation	
            // Put here what happens when it is aborted
            slideToEngage.value = 0;
            engaged = 0;
			[self showObj1];
            [self hideObj2];
			//slideToEngage.hidden = YES;
			//abort.hidden = NO;
			//cc.hidden = YES;
			//l1.hidden = YES;
            aborted = 1;
			// UNLOCKED = YES;
       //     NSLog(@"aborted == 0 && value ==0");

		} else { 
			// user did not slide far enough, so return back to 0 position
			[UIView beginAnimations: @"SlideCanceled" context: nil];
			[UIView setAnimationDelegate: self];
			[UIView setAnimationDuration: 0.35];
			// use CurveEaseOut to create "spring" effect
			[UIView setAnimationCurve: UIViewAnimationCurveEaseOut];	
			slideToAbort.value = 1.0;
			[l2 setAlpha:1];
			[UIView commitAnimations];
		//	NSLog(@"aborted == 0");
			
		}
		
	}
	
}

-(IBAction) touchOutside1 {
    // user did not slide far enough, so return back to 0 position
    [UIView beginAnimations: @"SlideCanceled" context: nil];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationDuration: 0.35];
    // use CurveEaseOut to create "spring" effect
    [UIView setAnimationCurve: UIViewAnimationCurveEaseOut];	
    slideToEngage.value = 0.0;
    [l1 setAlpha:1];
    [UIView commitAnimations];
}

-(IBAction) touchOutside2 {
    // user did not slide far enough, so return back to 0 position
    [UIView beginAnimations: @"SlideCanceled" context: nil];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationDuration: 0.35];
    // use CurveEaseOut to create "spring" effect
    [UIView setAnimationCurve: UIViewAnimationCurveEaseOut];	
    slideToAbort.value = 1.0;
    [l2 setAlpha:1];
    [UIView commitAnimations];
    //	NSLog(@"aborted == 0");
}

- (void) createObj 
{
    [slideToEngage setAlpha:0];
    [l1 setAlpha:0];
    
    int iPhone_5_height = 88;
    if ([UIScreen mainScreen].bounds.size.height == 568) 
    {
        slideToEngage.frame = CGRectMake(20, 430+iPhone_5_height, 280, 23);
        l1.frame = CGRectMake(135, 430+iPhone_5_height, 175, 20);
    }
    else 
    {
        slideToEngage.frame = CGRectMake(20, 430, 280, 23);
        l1.frame = CGRectMake(135, 430, 175, 20);
    }
    
    slideToEngage.frame = CGRectOffset(slideToEngage.frame, 0, +50);
    l1.frame = CGRectOffset(l1.frame, 0, +50);
    
    [slideToAbort setAlpha:0];
    slideToAbort.frame = CGRectMake(22, 30, 280, 23);
    slideToAbort.frame = CGRectOffset(slideToAbort.frame, 0, -50);
    
    [l2 setAlpha:0];
    l2.frame = CGRectMake(20, 30, 175, 20);
    l2.frame = CGRectOffset(l2.frame, 0, -50);
    
    engaged = 0;
    aborted = 1;
    
    [abort setAlpha:0];
    [b0 setAlpha:0];
    [b1 setAlpha:0];
    [again setAlpha:0];
    
    [bgImage setAlpha:0];
    
    [self createCountdown];
    [self hideCountdown];
}

- (void) showObj1 {
 //   NSLog(@"Show Object 1!!");
    
    //[bgImage setAlpha:0];
    bgImage.image = nil;
  //  img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gun barrel" ofType:@"png" inDirectory:nil]];
  //  [bgImage setImage:img];
    
    [again setAlpha:0];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.6];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseOut];
 
    [slideToEngage setAlpha:1];
    slideToEngage.frame = CGRectOffset(slideToEngage.frame, 0, -50);
    
    [l1 setAlpha:1];
    l1.frame = CGRectOffset(l1.frame, 0, -50);
    
    b0.alpha = 1;
    bgImage.alpha = 0;
    btnPickImg.alpha = 1;
    
    [self hideCountdown];
    [UIView commitAnimations];
    engaged = 0;
    aborted = 1;
    textBubble.alpha = 0;
    if (timer_again != nil) 
    {     
        [timer_again invalidate];
        timer_again = nil;
    }

    if (timer_vib != nil) 
    {     
        [timer_vib invalidate];
        timer_vib = nil;
    }
    t1 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(animate1) userInfo:nil repeats:YES];
}
- (void) hideObj1 {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.6];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseOut];
    
    [slideToEngage setAlpha:0];
    slideToEngage.frame = CGRectOffset(slideToEngage.frame, 0,50);
    [b0 setAlpha:0];
    btnPickImg.alpha = 0;
    
    [abort setAlpha:0.8];
    
    if (d!=0) {
        [self showCountdown];
    } else {
        [bgImage setAlpha:0];
    }
    
   // img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gun barrel1" ofType:@"png" inDirectory:nil]];
   // [bgImage setImage:img];
    
    [l1 setAlpha:0];
    l1.frame = CGRectOffset(l1.frame, 0, 50);
    [UIView commitAnimations];
    
    if (t1 != nil) {
        [t1 invalidate];
        t1 = nil;
    }
}

-(void) showObj2 {
 //   NSLog(@"Show Object 2!!");
    
    slideToAbort.value = 1;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.6];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseOut];
    
    [slideToAbort setAlpha:0.8];
    slideToAbort.frame = CGRectOffset(slideToAbort.frame, 0, 50);
    
    if (d==0) {
        [self showCountdown];
    }
    
    [self moveCountdown:70];
    
    [l2 setAlpha:1];
    l2.frame = CGRectOffset(l2.frame, 0, 50);
    
    [b1 setAlpha:1];
    [UIView commitAnimations];
    
    [abort setAlpha:0];
    
    engaged = 1;
    aborted = 0;
    
        
    if (timer_abort != nil) 
    {     
        [timer_abort invalidate];
        timer_abort = nil;
    }
    t2 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(animate2) userInfo:nil repeats:YES];
    
 /*   if (countDown != nil) {
        [countDown invalidate];
        countDown = nil;
    }*/
}


-(void) hideObj2 {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.6];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseOut];
    
    [slideToAbort setAlpha:0];
    slideToAbort.frame = CGRectOffset(slideToAbort.frame, 0, -50);
    
    [self moveCountdown:-70];
    
    [l2 setAlpha:0];
    l2.frame = CGRectOffset(l2.frame, 0, -50);
    [b1 setAlpha:0];
    
    [UIView commitAnimations];
    
    [abort setAlpha:0];
    
    if (t2 != nil) {
        [t2 invalidate];
        t2 = nil;
    }
}

-(void) moveCountdown: (int) k {
//    NSLog(@"50+k=%d",k);
    hr1.frame = CGRectOffset(hr1.frame, 0, k);
    hr0.frame = CGRectOffset(hr0.frame, 0, k);
    col1.frame = CGRectOffset(col1.frame, 0, k);
    min1.frame = CGRectOffset(min1.frame, 0, k);
    min0.frame = CGRectOffset(min0.frame, 0, k);
    col0.frame = CGRectOffset(col0.frame, 0, k);
    sec1.frame = CGRectOffset(sec1.frame, 0, k);
    sec0.frame = CGRectOffset(sec0.frame, 0, k);
}

-(void) createCountdown {
   // NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile: [Com1 getPath]];
   // d = [[settings objectForKey:@"display"] intValue];
    
    if (d == 2) {
   //     NSLog(@"d==%d",d);
        hr1.frame = CGRectMake(22, 50, 35, 35);
        hr0.frame = CGRectMake(55, 50, 35, 35);
        col1.frame = CGRectMake(90, 50, 35, 35);
        min1.frame = CGRectMake(125, 50, 35, 35);
        min0.frame = CGRectMake(160, 50, 35, 35);
        col0.frame = CGRectMake(195, 50, 35, 35);
        sec1.frame = CGRectMake(230, 50, 35, 35);
        sec0.frame = CGRectMake(265, 50, 35, 35);
    } else {
        hr1.frame = CGRectMake(80, 70, 20, 20);
        hr0.frame = CGRectMake(100, 70, 20, 20);
        col1.frame = CGRectMake(120, 70, 20, 20);
        min1.frame = CGRectMake(140, 70, 20, 20);
        min0.frame = CGRectMake(160, 70, 20, 20);
        col0.frame = CGRectMake(180, 70, 20, 20);
        sec1.frame = CGRectMake(200, 70, 20, 20);
        sec0.frame = CGRectMake(220, 70, 20, 20);
    }
    
}

-(void) showCountdown {
    [sec0 setAlpha:1];
    [sec1 setAlpha:1];
    [min0 setAlpha:1];
    [min1 setAlpha:1];
    [hr0 setAlpha:1];
    [hr1 setAlpha:1];
    [col0 setAlpha:1];
    [col1 setAlpha:1];

}
-(void) hideCountdown {
    [sec0 setAlpha:0];
    [sec1 setAlpha:0];
    [min0 setAlpha:0];
    [min1 setAlpha:0];
    [hr0 setAlpha:0];
    [hr1 setAlpha:0];
    [col0 setAlpha:0];
    [col1 setAlpha:0];
}


-(void) updateTimer 
{
    if (time%5 == 0) 
    {
        [UIView animateWithDuration:4.9f delay:0 options:UIViewAnimationCurveEaseIn animations:^{
            NSArray *text = TEXT_BUBBLE;
            int randomText = arc4random() % text.count;
            int offset = 20;
            CGSize screenSize = [UIScreen mainScreen].bounds.size;
            CGSize bubbleSize = textBubble.frame.size;
            int x = arc4random() % (int)(screenSize.width - bubbleSize.width - offset);
            int y = arc4random() % (int)(screenSize.height - bubbleSize.height - offset);
            CGRect frame = textBubble.frame;
            frame.origin.x = x;
            frame.origin.y = y;
            
            textBubble.frame = frame;
                                    
            [textBubble setTitle:[text objectAtIndex:randomText] forState:UIControlStateNormal];
            textBubble.alpha = 1;
            
        } 
                         completion:^(BOOL finished) 
        {
            [UIView animateWithDuration:1.5f animations:^{
            textBubble.alpha = 0;
            }];
        }];
        
    }
    
    time--;
    
    [Com1 updateDigits1:time/3600 :hr0 :hr1 :0];
    [Com1 updateDigits1:(time/60)%60 :min0 :min1 :0];
    [Com1 updateDigits1:time%60 :sec0 :sec1 :0];
//    NSLog(@"CountDown = %d",time);
    if (time == 0 || time == -1) {
        
 //       NSLog(@"Time is up");
        // reset count down timer
        if (countDown!=nil) {
            [countDown invalidate];
            countDown = nil;
        }
        
        c5 =0;
        // play bangbang
        
        [self setupSound];
        AudioServicesPlaySystemSound (soundID);
               
        // hide buttons
        [self hideCountdown];
        [abort setAlpha:0];
        slideToEngage.value = 0;
       
        
        if (v==1) {
            timer_vib=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(vib) userInfo:nil repeats:YES];
        }
        t5 = [NSTimer scheduledTimerWithTimeInterval:0.07 target:self selector:@selector(animate5) userInfo:nil repeats:YES];
    }
}

-(void) animate5 {
    c5++;
    // show images
    if (c5 == 1) {
        int n = 1 + arc4random() % 6;
      //  n=3;
        picNum = n;
        NSString *t =[[NSString alloc] initWithFormat:@"brok%@-1",[[NSNumber numberWithInt:picNum] stringValue]];
        img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:t ofType:@"png" inDirectory:nil]];
        [bgImage setImage:img];
        [bgImage setAlpha:1];
   //     NSLog(@"%@",t);
    }
    
    if (c5 == 16) {
        NSString *t =[[NSString alloc] initWithFormat:@"brok%@-2",[[NSNumber numberWithInt:picNum] stringValue]];
        img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:t ofType:@"png" inDirectory:nil]];
        [bgImage setImage:img];
        [again setAlpha:0.4];
   //     NSLog(@"%@",t);
        // reset count down timer
        if (t5!=nil) {
            [t5 invalidate];
            t5 = nil;
        }
        
    }
         
    
    //   NSLog(@"c5=%d",c5);
}

-(void) animate1 {
    int j;
    if (c1<8) {
        j=1;
    } else {
        j=c1-6;
    }
    
    // animate slide
    NSString *t =[[NSString alloc] initWithFormat:@"bullet-1-%d.png",j];
  //  NSLog(@"bbbbbb%@",t);
    [slideToEngage setThumbImage: [UIImage imageNamed:t] forState:UIControlStateNormal];
    
    // animate slide label
    t =[[NSString alloc] initWithFormat:@"engage%d",c1+1];
    img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:t ofType:@"png" inDirectory:nil]];
    [l1 setImage:img forState:UIControlStateNormal];
    
    // animate setting button  
    t =[[NSString alloc] initWithFormat:@"se%d",c1+1];
  //  NSLog(@"bbbbbb%@",t);
    img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:t ofType:@"png" inDirectory:nil]];
    [b0 setImage:img forState:UIControlStateNormal];
    
    
    c1++;
    if (c1==12) {
        c1=0;
    }
}

-(void) animate2 {
    int j;
    if (c2<8) {
        j=1;
    } else {
        j=c2-6;
    }
    
    // animate slide
    NSString *t =[[NSString alloc] initWithFormat:@"bullet-2-%d.png",j];
  //  NSLog(@"bbbbbb%@",t);
    [slideToAbort setThumbImage: [UIImage imageNamed:t] forState:UIControlStateNormal];
    
    // animate slide label
    t =[[NSString alloc] initWithFormat:@"abort%d",c2+1];
  //  NSLog(@"bbbbbb%@",t);
    img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:t ofType:@"png" inDirectory:nil]];
    [l2 setImage:img forState:UIControlStateNormal];

    // animate setting button 
    t =[[NSString alloc] initWithFormat:@"re%d",c2+1];
      
    img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:t ofType:@"png" inDirectory:nil]];
    [b1 setImage:img forState:UIControlStateNormal];
    
    c2++;
    if (c2==12) {
        c2=0;
    }
}





-(void) vib {
    int i = arc4random() % 11;
    if (i<7) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
  //  NSLog(@"radom vib i+%d",i);
}

- (void)dealloc
{
    //-----sound & timer
    AudioServicesDisposeSystemSoundID (soundID);
    CFRelease (soundFileURLRef);
    
    if (timer_vib != nil) {
        [timer_vib invalidate];
    }
    
    if (timer_again != nil) {
        [timer_again invalidate];
    }
    if (timer_abort != nil) {
        [timer_abort invalidate];
    }
    if (countDown != nil) {
        [countDown invalidate];
    }
    if (t1 != nil) {
        [t1 invalidate];
    }
    if (t2 != nil) {
        [t2 invalidate];
    }
    
    
    if (t5 != nil) {
        [t5 invalidate];
    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    UIImage *stetchRightTrack= [[UIImage imageNamed:@"Nothing.png"]
                                stretchableImageWithLeftCapWidth:20.0 topCapHeight:0.0];
	[slideToEngage setThumbImage: [UIImage imageNamed:@"bullet-1-5.png"] forState:UIControlStateNormal];
	//[slideToUnlock setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    [slideToEngage setMinimumTrackImage:stetchRightTrack forState:UIControlStateNormal];
	[slideToEngage setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    
    [slideToAbort setThumbImage: [UIImage imageNamed:@"bullet-2-5.png"] forState:UIControlStateNormal];
	//[slideToUnlock setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    [slideToAbort setMinimumTrackImage:stetchRightTrack forState:UIControlStateNormal];
	[slideToAbort setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    [super viewDidLoad];
    [textBubble.titleLabel setFont:[UIFont fontWithName:@"Vampiress" size:36.0]];
  //  [textBubble setFont:[UIFont fontWithName:@"Vampiress" size:20.0]];
    [self createObj]; 
//    [self showObj1];
   
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [self showObj1];
}
-(void)viewDidDisappear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"NO"forKey:@"firstLoad"];
    [defaults synchronize];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadBackground];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstLoad = [defaults objectForKey:@"firstLoad"];
    if (firstLoad.length == 0) 
    {
        slideToEngage.hidden = YES;
        l1.hidden = YES;
    }
    else 
    {
        slideToEngage.hidden = NO;
        l1.hidden = NO;
    }
}


- (void)loadBackground
{
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile: [Com1 getPath]];
    int bgType = [[settings objectForKey:@"bgType"] intValue];
     NSData *imageData1 = [NSData dataWithContentsOfFile:[Com1 getPath:@"currentImage" :@"png"]];
    switch (bgType) 
    {
        case 0:
            background.image = [UIImage imageNamed:@"gun barrel.png"];
            break;
            
        case 1:
            background.image = [UIImage imageWithData:imageData1];
            break;
            
        case 2:
            background.image = nil;
            break;
            
        default:
            break;
    }
    
}

@end
