//
//  ModalDatePickerViewController.m
//  TabCoreDataTemp
//
//  Created by kzhara13 on 2013/06/16.
//
//

#import "ModalDatePickerViewController.h"


@implementation ModalDatePickerViewController
@synthesize tdelegate, pickerName_, dispDate_;


- (id) init {
    if ((self = [self initWithNibName:@"ModalDatePickerViewController" bundle:nil])) {
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    picker.datePickerMode = UIDatePickerModeDate;
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.dispDate_ != nil) {
        [picker setDate:self.dispDate_];
    }
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (IBAction)commitButtonClicked:(id)sender {
    [self.tdelegate didCommitButtonClicked:self selectedDate:picker.date pickerName:self.pickerName_];
}

- (IBAction)cancelButtonClicked:(id)sender {
    [self.tdelegate didCancelButtonClicked:self pickerName:self.pickerName_];
}

- (IBAction)clearButtonClicked:(id)sender {
    [self.tdelegate didClearButtonClicked:self pickerName:self.pickerName_];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    pickerName_ = nil;
    dispDate_ = nil;
}


@end
