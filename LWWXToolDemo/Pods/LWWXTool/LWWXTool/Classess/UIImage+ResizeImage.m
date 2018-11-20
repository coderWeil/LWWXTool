//
//  UIImage+ResizeImage.m
//  LWWXToolDemo
//
//  Created by weil on 2018/11/20.
//  Copyright © 2018 allyoga. All rights reserved.
//

#import "UIImage+ResizeImage.h"

@implementation UIImage (ResizeImage)
+ (NSData *)compressImage:(UIImage *)sourceImage toByte:(NSUInteger)maxLength {
    CGFloat compression = 1.0;
    NSData *data = UIImageJPEGRepresentation(sourceImage, compression);
    if (data.length <= maxLength) {
        return data;
    }
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2.0;
        data = UIImageJPEGRepresentation(sourceImage, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        }else if (data.length > maxLength) {
            max = compression;
        }else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length <= maxLength) {
        return data;
    }
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    return data;
}

@end
