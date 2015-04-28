//
//  FLToasty.h
//
//  Created by Anton Gaenko on 06.03.15.
//  Copyright (c) 2015 Futurelabs. All rights reserved.
//

typedef void(^FLToastyTapBlock)();

@interface FLToasty : UIView

@property (strong, nonatomic) FLToastyTapBlock onToastTap;
@property (strong, nonatomic) UIFont* font UI_APPEARANCE_SELECTOR;


/**
 *  Show auto dismissing notification at the top of specific view
 *
 *  @param text Message to show
 *  @param view View where notification will be showed at the top
 */
+ (void)showInfo:(NSString*)text inView:(UIView*)parent;

/**
 *  Show auto dismissing notification at the top of specific view with tap handler
 *
 *  @param text Message to show
 *  @param view View where notification will be showed at the top
 *  @param tapBlock Block to execute when user tap this notification
 */

+ (void)showInfo:(NSString*)text inView:(UIView*)parent didTapBlock:(FLToastyTapBlock)tapBlock;

@end
