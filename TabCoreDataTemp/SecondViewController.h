//
//  SecondViewController.h
//  TabCoreDataTemp
//
//  Created by 真有 津坂 on 12/03/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UIWebViewDelegate>
{
    IBOutlet UIWebView *swimwebView;
    IBOutlet UIBarButtonItem *fBarButton;
    IBOutlet UIBarButtonItem *bBarButton;
    
}
- (IBAction)openButtonPress:(id)sender;
- (IBAction)forwardButtonPress:(id)sender;
- (IBAction)backButtonPress:(id)sender;
- (IBAction)mastersBtn:(id)sender;
- (IBAction)owsBtn:(id)sender;


@end
