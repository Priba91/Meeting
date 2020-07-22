//
//  SpinerTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 10/10/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "SpinerTableViewCell.h"
#import "ColorDefinitions.h"

@implementation SpinerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.spiner startAnimating];
    [self.spiner setTintColor:BASE_BAR_COLOR1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
