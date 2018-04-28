//
//  ViewController.m
//  CQMediator
//
//  Created by yto on 2017/10/27.
//  Copyright © 2017年 CQ. All rights reserved.
//

#import "ViewController.h"
#import "CQMediator.h"
#import "CQMediatorRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"0";
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CQMediatorRequest *mediator = [[CQMediatorRequest alloc] init];
    mediator.targetType = VC1;
    mediator.actionType = setupViewController1;
    mediator.parames = @[@"key1",@"vale1"];
    UIViewController *VC = [CQMediator performWithRequest:mediator shouldCacheTarget:YES];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (UIViewController *)setupViewController:(id)dict{
    NSLog(@"%s==%@",__func__,dict);
    return [[ViewController alloc] init];
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
