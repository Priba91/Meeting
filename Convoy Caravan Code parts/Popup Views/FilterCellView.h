//
//  FilterCellView.h
//  Convoy Caravan
//
//  Created by Priba on 9/30/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FilterCellView : UIView

@property (weak, nonatomic) IBOutlet UILabel *cellLbl;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *checkedImageView;

@property (weak, nonatomic) IBOutlet UIButton *cellBtn;

@property (nonatomic) BOOL state;

@end

NS_ASSUME_NONNULL_END
