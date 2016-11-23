//
//  Com1.h
//  pk1
//
//  Created by JJ WEI on 11-07-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "pk1ViewController.h"

@interface Com1 : NSObject {
 //   UIImage *img;
}

//@property (nonatomic, retain) UIImage *img;

+(NSString*) getPath;
+(NSString*) getPath: (NSString*) fname: (NSString*) ext;
+(void) updateDigits1: (int) num: (id) k1: (id) k2: (int) t;
@end
