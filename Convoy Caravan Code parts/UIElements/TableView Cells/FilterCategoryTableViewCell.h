//
//  FilterCategoryTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 2/25/19.
//  Copyright © 2019 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FilterCategoryTableViewCell : UITableViewCell
    
    @property (weak, nonatomic) IBOutlet UILabel *cellLbl;
    @property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
    @property (weak, nonatomic) IBOutlet UIImageView *checkedImageView;
    
    @property (weak, nonatomic) IBOutlet UIButton *cellBtn;
    
    @property (nonatomic) BOOL state;
    
    - (void)populateCellWith:(CategoryModel*)category;
    
@end

NS_ASSUME_NONNULL_END
