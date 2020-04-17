//
//  AppDelegate.m
//  CLReflectionDemo
//
//  Created by  蔡亮 蔡 on 2020/4/16.
//  Copyright © 2020 Wuhan Radio and Television Station. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@property (nonatomic,strong) UINavigationController *navi;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    ViewController *vc = [[ViewController alloc] init];
    vc.view.backgroundColor = [UIColor lightGrayColor];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    self.navi = navi;
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    
    // 延时5s，模拟服务器请求调用
    [self testServerRequestCall];
    return YES;
}


#pragma mark - UISceneSession lifecycle


//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}


//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // 根据服务器返回的数据动态加载所需的类和方法
    [self accordingToDataLoadClass:userInfo];
}

- (void)accordingToDataLoadClass:(NSDictionary *)userInfo {
    // 根据字典字段反射我们想要的类，并初始化控制器
    Class class = NSClassFromString(userInfo[@"className"]);
    UIViewController *vc = [[class alloc] init];
    // 获取参数列表，用枚举对控制器属性进行KVC赋值
    NSDictionary *dic = userInfo[@"properties"];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        // 在属性赋值前，做容错处理，防止因为后台数据导致的异常
        if ([vc respondsToSelector:NSSelectorFromString(key)]) {
            [vc setValue:obj forKey:key];
        }
    }];
    [self.navi pushViewController:vc animated:YES];
    // 从字典中获取对应的方法名，调用对应的方法
    SEL selector = NSSelectorFromString(userInfo[@"method"]);
    [vc performSelector:selector];
}

- (void)testServerRequestCall {
    // 模拟服务器返回数据的调用
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSDictionary *dic = @{
            // 类名
            @"className":@"TestViewController",
            // 属性
            @"properties":@{
                    @"name":@"caicai",
                    @"age":@"24"
            },
            // 方法
            @"method":@"testFuntion"
        };
        
        [self application:[UIApplication sharedApplication] didReceiveRemoteNotification:dic fetchCompletionHandler:^(UIBackgroundFetchResult result) {
            
        }];
    });
}

@end
