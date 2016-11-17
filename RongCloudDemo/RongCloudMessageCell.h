//
//  RongCloudMessageCell.h
//  Haoshiqi
//
//  Created by Minoz_敏 on 16/10/11.
//  Copyright © 2016年 haoshiqi. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>
#import "DMRongCloudMessage.h"

@protocol RongCloudMessageCellDelegate;
@interface RongCloudMessageCell : RCMessageCell

@property (nonatomic, weak) id<RongCloudMessageCellDelegate> cellDelegate;

@end

@protocol RongCloudMessageCellDelegate <NSObject>

- (void)rongCloudMessageCell:(RongCloudMessageCell *)cell didSelectedIndex:(NSInteger)index message:(DMRongCloudMessage *)message;

@end
