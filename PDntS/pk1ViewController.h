
#import <UIKit/UIKit.h>
#import "Com1.h"
#include <AudioToolbox/AudioToolbox.h>

#define TEXT_BUBBLE [NSArray arrayWithObjects: @"Please don’t shoot.",@"I beg you. Don’t kill me!",@"Have mercy on me.",@"Whatever I did, I’m sorry!",@"Oh God! Save me!",@"No! Not in the face!",@"I’ll do anything you want. Just don’t shoot.",@"Tell my parents I love them.",@"Aaarrrggg!",@"I’ve pooped myself. Are you happy now?",@"I think I peed my pants.",@"Wait!",@"Stop!",@"I don’t wanna die!",@"Don’t do it. I’ll pay you!",@"Let me go and I’ll be your BFF.",@"Pleeeease!",@"This is in violation of my life insurance policy!",@"Can this wait until tomorrow? The Bachelor is on tonight.",@"But I have tickets to see the Biebz this weekend.",@"Don’t shoot!",nil]


@interface pk1ViewController : UIViewController  
{
    
       //------- sounds
    CFURLRef		soundFileURLRef;
	SystemSoundID	soundID;
    //------- view 1
    IBOutlet UIButton *sec0;
    IBOutlet UIButton *sec1;
    IBOutlet UIButton *min0;
    IBOutlet UIButton *min1;
    IBOutlet UIButton *hr0;
    IBOutlet UIButton *hr1;
    IBOutlet UIButton *col0;
    IBOutlet UIButton *col1;
    IBOutlet UIButton *btnPickImg;
    IBOutlet UIButton *textBubble;
    
    int time;
    int engaged;
    int aborted;
    
    int picNum;
    int gunNum;
    int v;
    int d;
    
    IBOutlet UISlider *slideToEngage;
    IBOutlet UISlider *slideToAbort;
    IBOutlet UIButton *l1;
    IBOutlet UIButton *l2;
    
	IBOutlet UIButton *abort;
    IBOutlet UIButton *b0;
    IBOutlet UIButton *b1;
    IBOutlet UIButton *again;
	
	IBOutlet UIImageView *background;
    IBOutlet UIImageView *bgImage;
    
    NSTimer *timer_abort;
    NSTimer *timer_again;
    NSTimer *timer_vib;
    NSTimer *countDown;
    NSTimer *t1;
    NSTimer *t2;
    
    NSTimer *t5;
    
    
    UIImage *img;
    int c1;
    int c2;
    
    int c5;

}

//------- sounds
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundID;

@property (nonatomic) NSTimer *t1;
@property (nonatomic) NSTimer *t2;

@property (nonatomic) NSTimer *t5;
//@property (nonatomic,retain) NSArray *img1;


// view 1
- (IBAction)settingsPressed;
- (IBAction)pickBackgroundClicked;

-(void) createObj;
-(void) showObj1;
-(void) showObj2;
-(void) hideObj1;
-(void) hideObj2;

-(void) moveCountdown: (int) k;
-(void) createCountdown;
-(void) showCountdown;
-(void) hideCountdown;

//-(IBAction)abortPressed;
-(IBAction)resumePressed;
-(IBAction)engaging;
-(IBAction)fadeLabel;

-(IBAction)touchesBegan;
-(IBAction)touchesEnded;
-(IBAction) touchOutside1;
-(IBAction) touchOutside2;

-(IBAction)againBegan;
-(IBAction)againEnded;

-(void) animate1;
-(void) animate2;

-(void) animate5;
-(void) setupSound;
-(void) vib;


@end
