//
//  AboutPlaceTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 10/31/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "AboutPlaceTableViewCell.h"
#import "ColorDefinitions.h"
#import "UIImageView+WebCache.h"
#import "Utils.h"
#import "LanguageManager.h"

@implementation AboutPlaceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
}


- (void)populateWithPlace:(PlaceModel*)place{
    
    self.titleLbl.text = [LanguageManager setLanguageString:@"about"];
    self.aboutlbl.text = place.desc;
}


@end
