//
//  PickerViewController.m
//  TabCoreDataTemp
//
//  Created by kzhara13 on 2013/06/24.
//
//

#import "PickerViewController.h"

@interface PickerViewController ()

@end

@implementation PickerViewController
@synthesize pickerData;
int picknum = 0;


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // PickerViewのデリゲート先とデータソースをこのクラスに設定
    self.picker.delegate = self;
    self.picker.dataSource = self;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSArray *array = [defaults arrayForKey:@"pools"];
    if (array) {
        for (NSString *data in array) {
            NSLog(@"%@", data);
        }
    } else {
        NSLog(@"%@", @"データが存在しません。");
    }
    
//    NSArray *array = [[NSArray alloc] initWithObjects:@"勝川", @"サンフロッグ", @"瀬戸", @"星ヶ丘", @"笠寺", @"口論議",
//                      @"市民プール", @"その他", nil];
    self.pickerData = array;
    [self.delegate applySelectedString:[NSString stringWithFormat:@""]];
}

// PickerViewで要素が選択されたときに呼び出されるメソッド
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // デリゲート先の処理を呼び出し、選選択された文字列を親Viewに表示させる
    [self.delegate applySelectedString:[NSString stringWithFormat:@"%@", [pickerData objectAtIndex:row]]];
    picknum = row;
    
}

// PickerViewの列数を指定するメソッド
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView {
    return 1;
}

// PickerViewに表示する行数を指定するメソッド
-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component {
 return[pickerData count];
    //    return 10;
}

// PickerViewの各行に表示する文字列を指定するメソッド
-(NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
 return [pickerData objectAtIndex:row];
    
//    return [NSString stringWithFormat:@"%d", row];
}

// 空の領域にある透明なボタンがタップされたときに呼び出されるメソッド
- (IBAction)closePickerView:(id)sender {
    // PickerViewを閉じるための処理を呼び出す
    [self.delegate closePickerView:self];
}

- (IBAction)doneBtn:(id)sender {
    // PickerViewを閉じるための処理を呼び出す
    [self.delegate closePickerView:self];
}

- (IBAction)delBtn:(id)sender {
    //保存データ読み込み
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *array = [defaults arrayForKey:@"pools"];
    
    
    NSMutableArray *sarray = [NSMutableArray array];
    
    [sarray addObjectsFromArray:array];
    
    NSString *pickD = [pickerData objectAtIndex:picknum];
    
    //削除コマンド
    [sarray removeObject:pickD];
    
    NSSet* uniqueElements = [NSSet setWithArray:sarray];
    NSArray *uarray = [uniqueElements allObjects];
    

    
//    self.swimData = uarray;
    
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
    
    [self.delegate applySelectedString:[NSString stringWithFormat:@""]];    
    
// PickerViewを閉じるための処理を呼び出す
[self.delegate closePickerView:self];
}

- (IBAction)canBtn:(id)sender {
    // PickerViewを閉じるための処理を呼び出す
    [self.delegate closePickerView:self];
}

@end
