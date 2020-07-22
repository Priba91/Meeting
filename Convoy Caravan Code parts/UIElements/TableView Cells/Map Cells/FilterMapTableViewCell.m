//
//  FilterMapTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 9/29/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "FilterMapTableViewCell.h"

@implementation FilterMapTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self.categoryIcon.layer setCornerRadius:self.categoryIcon.frame.size.width/2];
    [self.checkedImageView.layer setCornerRadius:self.checkedImageView.frame.size.width/2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)populateCellWith:(CategoryModel*)category{

    self.titleLbl.text = category.name;
    [self.categoryIcon setBackgroundColor:category.color];

    if(category.checked){
        [self.checkedImageView setHighlighted:NO];
    }else{
        [self.checkedImageView setHighlighted:YES];
    }
    
}

@end
