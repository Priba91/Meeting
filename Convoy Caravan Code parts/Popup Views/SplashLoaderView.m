//
//  SplashLoaderView.m
//  Convoy Caravan
//
//  Created by Priba on 10/11/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "SplashLoaderView.h"
#import "ColorDefinitions.h"
#import "Utils.h"

@implementation SplashLoaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self prepareLoader];
    
    if([Utils isIphoneXSeries]){
        self.imageTopConstraint.constant = -120;
        self.imageBottomConstraint.constant = 120;
    }
}

- (void)prepareLoader{
//    CGRect screenRect = [UIApplication sharedApplication].keyWindow.frame;
//    CGFloat width = screenRect.size.width;
//    CGFloat height = screenRect.size.height;
//
//    CGSize loaderSize = CGSizeMake(40, 40);
//
//    self.loader = [[BLMultiColorLoader alloc] initWithFrame:CGRectMake((width - loaderSize.width)/2, (height - loaderSize.height)/2, loaderSize.width, loaderSize.height)];
//    [self.splashImageView addSubview:self.loader];
//
//    self.loader.lineWidth = 4.0;
//    self.loader.colorArray = [NSArray arrayWithObjects:BASE_BAR_COLOR1, nil];
//
//    [self.loader startAnimation];
    
}

@end
