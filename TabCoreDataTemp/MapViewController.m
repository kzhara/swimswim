//
//  MapViewController.m
//  TabCoreDataTemp
//
//  Created by kzhara13 on 2013/08/16.
//
//

#import "MapViewController.h"

@interface KMAreaAnnotation : MKPointAnnotation
@end
@implementation KMAreaAnnotation
@end


@interface MapViewController ()
@end
@implementation MapViewController
@synthesize mapview;
@synthesize myValue = _myValue;
@synthesize delegate = _delegate;



int pNum = 0;



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
                zoom_lv = 0.05;
	// Do any additional setup after loading the view.
}

- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{

[mapview removeAnnotations: mapview.annotations];
    
    //地図表示領域　regionの宣言
    MKCoordinateRegion region = mapview.region;
    //地図表示領域regionの緯度経度をGPSから取得した位置に指定
    region.center.latitude = newLocation.coordinate.latitude;//緯度
    region.center.longitude = newLocation.coordinate.longitude;//経度
    //緯度経度を記録
    last_latitude = region.center.latitude;
    last_longitude = region.center.longitude;
    
    //zoomの指定
    region.span.latitudeDelta =  zoom_lv;
    region.span.longitudeDelta = zoom_lv;
    
    //地図を設定範囲で表示
    [mapview setRegion:region animated:YES];
    
    //GPS測位の停止（停止しないと現在地に移動してしまう）
    [lm stopUpdatingLocation];

    MKPointAnnotation* pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = CLLocationCoordinate2DMake(
                                                last_latitude,
                                                last_longitude);
    pin.title = @"現在地";
    pin.subtitle = @"";
    
    [mapview addAnnotation:pin];
    

   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mapEndBtn:(id)sender {

    // ディクショナリに数値を格納する
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    pNum = pNum+1;
    // NSNumberに変換して配列に格納
    [dict setObject:[NSNumber numberWithInt:pNum] forKey:@"position"];
    [dict setObject:[NSNumber numberWithFloat:last_latitude] forKey:@"latitude"];
    [dict setObject:[NSNumber numberWithFloat:last_longitude] forKey:@"longitude"];
    
//    NSLog(@"%@", dict);

    if ([_delegate respondsToSelector:@selector(finishView:)]){
        [_delegate finishView:dict];//DetailViewControllerへ数値を渡す。






    }
    
[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btn_nowLocation:(id)sender {
//    NSLog(@"%@" , _myValue);//渡された変数の表示
    
    //GPSを使って現在位置を取得
    lm = [[CLLocationManager alloc] init];
    
    //lm の設定
    lm.delegate = self;
    lm.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    lm.distanceFilter = kCLDistanceFilterNone;
    
    //GPS測位開始
    [lm startUpdatingLocation];
    
    //電子コンパスの開始
    [lm startUpdatingHeading];

    
}

- (IBAction)btn_spot_a:(id)sender {
[mapview removeAnnotations: mapview.annotations];
    //GPS停止
    [lm stopUpdatingLocation];
    //地図表示領域
    MKCoordinateRegion region = mapview.region;
    //緯度経度
    region.center.latitude = 35.710057714926265;
    region.center.longitude = 139.81071829999996;
    //緯度経度を記録
    last_latitude = region.center.latitude;
    last_longitude = region.center.longitude;
    
    //zoomの指定
    region.span.latitudeDelta =  zoom_lv;
    region.span.longitudeDelta = zoom_lv;
    
    //地図を設定範囲で表示
    [mapview setRegion:region animated:YES];
    MKPointAnnotation* pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = CLLocationCoordinate2DMake(
                                                last_latitude,
                                                last_longitude);
    [mapview addAnnotation:pin];
}

- (IBAction)btn_spot_b:(id)sender {
[mapview removeAnnotations: mapview.annotations];
    //GPS停止
    [lm stopUpdatingLocation];
    //地図表示領域
    MKCoordinateRegion region = mapview.region;
    //緯度経度
    region.center.latitude = 35.658599714609366;
    region.center.longitude = 139.74544259999993;
    //緯度経度を記録
    last_latitude = region.center.latitude;
    last_longitude = region.center.longitude;
    
    //zoomの指定
    region.span.latitudeDelta =  zoom_lv;
    region.span.longitudeDelta = zoom_lv;
    
    //地図を設定範囲で表示
    [mapview setRegion:region animated:YES];
    MKPointAnnotation* pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = CLLocationCoordinate2DMake(
                                                last_latitude,
                                                last_longitude);
    [mapview addAnnotation:pin];
}

- (IBAction)ctr_zoom:(id)sender {
    UISegmentedControl *mySegmented = sender;
    //セグメントコントロール
    switch (mySegmented.selectedSegmentIndex) {
        case 0:
            zoom_lv = 0.003;
            break;
        case 1:
            zoom_lv = 0.05;
            break;
        case 2:
            zoom_lv = 1.0;
            break;
        default:
            zoom_lv = 0.05;
            break;
    }

    //地図表示領域
    MKCoordinateRegion region = mapview.region;
    //緯度経度
    region.center.latitude = last_latitude;
    region.center.longitude = last_longitude;

    //zoomの指定
    region.span.latitudeDelta =  zoom_lv;
    region.span.longitudeDelta = zoom_lv;
    
    //地図を設定範囲で表示
    [mapview setRegion:region animated:YES];
}
- (void)viewDidUnload {

    [self setMapview:nil];
    [super viewDidUnload];
}
@end
