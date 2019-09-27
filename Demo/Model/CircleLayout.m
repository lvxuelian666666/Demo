
//
//  CircleLayout.m
//  Demo
//
//  Created by Shelly on 9/26/19.
//  Copyright © 2019 Shelly. All rights reserved.
//

#import "CircleLayout.h"

@implementation CircleLayout

#pragma mark -- 用来设置布局钱的准备工作
-(void)prepareLayout
{
    [super prepareLayout];
    //设置内边距
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) / 2;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

#pragma mark -- 当collectionView的显示范围发生变化的时候,是否需要刷新,默认为no
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

#pragma mark -- 返回所有item的布局属性值
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //拿到collectionView的所有布局的属性值
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    //计算item的中心,等于collectionView的偏移值加上collectionView的宽度的一半
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width/2;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        CGFloat scale = 0.5;
        //计算每个item的center距离collectionView内容视图的center值
        CGFloat delta = ABS(attrs.center.x - centerX);
        scale = 1 - delta / self.collectionView.frame.size.width;
        //设置item布局属性的放大值
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return array;
}

#pragma mark -- 此函数的返回值决定了collectionview停止时item的偏移值，在这里主要是让我们滑动结束的时候item能自动调整到中间位置
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //计算出最终显示的矩形框
    CGRect rect ;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x + self.collectionView.frame.size.width /2;
    rect.size = self.collectionView.frame.size;
    //获得super已经计算出来的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    //计算collectionView的最中心点的x
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width /2;
    
    //存放最小的间距值
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }
    
    //计算最终的偏移量
    proposedContentOffset.x += minDelta;
    return proposedContentOffset;
}



@end
