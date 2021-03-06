
//
//  CollectionBtnView.m
//  CollectionAnimation
//
//  Created by lujh on 2018/2/7.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "CollectionBtnView.h"
@interface CollectionBtnView ()
// layer
@property (nonatomic, strong) CALayer *maskLayer;
// 边框图片
@property (nonatomic, strong) UIImageView *borderImageView;
// 点击手势
@property (nonatomic, strong) UITapGestureRecognizer *tap;
// 填充颜色view
@property (nonatomic, strong) UIView *fillView;
@end

@implementation CollectionBtnView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 初始化Subviews
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [self addGestureRecognizer:self.tap];
}

- (void)setMaskImage:(UIImage *)maskImage
{
    _maskImage = maskImage;
    
    if (!_maskLayer) {
        self.maskLayer = [CALayer layer];
        self.maskLayer.frame = CGRectMake(0,0, _maskImage.size.width, _maskImage.size.height);
        self.layer.mask = _maskLayer;
    }
    self.maskLayer.contents = (id)[_maskImage CGImage];
}

- (void)setBorderImage:(UIImage *)borderImage
{
    _borderImage = borderImage;
    if (!_borderImageView) {
        self.borderImageView = [[UIImageView alloc] init];
        self.borderImageView.frame = CGRectMake(0,0, _borderImage.size.width, _borderImage.size.height);
        [self addSubview:_borderImageView];
    }
    self.borderImageView.image = _borderImage;
    [self sendSubviewToBack:_borderImageView];
}

- (void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    if (!_fillView) {
        self.fillView = [[UIView alloc] initWithFrame:self.bounds];
        self.fillView.layer.cornerRadius = self.bounds.size.width * 0.5f;
        self.fillView.transform = CGAffineTransformMakeScale(0, 0);
        [self addSubview:_fillView];
    }
    self.fillView.backgroundColor = _fillColor;
}


- (void)tapView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    self.userInteractionEnabled = NO;
    if (CGAffineTransformIsIdentity(_fillView.transform)) {
        [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.fillView.transform = CGAffineTransformMakeScale(FLT_MIN, FLT_MIN);
        } completion:^(BOOL finished) {
            self.userInteractionEnabled = YES;
        }];
    }
    else{
        [UIView animateWithDuration:0.35f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.fillView.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            self.userInteractionEnabled = YES;
        }];
    }
}

@end
