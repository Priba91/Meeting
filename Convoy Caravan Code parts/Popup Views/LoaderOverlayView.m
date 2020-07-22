//
//  LoaderOverlayView.m
//  Convoy Caravan
//
//  Created by Priba on 10/15/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "LoaderOverlayView.h"
#import "ColorDefinitions.h"

@implementation LoaderOverlayView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    CGSize loaderSize = CGSizeMake(40, 40);

    CGRect screenRect = self.frame;
    CGFloat width = screenRect.size.width;
    CGFloat height = screenRect.size.height;
    
    self.loader = [[BLMultiColorLoader alloc] initWithFrame:CGRectMake((width - loaderSize.width)/2, height/2, loaderSize.width, loaderSize.height)];
    [self addSubview:self.loader];
    self.loader.lineWidth = 4.0;
    self.loader.colorArray = [NSArray arrayWithObjects:BASE_BAR_COLOR1, nil];

    
    [self.loader startAnimation];
}

@end
