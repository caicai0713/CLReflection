//
//  main.m
//  CLReflectionDemo
//
//  Created by  蔡亮 蔡 on 2020/4/16.
//  Copyright © 2020 Wuhan Radio and Television Station. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
