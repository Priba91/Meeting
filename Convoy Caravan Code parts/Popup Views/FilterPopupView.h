//
//  FilterPopupView.h
//  Convoy Caravan
//
//  Created by Priba on 9/29/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FilterPopupView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *filterHolderView;
@property (weak, nonatomic) IBOutlet UIScrollView *filterScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filterScrollContentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filterScrollViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *filterTitleLbl;
@property (weak, nonatomic) IBOutlet UIButton *filterBtn;
@property (strong, nonatomic) NSMutableArray *categotyArray;
@property (weak, nonatomic) IBOutlet UIView *backHolderView;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
