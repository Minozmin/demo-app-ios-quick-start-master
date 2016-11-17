//
//  GoodsLinkView.h
//  Haoshiqi
//
//  Created by Minoz_敏 on 16/10/9.
//  Copyright © 2016年 haoshiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodsLinkViewDelegate;

@interface GoodsLinkView : UIView

- (void)setData:(NSDictionary *)data delegate:(id)delegate;
@property (nonatomic, weak) id<GoodsLinkViewDelegate> delegate;

@end


@protocol GoodsLinkViewDelegate <NSObject>

- (void)sendGoodsLinkMessage;

@end