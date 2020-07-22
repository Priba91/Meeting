//
//  FilterPopupView.m
//  Convoy Caravan
//
//  Created by Priba on 9/29/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "FilterPopupView.h"
#import "FilterMapTableViewCell.h"
#import "DataManager.h"
#import "LanguageManager.h"
#import "ColorDefinitions.h"
#import "FilterCellView.h"
#import "Utils.h"

@implementation FilterPopupView 

NSInteger cellHeight = 50;
NSInteger cellCreateIndex = 0;

NSMutableArray<FilterCellView *> *cellsArray;

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self loadData];
    [self setupStrings];
    [self setupUI];
}

- (void)setupStrings{
    [self.filterBtn setTitle:[LanguageManager setLanguageString:@"filter"] forState:UIControlStateNormal];
    self.filterTitleLbl.text = [LanguageManager setLanguageString:@"filter"];
}

- (void)setupUI{

    [self.filterBtn.layer setCornerRadius:self.filterBtn.frame.size.height/2];
    [self.filterTitleLbl setTextColor:BASE_BAR_COLOR1];
    [Utils addGradientToView:self.filterBtn];
    [self.backHolderView.layer setCornerRadius:12];

    CGFloat cons = self.categotyArray.count * cellHeight;
    
    [self.filterScrollView setContentInset:UIEdgeInsetsMake(0, 0, (cons - 600), 0)];

    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backGestureAction)];
    [self.backgroundView addGestureRecognizer:backTap];
}

- (void)loadData{
    
    self.categotyArray = [[NSMutableArray alloc] initWithArray:[DataManager sharedInstance].storedCategories copyItems:YES];
    
    for (CategoryModel *category in self.categotyArray) {
        
        FilterCellView *cell = [[[NSBundle mainBundle] loadNibNamed:@"FilterCell" owner:self options:nil] lastObject];
        
        cell.state = category.checked;
        cell.cellLbl.text = category.name;
        [cell.iconImageView setBackgroundColor:category.color];
        
        cell.cellBtn.tag = cellCreateIndex;
        [cell.cellBtn addTarget:self action:@selector(changeCategoryState:) forControlEvents:UIControlEventTouchUpInside];
        
        if(category.checked){
            [cell.checkedImageView setHighlighted:NO];
        }else{
            [cell.checkedImageView setHighlighted:YES];
        }
        
        [cell setFrame:CGRectMake(0, cellCreateIndex*cellHeight, self.filterScrollView.frame.size.width, cellHeight)];
        [self.filterHolderView addSubview:cell];
        
        [cellsArray addObject:cell];
        cellCreateIndex += 1;
    }

    
}

- (void)reloadData{
    self.categotyArray = [[NSMutableArray alloc] initWithArray:[DataManager sharedInstance].storedCategories copyItems:YES];

    for (int i = 0; i < self.filterHolderView.subviews.count; i++) {
        
        if([[self.filterHolderView.subviews objectAtIndex:i] isKindOfClass:[FilterCellView class]] && i < self.categotyArray.count){
            FilterCellView *view = [self.filterHolderView.subviews objectAtIndex:i];
            CategoryModel *cat = [self.categotyArray objectAtIndex:i];
            view.state = cat.checked;
            if(view.state){
                [view.checkedImageView setHidden:NO];
            }else{
                [view.checkedImageView setHidden:YES];
            }
        }
    }

}

- (void)changeCategoryState:(UIButton *)sender {
    
    CategoryModel *cat = [self.categotyArray objectAtIndex:sender.tag];
    cat.checked = !cat.checked;
    
}

- (IBAction)filterBtnAction:(id)sender {
    [DataManager sharedInstance].storedCategories = [[NSMutableArray alloc] initWithArray:self.categotyArray];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeFilterView" object:nil userInfo:@{@"reload":@"YES"}];
}

#pragma mark - TableView Data and Delegate

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if(indexPath.row < [self.categotyArray count]){
        FilterMapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterMapTableViewCell" forIndexPath:indexPath];
        
        [cell populateCellWith:[self.categotyArray objectAtIndex:indexPath.row]];
        
        return cell;
    }else{
        return [[UITableViewCell alloc] init];
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categotyArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CategoryModel *tmp = [self.categotyArray objectAtIndex:indexPath.row];
    if(tmp.checked){
        tmp.checked = NO;
    }else{
        tmp.checked = YES;
    }
    //tmp.checked = !tmp.checked;
    //[self.filterTableView reloadData];
    
}

- (void)backGestureAction{
    [self endEditing:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeFilterView" object:nil userInfo:nil];
}

@end
