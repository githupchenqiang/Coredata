//
//  ViewController.m
//  Core
//
//  Created by chenq@kensence.com on 16/8/29.
//  Copyright © 2016年 chenq@kensence.com. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@interface ViewController ()
{
    AppDelegate *app;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    app = [UIApplication sharedApplication].delegate;
    [self creatButton];
}


- (void)creatButton
{
    NSArray *array = @[@"增",@"查",@"删",@"改"];
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(50 + i * 60, 100, 40, 40);
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonCtion:) forControlEvents:UIControlEventTouchDown];
        button.tag = 100 + i;
        [self.view addSubview:button];
    }
    
}
- (void)buttonCtion:(UIButton *)button
{
    switch (button.tag) {
        case 100:
            [self insert];
            break;
        case 101:
            [self coreSele];
            break;
        case 102:
            [self delect];
            break;
        case 103:
            [self coreUpdate];
            break;
            
        default:
            break;
            
    }
}

- (void)insert
{
    Dog *dog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:app.managedObjectContext];
    dog.name = [NSString stringWithFormat:@"花花%d",arc4random()%10];
    dog.sex = @"公";
    dog.age = [NSString stringWithFormat:@"%d",arc4random()%15];
    
    //保存
    [app.managedObjectContext save:nil];

}

- (void)coreSele
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Dog" inManagedObjectContext:app.managedObjectContext];
    //简历请求
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entity];
    //遍历所有数据
    NSArray *array = [app.managedObjectContext executeFetchRequest:request error:nil];
    for (Dog *dog in array) {
        NSLog(@"%@",dog.name);
        
    }
    
    
}


- (void)delect
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Dog" inManagedObjectContext:app.managedObjectContext];
    //简历请求
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entity];
    
    //设置检索条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@",@"花花7"];
    [request setPredicate:predicate];
    
    //遍历获取到的信息
    NSArray *array = [app.managedObjectContext executeFetchRequest:request error:nil];
    if (array.count) {
        for (Dog *newDog in array) {
            [app.managedObjectContext deleteObject:newDog];
            
        }
        
        //保存结果
        [app.managedObjectContext save:nil];
        NSLog(@"删除完成");
    }else
    {
        NSLog(@"检索数据失败");
    }
    
}

- (void)coreUpdate
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Dog" inManagedObjectContext:app.managedObjectContext];
    
    //简历请求
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entity];
    
    //建立检索条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name!=%@",@"小白107"];
    [request setPredicate:predicate];
    NSArray *arra = [app.managedObjectContext executeFetchRequest:request error:nil];
    if (arra.count) {
        for (Dog *newdog in arra) {
            newdog.name = @"小白107";
        }
        [app.managedObjectContext save:nil];
        NSLog(@"修改完成");
    }else
    {
        NSLog(@"检索到了");
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
