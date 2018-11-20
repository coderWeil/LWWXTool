//
//  LWWXTool.m
//  LWWXToolDemo
//
//  Created by weil on 2018/11/20.
//  Copyright © 2018 allyoga. All rights reserved.
//

#import "LWWXTool.h"
#import <UIImage+ResizeImage.h>

@interface LWWXTool ()
@property (nonatomic,copy) LWWXToolCompletionHandler completionHandler;
@end

@implementation LWWXTool
+ (instancetype)sharedManager {
    
    static LWWXTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[LWWXTool alloc] init];
    });
    return tool;
}

+ (void)startWxPay:(NSString *)partnertId prePayId:(NSString *)prePay_id sign:(NSString *)sign timestamp:(NSString *)timestamp nonceStr:(NSString *)nonceStr package:(NSString *)package appId:(NSString *)appId completionHandler:(LWWXToolCompletionHandler)completionHandler {
    [LWWXTool sharedManager].completionHandler = completionHandler;
    if (![WXApi isWXAppInstalled]) {
        if (completionHandler) {
            completionHandler(LWWXToolTypeNoneInstall,nil);
        }
        return;
    }
    
    if (![WXApi isWXAppSupportApi]) {
        if (completionHandler) {
            completionHandler(LWWXToolTypeNoSupport,nil);
        }
        return;
    }
    
    PayReq* req = [[PayReq alloc] init];
    req.partnerId = partnertId;
    req.prepayId = prePay_id;
    req.sign = sign;
    req.timeStamp = (UInt32)[timestamp intValue];
    req.nonceStr = nonceStr;
    req.package = package;
    [WXApi sendReq:req];
}


+ (void)sendAuthRequest:(NSString *)scope state:(NSString *)state openId:(NSString *)openId controller:(UIViewController *)controller completionHandler:(void(^)(LWWXToolType type))completionHandler {
    [LWWXTool sharedManager].completionHandler = completionHandler;
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = scope;
    req.state = state;
    req.openID = openId;
    [WXApi sendAuthReq:req viewController:controller delegate:[LWWXTool sharedManager]];
}

+ (void)weixinShare:(NSString *)shareTitle shareDesc:(NSString *)shareDesc shareImage:(UIImage *)shareImage shareLink:(NSString *)shareLink completionHandler:(void(^)(LWWXToolType type))completionHandler {
    [LWWXTool sharedManager].completionHandler = completionHandler;
    if (![WXApi isWXAppInstalled]) {
        if (completionHandler) {
            completionHandler(LWWXToolTypeNoneInstall,nil);
        }
        return;
    }
    
    SendMessageToWXReq *request = [[SendMessageToWXReq alloc] init];
    request.bText = NO;
    request.scene = WXSceneSession;
    WXMediaMessage *message = [WXMediaMessage message];
    if (shareLink == nil || shareLink.length == 0) {
        WXImageObject *imgObj = [WXImageObject object];
        imgObj.imageData = [UIImage compressImage:shareImage toByte:10 * 1024 * 1024];
        message.mediaObject = imgObj;
    }else {
        message.title = shareTitle;
        message.description = shareDesc;
        [message setThumbImage:[UIImage imageWithData:[UIImage compressImage:shareImage toByte:32 * 1024]]];
        WXWebpageObject *webObj = [WXWebpageObject object];
        webObj.webpageUrl = shareLink;
        message.mediaObject = webObj;
    }
    request.message = message;
    [WXApi sendReq:request];
    
}

+ (void)timelineShare:(NSString *)shareTitle shareDesc:(NSString *)shareDesc shareImage:(UIImage *)shareImage shareLink:(NSString *)shareLink completionHandler:(void(^)(LWWXToolType type))completionHandler {
    [LWWXTool sharedManager].completionHandler = completionHandler;
    if (![WXApi isWXAppInstalled]) {
        if (completionHandler) {
            completionHandler(LWWXToolTypeNoneInstall,nil);
        }
        return;
    }
    
    SendMessageToWXReq *request = [[SendMessageToWXReq alloc] init];
    request.bText = NO;
    request.scene = WXSceneTimeline;
    WXMediaMessage *message = [WXMediaMessage message];
    if (shareLink == nil || shareLink.length == 0) {
        WXImageObject *imgObj = [WXImageObject object];
        imgObj.imageData = [UIImage compressImage:shareImage toByte:10 * 1024 * 1024];
        message.mediaObject = imgObj;
    }else {
        message.title = shareTitle;
        message.description = shareTitle;
        [message setThumbImage:[UIImage imageWithData:[UIImage compressImage:shareImage toByte:32 * 1024]]];
        WXWebpageObject *webObj = [WXWebpageObject object];
        webObj.webpageUrl = shareLink;
        message.mediaObject = webObj;
    }
    request.message = message;
    [WXApi sendReq:request];
}

#pragma mark - 微信登录的代理
- (void)onResp:(BaseResp *)resp {
    
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {//微信分享
        SendMessageToWXResp *messageResp = (SendMessageToWXResp *)resp;
        if (messageResp.errCode == 0) {
            if ([LWWXTool sharedManager].completionHandler) {
                [LWWXTool sharedManager].completionHandler(LWWXToolTypeSuccess,nil);
            }
        }else {
            if ([LWWXTool sharedManager].completionHandler) {
                [LWWXTool sharedManager].completionHandler(LWWXToolTypeFailure,nil);
            }
        }
        return;
    }
    if ([resp isKindOfClass:[PayResp class]]) {//微信支付
        PayResp *response = (PayResp *)resp;
        switch (response.errCode) {
            case 0:
                if ([LWWXTool sharedManager].completionHandler) {
                    [LWWXTool sharedManager].completionHandler(LWWXToolTypeSuccess,@(response.errcode));
                }
                break;
            case -2:
                if ([LWWXTool sharedManager].completionHandler) {
                    [LWWXTool sharedManager].completionHandler(LWWXToolTypeCancel,@(response.errcode));
                }
                break;
            default:
                if ([LWWXTool sharedManager].completionHandler) {
                    [LWWXTool sharedManager].completionHandler(LWWXToolTypeFailure,@(response.errcode));
                }
                break;
        }
        return;
    }
    if (resp.errCode == 0) {//微信登录
        NSString *wxCode = ((SendAuthResp *)resp).code;
        if ([LWWXTool sharedManager].completionHandler) {
            [LWWXTool sharedManager].completionHandler(LWWXToolTypeSuccess,@(wxCode));
        }
    }else{
        if ([LWWXTool sharedManager].completionHandler) {
            [LWWXTool sharedManager].completionHandler(LWWXToolTypeFailure,nil);
        }
    }
}

@end
