//
//  FilterCategoryTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 2/25/19.
//  Copyright © 2019 Priba. All rights reserved.
//

#import "FilterCategoryTableViewCell.h"
#import "ColorDefinitions.h"

@implementation FilterCategoryTableViewCell
    
- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self.iconImageView.layer setCornerRadius:self.iconImageView.frame.size.width/2];
    [self.checkedImageView.layer setCornerRadius:self.checkedImageView.frame.size.height/2];
    [self.checkedImageView setBackgroundColor:BASE_BAR_COLOR1];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}
    
    
//- (IBAction)changeState:(id)sender {
//    self.state = !self.state;
//    if(self.state){
//        [self.checkedImageView setHidden:NO];
//    }else{
//        [self.checkedImageView setHidden:YES];
//    }
//}
    
- (void)populateCellWith:(CategoryModel*)category{
    
    self.cellLbl.text = category.name;
    [self.iconImageView setBackgroundColor:category.color];
    
    if(category.checked){
        [self.checkedImageView setHidden:NO];
    }else{
        [self.checkedImageView setHidden:YES];
    }
    
}
    

@end
