//
//  CustomAlertView.h
//  KohlerLife
//
//  Created by songcf on 16/3/15.
//  Copyright © 2016年 archermind. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomAlertView;

@protocol CustomAlertViewDelegate <NSObject>
@optional
- (void)customAlertView:(CustomAlertView *)alertView clickButtonIndex:(NSInteger)buttonIndex;

@end

@interface CustomAlertView : UIView

@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, weak) id <CustomAlertViewDelegate> delegate;

- (instancetype)initWithMessage:(NSString *)message delegate:(id<CustomAlertViewDelegate>)delegate cancelButtonTitle:(NSString  *)cancelButtonTitle chooseButtonTitle:(NSString *)chooseButtonTitle;

- (void)alertShow;

@end
