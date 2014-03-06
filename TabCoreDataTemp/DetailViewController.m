//
//  DetailViewController.m
//  TabCoreDataTemp
//
//  Created by 真有 津坂 on 12/03/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "MasterViewController.h"
#import "AppDelegate.h"


@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController {
    UIPickerView *upicker;
}


@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel;
@synthesize timeStampField;
@synthesize swimdatafield;
@synthesize editEndDate = _editEndDate;
@synthesize editStartDate = _editStartDate;
@synthesize swimdistance;
@synthesize weightFeild;
@synthesize pickerData;
@synthesize swimData;
@synthesize memo;

@synthesize styleField1;
@synthesize styleField2;
@synthesize styleField3;
@synthesize styleField4;
@synthesize styleField5;
@synthesize styleField6;
@synthesize styleField7;

@synthesize meterField1;
@synthesize meterField2;
@synthesize meterField3;
@synthesize meterField4;
@synthesize meterField5;
@synthesize meterField6;
@synthesize meterField7;


@synthesize secField1;
@synthesize secField2;
@synthesize secField3;
@synthesize secField4;
@synthesize secField5;
@synthesize secField6;
@synthesize secField7;


@synthesize setField1;
@synthesize setField2;
@synthesize setField3;
@synthesize setField4;
@synthesize setField5;
@synthesize setField6;
@synthesize setField7;


@synthesize totalField1;
@synthesize totalField2;
@synthesize totalField3;
@synthesize totalField4;
@synthesize totalField5;
@synthesize totalField6;
@synthesize totalField7;


//MapViewControllerから値をもらうところ。
- (void)finishView:(NSMutableDictionary*)returnValue{
    NSLog(@"%@" , returnValue);
    memo = returnValue;
    
}

//
- (void)keyboardWillShow:(NSNotification *)note {

//    CGPoint scrollPoint = CGPointMake(0.0,50.0);
//    [self.scrollView setContentOffset:scrollPoint animated:YES];



}



// 「履歴」ボタンがタップされたときに呼び出されるメソッド
- (IBAction)openPickerView:(id)sender {
    //キーボード表示を消す
    [ swimdistance resignFirstResponder ];
    [ swimdistance endEditing:(YES)];
    [ weightFeild resignFirstResponder ];
    [ weightFeild endEditing:(YES)];
    [timeStampField resignFirstResponder];
    [timeStampField endEditing:YES];
    [swimdatafield resignFirstResponder];
    [swimdatafield endEditing:YES];
    upicker.hidden = YES;

//　pickerViewControllerで表示する項目を渡す
    // PickerViewControllerのインスタンスをStoryboardから取得し
    self.pickerViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"PickerViewController"];
    self.pickerViewController.delegate = self;
    
    // PickerViewをサブビューとして表示する
    // 表示するときはアニメーションをつけて下から上にゆっくり表示させる
    
    // アニメーション完了時のPickerViewの位置を計算
    UIView *pickerView = self.pickerViewController.view;
    CGPoint middleCenter = pickerView.center;
    
    // アニメーション開始時のPickerViewの位置を計算
    UIWindow* mainWindow = (((AppDelegate*) [UIApplication sharedApplication].delegate).window);
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    pickerView.center = offScreenCenter;
    
    [mainWindow addSubview:pickerView];
    
    // アニメーションを使ってPickerViewをアニメーション完了時の位置に表示されるようにする
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    pickerView.center = middleCenter;
    [UIView commitAnimations];


}

- (IBAction)editPickerView:(id)sender {
    
    //保存データ読み込み
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *array = [defaults arrayForKey:@"pools"];
            
            
            NSMutableArray *sarray = [NSMutableArray array];

            [sarray addObjectsFromArray:array];

            //削除コマンド
            [sarray removeObject:swimdatafield.text];
            
            NSSet* uniqueElements = [NSSet setWithArray:sarray];
            NSArray *uarray = [uniqueElements allObjects];
            
    swimdatafield.text = @"";
            
            self.swimData = uarray;
            
            if (uarray) {
                for (NSString *data in uarray) {
                    NSLog(@"%@ 削除後", data);
                }
            } else {
                NSLog(@"%@", @"データが存在しません。");
            }
            
            //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:uarray forKey:@"pools"];
            BOOL successful = [defaults synchronize];
            if (successful) {
                NSLog(@"%@", @"データの保存に成功しました。");
            }
            

}

- (IBAction)mapBtn:(id)sender {
    [self performSegueWithIdentifier:@"mapSeg" sender:self];
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"mapSeg"]) {
        MapViewController *viewCon = segue.destinationViewController;
        viewCon.delegate = self;
        viewCon.myValue = @"test";
    }
}


// PickerViewのある行が選択されたときに呼び出されるPickerViewControllerDelegateプロトコルのデリゲートメソッド
- (void)applySelectedString:(NSString *)str
{
    self.selectedStringLabel.text = str;
    swimdatafield.text = str;
}

// PickerViewController上にある透明ボタンがタップされたときに呼び出されるPickerViewControllerDelegateプロトコルのデリゲートメソッド
- (void)closePickerView:(PickerViewController *)controller
{
    // PickerViewをアニメーションを使ってゆっくり非表示にする
    UIView *pickerView = controller.view;
    
    // アニメーション完了時のPickerViewの位置を計算
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    
    [UIView beginAnimations:nil context:(void *)pickerView];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    // アニメーション終了時に呼び出す処理を設定
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    pickerView.center = offScreenCenter;
    [UIView commitAnimations];
}

// 単位のPickerViewを閉じるアニメーションが終了したときに呼び出されるメソッド
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    // PickerViewをサブビューから削除
    UIView *pickerView = (__bridge UIView *)context;
    [pickerView removeFromSuperview];
}


-(void)updateTextField:(id)sender
{
    if([_editStartDate isFirstResponder]){
        UIDatePicker *picker = (UIDatePicker*)_editStartDate.inputView;
        _editStartDate.text = [NSString stringWithFormat:@"%@",picker.date];
    }
    if([_editEndDate isFirstResponder]){
        UIDatePicker *picker = (UIDatePicker*)_editEndDate.inputView;
        _editEndDate.text = [NSString stringWithFormat:@"%@",picker.date];
    }
    if([timeStampField isFirstResponder]){
        UIDatePicker *picker = (UIDatePicker*)timeStampField.inputView;

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // フォーマットを指定の日付フォーマットに設定
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"]; //"yyyy/MM/dd HH:mm:ss.SSS"
        // 日付型の文字列を生成
//        NSString *t1 = [NSString stringWithFormat:@"%@",picker.date]; //[dateFormatter stringFromDate:timeStampDisp];
        
    timeStampField.text = [dateFormatter stringFromDate:picker.date];
        
//        timeStampField.text = t1;
    }
}


//6.12 23:30added
- (Event *)detailItem
{
    if (!_detailItem) {
        _detailItem = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Event class])
                                                    inManagedObjectContext:self.managedObjectContext];
        _detailItem.record = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Record class])
                                                            inManagedObjectContext:self.managedObjectContext];
    }
    return _detailItem;
}




//以下追加、This code is added.
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(320, 310);

    //ツールバーを生成
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    //スタイルの設定
    toolBar.barStyle = UIBarStyleDefault;
    //ツールバーを画面サイズに合わせる
    [toolBar sizeToFit];
    // 「完了」ボタンを右端に配置したいためフレキシブルなスペースを作成する。
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    //　完了ボタンの生成
    UIBarButtonItem *_commitBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeKeyboard:)];
    // ボタンをToolbarに設定
    NSArray *toolBarItems = [NSArray arrayWithObjects:spacer, _commitBtn, nil];
    // 表示・非表示の設定
    [toolBar setItems:toolBarItems animated:YES];
    // ToolbarをswimdistanceのinputAccessoryViewに設定
    self.swimdistance.inputAccessoryView = toolBar;
    self.weightFeild.inputAccessoryView = toolBar;

    self.meterField1.inputAccessoryView = toolBar;
    self.meterField2.inputAccessoryView = toolBar;
    self.meterField3.inputAccessoryView = toolBar;
    self.meterField4.inputAccessoryView = toolBar;
    self.meterField5.inputAccessoryView = toolBar;
    self.meterField6.inputAccessoryView = toolBar;
    self.meterField7.inputAccessoryView = toolBar;
    
    self.secField1.inputAccessoryView = toolBar;
    self.secField2.inputAccessoryView = toolBar;
    self.secField3.inputAccessoryView = toolBar;
    self.secField4.inputAccessoryView = toolBar;
    self.secField5.inputAccessoryView = toolBar;
    self.secField6.inputAccessoryView = toolBar;
    self.secField7.inputAccessoryView = toolBar;
    
    self.setField1.inputAccessoryView = toolBar;
    self.setField2.inputAccessoryView = toolBar;
    self.setField3.inputAccessoryView = toolBar;
    self.setField4.inputAccessoryView = toolBar;
    self.setField5.inputAccessoryView = toolBar;
    self.setField6.inputAccessoryView = toolBar;
    self.setField7.inputAccessoryView = toolBar;
    
    self.totalField1.inputAccessoryView = toolBar;
    self.totalField2.inputAccessoryView = toolBar;
    self.totalField3.inputAccessoryView = toolBar;
    self.totalField4.inputAccessoryView = toolBar;
    self.totalField5.inputAccessoryView = toolBar;
    self.totalField6.inputAccessoryView = toolBar;
    self.totalField7.inputAccessoryView = toolBar;

    
    // デリゲート先を設定
    [self.styleField1 setDelegate:self];
    [self.styleField2 setDelegate:self];
    [self.styleField3 setDelegate:self];
    [self.styleField4 setDelegate:self];
    [self.styleField5 setDelegate:self];
    [self.styleField6 setDelegate:self];
    [self.styleField7 setDelegate:self];

    [self.meterField1 setDelegate:self];
    [self.meterField2 setDelegate:self];
    [self.meterField3 setDelegate:self];
    [self.meterField4 setDelegate:self];
    [self.meterField5 setDelegate:self];
    [self.meterField6 setDelegate:self];
    [self.meterField7 setDelegate:self];

    [self.secField1 setDelegate:self];
    [self.secField2 setDelegate:self];
    [self.secField3 setDelegate:self];
    [self.secField4 setDelegate:self];
    [self.secField5 setDelegate:self];
    [self.secField6 setDelegate:self];
    [self.secField7 setDelegate:self];
    
    [self.setField1 setDelegate:self];
    [self.setField2 setDelegate:self];
    [self.setField3 setDelegate:self];
    [self.setField4 setDelegate:self];
    [self.setField5 setDelegate:self];
    [self.setField6 setDelegate:self];
    [self.setField7 setDelegate:self];

    
    [self.totalField1 setDelegate:self];
    [self.totalField2 setDelegate:self];
    [self.totalField3 setDelegate:self];
    [self.totalField4 setDelegate:self];
    [self.totalField5 setDelegate:self];
    [self.totalField6 setDelegate:self];
    [self.totalField7 setDelegate:self];
    
    detailDescriptionLabel.text = @"Swim detail";

    // UIPickerのインスタンス化
    upicker = [[UIPickerView alloc]init];
    
    // デリゲートを設定
    upicker.delegate = self;
    
    // データソースを設定
    upicker.dataSource = self;
    
    // 選択インジケータを表示
    upicker.showsSelectionIndicator = YES;
    
    //高さの調整
    upicker.backgroundColor = [UIColor redColor];
    CGRect rect = upicker.frame;
    rect.origin.y -= -150;
    upicker.frame = rect;
    
    // UIPickerのインスタンスをビューに追加
//    [self.view addSubview:upicker];



    // イニシャライザ
    UIDatePicker *datePicker= [[UIDatePicker alloc]init];
    
    // 日付の表示モードを変更する(時分を表示)
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
    // 分の刻みを10分おきにする
    datePicker.minuteInterval = 10;

    
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [_editStartDate setInputView:datePicker];
    
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [_editEndDate setInputView:datePicker];

    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [timeStampField setInputView:datePicker];



// doneボタンを加えた　6/9 23:40
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                          target:self
                                                                          action:@selector(done)];
    self.navigationItem.rightBarButtonItem = item;


    
    
// テンキーの表示をウォッチング（テンキーにdoneボタンを表示させる切り替えのため）
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    

    [self configureView];
    
    
}

-(void)closeKeyboard:(id)sender{
//      [self.scrollView setContentOffset:CGPointZero animated:YES];

    int meterField1value = [meterField1.text intValue];
    int setField1value = [setField1.text intValue];
    int totalField1value = meterField1value * setField1value;
    totalField1.text = [NSString stringWithFormat:@"%d",totalField1value];
    
    int meterField2value = [meterField2.text intValue];
    int setField2value = [setField2.text intValue];
    int totalField2value = meterField2value * setField2value;
    totalField2.text = [NSString stringWithFormat:@"%d",totalField2value];
    
    int meterField3value = [meterField3.text intValue];
    int setField3value = [setField3.text intValue];
    int totalField3value = meterField3value * setField3value;
    totalField3.text = [NSString stringWithFormat:@"%d",totalField3value];
    
    int meterField4value = [meterField4.text intValue];
    int setField4value = [setField4.text intValue];
    int totalField4value = meterField4value * setField4value;
    totalField4.text = [NSString stringWithFormat:@"%d",totalField4value];
    
    int meterField5value = [meterField5.text intValue];
    int setField5value = [setField5.text intValue];
    int totalField5value = meterField5value * setField5value;
    totalField5.text = [NSString stringWithFormat:@"%d",totalField5value];
    
    int meterField6value = [meterField6.text intValue];
    int setField6value = [setField6.text intValue];
    int totalField6value = meterField6value * setField6value;
    totalField6.text = [NSString stringWithFormat:@"%d",totalField6value];
    
    int meterField7value = [meterField7.text intValue];
    int setField7value = [setField7.text intValue];
    int totalField7value = meterField7value * setField7value;
    totalField7.text = [NSString stringWithFormat:@"%d",totalField7value];
    
    int totalvalue = totalField1value
    +totalField2value
    +totalField3value
    +totalField4value
    +totalField5value
    +totalField6value
    +totalField7value;
    
    swimdistance.text = [NSString stringWithFormat:@"%d",totalvalue];


    
    [swimdistance resignFirstResponder];

    [weightFeild resignFirstResponder];

    [meterField1 resignFirstResponder];
    [meterField2 resignFirstResponder];
    [meterField3 resignFirstResponder];
    [meterField4 resignFirstResponder];
    [meterField5 resignFirstResponder];
    [meterField6 resignFirstResponder];
    [meterField7 resignFirstResponder];
    
    [secField1 resignFirstResponder];
    [secField2 resignFirstResponder];
    [secField3 resignFirstResponder];
    [secField4 resignFirstResponder];
    [secField5 resignFirstResponder];
    [secField6 resignFirstResponder];
    [secField7 resignFirstResponder];
    
    [setField1 resignFirstResponder];
    [setField2 resignFirstResponder];
    [setField3 resignFirstResponder];
    [setField4 resignFirstResponder];
    [setField5 resignFirstResponder];
    [setField6 resignFirstResponder];
    [setField7 resignFirstResponder];
    
    [totalField1 resignFirstResponder];
    [totalField2 resignFirstResponder];
    [totalField3 resignFirstResponder];
    [totalField4 resignFirstResponder];
    [totalField5 resignFirstResponder];
    [totalField6 resignFirstResponder];
    [totalField7 resignFirstResponder];
}





//キーボードのリターンキーが押されたとき
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    int meterField1value = [meterField1.text intValue];
    int setField1value = [setField1.text intValue];
    int totalField1value = meterField1value * setField1value;
    totalField1.text = [NSString stringWithFormat:@"%d",totalField1value];

    int meterField2value = [meterField2.text intValue];
    int setField2value = [setField2.text intValue];
    int totalField2value = meterField2value * setField2value;
    totalField2.text = [NSString stringWithFormat:@"%d",totalField2value];
    
    int meterField3value = [meterField3.text intValue];
    int setField3value = [setField3.text intValue];
    int totalField3value = meterField3value * setField3value;
    totalField3.text = [NSString stringWithFormat:@"%d",totalField3value];
    
    int meterField4value = [meterField4.text intValue];
    int setField4value = [setField4.text intValue];
    int totalField4value = meterField4value * setField4value;
    totalField4.text = [NSString stringWithFormat:@"%d",totalField4value];
    
    int meterField5value = [meterField5.text intValue];
    int setField5value = [setField5.text intValue];
    int totalField5value = meterField5value * setField5value;
    totalField5.text = [NSString stringWithFormat:@"%d",totalField5value];
    
    int meterField6value = [meterField6.text intValue];
    int setField6value = [setField6.text intValue];
    int totalField6value = meterField6value * setField6value;
    totalField6.text = [NSString stringWithFormat:@"%d",totalField6value];
    
    int meterField7value = [meterField7.text intValue];
    int setField7value = [setField7.text intValue];
    int totalField7value = meterField7value * setField7value;
    totalField7.text = [NSString stringWithFormat:@"%d",totalField7value];
    
    int totalvalue = totalField1value
                    +totalField2value
                    +totalField3value
                    +totalField4value
                    +totalField5value
                    +totalField6value
                    +totalField7value;
    
    swimdistance.text = [NSString stringWithFormat:@"%d",totalvalue];


    // ソフトウェアキーボードを閉じる
    [textField resignFirstResponder];
    
    return YES;
}


/**
 * ピッカーに表示する列数を返す
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

/**
 * ピッカーに表示する行数を返す
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return 5;
}

/**
 * 行のサイズを変更
 */
- (CGFloat)pickerView:(UIPickerView *)pickerView
    widthForComponent:(NSInteger)component
{
    switch (component) {
        case 0: // 1列目
            return 50.0;
            break;
            
        case 1: // 2列目
            return 100.0;
            break;
            
        case 2: // 3列目
            return 150.0;
            break;
            
        default:
            return 0;
            break;
    }
}

/**
 * ピッカーに表示する値を返す
 */
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0: // 1列目
            return [NSString stringWithFormat:@"%d", row];
            break;
            
        case 1: // 2列目
            return [NSString stringWithFormat:@"%d行目", row];
            break;
            
        case 2: // 3列目
            return [NSString stringWithFormat:@"%d列-%d行", component, row];
            break;
            
        default:
            return 0;
            break;
    }
}

/**
 * ピッカーの選択行が決まったとき
 */
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // 1列目の選択された行数を取得
    NSInteger val0 = [pickerView selectedRowInComponent:0];
    
    // 2列目の選択された行数を取得
//    NSInteger val1 = [pickerView selectedRowInComponent:1];
    
    // 3列目の選択された行数を取得
//    NSInteger val2 = [pickerView selectedRowInComponent:2];
    
    NSLog(@"1列目:%d行目が選択", val0);
//    NSLog(@"2列目:%d行目が選択", val1);
 //   NSLog(@"3列目:%d行目が選択", val2);
}







- (void)configureView
{
   [self becomeFirstResponder];

    if (self.detailItem) {
        
        NSString *ts = self.detailItem.timeStamp;
        if (ts == NULL) {

            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSArray *array = [defaults arrayForKey:@"pools"];
            if (array) {
                for (NSString *data in array) {
                    NSLog(@"%@", data);
                }
            } else {
                NSLog(@"%@", @"データが存在しません。");
            }
            
// このアレイからプール名を抜き出す
            
            NSString *str = [array objectAtIndex:0];
            

            // 現在の日時を文字列で得る
            NSDate *timeStampDisp = [NSDate date];
            
            // 日付フォーマットオブジェクトの生成
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            // フォーマットを指定の日付フォーマットに設定
            [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"]; //"yyyy/MM/dd HH:mm:ss.SSS"
            // 日付型の文字列を生成
            NSString *t1 = [dateFormatter stringFromDate:timeStampDisp];
            
            
            NSString *t2 = @" ";
            NSString *timeStampOut = [NSString stringWithFormat:@"%@ %@",t1,t2];
            
            self.detailItem.timeStamp = timeStampOut; //t1;
            self.timeStampField.text = t1;
            self.swimdatafield.text = str;

        }
        
        
        
//****************************ここで保存データを表示させる*****************************
        
        else{
            
            self.timeStampField.text = [ts substringWithRange: NSMakeRange(0, 16)];

            self.swimdatafield.text = self.detailItem.record.swimdata;
            self.weightFeild.text = self.detailItem.record.other;
            self.swimdistance.text = self.detailItem.record.score;

            self.styleField1.text = self.detailItem.record.styleField1;
            self.styleField2.text = self.detailItem.record.styleField2;
            self.styleField3.text = self.detailItem.record.styleField3;
            self.styleField4.text = self.detailItem.record.styleField4;
            self.styleField5.text = self.detailItem.record.styleField5;
            self.styleField6.text = self.detailItem.record.styleField6;
            self.styleField7.text = self.detailItem.record.styleField7;

            self.meterField1.text = self.detailItem.record.meterField1;
            self.meterField2.text = self.detailItem.record.meterField2;
            self.meterField3.text = self.detailItem.record.meterField3;
            self.meterField4.text = self.detailItem.record.meterField4;
            self.meterField5.text = self.detailItem.record.meterField5;
            self.meterField6.text = self.detailItem.record.meterField6;
            self.meterField7.text = self.detailItem.record.meterField7;
        
            
            self.secField1.text = self.detailItem.record.secField1;
            self.secField2.text = self.detailItem.record.secField2;
            self.secField3.text = self.detailItem.record.secField3;
            self.secField4.text = self.detailItem.record.secField4;
            self.secField5.text = self.detailItem.record.secField5;
            self.secField6.text = self.detailItem.record.secField6;
            self.secField7.text = self.detailItem.record.secField7;
            
            self.setField1.text = self.detailItem.record.setField1;
            self.setField2.text = self.detailItem.record.setField2;
            self.setField3.text = self.detailItem.record.setField3;
            self.setField4.text = self.detailItem.record.setField4;
            self.setField5.text = self.detailItem.record.setField5;
            self.setField6.text = self.detailItem.record.setField6;
            self.setField7.text = self.detailItem.record.setField7;
            
            self.totalField1.text = self.detailItem.record.totalField1;
            self.totalField2.text = self.detailItem.record.totalField2;
            self.totalField3.text = self.detailItem.record.totalField3;
            self.totalField4.text = self.detailItem.record.totalField4;
            self.totalField5.text = self.detailItem.record.totalField5;
            self.totalField6.text = self.detailItem.record.totalField6;
            self.totalField7.text = self.detailItem.record.totalField7;
            
            }
    }
    
}

// doneボタンで入力データを保存する。

- (void)done
{

    // 日付フォーマットオブジェクトの生成
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // フォーマットを指定の日付フォーマットに設定
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"]; //"yyyy/MM/dd HH:mm:ss.SSS"
    // 日付型の文字列を生成
    NSString *t1 = timeStampField.text; 
    NSString *t2 = swimdistance.text;
    NSString *p1 = swimdatafield.text;
    
    
    NSString *timeStampOut = [NSString stringWithFormat:@"%@ %@ %@",t1,p1,t2];
    
    self.detailItem.timeStamp = timeStampOut; //t1;
    self.detailItem.record.swimdata = self.swimdatafield.text;
    self.detailItem.record.location = self.swimdatafield.text;
    self.detailItem.record.score = self.swimdistance.text;
    self.detailItem.record.other = self.weightFeild.text;
    self.detailItem.record.swimday = timeStampOut;
//    self.detailItem.record.memo = self.memo;

    self.detailItem.record.styleField1 = self.styleField1.text;
    self.detailItem.record.styleField2 = self.styleField2.text;
    self.detailItem.record.styleField3 = self.styleField3.text;
    self.detailItem.record.styleField4 = self.styleField4.text;
    self.detailItem.record.styleField5 = self.styleField5.text;
    self.detailItem.record.styleField6 = self.styleField6.text;
    self.detailItem.record.styleField7 = self.styleField7.text;
    
    self.detailItem.record.meterField1 = self.meterField1.text;
    self.detailItem.record.meterField2 = self.meterField2.text;
    self.detailItem.record.meterField3 = self.meterField3.text;
    self.detailItem.record.meterField4 = self.meterField4.text;
    self.detailItem.record.meterField5 = self.meterField5.text;
    self.detailItem.record.meterField6 = self.meterField6.text;
    self.detailItem.record.meterField7 = self.meterField7.text;

    
    self.detailItem.record.secField1 = self.secField1.text;
    self.detailItem.record.secField2 = self.secField2.text;
    self.detailItem.record.secField3 = self.secField3.text;
    self.detailItem.record.secField4 = self.secField4.text;
    self.detailItem.record.secField5 = self.secField5.text;
    self.detailItem.record.secField6 = self.secField6.text;
    self.detailItem.record.secField7 = self.secField7.text;
    
    self.detailItem.record.setField1 = self.setField1.text;
    self.detailItem.record.setField2 = self.setField2.text;
    self.detailItem.record.setField3 = self.setField3.text;
    self.detailItem.record.setField4 = self.setField4.text;
    self.detailItem.record.setField5 = self.setField5.text;
    self.detailItem.record.setField6 = self.setField6.text;
    self.detailItem.record.setField7 = self.setField7.text;

    
    self.detailItem.record.totalField1 = self.totalField1.text;
    self.detailItem.record.totalField2 = self.totalField2.text;
    self.detailItem.record.totalField3 = self.totalField3.text;
    self.detailItem.record.totalField4 = self.totalField4.text;
    self.detailItem.record.totalField5 = self.totalField5.text;
    self.detailItem.record.totalField6 = self.totalField6.text;
    self.detailItem.record.totalField7 = self.totalField7.text;
    
    
//データ保存　NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *array = [defaults arrayForKey:@"pools"];
            
            
            NSMutableArray *sarray = [NSMutableArray array];
            [sarray addObject:swimdatafield.text];
            [sarray addObjectsFromArray:array];
            
            NSSet* uniqueElements = [NSSet setWithArray:sarray];
            NSArray *uarray = [uniqueElements allObjects];

            
            self.swimData = uarray;
            
            NSLog(@"sarray are : %@",  self.swimData);
            //    self.detailItem.record.swimday= self.swimData;

            
            //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:uarray forKey:@"pools"];
            BOOL successful = [defaults synchronize];
            if (successful) {
                NSLog(@"%@", @"データの保存に成功しました。");
            }
    
    
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    [self.view endEditing:YES];
}

//ここまで


- (void)viewDidUnload
{
    [self setDetailDescriptionLabel:nil];
    [self setSwimdatafield:nil];
    [self setSwimdistance:nil];
    [self setWeightFeild:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)textSset:(id)sender {
    [ timeStampField resignFirstResponder ];
    [ timeStampField endEditing:(YES)];
}

- (IBAction)textEset:(id)sender {
    
    [ _editEndDate resignFirstResponder];
    [ _editEndDate endEditing:(YES)];
    
}
- (IBAction)didTimeStamp:(id)sender {
    [sender resignFirstResponder];
     [timeStampField endEditing:YES];
}
- (IBAction)didSwimData:(id)sender {
    [sender resignFirstResponder];
    [swimdatafield endEditing:YES];
    [ swimdistance resignFirstResponder ];
    [ swimdistance endEditing:(YES)];
    [ weightFeild resignFirstResponder ];
    [ weightFeild endEditing:(YES)];
    [timeStampField resignFirstResponder];
    [timeStampField endEditing:YES];
    [swimdatafield resignFirstResponder];
    [swimdatafield endEditing:YES];


}
- (IBAction)didSwimDistance:(id)sender {
    [sender resignFirstResponder];
    [swimdistance endEditing:YES];
}
- (IBAction)didWeightFeild:(id)sender {
    [sender resignFirstResponder];
    [weightFeild endEditing:YES];
}

- (IBAction)swimdataStart:(id)sender {
//    [sender resignFirstResponder];

 
//[self.view addSubview:upicker];
//    upicker.hidden = NO;

    
}






- (IBAction)gesIn:(id)sender {
/*
    [ swimdistance resignFirstResponder ];
    [ swimdistance endEditing:(YES)];
    [ weightFeild resignFirstResponder ];
    [ weightFeild endEditing:(YES)];
    [timeStampField resignFirstResponder];
    [timeStampField endEditing:YES];
    [swimdatafield resignFirstResponder];
    [swimdatafield endEditing:YES];
    upicker.hidden = YES;
*/

}

- (void)doneButton:(id)sender {
    [ swimdistance resignFirstResponder ];
    [ swimdistance endEditing:(YES)];
    [ weightFeild resignFirstResponder ];
    [ weightFeild endEditing:(YES)];
    [timeStampField resignFirstResponder];
    [timeStampField endEditing:YES];
    [swimdatafield resignFirstResponder];
    [swimdatafield endEditing:YES];
    upicker.hidden = YES;
}


- (IBAction)stylePicker1:(id)sender {
    //キーボード表示を消す
    [ styleField1 resignFirstResponder ];
    [ styleField1 endEditing:(YES)];
    [ styleField2 resignFirstResponder ];
    [ styleField2 endEditing:(YES)];
    [ styleField3 resignFirstResponder ];
    [ styleField3 endEditing:(YES)];
    [ styleField4 resignFirstResponder ];
    [ styleField4 endEditing:(YES)];
    [ styleField5 resignFirstResponder ];
    [ styleField5 endEditing:(YES)];
    [ styleField6 resignFirstResponder ];
    [ styleField6 endEditing:(YES)];
    [ styleField7 resignFirstResponder ];
    [ styleField7 endEditing:(YES)];
    
    [ swimdistance resignFirstResponder ];
    [ swimdistance endEditing:(YES)];
    [ weightFeild resignFirstResponder ];
    [ weightFeild endEditing:(YES)];
    [timeStampField resignFirstResponder];
    [timeStampField endEditing:YES];
    [swimdatafield resignFirstResponder];
    [swimdatafield endEditing:YES];
    upicker.hidden = YES;
    
    //　pickerViewControllerで表示する項目を渡す
    // PickerViewControllerのインスタンスをStoryboardから取得し
    self.pickerViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"PickerViewController"];
    self.pickerViewController.delegate = self;
    
    // PickerViewをサブビューとして表示する
    // 表示するときはアニメーションをつけて下から上にゆっくり表示させる
    
    // アニメーション完了時のPickerViewの位置を計算
    UIView *pickerView = self.pickerViewController.view;
    CGPoint middleCenter = pickerView.center;
    
    // アニメーション開始時のPickerViewの位置を計算
    UIWindow* mainWindow = (((AppDelegate*) [UIApplication sharedApplication].delegate).window);
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    pickerView.center = offScreenCenter;
    
    [mainWindow addSubview:pickerView];
    
    // アニメーションを使ってPickerViewをアニメーション完了時の位置に表示されるようにする
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    pickerView.center = middleCenter;
    [UIView commitAnimations];

}
@end
