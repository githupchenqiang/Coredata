//
//  CoreDataViewController.m
//  Jobstudy
//
//  Created by chenq@kensence.com on 16/8/29.
//  Copyright © 2016年 chenq@kensence.com. All rights reserved.
//

#import "CoreDataViewController.h"
#import "AppDelegate.h"
@interface CoreDataViewController ()
{
    AppDelegate *app;
    
}
@end

@implementation CoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    app = [UIApplication sharedApplication].delegate;
    [self creatButton];
    
    //从应用程序包中加载模型文件
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    //传入模型对象 初始化NSPersistentStoreCoordinator
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    //构建SQlite数据库文件的路径
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"dog.data"]];

    //初始化上下文 设置persistentStorecoordinator属性
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSManagedObjectContextLockingError];
    context.persistentStoreCoordinator = psc;
    
}

- (void)creatButton
{
    NSArray *array = @[@"增",@"删",@"改",@"查"];
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
            
            break;
         case 101:
            break;
        case 102:
            break;
        case 103:
            break;
            
        default:
            break;
    }
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
