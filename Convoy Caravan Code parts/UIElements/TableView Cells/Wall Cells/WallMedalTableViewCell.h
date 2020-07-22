//
//  WallMedalTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 11/20/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WallPostModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WallMedalTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *postTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *placeNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *messageLbl;

@property (weak, nonatomic) IBOutlet UIImageView *postImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHight;

@property (weak, nonatomic) IBOutlet UIView *cellMenuView;
@property (weak, nonatomic) IBOutlet UIButton *reportBtn;
@property (weak, nonatomic) IBOutlet UIButton *deletePostBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *goToProfileBtn;
@property (weak, nonatomic) IBOutlet UIButton *goToPlaceBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeListBtn;

@property (weak, nonatomic) IBOutlet UILabel *levelLbl;
@property (weak, nonatomic) IBOutlet UILabel *medalNameLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *levelLblHeight;

@property (weak, nonatomic) IBOutlet UIButton *commentsCountBtn;
@property (weak, nonatomic) IBOutlet UIView *likesView;
@property (weak, nonatomic) IBOutlet UIImageView *likesIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *lastLikedNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *likesOthersCountLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *likesViewHeight;

@property (weak, nonatomic) IBOutlet UIView *firstCommentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstCommentViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *firstCommentAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstComentNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *firstCommentBodyLbl;
@property (weak, nonatomic) IBOutlet UILabel *firstCommentTimeLbl;
@property (weak, nonatomic) IBOutlet UIView *firstCommentHolderView;

@property (weak, nonatomic) IBOutlet UIView *secondCommentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondCommentViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *secCommentAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *secCommentNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *secCommentTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *secCommentBodyLbl;
@property (weak, nonatomic) IBOutlet UIView *secCommentHolderView;

- (void)populateWithPost:(WallPostModel*)post;

@end

NS_ASSUME_NONNULL_END
