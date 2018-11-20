//
//  LWWXTool.h
//  LWWXToolDemo
//
//  Created by weil on 2018/11/20.
//  Copyright © 2018 allyoga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WXApi.h>
#import <WXApiObject.h>

typedef NS_ENUM(NSUInteger, LWWXToolType) {
    LWWXToolTypeNoneInstall,//未安装
    LWWXToolTypeFailure,//失败
    LWWXToolTypeSuccess, //成功
    LWWXToolTypeCancel,//取消
    LWWXToolTypeNoSupport,//不支持
};


typedef void(^LWWXToolCompletionHandler)(LWWXToolType type,_Nullable id value);
@interface LWWXTool : NSObject<WXApiDelegate>
//单例模式
+ (instancetype)sharedManager;
//向微信注册
+ (BOOL)lw_registerApp:(NSString *)appId enableMTA:(BOOL)enable;
//是否允许app打开微信
+ (BOOL)lw_handleOpenURL:(NSURL *)url;
//是否安装微信
+ (BOOL)lw_isWXInstalled;
//是否支持微信
+ (BOOL)lw_isWXSupported;
//微信支付
+ (void)startWxPay:(NSString *)partnertId prePayId:(NSString *)prePay_id sign:(NSString *)sign timestamp:(NSString *)timestamp nonceStr:(NSString *)nonceStr package:(NSString *)package appId:(NSString *)appId completionHandler:(LWWXToolCompletionHandler)completionHandler;
//微信登录
+ (void)sendAuthRequest:(NSString *)scope state:(NSString *)state openId:(NSString *)openId controller:(UIViewController *)controller completionHandler:(LWWXToolCompletionHandler)completionHandler;
//分享到微信
+ (void)weixinShare:(NSString *)shareTitle shareDesc:(NSString *)shareDesc shareImage:(UIImage *)shareImage shareLink:(NSString *)shareLink completionHandler:(LWWXToolCompletionHandler)completionHandler;
//分享到朋友圈
+ (void)timelineShare:(NSString *)shareTitle shareDesc:(NSString *)shareDesc shareImage:(UIImage *)shareImage shareLink:(NSString *)shareLink completionHandler:(LWWXToolCompletionHandler)completionHandler;
@end
