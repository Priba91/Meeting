//
//  WallMedalTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 11/20/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "WallMedalTableViewCell.h"
#import "LanguageManager.h"
#import "ColorDefinitions.h"
#import "UIImageView+WebCache.h"
#import "DataManager.h"
#import "Utils.h"

@implementation WallMedalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self setBackgroundColor:[UIColor clearColor]];
    
    [self.profileImageView.layer setCornerRadius:self.profileImageView.frame.size.height/2];
    
    [self.cellMenuView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.cellMenuView.layer setBorderWidth:0.5];
    
    [self.placeNameLbl setTextColor:BASE_BAR_COLOR1];
    
    [Utils addHalfHightCornerRadiusToView:self.likeBtn];
    [Utils addHalfHightCornerRadiusToView:self.commentBtn];
    
    [self.backView.layer setCornerRadius:8];
    self.layer.shadowRadius = 2.5f;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2.f, 2.f);
    self.layer.shadowOpacity = 0.1f;
    self.layer.masksToBounds = NO;
    
    [self.cellMenuView.layer setCornerRadius:4];
    self.cellMenuView.layer.shadowRadius = 2.5f;
    self.cellMenuView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.cellMenuView.layer.shadowOffset = CGSizeMake(2.f, 2.f);
    self.cellMenuView.layer.shadowOpacity = 0.3f;
    self.cellMenuView.layer.masksToBounds = NO;
    
    [Utils addHalfHightCornerRadiusToView:self.likesIconImageView];
    self.likesIconImageView.backgroundColor = [UIColor clearColor];
    
    //Comment Views
    
    [self.firstCommentBodyLbl setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.firstCommentAvatarImageView.layer setCornerRadius:self.firstCommentAvatarImageView.frame.size.height/2];
    [self.firstCommentHolderView.layer setCornerRadius:16];
    
    [self.secCommentBodyLbl setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.secCommentAvatarImageView.layer setCornerRadius:self.secCommentAvatarImageView.frame.size.height/2];
    [self.secCommentHolderView.layer setCornerRadius:16];
    
    [self.likesIconImageView setImage:[UIImage imageNamed:@"liked"]];
}

- (void)populateWithPost:(WallPostModel*)post{
    
    if(post.user.userId == [DataManager sharedInstance].logedUser.userId){
        
        [self.reportBtn setTitle:[LanguageManager setLanguageString:@"delete_btn"] forState:UIControlStateNormal];
        
        self.deletePostBtn.hidden = NO;
    }else{
        [self.reportBtn setTitle:[LanguageManager setLanguageString:@"report_btn"] forState:UIControlStateNormal];
        self.deletePostBtn.hidden = YES;
    }
    
    if(post.likedByMe){
        [self.likeBtn setImage:[UIImage imageNamed:@"liked"] forState:normal];
    }else{
        [self.likeBtn setImage:[UIImage imageNamed:@"unliked"] forState:normal];
    }
    
    [self.likeBtn setTitle:[LanguageManager setLanguageString:@"honk"] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[LanguageManager setLanguageString:@"comments"] forState:UIControlStateNormal];

    self.profileNameLbl.text = post.user.name;
    self.postTimeLbl.text = [Utils makeTimePassShortString:post.timePass];

    self.placeNameLbl.text = @"";
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:post.user.avatar]
                             placeholderImage:[UIImage imageNamed:@"profilePlaceholder"]
                                      options:SDWebImageRefreshCached];

    if(post.type == 7){
        
        self.messageLbl.text = post.medal.medalDesc;
        self.medalNameLbl.text = post.medal.name;
        
        if(post.medal.type != 1){
            self.levelLbl.text = [NSString stringWithFormat:@"%@ %ld", [LanguageManager setLanguageString:@"medal_level"], post.medal.level];
            self.levelLblHeight.constant = 33;
        }else{
            self.levelLbl.text = @"";
            self.levelLblHeight.constant = 0;
        }
        
        [self.postImageView sd_setImageWithURL:[NSURL URLWithString:post.medal.imageUrl]
                              placeholderImage:[UIImage imageNamed:@"placeImagePlaceholder"]
                                       options:SDWebImageHighPriority];
        
    }else if(post.type == 6){
        
        self.messageLbl.text = post.achivment.achiDescription;
        self.medalNameLbl.text = post.achivment.name;
        self.levelLbl.text = @"";
        self.levelLblHeight.constant = 0;
        [self.postImageView sd_setImageWithURL:[NSURL URLWithString:post.achivment.imageUrl]
                              placeholderImage:[UIImage imageNamed:@"placeImagePlaceholder"]
                                       options:SDWebImageHighPriority];
    }
    
    if(post.likesCount == 0 && post.commentsCount == 0){
        self.likesViewHeight.constant = 0;
        self.likesView.hidden = YES;
        self.commentsCountBtn.hidden = YES;
        
        self.firstCommentViewHeight.constant = 0;
        self.firstCommentView.hidden = YES;
        self.secondCommentViewHeight.constant = 0;
        self.secondCommentView.hidden = YES;
        
    }else{
        if(post.likesCount == 0){
            self.likesIconImageView.hidden = YES;
            self.likesOthersCountLbl.hidden = YES;
            self.lastLikedNameLbl.hidden = YES;
        }else{
            self.likesViewHeight.constant = 27;
            self.likesView.hidden = NO;
            
            self.likesIconImageView.hidden = NO;
            self.likesOthersCountLbl.hidden = NO;
            self.lastLikedNameLbl.hidden = NO;
            
            if(post.likedByMe){
                self.lastLikedNameLbl.text = [LanguageManager setLanguageString:@"you"];
                if(post.likesCount == 1){
                    self.likesOthersCountLbl.text = [NSString stringWithFormat:@" %@", [LanguageManager setLanguageString:@"honked_this"]];
                }else{
                    self.likesOthersCountLbl.text = [NSString stringWithFormat:@"%@ %ld %@",[LanguageManager setLanguageString:@"and"], post.likesCount-1, [LanguageManager setLanguageString:@"others"]];
                }
            }else{
                self.lastLikedNameLbl.text = post.likedUser.name;
                if(post.likesCount == 1){
                    self.likesOthersCountLbl.text = [NSString stringWithFormat:@" %@", [LanguageManager setLanguageString:@"honked_this"]];
                }else{
                    self.likesOthersCountLbl.text = [NSString stringWithFormat:@"%@ %ld %@",[LanguageManager setLanguageString:@"and"], post.likesCount-1, [LanguageManager setLanguageString:@"others"]];
                }
            }
        }
        
        if (post.commentsCount == 0){
            self.commentsCountBtn.hidden = YES;
            
            self.firstCommentViewHeight.constant = 0;
            self.firstCommentView.hidden = YES;
            self.secondCommentViewHeight.constant = 0;
            self.secondCommentView.hidden = YES;
        }else{
            if(post.commentsArray.count > 0){
                
                self.likesViewHeight.constant = 27;
                self.likesView.hidden = NO;
                self.commentsCountBtn.hidden = NO;
                if(post.commentsCount == 1){
                    [self.commentsCountBtn setTitle:[NSString stringWithFormat:@"%ld %@", (long)post.commentsCount, [LanguageManager setLanguageString:@"one_comment"]] forState:UIControlStateNormal];
                }else{
                    [self.commentsCountBtn setTitle:[NSString stringWithFormat:@"%ld %@", (long)post.commentsCount, [LanguageManager setLanguageString:@"comments"]] forState:UIControlStateNormal];
                }
                
                PostCommentModel *firstCom = post.commentsArray.firstObject;
                self.firstCommentViewHeight.constant = 62 + [Utils heightWithText:firstCom.comment andLabel:self.firstCommentBodyLbl];
                self.firstCommentView.hidden = NO;
                
                [self.firstCommentAvatarImageView sd_setImageWithURL:[NSURL URLWithString:firstCom.user.avatar]
                                                    placeholderImage:[UIImage imageNamed:@"profilePlaceholder"]
                                                             options:SDWebImageRefreshCached];
                self.firstComentNameLbl.text = firstCom.user.name;
                self.firstCommentBodyLbl.text = firstCom.comment;
                self.firstCommentTimeLbl.text = [Utils makeTimePassShortString:firstCom.timePass];
                
            }else{
                self.firstCommentView.hidden = YES;
                self.firstCommentViewHeight.constant = 0;
            }
            
            if(post.commentsArray.count > 1){
                PostCommentModel *secondCom = post.commentsArray.lastObject;
                self.secondCommentViewHeight.constant = 62 + [Utils heightWithText:secondCom.comment andLabel:self.secCommentBodyLbl];
                self.secondCommentView.hidden = NO;
                
                [self.secCommentAvatarImageView sd_setImageWithURL:[NSURL URLWithString:secondCom.user.avatar]
                                                  placeholderImage:[UIImage imageNamed:@"profilePlaceholder"]
                                                           options:SDWebImageRefreshCached];
                self.secCommentNameLbl.text = secondCom.user.name;
                self.secCommentBodyLbl.text = secondCom.comment;
                self.secCommentTimeLbl.text = [Utils makeTimePassShortString:secondCom.timePass];
                
            }else{
                self.secondCommentView.hidden = YES;
                self.secondCommentViewHeight.constant = 0;
            }
        }
    }
}

- (IBAction)dotsBtnAction:(id)sender {
    [self.cellMenuView setHidden:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeWallCellMenu" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeCellMenu) name:@"closeWallCellMenu" object:nil];
}

- (void)closeCellMenu{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"closeWallCellMenu" object:nil];
    [self.cellMenuView setHidden:YES];
}


- (void)likedUserName:(UserModel*)user{
    if(user.userId == [DataManager sharedInstance].logedUser.userId){
        self.lastLikedNameLbl.text = [LanguageManager setLanguageString:@"you"];
    }else{
        self.lastLikedNameLbl.text = user.name;
    }
}

@end
