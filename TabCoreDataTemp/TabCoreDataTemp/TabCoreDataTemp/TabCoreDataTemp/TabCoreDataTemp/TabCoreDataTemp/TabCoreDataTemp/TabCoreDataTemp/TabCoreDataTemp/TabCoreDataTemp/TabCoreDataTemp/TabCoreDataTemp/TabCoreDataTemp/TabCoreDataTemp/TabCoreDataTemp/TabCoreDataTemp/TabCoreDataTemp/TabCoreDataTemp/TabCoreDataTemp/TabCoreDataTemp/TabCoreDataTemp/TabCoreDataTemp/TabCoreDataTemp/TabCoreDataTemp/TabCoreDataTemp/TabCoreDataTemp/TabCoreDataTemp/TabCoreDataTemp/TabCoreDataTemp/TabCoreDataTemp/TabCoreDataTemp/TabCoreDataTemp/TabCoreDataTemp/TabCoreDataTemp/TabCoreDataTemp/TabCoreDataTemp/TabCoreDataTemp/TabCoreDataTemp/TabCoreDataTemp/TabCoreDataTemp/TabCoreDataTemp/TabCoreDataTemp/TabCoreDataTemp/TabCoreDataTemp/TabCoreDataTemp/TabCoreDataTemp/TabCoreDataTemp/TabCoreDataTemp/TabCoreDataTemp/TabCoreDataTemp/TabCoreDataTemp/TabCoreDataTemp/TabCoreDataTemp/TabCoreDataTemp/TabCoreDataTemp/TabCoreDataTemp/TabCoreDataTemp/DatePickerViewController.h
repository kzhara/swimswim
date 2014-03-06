//
//  DatePickerViewController.h
//  TabCoreDataTemp
//
//  Created by kzhara13 on 2013/06/16.
//
//

#import <UIKit/UIKit.h>

@class DatePickerViewController;

@protocol DatePickerViewControllerDelegate
- (void)didCommitButtonClicked:(DatePickerViewController *)controller selectedDate:(NSDate *)selectedDate;
- (void)didCancelButtonClicked:(DatePickerViewController *)controller;

@end


@interface DatePickerViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) id<DatePickerViewControllerDelegate> delegate;
- (IBAction)cancelBtn:(id)sender;
- (IBAction)doneBtn:(id)sender;

@end
