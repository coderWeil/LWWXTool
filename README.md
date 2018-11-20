# LWWXTool
微信登录，注册,分享到朋友圈，支付等功能封装


#### 调用：

> 登录注册：

```
+ (void)sendAuthRequest:(NSString *)scope state:(NSString *)state openId:(NSString *)openId controller:(UIViewController *)controller completionHandler:(LWWXToolCompletionHandler)completionHandler

```

> 分享到微信：

```
+ (void)weixinShare:(NSString *)shareTitle shareDesc:(NSString *)shareDesc shareImage:(UIImage *)shareImage shareLink:(NSString *)shareLink completionHandler:(LWWXToolCompletionHandler)completionHandler

```

> 分享到朋友圈:

```
+ (void)timelineShare:(NSString *)shareTitle shareDesc:(NSString *)shareDesc shareImage:(UIImage *)shareImage shareLink:(NSString *)shareLink completionHandler:(LWWXToolCompletionHandler)completionHandler

```

> 支付：

```
+ (void)startWxPay:(NSString *)partnertId prePayId:(NSString *)prePay_id sign:(NSString *)sign timestamp:(NSString *)timestamp nonceStr:(NSString *)nonceStr package:(NSString *)package appId:(NSString *)appId completionHandler:(LWWXToolCompletionHandler)completionHandler

```
