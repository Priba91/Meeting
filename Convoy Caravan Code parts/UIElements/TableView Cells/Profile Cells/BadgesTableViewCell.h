//
//  BadgesTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 12/16/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BadgesTableViewCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UICollectionView *medalCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *seeAllBtn;

@property (strong, nonatomic) NSMutableArray *medalArray;

- (void)populateWithArray:(NSMutableArray*)array;


@end

NS_ASSUME_NONNULL_END
