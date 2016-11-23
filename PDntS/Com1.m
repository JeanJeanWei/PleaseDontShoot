//
//  Com1.m
//  pk1
//
//  Created by JJ WEI on 11-07-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Com1.h"


@implementation Com1

//@synthesize img;

+(NSString*) getPath {
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1 Create a list of paths.
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2 Get a path to your documents directory from the list.
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"]; //3 Create a full file path.
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]) //4 Check if file exists.
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]; //5 Get a path to your plist created before in bundle directory (by Xcode).
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6 Copy this plist to your documents directory.
    }
    
    return path;
}

+(NSString*) getPath: (NSString*) fname: (NSString*) ext {
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1 Create a list of paths.
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2 Get a path to your documents directory from the list.
    
    NSString *filename =[NSString new];
    filename =[NSString stringWithFormat:@"%@.%@",fname,ext];
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:filename]; //3 Create a full file path.
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]) //4 Check if file exists.
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:fname ofType:ext]; //5 Get a path to your plist created before in bundle directory (by Xcode).
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6 Copy this plist to your documents directory.
    }
    
    return path;
}
+(void) updateDigits1: (int) num: (id) k1: (id) k2: (int) t {
    if (num<10) {
        
        NSString *b =[[NSString alloc] initWithFormat:@"s%i", num];
       UIImage *img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:b ofType:@"png" inDirectory:nil]];
        if (t == 0) {
            [k1 setImage:img forState:UIControlStateNormal];
            img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"s0" ofType:@"png" inDirectory:nil]];
            [k2 setImage:img forState:UIControlStateNormal];
        } else if (t == 1){
            [k1 setImage:img forState:UIControlStateNormal];
            [k2 setImage:nil forState:UIControlStateNormal];
        } else {
            [k1 setImage:nil forState:UIControlStateNormal];
            [k2 setImage:img forState:UIControlStateNormal];
        }
    } else {
        NSString *b =[[NSString alloc] initWithFormat:@"s%i", num%10];
        UIImage *img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:b ofType:@"png" inDirectory:nil]];
        [k1 setImage:img forState:UIControlStateNormal];
        
        b =[[NSString alloc] initWithFormat:@"s%i", num/10];
        img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:b ofType:@"png" inDirectory:nil]];
        [k2 setImage:img forState:UIControlStateNormal];
    }
    
}


@end
