//
//  RongCloudMessageCell.m
//  Haoshiqi
//
//  Created by Minoz_敏 on 16/10/11.
//  Copyright © 2016年 haoshiqi. All rights reserved.
//

#import "RongCloudMessageCell.h"
#import "UIView+Frame.h"

#define WidthScreen                     CGRectGetWidth([[UIScreen mainScreen] bounds])
#define HeightScreen                    CGRectGetHeight([[UIScreen mainScreen] bounds])

@interface RongCloudMessageCell ()

@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UIImageView *imageSku;
@property (nonatomic, strong) UILabel *labelPrice;
@property (nonatomic, strong) UILabel *labelMarketPrice;
@property (nonatomic, strong) UIImageView *imageBg;
@property (nonatomic, strong) DMRongCloudMessage *message;

@end

@implementation RongCloudMessageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self installView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self installView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSString *price = [NSString stringWithFormat:@"￥%.2f", self.message.price/100.];
    NSString *marketPrice = [NSString stringWithFormat:@"￥%.2f", self.message.marketPrice/100.];
    if ([self labelSizeFromString:price].width > 50) {
        self.labelPrice.width = [self labelSizeFromString:price].width;
    }
    
    if ([self labelSizeFromString:marketPrice].width > 50) {
        self.labelMarketPrice.width = [self labelSizeFromString:marketPrice].width;
    }
    
    self.imageBg.y = [self referenceExtraHeight:[RongCloudMessageCell class] messageModel:self.model];
}

#pragma mark - init view

- (void)installView
{
    [self addSubview:self.imageBg];
    [self.imageBg addSubview:self.imageSku];
    [self.imageBg addSubview:self.labelName];
    [self.imageBg addSubview:self.labelPrice];
    [self.imageBg addSubview:self.labelMarketPrice];
    
    self.imageBg.userInteractionEnabled = true;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGes)];
    [self.imageBg addGestureRecognizer:tapGes];
}

- (UIImageView *)imageBg
{
    if (!_imageBg) {
        _imageBg = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScreen - (CGRectGetWidth(self.bounds) - 120 + 55), 0, CGRectGetWidth(self.bounds) - 120, 76)];
    }
    return _imageBg;
}

- (UIImageView *)imageSku
{
    if (!_imageSku) {
        _imageSku = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 60, 60)];
    }
    return _imageSku;
}

- (UILabel *)labelName
{
    if (!_labelName) {
        _labelName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageSku.frame) + 10, 8, CGRectGetWidth(self.imageBg.frame) - CGRectGetMaxX(self.imageSku.frame) - 20, 30)];
        _labelName.textColor = [UIColor blackColor];
        _labelName.font = [UIFont systemFontOfSize:12.0];
        _labelName.numberOfLines = 2;
    }
    return _labelName;
}

- (UILabel *)labelPrice
{
    if (!_labelPrice) {
        _labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageSku.bounds) + 10, CGRectGetMaxY(self.imageSku.frame) - 20, 50, 20)];
    }
    return _labelPrice;
}

- (UILabel *)labelMarketPrice
{
    if (!_labelMarketPrice) {
        _labelMarketPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.labelPrice.frame) + 10, CGRectGetMaxY(self.imageSku.frame) - 14, 50, 14)];
    }
    return _labelMarketPrice;
}

#pragma mark - init data

- (void)setDataModel:(RCMessageModel *)model
{
    [super setDataModel:model];
        
    self.message = (DMRongCloudMessage *)model.content;
    self.labelName.text = self.message.name;
    self.labelPrice.text = [NSString stringWithFormat:@"%.2ld", (long)self.message.price];
    self.labelMarketPrice.text = [NSString stringWithFormat:@"%.2ld", (long)self.message.marketPrice];
    
    if (model.messageDirection == MessageDirection_SEND) {
        self.imageBg.image = [UIImage imageNamed:@"chat_to_bg_yellow"];
    }else {
        self.imageBg.image = [UIImage imageNamed:@"chat_from_bg_normal"];
    }
}

- (CGSize)labelSizeFromString:(NSString *)str {
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:20]};
    return [str sizeWithAttributes:attributes];
}


#pragma mark - UITapGestureRecognizer

- (void)onTapGes
{
    if ([self.cellDelegate respondsToSelector:@selector(rongCloudMessageCell:didSelectedIndex:message:)]) {
        [self.cellDelegate rongCloudMessageCell:self didSelectedIndex:self.message.detailType message:self.message];
    }
}

#pragma mark - 自定义cell显示时间label计算的额外高度

- (CGFloat)referenceExtraHeight:(Class)cellClass messageModel:(RCMessageModel *)model {
    CGFloat extraHeight = 0;
    if ([cellClass isSubclassOfClass:RCMessageBaseCell.class]) {
        extraHeight += 5; // up padding
        extraHeight += 5; // down padding
        
        // time label height
        if (model.isDisplayMessageTime) {
            extraHeight += 45;
        }
    }
    if ([cellClass isSubclassOfClass:RCMessageCell.class]) {
        // name label height
        if (model.isDisplayNickname &&
            model.messageDirection == MessageDirection_RECEIVE) {
            extraHeight += 16;
        }
    }
    return extraHeight;
}

@end
