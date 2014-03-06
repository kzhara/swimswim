//
//  DatePickerViewController.m
//  TabCoreDataTemp
//
//  Created by kzhara13 on 2013/06/16.
//
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDatePicker:nil];
//    [self setDoneBtn:nil];
    [super viewDidUnload];
}
- (IBAction)cancelBtn:(id)sender {
    [self.delegate didCancelButtonClicked:self];
}

- (IBAction)doneBtn:(id)sender {
    [self.delegate didCommitButtonClicked:self selectedDate:self.datePicker.date];
}
@end
