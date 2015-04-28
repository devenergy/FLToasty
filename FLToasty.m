//
//  FLToasty.m
//  talks
//
//  Created by Anton Gaenko on 06.03.15.
//  Copyright (c) 2015 Futurelabs. All rights reserved.
//

#import "FLToasty.h"

const NSInteger kFLToastyTag = 100001;

@implementation FLToasty

+ (void)showInfo:(NSString*)text inView:(UIView*)parent {
    [self showInfo:text inView:parent didTapBlock:nil];
}

+ (void)showInfo:(NSString*)text inView:(UIView*)parent didTapBlock:(FLToastyTapBlock)tapBlock {
    [self removePreviousIfShowing:parent];
    
    FLToasty* toast = [self createToast:text inView:parent];
    toast.onToastTap = tapBlock;
    
    [self performPresentToastAnimation:toast inParent:parent];
    [self scheduleDismissToastAnimation:toast];
    [self addTapHandler:toast];
}

+ (BOOL)removePreviousIfShowing:(UIView*)parent {
    for (UIView* s in parent.subviews) {
        if (s.tag == kFLToastyTag) {
            [s removeFromSuperview];
            return YES;
        }
    }
    return NO;
}

+ (FLToasty*)createToast:(NSString*)text inView:(UIView*)parent {
    FLToasty* toast = [FLToasty new];
    toast.tag = kFLToastyTag;
    toast.frame = CGRectMake(0, 0, CGRectGetWidth(parent.frame), 20);
    toast.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7f];
    toast.translatesAutoresizingMaskIntoConstraints = NO;
    
    UILabel* label = [UILabel new];
    label.textColor = [UIColor whiteColor];
    label.text = text;
    label.font = [FLToasty appearance].font ? : [UIFont systemFontOfSize:14];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.textAlignment = NSTextAlignmentCenter;
    
    [toast addSubview:label];
    [parent addSubview:toast];
    
    [parent addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[toast]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(toast)]];
    [parent addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[toast(32)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(toast)]];
    [toast addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-16-[label]-16-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
    [toast addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                      attribute:NSLayoutAttributeCenterY
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:toast
                                                      attribute:NSLayoutAttributeCenterY
                                                     multiplier:1.0f constant:0]];
    
    [parent layoutSubviews];
    
    return toast;
}

+ (void)performPresentToastAnimation:(FLToasty*)toast inParent:(UIView*)parent {
    toast.hidden = YES;
    [UIView transitionWithView:parent
                      duration:.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve |
     UIViewAnimationOptionLayoutSubviews
                    animations:^{
                        toast.hidden = NO;
                    } completion:nil];
}

+ (void)scheduleDismissToastAnimation:(FLToasty*)toast {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performDismissToastAnimation:toast];
    });
}

+ (void)performDismissToastAnimation:(FLToasty*)toast {
    [UIView transitionFromView:toast
                        toView:nil
                      duration:.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve |
     UIViewAnimationOptionLayoutSubviews
                    completion:^(BOOL finished) {
                        [toast removeFromSuperview];
                    }];

}

+ (void)addTapHandler:(FLToasty*)toast {
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:toast action:@selector(didToastTap:)];
    [toast addGestureRecognizer:tapRecognizer];
}

- (void)didToastTap:(UITapGestureRecognizer*)tapRecognizer {
    FLToasty* toast = (FLToasty*) tapRecognizer.view;
    if (toast.onToastTap) toast.onToastTap();
    [FLToasty performDismissToastAnimation:toast];
}

@end
