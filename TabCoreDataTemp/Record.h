//
//  Record.h
//  TabCoreDataTemp
//
//  Created by kzhara13 on 2013/06/09.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

//@class Event;

@interface
Record : NSManagedObject

@property (nonatomic, retain) NSString * swimdata;
@property (nonatomic, retain) NSString * score;
@property (nonatomic, retain) NSString * other;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * swimday;

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * memo;
@property (nonatomic, retain) NSString * menu;

@property (nonatomic, retain) NSString * styleField1;
@property (nonatomic, retain) NSString * styleField2;
@property (nonatomic, retain) NSString * styleField3;
@property (nonatomic, retain) NSString * styleField4;
@property (nonatomic, retain) NSString * styleField5;
@property (nonatomic, retain) NSString * styleField6;
@property (nonatomic, retain) NSString * styleField7;

@property (nonatomic, retain) NSString * meterField1;
@property (nonatomic, retain) NSString * meterField2;
@property (nonatomic, retain) NSString * meterField3;
@property (nonatomic, retain) NSString * meterField4;
@property (nonatomic, retain) NSString * meterField5;
@property (nonatomic, retain) NSString * meterField6;
@property (nonatomic, retain) NSString * meterField7;


@property (nonatomic, retain) NSString * secField1;
@property (nonatomic, retain) NSString * secField2;
@property (nonatomic, retain) NSString * secField3;
@property (nonatomic, retain) NSString * secField4;
@property (nonatomic, retain) NSString * secField5;
@property (nonatomic, retain) NSString * secField6;
@property (nonatomic, retain) NSString * secField7;


@property (nonatomic, retain) NSString * setField1;
@property (nonatomic, retain) NSString * setField2;
@property (nonatomic, retain) NSString * setField3;
@property (nonatomic, retain) NSString * setField4;
@property (nonatomic, retain) NSString * setField5;
@property (nonatomic, retain) NSString * setField6;
@property (nonatomic, retain) NSString * setField7;

@property (nonatomic, retain) NSString * totalField1;
@property (nonatomic, retain) NSString * totalField2;
@property (nonatomic, retain) NSString * totalField3;
@property (nonatomic, retain) NSString * totalField4;
@property (nonatomic, retain) NSString * totalField5;
@property (nonatomic, retain) NSString * totalField6;
@property (nonatomic, retain) NSString * totalField7;

//@property (nonatomic, retain) Event *event;

@end
