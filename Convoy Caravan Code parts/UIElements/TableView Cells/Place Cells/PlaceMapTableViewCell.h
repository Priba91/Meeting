//
//  PlaceMapTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 10/31/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceModel.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import "LocationManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaceMapTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong, nonatomic) GMSMarker *marker;

- (void)populateWithPlace:(PlaceModel*)place;

@end

NS_ASSUME_NONNULL_END
