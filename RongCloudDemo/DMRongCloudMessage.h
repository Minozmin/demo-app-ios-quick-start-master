//
//  DMRongCloudMessage.h
//  Haoshiqi
//
//  Created by Minoz_敏 on 16/10/10.
//  Copyright © 2016年 haoshiqi. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

@interface DMRongCloudMessage : RCMessageContent

@property (nonatomic, assign) int detailType;  //1表示普通商品详情页，2表示2人团商品详情页
@property (nonatomic, assign) int skuId;   //detailType=1,skuId; detailType=2,pinActiviesId;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, assign) NSInteger marketPrice;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *thumbnail;

+ (instancetype)messagetWithGoodsInfoSkuId:(int)skuId
                                detailType:(int)detailType
                                      name:(NSString *)name
                                 thumbnail:(NSString *)thumbnail
                                     price:(NSInteger)price
                               marketPrcie:(NSInteger)marketPrice;

@end
