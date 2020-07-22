//
//  BannerTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 10/10/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "BannerTableViewCell.h"
#import "ColorDefinitions.h"
#import "UIImageView+WebCache.h"
#import "Utils.h"

@implementation BannerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
 
    self.layer.shadowRadius = 2.5f;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2.f, 2.f);
    self.layer.shadowOpacity = 0.1f;
    self.layer.masksToBounds = NO;
    
    [self.bannerImageView.layer setCornerRadius:8];
}

-(void) setImageWithUrl:(NSString*)urlStr{
    [self.bannerImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]
                             placeholderImage:[UIImage imageNamed:@"placeImagePlaceholder"]
                                      options:SDWebImageHighPriority];
}

@end
