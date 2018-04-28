## 描述
相对于CTMediator写了一个简单的中间件

## 使用方法
需要跳转的控制器和方法名需要在CQMediatorAPI中声明，声明的Target和Action是一一对应的。根据如下方法可以进行跳转和传参数，从而降低组件之间的耦合性
调用方法如下：
```objective-c

    CQMediatorRequest *mediator = [[CQMediatorRequest alloc] init];
    mediator.targetType = ViewController1;
    mediator.actionType = setupViewController1;
    mediator.parames = @[@"key",@"vale"];
    UIViewController *VC = [CQMediator performWithRequest:mediator shouldCacheTarget:YES];
    [self.navigationController pushViewController:VC animated:YES];

```
