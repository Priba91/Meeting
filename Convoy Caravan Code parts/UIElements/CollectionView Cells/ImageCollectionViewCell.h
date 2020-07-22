//
//  ImageCollectionViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 12/15/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *allImagesBtn;
@property (weak, nonatomic) IBOutlet UIButton *openImageBtn;

-(void)populateCellWithUrl:(NSString*)url cellIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
