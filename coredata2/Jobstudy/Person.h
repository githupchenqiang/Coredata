//
//  Person.h
//  Jobstudy
//
//  Created by chenq@kensence.com on 16/8/29.
//  Copyright © 2016年 chenq@kensence.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Card;

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSManagedObject
@property (nonatomic ,retain)NSString *name;
@property(nonatomic,retain)NSNumber *age;
@property(nonatomic,retain)Card *card;

@end

NS_ASSUME_NONNULL_END

#import "Person+CoreDataProperties.h"
