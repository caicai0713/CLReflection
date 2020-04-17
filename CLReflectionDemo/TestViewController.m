//
//  TestViewController.m
//  CLReflectionDemo
//
//  Created by  蔡亮 蔡 on 2020/4/17.
//  Copyright © 2020 Wuhan Radio and Television Station. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor greenColor];
}


- (void)testFuntion {
    NSLog(@"属性name:%@",self.name);
    NSLog(@"属性age:%@",self.age);
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
