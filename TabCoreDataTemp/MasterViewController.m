//
//  MasterViewController.m
//  TabCoreDataTemp
//
//  Created by 真有 津坂 on 12/03/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AppDelegate.h"
#import "Event.h"
#import "Record.h"
#import "Srace.h"


@interface MasterViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation MasterViewController
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize detailViewController = _detailViewController;

int y = 0;
int yweek = 0;
int ymonth = 0;

int w = 0;

int weight = 0;
int weightMax =0;

int kcal = 0;
int k = 0;
int kweek = 0;
int kmonth = 0;

NSDate *dateMax;



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
    //+ボタンやEditボタンを作る、Make + and Edit button.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    //おまじない、This code is added.
    __managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
    NSLog(@"After managedObjectContext: %@",  __managedObjectContext);
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//以下追加、This code is added.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}




- (NSUInteger)getCount
{
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Event"
                                   inManagedObjectContext:self.managedObjectContext]];
    [request setIncludesSubentities:NO];
    
    NSError* error = nil;
    NSUInteger count = [self.managedObjectContext countForFetchRequest:request error:&error];
    if (count == NSNotFound) {
        count = 0;
    }
    
    return count;
}












- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];

        
        // Save the context.
        NSError *error = nil;
        if (![context save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];//,,,,
    }   
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}


//6月9日２２：４３edit
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Event *selectedObject =
        [[self fetchedResultsController] objectAtIndexPath:indexPath];
        [[segue destinationViewController] setDetailItem:selectedObject];
    }
    [[segue destinationViewController]
     setManagedObjectContext:self.fetchedResultsController.managedObjectContext];
}




#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil) {
        return __fetchedResultsController;
    }
    
    // Set up the fetched results controller.
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];;
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	    /*
	     Replace this implementation with code to handle the error appropriately.
         
	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return __fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{

    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // 日付フォーマットオブジェクトの生成
    NSString *timeStampDisp = [managedObject valueForKey:@"timeStamp"];
    
    // フォーマットを指定の日付フォーマットに設定
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    // 日付型の文字列を生成
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"]; //"yyyy/MM/dd HH:mm:ss.SSS"

    // timStampDisp（日付時間距離の合成）から西暦を削除しt1aに設定
    NSString *t1 = timeStampDisp; 
    NSString *pStr = [[NSString alloc] init];
    pStr = t1;
    NSString *t1a = [pStr substringFromIndex:5];

    //画面表示する際の距離の単位mを作成し合成
    NSString *t2 = @"m"; //record.swimdata;
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",t1a,t2];

//Recordデータの読み込み　・・・・・
    
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Record"inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSArray *list = [moc executeFetchRequest:request error:&error];
    
    int count = [list count];
    y = 0;
    yweek = 0;
    ymonth = 0;
    k = 0;
    kcal = 0;
    kweek = 0;
    kmonth = 0;
    w = 0;
    weight = 0;
    weightMax =0;


    for(int i=0; i< count; i++){

        NSManagedObject *resultObject = [list objectAtIndex:i];
        //resultObjectに結果(list)から値を抜き出していれている。
        
        NSString *result_score = [resultObject valueForKey:@"score"];//泳いだ距離
        NSString *result_swimday = [resultObject valueForKey:@"swimday"];//泳いだ日
        NSString *result_other = [resultObject valueForKey:@"other"];//体重
        NSString *swimday = [result_swimday substringWithRange: NSMakeRange(0, 10)];
        //文字列日付をNSDateに変換
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy/MM/dd"];
        NSDate* date = [formatter dateFromString:swimday];

        // 現在の日時を文字列で得る
        NSDate *today = [NSDate date];
        
        if(i==0){
            dateMax = date;//一番古い練習記録
        };

        int x = [result_score intValue];
        y = y + x;

        /////// カロリー計算
        /*        エネルギー消費量(kcal)＝１．０５×体重（ｋｇ）×ＭＥＴＳ×時間（Ｈ）
         
         ※ＭＥＴＳ：する運動によって変わります。
         目安：普通の歩行（4～6km/h)：3～4METS、
         ジョギング（8km/h)登山：6-7METS
         水泳、背泳ぎ：7METS
         水泳、平泳ぎ：10METS
         水泳、クロール（速度遅～普通 約45m/分）：8METS
         水泳、クロール（速度早 約45m/分）：11 METS
         水泳、バタフライ：11 METS
         */
        
        int mets = 8;
        weight = [result_other intValue];
        if (weight > 0) {
            weightMax = weight;
        }
        if (weight == 0) {
            NSLog(@"zeroweight");
            weight = weightMax;
        }
        kcal = 1.05*weight*mets*x/1000*0.4;//1kmにかかる時間は0.4
        NSLog(@"消費カロリーは : %d",  kcal);
        k = k + kcal;
    
        NSTimeInterval since;
        since = [dateMax timeIntervalSinceDate: date];
        NSTimeInterval sinceToday;
        sinceToday = [today timeIntervalSinceDate: date];
        
        NSLog(@"開始から経過日は%f日", since/(24*60*60));
        NSLog(@"今日からの経過日は%f日", sinceToday/(24*60*60));
        
        if( sinceToday < 3*24*60*60 && sinceToday >0){
            yweek = yweek + x;
            NSLog(@"yweek is : %d", yweek);
            kweek = kweek + kcal;
            NSLog(@"kweek is : %d", kweek);
        }
        
        //練習した月
        NSString *strDateM = [swimday substringWithRange: NSMakeRange(5, 2)];
        //今月
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
        NSString *tm = [dateFormatter stringFromDate:today];
        NSString *strDateTM = [tm substringWithRange: NSMakeRange(5, 2)];
        int iM = [strDateM intValue];
        int iTm = [strDateTM intValue];
        
        
        if (iM == iTm) {
            ymonth = ymonth + x;
            kmonth = kmonth + kcal;
            NSLog(@"kmonth is : %d", kmonth);
        }
        
        
        NSLog(@"strDateM is : %@",  strDateM);
        NSLog(@"strDateTM is : %@",  strDateTM);
        NSLog(@"swimdata is : %@",  result_score);
        NSLog(@"i is : %d",  i);
        NSLog(@"count is : %d",  count);
        NSLog(@"length is : %d",  y);
        NSLog(@"swimday is : %@", swimday);
        NSLog(@"swimdate is : %@", date);
        NSLog(@"dateMax is : %@", dateMax);
        NSLog(@"今月泳いだ距離は is : %d",  ymonth);
        


        if(i== count-1){
        //データ保存　NSUserDefaults swimtotalに距離yを保存
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:y forKey:@"swimtotal"];
        [defaults setInteger:yweek forKey:@"swimweek"];
        [defaults setInteger:ymonth forKey:@"swimmonth"];
        [defaults setInteger:k forKey:@"kcaltotal"];
        [defaults setInteger:kweek forKey:@"kcalweek"];
        [defaults setInteger:kmonth forKey:@"kcalmonth"];

        BOOL successful = [defaults synchronize];

            if (successful) {
            NSLog(@"%@", @"データの保存に成功しました。");
            }
        }

    } //for loop エンド

    
    NSLog(@"xxxxxxx");

}


- (void)insertNewObject
{

    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:indexPath
                                  animated:YES];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.detailViewController.detailItem = nil;
        self.detailViewController.managedObjectContext =
        self.fetchedResultsController.managedObjectContext;
    } else {
        [self performSegueWithIdentifier:@"showDetail" sender:self];
        }
}

@end
