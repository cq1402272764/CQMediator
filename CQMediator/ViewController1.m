//
//  ViewController1.m
//  CQMediator
//
//  Created by yto on 2017/10/27.
//  Copyright © 2017年 CQ. All rights reserved.
//

#import "ViewController1.h"
#import "CQMediator.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (UIViewController *)setupViewController1:(id)dict{
    NSLog(@"%s==%@",__func__,dict);
    return [[ViewController1 alloc] init];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"1";
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100,100, 100, 100)];
    [btn setTitle:@"back" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)backBtn{
    CQMediatorRequest *mediator = [[CQMediatorRequest alloc] init];
    mediator.targetType = VC;
    mediator.actionType = setupViewController;
    mediator.parames = @[@"key",@"vale"];
    [CQMediator performWithRequest:mediator shouldCacheTarget:NO];
    [self.navigationController popViewControllerAnimated:YES];
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
