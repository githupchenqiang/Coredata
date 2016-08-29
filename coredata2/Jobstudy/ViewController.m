//
//  ViewController.m
//  Jobstudy
//
//  Created by chenq@kensence.com on 16/8/29.
//  Copyright © 2016年 chenq@kensence.com. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //从应用程序包中加载模型文件
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    //传入模型对象 初始化NSPersistentStoreCoordinator
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    //构建SQlite数据库文件的路径
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"person.data"]];
    
    //添加持久化存储库 这里使用SQLite作为存储库
    NSError *error = nil;
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (store == nil) {
        [NSException raise:@"添加数据错误" format:@"%@",[error localizedDescription]];
    }
    //初始化上下文 设置persistentStorecoordinator属性
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSManagedObjectContextLockingError];
    context.persistentStoreCoordinator = psc;
    
    
    //传入上下文,创建一个person实体对象
    NSManagedObject *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
    //设置person的简单属性
    [person setValue:@"CQ" forKey:@"name"];
    [person setValue:[NSNumber numberWithInt:24] forKey:@"age"];
    
    //传入上下文 创建一个car的实体对象
    NSManagedObject *card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:context];
    [card setValue:@"18519660697" forKey:@"no"];
    //设置person与card之间的关联关系
    [person setValue:card forKey:@"Card"];
    
    //利用上下文对象 将数据同步到持久化存储库
    NSError *err = nil;
    BOOL success = [context save:&err];
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@",[err localizedDescription]];
        
    }
    //// 如果是想做更新操作：只要在更改了实体对象的属性后调用[context save:&error]，就能将更改的数据同步到数据库
    
    
    
    //从数据库中查找数据
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    //设置要查询的实体
    request.entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    //设置排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    
    //设置条件过滤
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@",@"*Itcast -1*"];
    request.predicate = predicate;
    
    //执行请求
    NSError *error1 = nil;
    NSArray *objs = [context executeFetchRequest:request error:&error1];
    if (error1) {
        [NSException raise:@"查询错误" format:@"%@",[error1 localizedDescription]];
    }
    
    //遍历数据
    for (NSManagedObject *obj in objs) {
        NSLog(@"name = %@",[obj valueForKey:@"name"]);
    }
    
    //删除数据库中的数据
    [context deleteObject:person];
    
    //将结果同步到数据库中
    NSError *error2 = nil;
    [context save:&error2];
    if (error2) {
        [NSException raise:@"删除错误" format:@"%@",[error2 localizedDescription]];
    }
    
    
    /**
     *  CoreData的SQL语句输出开关
     *
     *  Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
     person.name = @"MJ";
     person.age = [NSNumber numberWithInt:27];
     
     Card *card = [NSEntityDescription insertNewObjectForEntityForName:@”Card" inManagedObjectContext:context];
     card.no = @”4414245465656";
     person.card = card;
     */
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
