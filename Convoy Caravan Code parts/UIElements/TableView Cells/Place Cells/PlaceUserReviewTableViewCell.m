//
//  PlaceUserReviewTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 11/8/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "PlaceUserReviewTableViewCell.h"
#import "ColorDefinitions.h"
#import "UIImageView+WebCache.h"
#import "Utils.h"
#import "LanguageManager.h"
#import "UIImageView+WebCache.h"

@implementation PlaceUserReviewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self.commentLbl setLineBreakMode:NSLineBreakByWordWrapping];
    
    [self.profileImageView.layer setCornerRadius:self.profileImageView.frame.size.height/2];
    [self.backView.layer setCornerRadius:16];
    
    [self.backView.layer setCornerRadius:8];
    self.backView.layer.shadowRadius = 3.5f;
    self.backView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backView.layer.shadowOffset = CGSizeMake(0.f, 0.f);
    self.backView.layer.shadowOpacity = 0.2f;
    self.backView.layer.masksToBounds = NO;
    [self.rateView setUserInteractionEnabled:NO];
}

- (void)populateWithComment:(ReviewModel*)review{
    
    self.commentLbl.text = review.comment;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:review.user.avatar]
                             placeholderImage:[UIImage imageNamed:@"profilePlaceholder"]
                                      options:SDWebImageRefreshCached];
    self.profileNameLbl.text = review.user.name;
    self.timeLbl.text = [Utils makeTimePassShortString:review.timePass];
    [self.rateView setRating:review.rate];

}

@end
