//
//  CQMediator.h
//  YTOUserList
//
//  Created by CQ on 2017/10/27.
//  Copyright © 2017年 CQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CQMediatorAPI.h"
#import "CQMediatorRequest.h"

@class CQMediator;

@protocol CQMediatorDelegate <NSObject>
@optional
/**
 * 为跳转到指定的控制器
 */
- (void)mediatorWithTarget:(CQMediator *)target;

/**
 * 无法接收到参数
 */
- (void)mediatorWithParams:(CQMediator *)params;

@end

@interface CQMediator : NSObject

@property (nonatomic, weak) id<CQMediatorDelegate>delegate;

+ (instancetype)sharedInstance;

/**
 * 本地组件调用入口
 * targetName: 跳转的控制器
 * actionName: 跳转的方法
 * params: 跳转时传的参数
 * shouldCacheTarget : 是否使用目标名释放缓存的目标
 */
+ (id)performWithRequest:(CQMediatorRequest *)request shouldCacheTarget:(BOOL)shouldCacheTarget;


/**
 * 本地组件调用入口
 * targetName: 跳转的控制器
 * actionName: 跳转的方法
 * params: 跳转时传的参数
 * shouldCacheTarget : 是否使用目标名释放缓存的目标
 */
- (id)performWithRequest:(CQMediatorRequest *)request shouldCacheTarget:(BOOL)shouldCacheTarget;


@end
