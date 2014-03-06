//
//  ModalDatePickerViewController.h
//  TabCoreDataTemp
//
//  Created by kzhara13 on 2013/06/16.
//
//

#import <UIKit/UIKit.h>


@class ModalDatePickerViewController;
@protocol ModalDatePickerViewControllerDelegate

- (void)didCommitButtonClicked:(ModalDatePickerViewController *)controller selectedDate:(NSDate *)selectedDate pickerName:(NSString *)pickerName;
- (void)didCancelButtonClicked:(ModalDatePickerViewController *)controller pickerName:(NSString *)pickerName;
- (void)didClearButtonClicked:(ModalDatePickerViewController *)controller pickerName:(NSString *)pickerName;

@end

@interface ModalDatePickerViewController : UIViewController {
    NSString *pickerName_;
    NSDate *dispDate_;
    IBOutlet UIDatePicker *picker;
    IBOutlet UIButton *commitButton;
    IBOutlet UIButton *cancelButton;
    IBOutlet UIButton *clearButton;
    id<ModalDatePickerViewControllerDelegate>delegate;
}

- (IBAction)commitButtonClicked:(id)sender;
- (IBAction)cancelButtonClicked:(id)sender;
- (IBAction)clearButtonClicked:(id)sender;

@property (nonatomic, assign) id<ModalDatePickerViewControllerDelegate> tdelegate;
@property (nonatomic, retain) NSString *pickerName_;
@property (nonatomic, retain) NSDate *dispDate_;

@end