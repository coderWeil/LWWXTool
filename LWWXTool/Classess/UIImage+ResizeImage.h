//
//  UIImage+ResizeImage.h
//  LWWXToolDemo
//
//  Created by weil on 2018/11/20.
//  Copyright © 2018 allyoga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ResizeImage)
+ (NSData *)compressImage:(UIImage *)sourceImage toByte:(NSUInteger)maxLength;
@end
