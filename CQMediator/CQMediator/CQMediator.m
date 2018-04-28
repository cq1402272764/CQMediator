//
//  CQMediator.m
//  YTOUserList
//
//  Created by CQ on 2017/10/27.
//  Copyright © 2017年 CQ. All rights reserved.
//

#import "CQMediator.h"

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#ifdef DEBUG
#define CQLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define CQLog(...)
#endif


@interface CQMediator ()
@property (nonatomic, strong) NSMutableDictionary *targetCache;
@end

@implementation CQMediator


+ (id)performWithRequest:(CQMediatorRequest *)request shouldCacheTarget:(BOOL)shouldCacheTarget{
    return [[self sharedInstance] performWithRequest:request shouldCacheTarget:shouldCacheTarget];
}

#pragma mark - public methods
+ (instancetype)sharedInstance {
    static CQMediator *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[CQMediator alloc] init];
    });
    return mediator;
}

- (id)performWithRequest:(CQMediatorRequest *)request shouldCacheTarget:(BOOL)shouldCacheTarget{
    
    NSString *targetClassString = [NSString stringWithFormat:@"%@", request.targetType];
    NSString *actionString = [NSString stringWithFormat:@"%@", request.actionType];
    Class targetClass;
    
    NSObject *target = self.targetCache[targetClassString];
    if (target == nil) {
        targetClass = NSClassFromString(targetClassString);
        target = [[targetClass alloc] init];
    }
    
    SEL action = NSSelectorFromString(actionString);
    
    if (target == nil) {
        CQLog(@"找不到控制器");
        if ([_delegate respondsToSelector:@selector(mediatorWithTarget:)]) {
            [_delegate mediatorWithTarget:self];
        }
        return nil;
    }
    if (shouldCacheTarget) {
        self.targetCache[targetClassString] = target;
    }
    if ([target respondsToSelector:action]) { // 有action
        if (request.parames == nil) {
            SuppressPerformSelectorLeakWarning(return [target performSelector:action]);
        }else{
            SuppressPerformSelectorLeakWarning(return [target performSelector:action withObject:request.parames]);
        }
    }else {
        // 这里是处理无响应请求的地方，如果无响应，则尝试调用对应target的notFound方法统一处理
        SEL actionFound = NSSelectorFromString(@"notFound:");
        if ([target respondsToSelector:actionFound]) {// 有actionFound
            if (request.parames == nil) {
                SuppressPerformSelectorLeakWarning(return [target performSelector:actionFound]);
            }else{
                SuppressPerformSelectorLeakWarning(return [target performSelector:actionFound withObject:request.parames]);
            }
        } else {
            // 这里也是处理无响应请求的地方，在notFound都没有的时候，这个demo是直接return了。实际开发过程中，可以用前面提到的固定的target顶上的。
            CQLog(@"无法解析参数或者找不到方法");
            if ([_delegate respondsToSelector:@selector(mediatorWithParams:)]) {
                [_delegate mediatorWithParams:self];
            }
            [self.targetCache removeObjectForKey:targetClassString];
            return nil;
        }
    }
}

- (NSMutableDictionary *)targetCache {
    if (_targetCache == nil) {
        _targetCache = [NSMutableDictionary dictionary];
    }
    return _targetCache;
}


@end
