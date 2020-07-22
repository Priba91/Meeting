//
//  PlaceInfoTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 10/31/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "PlaceInfoTableViewCell.h"
#import "ColorDefinitions.h"
#import "UIImageView+WebCache.h"
#import "Utils.h"
#import "LanguageManager.h"

@implementation PlaceInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)populateWithPlace:(PlaceModel*)place{
    
    self.titleLbl.text = [LanguageManager setLanguageString:@"info"];
    
    if(place.phone != nil){
        NSMutableAttributedString *attributePhoneString = [[NSMutableAttributedString alloc] initWithString:place.phone];
        [attributePhoneString addAttribute:NSUnderlineStyleAttributeName
                                     value:[NSNumber numberWithInt:1]
                                     range:(NSRange){0,[attributePhoneString length]}];
        [attributePhoneString addAttribute:NSForegroundColorAttributeName value:MAIN_ROUTE_COLOR range:(NSRange){0,[attributePhoneString length]}];
        [attributePhoneString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16 weight:UIFontWeightSemibold] range:(NSRange){0,[attributePhoneString length]}];
        self.phoneLbl.attributedText = attributePhoneString;
    }
    
    if(place.url != nil){
        NSMutableAttributedString *attributeWebString = [[NSMutableAttributedString alloc] initWithString:place.url];
        [attributeWebString addAttribute:NSUnderlineStyleAttributeName
                                   value:[NSNumber numberWithInt:1]
                                   range:(NSRange){0,[attributeWebString length]}];
        [attributeWebString addAttribute:NSForegroundColorAttributeName value:MAIN_ROUTE_COLOR range:(NSRange){0,[attributeWebString length]}];
        [attributeWebString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16 weight:UIFontWeightSemibold] range:(NSRange){0,[attributeWebString length]}];
        self.webSiteLbl.attributedText = attributeWebString;
        
        self.worktimeLbl.text = place.workTime;
    }

}

@end
