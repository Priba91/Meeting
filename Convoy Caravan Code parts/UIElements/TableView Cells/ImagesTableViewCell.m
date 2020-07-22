//
//  ImagesTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 12/15/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "ImagesTableViewCell.h"
#import "ColorDefinitions.h"
#import "LanguageManager.h"
#import "ServerCommunicationManager.h"
#import "DataManager.h"
#import "Utils.h"
#import "ImageCollectionViewCell.h"

@implementation ImagesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    self.titleLbl.text = [LanguageManager setLanguageString:@"images"];
    [self.seeAllBtn setTitle:[[LanguageManager setLanguageString:@"see_all"] uppercaseString] forState:UIControlStateNormal];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.collectionViewHeight.constant = [Utils sizeForImagesCollectionView].height;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - CollectionView Data and Delegate

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if(indexPath.row < self.urlArray.count){
        NSString *url = [self.urlArray objectAtIndex:indexPath.row];
        ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCell" forIndexPath:indexPath];
        [cell populateCellWithUrl:url cellIndex:indexPath.row];
        cell.openImageBtn.tag = indexPath.row;
        
        [cell.openImageBtn removeTarget:self action:@selector(openImageBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.openImageBtn addTarget:self action:@selector(openImageBtnAction:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }else{
        return  [[UICollectionViewCell alloc] init];
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.urlArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [Utils sizeForImagesCollectionView];
}

- (void)populateWithArray:(NSMutableArray*)array{
    
    self.urlArray = [[NSMutableArray alloc] init];
    self.urlArray = array;
    
    if(self.urlArray.count < 5){
        self.seeAllBtn.hidden = YES;
    }else{
        self.seeAllBtn.hidden = NO;
    }
    
    [self.collectionView reloadData];
    
}
- (IBAction)openImageBtnAction:(UIButton *)sender {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"openImageWithUrl" object:[self.urlArray objectAtIndex:sender.tag]];
}

@end
