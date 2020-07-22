//
//  CategoryTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 11/19/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *cellBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

- (void)populateWithCategory:(CategoryModel*)category;

@end

NS_ASSUME_NONNULL_END
