//
//  CustomAlertView.m
//  KohlerLife
//
//  Created by songcf on 16/3/15.
//  Copyright © 2016年 archermind. All rights reserved.
//

#import "CustomAlertView.h"
#import "CommonMacro.h"
#import "Masonry.h"

@implementation CustomAlertView

- (instancetype)initWithMessage:(NSString *)message delegate:(id<CustomAlertViewDelegate>)delegate cancelButtonTitle:(NSString  *)cancelButtonTitle chooseButtonTitle:(NSString *)chooseButtonTitle {
    
    self = [super init];
    
    if (self) {
        
        _delegate = delegate;
        
        //设置frame and backgroundcolor
        self.frame = [[UIScreen mainScreen] bounds];
        self.backgroundColor = [UIColor clearColor];
        
        //创建一个小的view 用来作为提示框部分
        UIView *view = [[UIView alloc] init];//由于开始的时候并不知道alertview的大小 所以 只初始化 不设定大小 等所有的东西固定完毕再去重新设定
        
        /*-----------创建内容label------*/
        UILabel  *messageLabel = [[UILabel alloc] init];
        // 先计算出 message文本的大小
        CGSize size = [message boundingRectWithSize:CGSizeMake(150, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
//        messageLabel.frame = CGRectMake(5, 5, kMainScreenWidth - 70, size.height + 60);
        messageLabel.numberOfLines = 0;
        messageLabel.text = message;
        messageLabel.font = [UIFont systemFontOfSize:13];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.backgroundColor = [UIColor clearColor];
        [view addSubview:messageLabel];
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.and.top.mas_equalTo(5);
            make.width.mas_equalTo(kMainScreenWidth - 70);
            make.height.mas_equalTo(size.height + 40);
        }];
        
        // 横线
        UILabel *longLine = [[UILabel alloc] init];
        longLine.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:longLine];
        [longLine mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_equalTo(0);
            make.top.equalTo(messageLabel.mas_bottom).with.offset(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        // 创建按钮button
        if (cancelButtonTitle != nil && chooseButtonTitle != nil) {
            
            UIButton  *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            //        cancelButton.frame = CGRectMake(5, size.height+15+60, (kMainScreenWidth - 70) / 2, 40);
            [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
            cancelButton.tag = 0;
            //        cancelButton.backgroundColor = [UIColor magentaColor];
            [cancelButton addTarget:self action:@selector(alertButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:cancelButton];
            [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(5);
                make.top.equalTo(longLine.mas_bottom).with.offset(0);
                make.width.mas_equalTo((kMainScreenWidth - 70) / 2);
                make.height.mas_equalTo(40);
            }];
            
            UILabel *shortLine = [[UILabel alloc] init];
            shortLine.backgroundColor = [UIColor lightGrayColor];
            [view addSubview:shortLine];
            [shortLine mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(cancelButton.mas_right).with.offset(0);
                make.top.equalTo(longLine.mas_bottom).with.offset(0);
                make.width.mas_equalTo(1);
                make.bottom.mas_equalTo(0);
            }];
            
            
            UIButton  *chooseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            //        chooseButton.frame = CGRectMake(5, size.height+15+60, (kMainScreenWidth - 70) / 2, 40);
            chooseButton.tag = 1;
            [chooseButton setTitle:chooseButtonTitle forState:UIControlStateNormal];
            chooseButton.backgroundColor = [UIColor clearColor];
            [chooseButton addTarget:self action:@selector(alertButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:chooseButton];
            [chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(cancelButton.mas_right).with.offset(0);
                make.top.equalTo(longLine.mas_bottom).with.offset(0);
                make.width.mas_equalTo((kMainScreenWidth - 70) / 2);
                make.height.mas_equalTo(40);
            }];
            
        }else if (cancelButtonTitle == nil || chooseButtonTitle == nil){
            
            UIButton  *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            //        cancelButton.frame = CGRectMake(5, size.height+15+60, (kMainScreenWidth - 70) / 2, 40);
            if (cancelButtonTitle == nil) {
                
                [cancelButton setTitle:chooseButtonTitle forState:UIControlStateNormal];
            }else{
                [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
            }
            
            cancelButton.tag = 0;
            //        cancelButton.backgroundColor = [UIColor magentaColor];
            [cancelButton addTarget:self action:@selector(alertButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:cancelButton];
            [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(5);
                make.top.equalTo(longLine.mas_bottom).with.offset(0);
                make.width.mas_equalTo(kMainScreenWidth - 70);
                make.height.mas_equalTo(40);
            }];
        }
        
        
        /*-------当计算完alerview上面所有的子控件时  就可以计算alertview自身的frame了*/
//        view.center = self.center;
        view.backgroundColor = [UIColor whiteColor];
//        view.bounds = CGRectMake(0, 0, kMainScreenWidth - 60, 125+size.height);
        [self addSubview:view];
        WS(ws);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.center.equalTo(ws);
            make.width.mas_equalTo(kMainScreenWidth - 60);
            make.height.mas_equalTo(85 + size.height);
        }];
        _alertView = view;
    }
    
    return self;
}

- (void)alertShow{
    //找window
    UIWindow   *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    
    self.alertView.center = self.center;
}

#pragma mark -- button的点击事件
- (void)alertButtonClick:(UIButton*)sender{
    
    //将你的alert动画的从屏幕中移除
    [self removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(customAlertView:clickButtonIndex:)]) {
        
        [self.delegate customAlertView:self clickButtonIndex:sender.tag];
    }
}

@end
