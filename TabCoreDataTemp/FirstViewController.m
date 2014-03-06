//
//  FirstViewController.m
//  TabCoreDataTemp
//
//  Created by 真有 津坂 on 12/03/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController
@synthesize swimlength;
@synthesize weekLabel;
@synthesize monthLabel;
@synthesize kcaltotalfield;
@synthesize kcalweekfield;
@synthesize kcalmonthfield;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    int w = [defaults integerForKey:@"swimweek"];
    NSLog( @"今週泳いだ距離は　%dメートルです", w );
    NSString *strW = [NSString stringWithFormat:@"%d",w];
    weekLabel.text = strW;
    
    // 泳いだ距離の読み込み
    int y = [defaults integerForKey:@"swimtotal"];
    NSLog( @"泳いだ距離は　%dメートルです", y );
    NSString *str = [NSString stringWithFormat:@"%d",y];
    NSString *str1=[NSString stringWithFormat:@"%@メートル",str];
    swimlength.text = str1;

    int m = [defaults integerForKey:@"swimmonth"];
    NSLog( @"今月泳いだ距離は　%dメートルです", m);
    NSString *strM = [NSString stringWithFormat:@"%d",m];
    NSString *strM1=[NSString stringWithFormat:@"%@メートル",strM];
    monthLabel.text = strM1;

    int kcalweek = [defaults integerForKey:@"kcalweek"];
    NSString *strkcalweek = [NSString stringWithFormat:@"%d",kcalweek];
    NSString *strkcalweek1 = [NSString stringWithFormat:@"%@kcal",strkcalweek];
    kcalweekfield.text = strkcalweek1;
    
    int kcalmonth = [defaults integerForKey:@"kcalmonth"];
    NSString *strkcalmonth = [NSString stringWithFormat:@"%d",kcalmonth];
    NSString *strkcalmonth1 = [NSString stringWithFormat:@"%@kcal",strkcalmonth];
    kcalmonthfield.text = strkcalmonth1;

    int kcaltotal = [defaults integerForKey:@"kcaltotal"];
    NSString *strkcaltotal = [NSString stringWithFormat:@"%d",kcaltotal];
    NSString *strkcaltotal1 = [NSString stringWithFormat:@"%@kcal",strkcaltotal];
    kcaltotalfield.text = strkcaltotal1;
}

- (void)viewDidUnload
{
    [self setTopLabel1:nil];
    [self setSwimlength:nil];
    [self setWeekLabel:nil];
    [self setMonthLabel:nil];
    [self setKcalmonthfield:nil];
    [self setKcalweekfield:nil];
    [self setKcaltotalfield:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;


}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];


    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    
    // 泳いだ距離の読み込み
    int y = [defaults integerForKey:@"swimtotal"];
    NSLog( @"B泳いだ距離は　%dメートルです", y );
    NSString *str = [NSString stringWithFormat:@"%d",y];
    NSString *str1=[NSString stringWithFormat:@"%@メートル",str];
    swimlength.text = str1;
    
    int w = [defaults integerForKey:@"swimweek"];
    NSLog( @"B今週泳いだ距離は　%dメートルです", w );
    NSString *strW = [NSString stringWithFormat:@"%d",w];
    NSString *strW1=[NSString stringWithFormat:@"%@メートル",strW];
    weekLabel.text = strW1;
    
    int m = [defaults integerForKey:@"swimmonth"];
    NSLog( @"B今月泳いだ距離は　%dメートルです", m);
    NSString *strM = [NSString stringWithFormat:@"%d",m];
    NSString *strM1=[NSString stringWithFormat:@"%@メートル",strM];
    monthLabel.text = strM1;


    int kcaltotal = [defaults integerForKey:@"kcaltotal"];
    NSString *strkcaltotal = [NSString stringWithFormat:@"%d",kcaltotal];
    NSString *strkcaltotal1 = [NSString stringWithFormat:@"%@kcal",strkcaltotal];
    kcaltotalfield.text = strkcaltotal1;
    NSLog( @"Bトータルカロリーは　%dです", kcaltotal );
    
    int kcalweek = [defaults integerForKey:@"kcalweek"];
    NSString *strkcalweek = [NSString stringWithFormat:@"%d",kcalweek];
    NSString *strkcalweek1 = [NSString stringWithFormat:@"%@kcal",strkcalweek];
    kcalweekfield.text = strkcalweek1;
    NSLog( @"B週カロリーは　%dです", kcalweek );
    
    int kcalmonth = [defaults integerForKey:@"kcalmonth"];
    NSString *strkcalmonth = [NSString stringWithFormat:@"%d",kcalmonth];
    NSString *strkcalmonth1 = [NSString stringWithFormat:@"%@kcal",strkcalmonth];
    kcalmonthfield.text = strkcalmonth1;
    NSLog( @"B今月カロリーは　%dです", kcalmonth );



}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
