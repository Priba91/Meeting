//
//  CategoryTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 11/19/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "CategoryTableViewCell.h"
#import "ColorDefinitions.h"
#import "UIImageView+WebCache.h"
#import "Utils.h"
#import "LanguageManager.h"
#import "UIImageView+WebCache.h"

@implementation CategoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [Utils addHalfHightCornerRadiusToView:self.iconImageView];
    [Utils addHalfHightCornerRadiusToView:self.checkImageView];
    [self.checkImageView setBackgroundColor:BASE_BAR_COLOR1];
}

- (void)populateWithCategory:(CategoryModel*)category{
    
    if(category.checked){
        [self.checkImageView setHidden:NO];
    }else{
        [self.checkImageView setHidden:YES];
    }
    
    [self.iconImageView setBackgroundColor:category.color];
    self.titleLbl.text = category.name;
}

@end
