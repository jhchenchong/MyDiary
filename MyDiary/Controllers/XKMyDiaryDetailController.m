//
//  XKMyDiaryDetailController.m
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/4/5.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKMyDiaryDetailController.h"
#import "XKMyDiaryDetailCell.h"

@interface XKMyDiaryDetailController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation XKMyDiaryDetailController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"detailBG"].CGImage;
    
    [self.view addSubview:self.collectionView];
    
    if (self.index) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.index inSection:0];
            
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            
        });
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XKMyDiaryDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    cell.model = self.dataSource[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    cell.block = ^{
      
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            
            if (weakSelf.block) {
                
                weakSelf.block();
            }
            
        }];
    };
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"...");
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        AnimatedCollectionViewLayout *layout = [[AnimatedCollectionViewLayout alloc] initWithAnimationType:NSClassFromString(@"RotateInOutAttributesAnimator")];
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        layout.minimumLineSpacing = 0;
        
        layout.minimumInteritemSpacing = 0;
        
        layout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        
        _collectionView.dataSource = self;
        
        _collectionView.delegate = self;
        
        _collectionView.showsVerticalScrollIndicator = NO;
        
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        _collectionView.pagingEnabled = YES;
        
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[XKMyDiaryDetailCell class] forCellWithReuseIdentifier:@"cellID"];
    }
    return _collectionView;
}

- (NSArray *)dataSource {
    
    if (!_dataSource) {
        
        _dataSource = @[];
    }
    return _dataSource;
}

@end
