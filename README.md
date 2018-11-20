# LWWXTool
微信登录，注册,分享到朋友圈，支付等功能封装


#### 调用：

> 向微信注册：

```
//向微信注册
+ (BOOL)lw_registerApp:(NSString *)appId enableMTA:(BOOL)enable;

```

> 是否允许打开微信（app打开微信）

```
//是否允许app打开微信
+ (BOOL)lw_handleOpenURL:(NSURL *)url;

```
> 是否安装了微信

```
//是否安装微信
+ (BOOL)lw_isWXInstalled;

```

> 是否支持微信

```
//是否支持微信
+ (BOOL)lw_isWXSupported;
```

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
