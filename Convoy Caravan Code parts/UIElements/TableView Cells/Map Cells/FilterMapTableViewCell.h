//
//  FilterMapTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 9/29/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FilterMapTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *categoryIcon;
@property (weak, nonatomic) IBOutlet UIImageView *checkedImageView;

- (void)populateCellWith:(CategoryModel*)category;

@end

NS_ASSUME_NONNULL_END
