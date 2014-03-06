//
//  Event.h
//  TabCoreDataTemp
//
//  Created by kzhara13 on 2013/06/09.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Record.h"

//@class Record;  // Receiver type 'Record' for instance message is a forward declaration 
//6.12 23:42

@interface Event : NSManagedObject

@property (strong, retain) NSString * timeStamp;
@property (strong, retain) Record *record;

@end
