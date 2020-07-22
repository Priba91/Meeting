//
//  SpinerCollectionViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 12/16/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "SpinerCollectionViewCell.h"
#import "ColorDefinitions.h"

@implementation SpinerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.spiner startAnimating];
    [self.spiner setTintColor:BASE_BAR_COLOR1];
}
@end
