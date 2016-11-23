//
//  BackgroundViewController.m
//  PDntS
//
//  Created by JJ WEI on 12-10-08.
//  Copyright (c) 2012 Ice Whale Inc. All rights reserved.
//

#import "BackgroundViewController.h"
#import "Com1.h"

@implementation BackgroundViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   //load from settings int value
    [self loadBackground];

}

- (void)loadBackground
{
     NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile: [Com1 getPath]];
    bgType = [[settings objectForKey:@"bgType"] intValue];
    NSData *imageData1 = [NSData dataWithContentsOfFile:[Com1 getPath:@"currentImage" :@"png"]];
    
    switch (bgType) 
    {
        case 0:
            bgImgView.image = [UIImage imageNamed:@"gun barrel.png"];
            break;
            
        case 1:
            
            bgImgView.image = [UIImage imageWithData:imageData1];
            break;
            
        case 2:
            bgImgView.image = nil;
            break;
            
        default:
            break;
    }
    
}
#pragma mark UIImagePickerDelegate Method - finished, and cancelled

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker 
{
   
    
	[picker  dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info 
{
    bgImgView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
	[picker  dismissModalViewControllerAnimated:YES];
    bgType = 1;
    [self saveBackgroundImg];
}

-(IBAction) pickImgPressed
{
    
    ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    
    // check if the choosen image type source is avaiable
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentModalViewController:ipc animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Unable to acces selected photo sources"
                                                       message:@"Photo Library is not available in this device."
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        [alert show];
        
        //		NSLog(@"pickImg != nil");
    }
}
-(void) saveBackgroundImg 
{

    //NSString* cacheDirectory = [BackgroundViewController imageDirectory];
    NSString *tmpPathToFile1 =[NSString new];
    tmpPathToFile1 = [Com1 getPath:@"currentImage" :@"png"];
    NSError* error = nil;
    //NSString* fileName = @"currentImage.png";
    
   // NSString* imagePath = [cacheDirectory stringByAppendingPathComponent:fileName];
    //if([imageData1 writeToFile:tmpPathToFile1 atomically:YES])
    if ([UIImageJPEGRepresentation(bgImgView.image, 1.0) writeToFile:tmpPathToFile1 options:NSDataWritingAtomic error:&error]) 
    {
    
          NSLog(@"img0 Success!");
        //Write was successful. 
    }
    
    
}
+ (NSString*)imageDirectory
{
    NSString* cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString* imagesPath = [cachesPath stringByAppendingPathComponent:@"images"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:imagesPath])
    {
        NSError* error = nil;
        
        if (![[NSFileManager defaultManager] createDirectoryAtPath:imagesPath withIntermediateDirectories:YES attributes:nil error:&error])
        {
            NSLog(@"IMAGE CACHE: %@", error);
        }
    }
    
    return imagesPath;
}
- (IBAction)defaultPressed
{
    bgType = 0;
    bgImgView.image =[UIImage imageNamed:@"gun barrel.png"];
}

- (IBAction)blankPressed
{
    bgType = 2;
    bgImgView.image = nil;
}
- (IBAction)doneClidked
{
    NSString *p =[Com1 getPath];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:p];
    [data setObject:[NSNumber numberWithInt:bgType] forKey:@"bgType"];
    [data writeToFile:p atomically:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
