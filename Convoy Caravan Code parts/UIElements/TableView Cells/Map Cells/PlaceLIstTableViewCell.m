//
//  PlaceLIstTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 9/20/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "PlaceLIstTableViewCell.h"
#import "ColorDefinitions.h"

@implementation PlaceLIstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.iconImageView setTintColor:BASE_BAR_COLOR1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
