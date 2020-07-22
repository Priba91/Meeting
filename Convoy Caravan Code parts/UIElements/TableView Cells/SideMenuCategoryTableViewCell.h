//
//  SideMenuCategoryTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 9/26/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SideMenuCategoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIButton *cellBtn;

- (void)populateCellWithCategory:(CategoryModel*)category;

@end

NS_ASSUME_NONNULL_END
