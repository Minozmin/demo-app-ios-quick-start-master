//
//  DMRongCloudMessage.m
//  Haoshiqi
//
//  Created by Minoz_敏 on 16/10/10.
//  Copyright © 2016年 haoshiqi. All rights reserved.
//

#import "DMRongCloudMessage.h"

@implementation DMRongCloudMessage

+ (instancetype)messagetWithGoodsInfoSkuId:(int)skuId
                                detailType:(int)detailType
                                      name:(NSString *)name
                                 thumbnail:(NSString *)thumbnail
                                     price:(NSInteger)price
                               marketPrcie:(NSInteger)marketPrice
{
    static DMRongCloudMessage *message = nil;
    @synchronized(self) {
        if (!message) {
            message = [[DMRongCloudMessage alloc] init];
            if (message) {
                message.skuId = skuId;
                message.detailType = detailType;
                message.name = name;
                message.thumbnail = thumbnail;
                message.price = price;
                message.marketPrice = marketPrice;
            }
        }
    }
    return message;
}

- (NSData *)encode
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:@(self.skuId).description forKey:@"id"];
    [dictionary setObject:self.name forKey:@"name"];
    [dictionary setObject:self.thumbnail forKey:@"thumbnail"];
    [dictionary setObject:@(self.price).description forKey:@"price"];
    [dictionary setObject:@(self.marketPrice).description forKey:@"marketPrice"];
    [dictionary setObject:@(self.detailType).description forKey:@"detailType"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:nil];
    return data;
}

- (void)decodeWithData:(NSData *)data
{
    if (!data) {
        return;
    }
    
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.skuId = [[jsonData valueForKey:@"id"] intValue];
    self.name = [jsonData valueForKey:@"name"];
    self.thumbnail = [jsonData valueForKey:@"thumbnail"];
    self.price = [[jsonData valueForKey:@"price"] integerValue];
    self.marketPrice = [[jsonData valueForKey:@"marketPrice"] integerValue];
    self.detailType = [[jsonData valueForKey:@"detailType"] intValue];
}

//自定义消息cell的列表上显示的信息
- (NSString *)conversationDigest
{
    return @"[商品信息]";
}

+ (NSString *)getObjectName
{
    return @"app:goodsmessage";
}

+ (RCMessagePersistent)persistentFlag
{
    return (MessagePersistent_ISCOUNTED);
}

@end
