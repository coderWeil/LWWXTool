
Pod::Spec.new do |s|

  s.name         = "LWWXTool"
  s.version      = "0.0.4"
  s.summary      = "微信小工具"

  s.description  = "提供微信登录，注册，支付，分享等功能"

  s.homepage     = "https://github.com/weilLove/LWWXTool"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "weilLove" => "weil218@163.com" }
 
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/weilLove/LWWXTool.git", :tag => "#{s.version}" }

  s.source_files  = "LWWXTool/Classess", "LWWXTool/Classess/**/*.{h,m}"
  
  s.frameworks = "UIKit", "Foundation"

  s.dependency "WechatOpenSDK"

end
