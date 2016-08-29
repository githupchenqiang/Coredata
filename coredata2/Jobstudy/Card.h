//
//  Card.h
//  Jobstudy
//
//  Created by chenq@kensence.com on 16/8/29.
//  Copyright © 2016年 chenq@kensence.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSManagedObject

@property(nonatomic,retain)NSString *no;
//@property(nonatomic,retain)Person *person;


@end

NS_ASSUME_NONNULL_END

#import "Card+CoreDataProperties.h"
