//
//  DetailViewController.h
//  TabCoreDataTemp
//
//  Created by 真有 津坂 on 12/03/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "PickerViewController.h"
#import "MapViewController.h"



@interface DetailViewController : UIViewController    <UIActionSheetDelegate,UIPickerViewDelegate, UIPickerViewDataSource,PickerViewControllerDelegate,MapViewDelegate,UITextFieldDelegate>
{
	UIActionSheet *actionSheet;
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) Event *detailItem;
@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) IBOutlet NSArray *swimData;

@property (weak, nonatomic) IBOutlet UITextField *timeStampField;
- (IBAction)didTimeStamp:(id)sender;
@property (nonatomic, retain) IBOutlet NSArray *pickerData;
@property (weak, nonatomic) IBOutlet UITextField *swimdatafield;
- (IBAction)didSwimData:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *editStartDate;
@property (weak, nonatomic) IBOutlet UITextField *editEndDate;
- (IBAction)textSset:(id)sender;
- (IBAction)textEset:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *swimdistance;
- (IBAction)didSwimDistance:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *weightFeild;
- (IBAction)didWeightFeild:(id)sender;

- (IBAction)swimdataStart:(id)sender;
@property (weak, nonatomic) NSMutableDictionary *memo;


- (IBAction)stylePicker1:(id)sender;


//@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

// 「選択」ボタン
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

// PickerViewで選択された文字列を表示するラベル
@property (weak, nonatomic) IBOutlet UILabel *selectedStringLabel;

// 呼び出すPickerViewControllerのポインタ　※strongを指定してポインタを掴んでおかないと解放されてしまう
@property (strong, nonatomic) PickerViewController *pickerViewController;

// 「選択」ボタンがタップされたときに呼び出されるメソッド
- (IBAction)openPickerView:(id)sender;

- (IBAction)editPickerView:(id)sender;

- (IBAction)mapBtn:(id)sender;



@property (weak, nonatomic) IBOutlet UITextField *styleField1;
@property (weak, nonatomic) IBOutlet UITextField *styleField2;
@property (weak, nonatomic) IBOutlet UITextField *styleField3;
@property (weak, nonatomic) IBOutlet UITextField *styleField4;
@property (weak, nonatomic) IBOutlet UITextField *styleField5;
@property (weak, nonatomic) IBOutlet UITextField *styleField6;
@property (weak, nonatomic) IBOutlet UITextField *styleField7;


@property (weak, nonatomic) IBOutlet UITextField *meterField1;
@property (weak, nonatomic) IBOutlet UITextField *meterField2;
@property (weak, nonatomic) IBOutlet UITextField *meterField3;
@property (weak, nonatomic) IBOutlet UITextField *meterField4;
@property (weak, nonatomic) IBOutlet UITextField *meterField5;
@property (weak, nonatomic) IBOutlet UITextField *meterField6;
@property (weak, nonatomic) IBOutlet UITextField *meterField7;



@property (weak, nonatomic) IBOutlet UITextField *secField1;
@property (weak, nonatomic) IBOutlet UITextField *secField2;
@property (weak, nonatomic) IBOutlet UITextField *secField3;
@property (weak, nonatomic) IBOutlet UITextField *secField4;
@property (weak, nonatomic) IBOutlet UITextField *secField5;
@property (weak, nonatomic) IBOutlet UITextField *secField6;
@property (weak, nonatomic) IBOutlet UITextField *secField7;


@property (weak, nonatomic) IBOutlet UITextField *setField1;
@property (weak, nonatomic) IBOutlet UITextField *setField2;
@property (weak, nonatomic) IBOutlet UITextField *setField3;
@property (weak, nonatomic) IBOutlet UITextField *setField4;
@property (weak, nonatomic) IBOutlet UITextField *setField5;
@property (weak, nonatomic) IBOutlet UITextField *setField6;
@property (weak, nonatomic) IBOutlet UITextField *setField7;


@property (weak, nonatomic) IBOutlet UITextField *totalField1;
@property (weak, nonatomic) IBOutlet UITextField *totalField2;
@property (weak, nonatomic) IBOutlet UITextField *totalField3;
@property (weak, nonatomic) IBOutlet UITextField *totalField4;
@property (weak, nonatomic) IBOutlet UITextField *totalField5;
@property (weak, nonatomic) IBOutlet UITextField *totalField6;
@property (weak, nonatomic) IBOutlet UITextField *totalField7;






@end
