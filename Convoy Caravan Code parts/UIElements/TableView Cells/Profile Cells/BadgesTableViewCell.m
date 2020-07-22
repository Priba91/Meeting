//
//  BadgesTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 12/16/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "BadgesTableViewCell.h"
#import "ColorDefinitions.h"
#import "LanguageManager.h"
#import "ServerCommunicationManager.h"
#import "DataManager.h"
#import "UIImageView+WebCache.h"
#import "Toast.h"
#import "MedalModel.h"
#import "AchivmentModel.h"
#import "CommentsViewController.h"
#import "ProfileMedalCollectionViewCell.h"
#import "MedalHeaderTableViewCell.h"
#import "WallMedalTableViewCell.h"

@implementation BadgesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    self.titleLbl.text = [LanguageManager setLanguageString:@"badges"];
    [self.seeAllBtn setTitle:[[LanguageManager setLanguageString:@"see_all"] uppercaseString] forState:UIControlStateNormal];
    self.medalCollectionView.dataSource = self;
    self.medalCollectionView.delegate = self;
    
    self.collectionViewHeight.constant = [Utils sizeForImagesCollectionView].height;
    
}

#pragma mark - CollectionView Data and Delegate

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if(indexPath.row < self.medalArray.count){
        MedalModel *medal = [self.medalArray objectAtIndex:indexPath.row];
        ProfileMedalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileMedalCollectionViewCell" forIndexPath:indexPath];
        cell.selectionBtn.tag = indexPath.row;
        [cell populateCellWithMedal:medal];
        
        return cell;
    }else{
        return  [[UICollectionViewCell alloc] init];
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.medalArray.count;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [Utils sizeForImagesCollectionView];

}

- (void)populateWithArray:(NSMutableArray*)array{
    
    self.medalArray = [[NSMutableArray alloc] init];
    self.medalArray = array;
    [self.medalCollectionView reloadData];
    
}

@end
