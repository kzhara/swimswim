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



@interface DetailViewController : UIViewController    <UIPickerViewDelegate, UIPickerViewDataSource,PickerViewControllerDelegate>


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



@end
