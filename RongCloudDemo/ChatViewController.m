//
//  ChatViewController.m
//  Haoshiqi
//
//  Created by Minoz_敏 on 16/10/9.
//  Copyright © 2016年 haoshiqi. All rights reserved.
//

#import "ChatViewController.h"
#import "GoodsLinkView.h"
#import <RongIMKit/RongIMKit.h>
#import "RongCloudMessageCell.h"
#import "DMRongCloudMessage.h"

@interface ChatViewController () <GoodsLinkViewDelegate, RongCloudMessageCellDelegate>

@property (nonatomic, strong) GoodsLinkView *linkView;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //头像设置圆角
    [self setMessageAvatarStyle:RC_USER_AVATAR_CYCLE];
    [self setMessagePortraitSize:CGSizeMake(40, 40)];
    //不显示发送者昵称
    self.displayUserNameInCell = false;
    //自定义消息cell
    [self registerClass:[RongCloudMessageCell class] forCellWithReuseIdentifier:@"RongCloudMessageCell"];
    
    //去掉位置功能
    [self.pluginBoardView removeItemAtIndex:[self.pluginBoardView allItems].count - 1];
    
    [self configHeaderView];}

- (void)configHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 86)];
    headerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:headerView];
    
    self.linkView = [[[NSBundle mainBundle] loadNibNamed:@"GoodsLinkView" owner:self options:0] lastObject];
    self.linkView.delegate = self;
    [headerView addSubview:self.linkView];
    self.linkView.translatesAutoresizingMaskIntoConstraints = false;
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[linkView]-0-|" options:0 metrics:nil views:@{@"linkView":self.linkView}]];
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[linkView]-0-|" options:0 metrics:nil views:@{@"linkView":self.linkView}]];
    [headerView layoutIfNeeded];
    
    //聊天view
    self.conversationMessageCollectionView.frame = CGRectMake(0, CGRectGetMaxY(headerView.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - CGRectGetMaxY(headerView.frame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - GoodsLinkViewDelegate

- (void)sendGoodsLinkMessage
{
    DMRongCloudMessage *message = [[DMRongCloudMessage alloc] init];
    message.thumbnail = @"";
    message.name = @"测试";
    message.price = 20;
    message.skuId = 123;
    message.detailType = 1;
    message.marketPrice = 30;
    [self sendMessage:message pushContent:@""];
}

- (void)didSendMessage:(NSInteger)stauts content:(RCMessageContent *)messageCotent
{
    NSLog(@"%@----%ld", messageCotent, (long)stauts);
}

- (RCMessageBaseCell *)rcConversationCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RCMessageModel *model = self.conversationDataRepository[indexPath.row];
    RongCloudMessageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RongCloudMessageCell" forIndexPath:indexPath];
    cell.cellDelegate = self;
    [cell setDataModel:model];
    return cell;
}

- (CGSize)rcConversationCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RCMessageModel *model = self.conversationDataRepository[indexPath.row];
    CGFloat height = [self referenceExtraHeight:[RongCloudMessageCell class] messageModel:model];
    return CGSizeMake(CGRectGetWidth(self.view.bounds), height + 76);
}

#pragma mark - RongCloudMessageCellDelegate

- (void)rongCloudMessageCell:(RongCloudMessageCell *)cell didSelectedIndex:(NSInteger)index message:(DMRongCloudMessage *)message
{
    UIViewController *viewController = [[UIViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

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
