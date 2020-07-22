//
//  PostViewerViewController.h
//  Convoy Caravan
//
//  Created by Priba on 10/19/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Cosmos-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostViewerViewController : BaseViewController
@property (strong, nonatomic) NSString *postUrl;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *postTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *placeNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *messageLbl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *optionsViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHight;

@property (weak, nonatomic) IBOutlet UIView *cellMenuView;
@property (weak, nonatomic) IBOutlet UIButton *reportBtn;
@property (weak, nonatomic) IBOutlet UIButton *deletePostBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet UIView *medalView;
@property (weak, nonatomic) IBOutlet UIImageView *medalImageView;
@property (weak, nonatomic) IBOutlet UILabel *medalLevelLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *medalLevelHeight;
@property (weak, nonatomic) IBOutlet UILabel *medalNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *medalMessageLbl;

@property (weak, nonatomic) IBOutlet UIView *likesView;
@property (weak, nonatomic) IBOutlet UIImageView *likesIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *lastLikedNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *likesOthersCountLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *likesViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *commentsCountBtn;

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
@property (weak, nonatomic) IBOutlet CosmosView *rateView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rateViewHeight;
@property (strong, nonatomic) WallPostModel *post;

@end

NS_ASSUME_NONNULL_END
