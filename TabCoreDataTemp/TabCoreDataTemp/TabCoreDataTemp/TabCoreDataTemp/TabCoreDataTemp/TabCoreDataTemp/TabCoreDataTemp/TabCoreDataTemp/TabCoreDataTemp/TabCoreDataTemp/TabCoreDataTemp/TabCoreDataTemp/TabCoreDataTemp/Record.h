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

@interface Record : NSManagedObject

@property (nonatomic, retain) NSString * swimdata;
@property (nonatomic, retain) NSString * score;
@property (nonatomic, retain) NSString * other;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSArray * locationlist;
//@property (nonatomic, retain) Event *event;

@end
