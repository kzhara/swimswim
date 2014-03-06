//
//  Srace.h
//  TabCoreDataTemp
//
//  Created by kzhara13 on 2013/08/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Srace : NSManagedObject

@property (nonatomic, retain) NSString * srdate;
@property (nonatomic, retain) NSString * srplace;
@property (nonatomic, retain) NSString * sresult;
@property (nonatomic, retain) NSString * srmemo;
@property (nonatomic, retain) NSString * srstyle;
@property (nonatomic, retain) NSString * srtime;

@end
