//
//  ImageCollectionViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 12/15/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

- (void)awakeFromNib{
    [super awakeFromNib];

    self.layer.cornerRadius = 4;
    
}

-(void)populateCellWithUrl:(NSString*)url cellIndex:(NSInteger)index{
    
//    if(index == 4){
//        self.backView.hidden = NO;
//    }else{
//        self.backView.hidden = YES;
//    }
    self.backView.hidden = YES;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeImagePlaceholder"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.imageView.image = image;
    }];
    
}

@end
