//
//  FriendCollectionView.m
//  MyWeibo
//
//  Created by Allen on 15/12/23.
//  Copyright © 2015年 Allen. All rights reserved.
//

#define identify @"friendCell"
#import "FriendCollectionView.h"
#import "Common.h"
#import "FriendCollectionViewCell.h"
@implementation FriendCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = NO;
    
    flowLayout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[FriendCollectionViewCell class] forCellWithReuseIdentifier:identify];
    }
    return self;
   
}
@end
