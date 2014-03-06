//
//  MapViewController.h
//  TabCoreDataTemp
//
//  Created by kzhara13 on 2013/08/16.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol MapViewDelegate <NSObject>
- (void)finishView:(NSMutableDictionary*)returnValue;//DetailViewに値を渡す。

@end

@interface MapViewController : UIViewController <CLLocationManagerDelegate>{
    NSString* _myValue;
    id<MapViewDelegate> _delegate;
    CLLocationManager *lm;
    double zoom_lv;
    double last_latitude;
    double last_longitude;


    
}
// プロパティ
@property (nonatomic, retain) NSDictionary* logDict;

@property (nonatomic) NSString* myValue;
@property (nonatomic) id<MapViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property (weak, nonatomic) IBOutlet UISegmentedControl *select_zoom;


- (IBAction)mapEndBtn:(id)sender;

- (IBAction)btn_nowLocation:(id)sender;
- (IBAction)btn_spot_a:(id)sender;
- (IBAction)btn_spot_b:(id)sender;
- (IBAction)ctr_zoom:(id)sender;


@end

