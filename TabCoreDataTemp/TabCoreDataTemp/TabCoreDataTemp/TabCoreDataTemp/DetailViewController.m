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



// 「選択」ボタンがタップされたときに呼び出されるメソッド
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
//    self.scrollView.contentSize = CGSizeMake(320, 800);
    [self configureView];
    
    
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

            // 現在の日時を文字列で得る
            
            NSDate *timeStampDisp = [NSDate date];
            
            // 日付フォーマットオブジェクトの生成
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            // フォーマットを指定の日付フォーマットに設定
            [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"]; //"yyyy/MM/dd HH:mm:ss.SSS"
            // 日付型の文字列を生成
            NSString *t1 = [dateFormatter stringFromDate:timeStampDisp];
            
            
            NSString *t2 = @"場所";
            NSString *timeStampOut = [NSString stringWithFormat:@"%@ %@",t1,t2];
            
            self.detailItem.timeStamp = timeStampOut; //t1;
            self.timeStampField.text = t1;
            self.swimdatafield.text = t2;

        }
        else{
            
            self.timeStampField.text = [ts substringWithRange: NSMakeRange(0, 16)];

            self.swimdatafield.text = self.detailItem.record.swimdata;
            self.weightFeild.text = self.detailItem.record.other;
            self.swimdistance.text = self.detailItem.record.score;
 //           self.swimData  =  self.detailItem.record.locationlist;
            
            }
    }
    
}

// doneの処置を作成中

- (void)done
{
    // 現在の日時を文字列で得る
//    NSDate *date = [NSDate date];

//    NSDate *timeStampDisp = [NSDate date];

    // 日付フォーマットオブジェクトの生成
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // フォーマットを指定の日付フォーマットに設定
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"]; //"yyyy/MM/dd HH:mm:ss.SSS"
    // 日付型の文字列を生成
    NSString *t1 = timeStampField.text; //[dateFormatter stringFromDate:timeStampDisp];
    NSString *t2 = swimdatafield.text;
    NSString *timeStampOut = [NSString stringWithFormat:@"%@ %@",t1,t2];
    
    self.detailItem.timeStamp = timeStampOut; //t1;
    self.detailItem.record.swimdata = self.swimdatafield.text;
    self.detailItem.record.location = self.swimdatafield.text;
    self.detailItem.record.score = self.swimdistance.text;
    self.detailItem.record.other = self.weightFeild.text;

//保存データ読み込み
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *array = [defaults arrayForKey:@"pools"];
            
            
            NSMutableArray *sarray = [NSMutableArray array];
            [sarray addObject:swimdatafield.text];
            [sarray addObjectsFromArray:array];
            
            NSSet* uniqueElements = [NSSet setWithArray:sarray];
            NSArray *uarray = [uniqueElements allObjects];

            
            self.swimData = uarray;
            
            NSLog(@"sarray are : %@",  self.swimData);
            //    self.detailItem.record.locationlist = self.swimData;

            
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


@end
