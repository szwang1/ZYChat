//
//  GJGCChatSystemActiveGuideCell.m
//  ZYChat
//
//  Created by ZYVincent QQ:1003081775 on 14-11-10.
//  Copyright (c) 2014年 ZYProSoft. All rights reserved.
//

#import "GJGCChatSystemActiveGuideCell.h"
#import "GJGCChatSystemNotiCellStyle.h"
#import "GJGCChatSystemNotiModel.h"

@implementation GJGCChatSystemActiveGuideCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        /* 标题 */
        self.titleLabel = [[GJCFCoreTextContentView alloc]init];
        self.titleLabel.gjcf_top = self.contentBordMargin;
        self.titleLabel.gjcf_left = self.contentBordMargin;
        self.titleLabel.contentBaseWidth = self.stateContentView.gjcf_width - 2*self.contentBordMargin;
        self.titleLabel.contentBaseHeight = 30;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self.stateContentView addSubview:self.titleLabel];

        /* 图片 */
        self.activeImageView = [[GJCUAsyncImageView alloc]init];
        self.activeImageView.gjcf_left = self.contentBordMargin;
        self.activeImageView.gjcf_top = self.titleLabel.gjcf_bottom + self.contentInnerMargin;
        self.activeImageView.gjcf_width = self.stateContentView.gjcf_width - 2* self.contentBordMargin;
        self.activeImageView.gjcf_height = GJCFSystemiPhone6Plus? 66*1.5:66;
        [self.stateContentView addSubview:self.activeImageView];
        
        /* 按钮 */
        self.acceptButton = [[GJCURoundCornerButton alloc]init];
        self.acceptButton.gjcf_top = self.contentLabel.gjcf_bottom + self.contentInnerMargin;
        self.acceptButton.gjcf_left = 0;
        self.acceptButton.gjcf_width = self.stateContentView.gjcf_width;
        self.acceptButton.gjcf_height = 44.f;
        self.acceptButton.cornerBackView.borderWidth = 0.5f;
        self.acceptButton.cornerBackView.borderColor = [GJGCCommonFontColorStyle mainSeprateLineColor];
        self.acceptButton.cornerBackView.cornerRadius = 8.f;
        self.acceptButton.cornerBackView.roundedCorners = TKRoundedCornerBottomLeft|TKRoundedCornerBottomRight;
        self.acceptButton.cornerBackView.drawnBordersSides = TKDrawnBorderSidesTop;
        self.acceptButton.highlightBackColor = [GJGCCommonFontColorStyle tapHighlightColor];
        GJCFWeakSelf weakSelf = self;
        [self.acceptButton configureButtonDidTapAction:^(GJCURoundCornerButton *button) {
            [weakSelf tapOnButton:button];
        }];
        [self.stateContentView addSubview:self.acceptButton];
    }
    return self;
}

- (void)setContentModel:(GJGCChatContentBaseModel *)contentModel
{
    if (!contentModel) {
        return;
    }
    
    [super setContentModel:contentModel];
    
    GJGCChatSystemNotiModel *notiModel = (GJGCChatSystemNotiModel *)contentModel;

    self.titleLabel.contentAttributedString = notiModel.systemNotiTitle;
    self.titleLabel.gjcf_size = [GJCFCoreTextContentView contentSuggestSizeWithAttributedString:notiModel.systemNotiTitle forBaseContentSize:self.titleLabel.contentBaseSize];
    
    /* 有按钮 */
    if (notiModel.systemGuideButtonTitle) {
        
        self.acceptButton.titleView.contentAttributedString = notiModel.systemGuideButtonTitle;
        
        /* 按钮居中 */
        [self.acceptButton setNeedsLayout];
        
    }else{
        
        self.acceptButton.hidden = YES;
        
    }
    
    self.activeImageView.gjcf_top = self.titleLabel.gjcf_bottom + self.contentInnerMargin;
    
    notiModel.systemActiveImageUrl = notiModel.systemActiveImageUrl;
    self.activeImageView.url = notiModel.systemActiveImageUrl;
    
    /* 调整内容标签 */
    self.contentLabel.gjcf_top = self.activeImageView.gjcf_bottom + self.contentInnerMargin;
    self.contentLabel.contentAttributedString = notiModel.systemOperationTip;
    self.contentLabel.gjcf_size = [GJCFCoreTextContentView contentSuggestSizeWithAttributedString:notiModel.systemOperationTip forBaseContentSize:self.contentLabel.contentBaseSize];
    
    /* 有按钮 */
    if (notiModel.systemGuideButtonTitle) {
        
        self.acceptButton.gjcf_top = self.contentLabel.gjcf_bottom + self.contentInnerMargin;
        
        self.stateContentView.gjcf_height = self.acceptButton.gjcf_bottom;
        
    }else{
        
        self.stateContentView.gjcf_height = self.contentLabel.gjcf_bottom + self.contentInnerMargin;
    }
}

- (void)tapOnButton:(GJCURoundCornerButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(systemNotiBaseCellDidTapOnSystemActiveGuideButton:)]) {
        [self.delegate systemNotiBaseCellDidTapOnSystemActiveGuideButton:self];
    }
}

@end
