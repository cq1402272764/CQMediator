//
//  CQMediatorRequest.h
//  YTOUserList
//
//  Created by yto on 2017/10/31.
//  Copyright © 2017年 CQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CQMediatorAPI.h"

@interface CQMediatorRequest : NSObject

#pragma mark Target
@property (nonatomic, copy) NSString *targetType;

#pragma mark Action
@property (nonatomic, copy) NSString *actionType;

#pragma mark Parames
@property (nonatomic, copy) id parames;

@end
