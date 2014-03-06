//
//  PickerViewController.h
//  TabCoreDataTemp
//
//  Created by kzhara13 on 2013/06/24.
//
//


#import <UIKit/UIKit.h>

@protocol PickerViewControllerDelegate;

@interface PickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *picker;

// 空の領域にある透明なボタン
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

// 処理のデリゲート先の参照
@property (weak, nonatomic) id<PickerViewControllerDelegate> delegate;

@property (nonatomic, retain) IBOutlet NSArray *pickerData;

// PickerViewを閉じる処理を行うメソッド。closeButtonが押下されたときに呼び出される
- (IBAction)closePickerView:(id)sender;
- (IBAction)doneBtn:(id)sender;
- (IBAction)delBtn:(id)sender;
- (IBAction)canBtn:(id)sender;

@end

@protocol PickerViewControllerDelegate <NSObject>
// 選択された文字列を適用するためのデリゲートメソッド
-(void)applySelectedString:(NSString *)str;
// 当該PickerViewを閉じるためのデリゲートメソッド
-(void)closePickerView:(PickerViewController *)controller;
@end
