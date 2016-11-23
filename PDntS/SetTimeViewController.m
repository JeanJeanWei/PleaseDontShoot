//
//  SetTimeViewController.m
//  PzDontShoot
//
//  Created by JJ WEI on 12-09-17.
//  Copyright (c) 2012 Ice Whale Inc. All rights reserved.
//

#import "SetTimeViewController.h"
#import "Com1.h"

@implementation SetTimeViewController

@synthesize mins, hours;

- (void)viewDidLoad
{
    [super viewDidLoad];
     t3 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(animate3) userInfo:nil repeats:YES];
    [self setupTimer];
    [self loadTimer];
    // Do any additional setup after loading the view from its nib.
}
-(void) loadTimer {
    
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile: [Com1 getPath]];
    
    //load from settings int value
    int h;
    int m;
    int s;
    
    h = [[settings objectForKey:@"hour"] intValue];
    m = [[settings objectForKey:@"min"] intValue];
    s = [[settings objectForKey:@"sec"] intValue];
    [picker selectRow:h inComponent:0 animated:NO];
    [picker selectRow:m+60 inComponent:1 animated:NO];
    [picker selectRow:s+60 inComponent:2 animated:NO];
    
    //   NSLog(@"hours=%d, mins=%d, sec=%d",h,m,s);
    
    if (m%60 == 1) {
        NSString *t =[[NSString alloc] initWithFormat:@"min"];
        mLabel.text = t;
    } else {
        NSString *t =[[NSString alloc] initWithFormat:@"mins"];
        mLabel.text = t;
    }
    
    if (s%60 == 1) {
        NSString *t =[[NSString alloc] initWithFormat:@"sec"];
        sLabel.text = t;
    } else {
        NSString *t =[[NSString alloc] initWithFormat:@"secs"];
        sLabel.text = t;
    }
    
    if (h == 1) {
        NSString *t =[[NSString alloc] initWithFormat:@"hr"];
        hLabel.text = t;
    } else {
        NSString *t =[[NSString alloc] initWithFormat:@"hrs"];
        hLabel.text = t;
    }
    
}


-(void) saveTimer {
    NSString *p =[Com1 getPath];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:p];
    
    //here add elements to data file and write data to file
    
    
    [data setObject:[NSNumber numberWithInt:[picker selectedRowInComponent:0]] forKey:@"hour"];
    [data setObject:[NSNumber numberWithInt:[picker selectedRowInComponent:1]%60] forKey:@"min"];
    [data setObject:[NSNumber numberWithInt:[picker selectedRowInComponent:2]%60] forKey:@"sec"];
    
    [data writeToFile:p atomically:YES];
    
}

-(void) animate3
{
    int j;
    if (c < 11) {
        j = c + 1;
    } else {
        j= 21 - c;
    }
    NSString *t =[[NSString alloc] initWithFormat:@"set%d.png",j];
    //  NSLog(@"t3=%@",t);
    
    UIImage *img = [UIImage imageNamed:t];
    [set setImage:img forState:UIControlStateNormal];
    
    
    c++;
    if (c == 21) {
        c = 1;
    }
}
-(IBAction) backV2Pressed {
    
    if (t3 != nil) {
        [t3 invalidate];
        t3 = nil;
    }
    
    [self saveTimer];
    
 //   NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile: [Com1 getPath]];
    [self.navigationController popViewControllerAnimated:YES];
        

}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
        return [self.hours objectAtIndex:row];
    else if (component == 1)
        return [self.mins objectAtIndex:row%[self.mins count]];
    
    return [self.mins objectAtIndex:row%[self.mins count]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSInteger hr_NewRow = [picker selectedRowInComponent:0];
    NSInteger min_NewRow = [picker selectedRowInComponent:1];
    NSInteger sec_NewRow = [picker selectedRowInComponent:2];
    
    //   NSLog(@"com2=%d",sec_NewRow);
    
    if ([picker selectedRowInComponent:1] < ([self.mins count]*3) || [picker selectedRowInComponent:1] >= (4 * [self.mins count]) ) {
        min_NewRow = [picker selectedRowInComponent:1] % [self.mins count];
        min_NewRow += [self.mins count]*3;
        [pickerView selectRow:min_NewRow inComponent:1 animated:NO];
    }
    
    if ([picker selectedRowInComponent:2] < ([self.mins count]*3) || [picker selectedRowInComponent:2] >= (4 * [self.mins count]) ) {
        sec_NewRow = [picker selectedRowInComponent:2] % [self.mins count];
        sec_NewRow += [self.mins count]*3;
        [pickerView selectRow:sec_NewRow inComponent:2 animated:NO];
    }
    
    if (min_NewRow%60 == 1) {
        NSString *t =[[NSString alloc] initWithFormat:@"min"];
        mLabel.text = t;
    } else {
        NSString *t =[[NSString alloc] initWithFormat:@"mins"];
        mLabel.text = t;
    }
    
    if (sec_NewRow%60 == 1) {
        NSString *t =[[NSString alloc] initWithFormat:@"sec"];
        sLabel.text = t;
    } else {
        NSString *t =[[NSString alloc] initWithFormat:@"secs"];
        sLabel.text = t;
    }
    
    if (hr_NewRow == 1) {
        NSString *t =[[NSString alloc] initWithFormat:@"hr"];
        hLabel.text = t;
    } else {
        NSString *t =[[NSString alloc] initWithFormat:@"hrs"];
        hLabel.text = t;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == 0)
        return 87;
    return 105;
}


-(void) setupTimer {
    NSArray *a1 = [[NSArray alloc] initWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",nil];
    
    self.mins = a1;
    a1 = [[NSArray alloc] initWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",nil];
    
    self.hours = a1;
    // [picker selectRow:9 inComponent:0 animated:NO];
    // [picker setBackgroundColor:[UIColor clearColor]];
}

#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
        return [self.hours count];
    else if (component == 1)
        return [self.mins count]*7;
    
    return [self.mins count]*7;
}

@end
