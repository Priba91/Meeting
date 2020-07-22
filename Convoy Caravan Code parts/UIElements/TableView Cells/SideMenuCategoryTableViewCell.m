//
//  SideMenuCategoryTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 9/26/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "SideMenuCategoryTableViewCell.h"

@implementation SideMenuCategoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.iconImageView.layer setCornerRadius:self.iconImageView.frame.size.width/2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)populateCellWithCategory:(CategoryModel*)category{
    
    self.titleLbl.text = category.name;
    [self.iconImageView setBackgroundColor:category.color];
}

@end
