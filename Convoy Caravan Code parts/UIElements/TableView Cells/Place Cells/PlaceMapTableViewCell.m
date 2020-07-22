//
//  PlaceMapTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 10/31/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "PlaceMapTableViewCell.h"
#import "ColorDefinitions.h"
#import "UIImageView+WebCache.h"
#import "Utils.h"
#import "LanguageManager.h"

@implementation PlaceMapTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.mapView setUserInteractionEnabled:NO];
}

- (void)populateWithPlace:(PlaceModel*)place{
    
    if(self.marker == nil){
        self.titleLbl.text = [LanguageManager setLanguageString:@"find_us"];
        self.marker = [[GMSMarker alloc] init];
        self.marker .position = CLLocationCoordinate2DMake(place.latitude, place.longitude);
        [self.marker  setMap:self.mapView];
        //[self.marker  setUserData:place];
        
        //[self.marker  setIconView:[self getImageButtonIconViewWithColor:place.color isSmall:YES]];
        
        [self.mapView setCamera:[GMSCameraPosition cameraWithLatitude:place.latitude longitude:place.longitude zoom:14]];
    }

}

- (UIImageView*)getImageButtonIconViewWithColor:(UIColor*)color isSmall:(BOOL)small{
    CGRect frame = CGRectMake(0, 0, 50, 50);
    if(!small){
        frame = CGRectMake(0, 0, 64, 64);
    }
    
    UIImageView *marker = [[UIImageView alloc] initWithFrame:frame];
    [marker setTintColor:color];
    [marker setImage:[UIImage imageNamed:@"placeListIcon"]];
    return marker;
}

@end
