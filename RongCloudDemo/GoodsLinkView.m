//
//  GoodsLinkView.m
//  Haoshiqi
//
//  Created by Minoz_敏 on 16/10/9.
//  Copyright © 2016年 haoshiqi. All rights reserved.
//

#import "GoodsLinkView.h"

@interface GoodsLinkView ()

@property (strong, nonatomic) IBOutlet UIImageView *imageViewSku;
@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet UILabel *labelPrice;
@property (strong, nonatomic) IBOutlet UILabel *labelMarketPrice;
@property (strong, nonatomic) IBOutlet UIButton *buttonLink;

@end

@implementation GoodsLinkView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self installView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.labelName.preferredMaxLayoutWidth = CGRectGetWidth(self.labelName.bounds);
}

#pragma mark - init view

- (void)installView
{
    self.labelName.textColor = [UIColor blackColor];
    self.labelName.font = [UIFont systemFontOfSize:14];
    
    [self.buttonLink setTitle:@"发送商品链接" forState:UIControlStateNormal];
    self.buttonLink.titleLabel.font = [UIFont systemFontOfSize:12];
    self.buttonLink.layer.borderWidth = 0.5;
    self.buttonLink.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.buttonLink.layer.cornerRadius = 4;
    self.buttonLink.layer.masksToBounds = true;
}

- (void)setData:(NSDictionary *)data delegate:(id)delegate
{
    self.labelName.text = [data valueForKey:@"name"];
    self.labelPrice.text = [data valueForKey:@"price"];
}

#pragma mark - action

- (IBAction)onSendLink:(id)sender {
    if ([self.delegate respondsToSelector:@selector(sendGoodsLinkMessage)]) {
        [self.delegate sendGoodsLinkMessage];
    }
}

@end
