//
//  LLUtils.m
//  StoreIntegral
//
//  Created by kevin on 2016/12/20.
//  Copyright © 2016年 Ecommerce. All rights reserved.
//

#define hudDismissTime 3

#import "SVProgressHUD.h"
#import "LLUtils.h"
#import <TTTAttributedLabel/TTTAttributedLabel.h>



@implementation LLUtils

+ (BOOL)strNilOrEmpty:(NSString *)str{
    return str == nil
    || str == NULL
    || [str isKindOfClass:[NSNull class]]
    ||([str respondsToSelector:@selector(length)]
       && [(NSData *)str length] == 0)
    || ([str respondsToSelector:@selector(count)]
        && [(NSArray *)str count] == 0);
}

+ (NSString *)strRelay:(id)str
{
    if([LLUtils strNilOrEmpty:str]){
        return @"";
    }
    else if([str isKindOfClass:[NSString class]]){
        return str;
    }
    else if([str isKindOfClass:[NSNumber class]]){
        return [str stringValue];
    }
    return str;
}

+ (NSString *)strNilOrEmpty:(id)str elseBack:(id)back
{
    if([LLUtils strNilOrEmpty:str]){
        return back;
    }
    else if([str isKindOfClass:[NSString class]]){
        return str;
    }
    else if([str isKindOfClass:[NSNumber class]]){
        return [str stringValue];
    }
    return str;
}

/**
将图片缩小到指定尺寸
 image  : 原图片
 size   : 缩小到的尺寸
 return : 缩小的图片
 */
+ (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate tag:(NSInteger)tag type:(AlertViewType)type
{
    UIAlertView *alertView = nil;
    if (type == AlertViewTypeOnlyYes || type == AlertViewTypeOnlyConfirm) {
        alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:type == AlertViewTypeOnlyYes ? @"是" : @"确定" otherButtonTitles:nil, nil];
    }
    else
    {
        alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:type==AlertViewTypeYesAndNo?@"是":@"确定" otherButtonTitles:type==AlertViewTypeYesAndNo?@"否":@"取消", nil];
    }
    alertView.tag = tag;
    [alertView show];
}

+ (void)callPhoneWithPhone:(NSString *)phoneStr
{
    if (isEmptyStr(phoneStr)) {
        return;
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneStr]]];
}

+ (NSString *)jsonStrWithJSONObject:(id)jsonObj
{
    if (!jsonObj || ![NSJSONSerialization isValidJSONObject:jsonObj]) {
        return @"";
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObj options:0 error:&error];
    if (error || !jsonData) {
        return @"";
    }
    else
    {
        
        NSString * policyStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        policyStr = [policyStr stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
        return  policyStr;
        
//       return  [NSString stringWithUTF8String:[jsonData bytes]];
        
//        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

+ (id)jsonObjectWithJSONStr:(NSString *)jsonStr
{
    if (!jsonStr) {
        return @{};
    }
    NSError *error = nil;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    if (!error && jsonObj) {
        return jsonObj;
    }
    else
    {
        return @{};
    }
}

+ (NSString *)replaceUnicode:(NSString *)unicodeStr
{
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    // NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"%u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [ NSPropertyListSerialization  propertyListFromData:tempData
                                                             mutabilityOption:NSPropertyListImmutable
                                                                       format:NULL
                                                             errorDescription:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

//回弹动画
//实现view由小放大再缩小，回弹效果的动画
//view : 要做动画的view
+ (void)showSpringBackAnimationView:(UIView *)view
{
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:popAnimation forKey:nil];
}

//消失动画
//alphaView   : alphaView 要做透明度变化到完全透明的View
//scaleView   : 要做缩放动画的View
//dismissBlock: alphaView从父视图移除时的回调block
+ (void)showDismissAnimationWithAlphaView:(UIView *)alphaView scaleView:(UIView *)scaleView didDismissBlock:(void(^)())dismissBlock
{
    [UIView animateWithDuration:0.2f animations:^{
        alphaView.alpha = 0;
        scaleView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    } completion:^(BOOL finished) {
        [alphaView removeFromSuperview];
        if (dismissBlock) {
            dismissBlock();
        }
    }];
}

//将时间戳转换成NSDate
//timeStamp  : 时间戳 NSString / NSNumber
//return     : 返回对应的日期 NSDate
+ (NSDate *)dateWithTimeStamp:(id)timeStamp
{
    if (isNull(timeStamp)) {
        return [NSDate date];
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];
    if (isNull(date)) {
        return [NSDate date];
    }
    else
    {
        return date;
    }
}

//将时间戳转换成NSString
//timeStamp  : 时间戳 NSString / NSNumber
//dateFormat : 返回的时期格式 eg. @"yyyy-MM-dd"
//return     : 返回对应的日期字符串 NSString
+ (NSString *)dateStrWithTimeStamp:(id)timeStamp dateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    dateFormater.dateFormat = isNull(dateFormat)?@"yyyy-MM-dd":dateFormat;
    if (isNull(timeStamp)) {
        return [dateFormater stringFromDate:[NSDate date]];
    }
    NSString *timeStampStr = [NSString stringWithFormat:@"%@",timeStamp];
    if (timeStampStr.length>10) {
        timeStampStr = [timeStampStr substringToIndex:10];
    }
    NSDate *date = [self dateWithTimeStamp:timeStampStr];
    NSString *dateStr = [dateFormater stringFromDate:date];
    if (isNull(dateStr)) {
        return [dateFormater stringFromDate:[NSDate date]];
    }
    else
    {
        return dateStr;
    }
}

//将日期转换成 制定格式的日期字符串
//date       : 待转换日期 NSDate
//dateFormat : 返回的时期格式 eg. @"yyyy-MM-dd"
//return     : 返回对应的日期字符串 NSString
+ (NSString *)dateStrWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    dateFormater.dateFormat = isNull(dateFormat)?@"yyyy-MM-dd":dateFormat;
    if (isNull(date)) {
        return [dateFormater stringFromDate:[NSDate date]];
    }
    NSString *dateStr = [dateFormater stringFromDate:date];
    if (isNull(dateStr)) {
        return [dateFormater stringFromDate:[NSDate date]];
    }
    else
    {
        return dateStr;
    }
}

//将日期字符串 按照相应的格式 转换成对应的 日期
//dateStr    : 待转换日期字符串 NSString
//dateFormat : 返回的时期格式 eg. @"yyyy-MM-dd"  注意：dateFormat参数传入的字符串格式必须和传入的dateStr的格式一致，否则会崩溃!
//return     : 返回对应的日期 NSDate
+ (NSDate *)dateWithDateStr:(NSString *)dateStr dateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    dateFormater.dateFormat = isNull(dateFormat)?@"yyyy-MM-dd":dateFormat;
    if (isNull(dateStr)) {
        return [NSDate date];
    }
    NSDate *date = [dateFormater dateFromString:dateStr];
    if (isNull(date)) {
        return [NSDate date];
    }
    else
    {
        return date;
    }
}

//获取对应日期的时间戳
//date   : NSDate
//return : 时间戳
+ (long long)timestampsWithDate:(NSDate *)date
{
    if (isNull(date)) {
        return [[NSDate date] timeIntervalSince1970];
    }
    long long timestamps = [date timeIntervalSince1970];
    if (timestamps<0) {
        return [[NSDate date] timeIntervalSince1970];
    }
    else
    {
        return timestamps;
    }
}

//获取对应日期字符串的时间戳
//dateStr   : NSString
//format    :格式化的字符串
//return    : 时间戳
+ (long long)timestampsWithDateStr:(NSString *)dateStr dateFormat:(NSString *)format
{
    if (isNull(dateStr)) {
        return [[NSDate date] timeIntervalSince1970];
    }
    NSDate *date = [self dateWithDateStr:dateStr dateFormat:format];
    long long timestamps = [self timestampsWithDate:date];
    return timestamps;
}

#pragma mark - HUD

+ (void)showOnlyProgressHud
{
    [SVProgressHUD show];
}

+ (void)showTextAndProgressHud:(NSString *)status
{
    [SVProgressHUD showWithStatus:status];
}

+ (void)showTextAndProgressHud:(NSString *)status afterDelay:(NSTimeInterval)delay
{
    [SVProgressHUD showWithStatus:status];
    [SVProgressHUD dismissWithDelay:delay];
}

+ (void)showOnlyTextHub:(NSString *)text
{
    
}

+ (void)showSuccessHudWithStatus:(NSString *)statusStr
{
    if (isNull(statusStr)) {
        return;
    }
    [self setSVProgressHideTime];
    [SVProgressHUD showSuccessWithStatus:statusStr];
}

+ (void)showErrorHudWithStatus:(NSString *)statusStr
{
    if (isNull(statusStr)) {
        return;
    }
    [self setSVProgressHideTime];
    [SVProgressHUD showErrorWithStatus:statusStr];
}

+ (void)showInfoHudWithStatus:(NSString *)statusStr
{
    if (isNull(statusStr)) {
        return;
    }
    [self setSVProgressHideTime];
    [SVProgressHUD showWithStatus:statusStr];
//    [SVProgressHUD showInfoWithStatus:statusStr];
}

+ (void)setSVProgressHideTime
{
//    [SVProgressHUD setMinimumDismissTimeInterval:hudDismissTime];
}

+ (void)dismiss
{
    [SVProgressHUD dismiss];
}

+(BOOL)validateMobile:(NSString *)mobileNum
{
    NSString *pattern = @"1[3|5|7|8|][0-9]{9}";;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:mobileNum];
    return isMatch;
}

+(BOOL)validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

/**
 *
 *  判断用户输入的密码是否符合规范，符合规范的密码要求：
 1. 长度大于等于maxLength 小于maxLenght
 2. 密码中必须同时包含数字和字母
 */
+(BOOL)validatePassword:(NSString *)pass minLength:(int)minLength maxLength:(int)maxLength{
    BOOL result = false;
    if ([pass length] >= minLength && [pass length] <= maxLength){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = [NSString stringWithFormat:@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{%d,%d}$",minLength,maxLength];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}

//UIImage ===> NSData
+ (NSData *)dataWithImage:(UIImage *)image
{
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        
        data = UIImageJPEGRepresentation(image, 1);
        
    } else {
        
        data = UIImagePNGRepresentation(image);
    }
    return data;
}

+ (NSString *)previousMonthWithProviceMonthIndex:(NSInteger)monthIndex dateFormat:(NSString *)format
{
    NSCalendar *calender = [NSCalendar currentCalendar];//获取NSCalender单例。
    NSDateComponents *cmp = [calender components:(NSMonthCalendarUnit | NSYearCalendarUnit
                                                  |NSDayCalendarUnit | NSHourCalendarUnit
                                                  |NSMinuteCalendarUnit
                                                  |NSSecondCalendarUnit) fromDate:[[NSDate alloc] init]];// 设置属性，因为我只需要年和月，这个属性还可以支持时，分，秒。
    [cmp setMonth:[cmp month] - monthIndex];//设置上个月，即在现有的基础上减去一个月。这个地方可以灵活的支持跨年了，免去了繁琐的计算年份的工作。
    NSDate *lastMonDate = [calender dateFromComponents:cmp];//拿到上个月的NSDate，再用
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    NSString *dateStr = [formatter stringFromDate:lastMonDate];
    return dateStr;
}

+ (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}

//将日期的时分秒置为0
+ (NSDate *)setHourMinSecToZero:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                    |NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:date];
    
    components.hour = components.minute = components.second = 0;
    
    return [calendar dateFromComponents:components];
}

//过滤手机号的86,+86,+86·
+ (NSString *)filterPhoneNum86:(NSString *)phone
{
    if ([phone hasPrefix:@"86"]) {
        NSString *formatStr = [phone substringWithRange:NSMakeRange(2, [phone length]-2)];
        return formatStr;
    }
    else if ([phone hasPrefix:@"+86"])
    {
        if ([phone hasPrefix:@"+86·"]) {
            NSString *formatStr = [phone substringWithRange:NSMakeRange(4, [phone length]-4)];
            return formatStr;
        }
        else
        {
            NSString *formatStr = [phone substringWithRange:NSMakeRange(3, [phone length]-3)];
            return formatStr;
        }
    }
    return phone;
}

//获取url字符串中某一参数值对应的参数值
//paraName : 要扣取的参数名
//url      : url字符串
//return   : 返回对应参数名的参数值
+ (NSString *)getParaValueWithParaName:(NSString *)paraName url:(NSString *)url
{
    NSArray *urlSepArr = [url componentsSeparatedByString:@"?"];
    if (isEmptyStr(paraName) || isEmptyStr(url) || urlSepArr.count != 2) {
        return @"";
    }
    NSString *paraListStr = [urlSepArr lastObject];
    NSArray *paraSepArr = [paraListStr componentsSeparatedByString:@"&"];
    for (NSString *paraStr in paraSepArr) {
        if ([paraStr containsString:paraName]) {
            NSArray *getArr = [paraStr componentsSeparatedByString:@"="];
            if (getArr.count==0) {
                return @"";
            }
            else if (getArr.count==1)
            {
                return @"";
            }
            else
            {
                return [getArr lastObject];
            }
        }
    }
    return @"";
}

/**
 获取url的所有参数
 url : 要获取参数的url字符串
 return : 获得的参数字典
 */
+ (NSDictionary *)getUrlParametersWithUrl:(NSString *)url{
    NSArray *urlSepArr = [url componentsSeparatedByString:@"?"];
    if (urlSepArr.count != 2) {
        return @{};
    }
    NSString *paraListStr = [urlSepArr lastObject];
    NSArray *paraSepArr = [paraListStr componentsSeparatedByString:@"&"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (NSString *paraStr in paraSepArr) {
        NSArray *getArr = [paraStr componentsSeparatedByString:@"="];
        if (getArr.count != 2) {
            continue;
        } else {
            [dic setValue:[getArr lastObject] forKey:[getArr firstObject]];
        }
    }
    return dic;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{

    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [[LLUtils new] getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}


/**
 url编码
 */
+ (NSString *)encodeUrlWithUrlStr:(NSString *)urlStr{
   return  [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLUserAllowedCharacterSet]];
}

/**
 url解码
 */
+ (NSString *)decodeUrl:(NSString *)str{
  return [str stringByRemovingPercentEncoding];
}

/**
     url编码
     encodeURL方法不会对下列字符编码 ASCII字母 数字 ~!@#$&*()=:/,;?+'
     encodeURIComponent方法不会对下列字符编码 ASCII字母 数字 ~!*()'
     所以encodeURIComponent比encodeURI编码的范围更大。
     实际例子来说，encodeURIComponent会把 http:// 编码成 http%3A%2F%2F 而encodeURL却不会。
 */
+ (NSString *)encodeURIComponent:(NSString *)paraStr{
   return (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)paraStr,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?#[]",
                                                              kCFStringEncodingUTF8));
}

/**
 旋转按钮的剪头
 */
+ (void)rotateBtnArrow:(UIButton *)btn{
    UIImageView *imgView = btn.imageView;
    if (imgView) {
        [UIView animateWithDuration:0.5 animations:^{
            imgView.transform = btn.selected?CGAffineTransformMakeRotation(M_PI):CGAffineTransformRotate(imgView.transform, -M_PI_2);
            if (!btn.selected) {
                imgView.transform = CGAffineTransformRotate(imgView.transform, -M_PI_2);
            }
        }];
    }
}

/**
 显示回弹动画，比如从下划到屏幕内再回弹一点
 */
+ (void)showSpring:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion{
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:5.0f options:UIViewAnimationOptionCurveEaseInOut animations:animations completion:completion];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/*
 过滤字符串中的html标签 方案一
 */
+ (NSString *)filterHTMLOne:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    //过滤&nbsp
    NSArray *sepArr = [html componentsSeparatedByString:@"&nbsp;"];
    html = [sepArr componentsJoinedByString:@" "];
    return html;
}
/*
 过滤字符串中的html标签 方案二
 */
+(NSString *)filterHTMLSecond:(NSString *)html{
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n"
                                                                                    options:0
                                                                                      error:nil];
    html=[regularExpretion stringByReplacingMatchesInString:html options:NSMatchingReportProgress range:NSMakeRange(0, html.length) withTemplate:@""];
    return html;
}


/**
 根据日期获得星期几
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate{
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

/**
 用某个字符串分割字符串
 originStr  : 原字符串
 decollator : 分割符
 length     : 分割长度
 */
+ (nullable NSString *)separateStr:(nonnull NSString *)originStr decollator:(nonnull NSString *)decollator separateLength:(int)separateLength{
    NSUInteger lenght = originStr.length;
    NSUInteger num = lenght/separateLength+(lenght%separateLength!=0);
    NSMutableString *appendStr = [NSMutableString string];
    for (int i = 0; i < num; i++) {
        [appendStr appendString:[originStr substringWithRange:NSMakeRange(i*separateLength, i==num-1?(lenght%separateLength?:separateLength):separateLength)]];
        if (i!=num-1) {
            [appendStr appendString:decollator];
        }
    }
    return appendStr;
}

/**
 手机号安全处理，加*处理
 */
+ (nullable NSString *)phoneSecureHandle:(nonnull NSString *)phone{
    if (phone.length<11) {
        return phone;
    }
    NSString *securePhone = [NSString stringWithFormat:@"%@****%@",[phone substringToIndex:3],[phone substringFromIndex:phone.length-4]];
    return securePhone;
}

+ (void)showAlterView:(UIViewController *)controller title:(NSString *)title message:(NSString *)message yesBtnTitle:(NSString *)yesTitle noBtnTitle:(NSString *)noTitle  yesBlock:(void (^)(void))yesAction  noBlock:(void (^)(void))noAction{
    

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:1];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:noTitle style:1 handler:^(UIAlertAction * _Nonnull action) {
        if (noAction == nil) {
            
        }else{
             noAction();
        }
    }];
    
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:yesTitle style:0 handler:^(UIAlertAction * _Nonnull action) {
        
        if (yesAction  == nil) {
            
        }else{
             yesAction();
        }
       
    }];
    
    
    [alertController addAction:actionCancel];
    [alertController addAction:actionOk];
    [controller presentViewController:alertController animated:YES completion:nil];
    
}

+ (UIColor *)colorWithHex:(NSString *)color alpha:(CGFloat)alpha{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

+ (UIColor *)colorWithHex:(NSString *)color{
    return [LLUtils colorWithHex:color alpha:1.f];
}



/**
 旋转imgView的剪头
 */
+ (void)rotateImgViewArrow:(UIImageView *)imgView isSelected:(BOOL)isSelected{
    if (imgView) {
        [UIView animateWithDuration:0.5 animations:^{
            imgView.transform = isSelected? CGAffineTransformRotate(imgView.transform, M_PI) : CGAffineTransformRotate(imgView.transform, -M_PI_2);
            if (!isSelected) {
                imgView.transform = CGAffineTransformRotate(imgView.transform, -M_PI_2);
            }
        }];
    }
}

+ (CGSize )getStringSize:(NSString *)string font:(CGFloat )font width:(CGFloat)width
{
    CGSize titleSize = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    
    return titleSize;
}

//iOS中显示获取缓存的大小多少M，点击清除缓存方法 (2016-03-03 12:12:01)转载▼
// 显示缓存大小
+( float )filePath
{
    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    LLUtils *utils =[[LLUtils alloc]init];
    
    return [utils folderSizeAtPath :cachPath];
    
}
//1:首先我们计算一下 单个文件的大小

- ( long long ) fileSizeAtPath:( NSString *) filePath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    
    return 0 ;
    
}
//2:遍历文件夹获得文件夹大小，返回多少 M（提示：你可以在工程界设置（)m）

- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    
    NSString * fileName;
    
    long long folderSize = 0 ;
    
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
        
    }
    
    return folderSize/( 1024.0 * 1024.0 );
    
}




// 清理缓存

+ (void)clearFileBlock:(void (^)(void))success{
    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    
//    NSLog ( @"cachpath = %@" , cachPath);
    
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
            
        }
        
    }
    
    success();
    
    
//    [ self performSelectorOnMainThread : @selector (clearCachSuccess) withObject : nil waitUntilDone : YES ];
    
}
-(void)clearCachSuccess
{
    NSLog ( @" 清理成功 " );
    
//    NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:0];//刷新
//    [_aTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
}

//调整lable行间距
+ (NSAttributedString *)setLineSpacing:(CGFloat)spacing string:(NSString *)text
{
    if (text.length < 1) {
        text =  @"";
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    return attributedString;
}


//获取自定义行间距文字lable高度
+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(CGFloat)fontSize  lineSpacing:(CGFloat )lineSpace withWidth:(CGFloat)width {
    
    NSString *string;
    
    if (str.length!= 0) {
        string = str;
    }else{
        string = @"";
    }
    
    //先通过NSMutableAttributedString设置和上面tttLabel一样的属性,例如行间距,字体
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    //自定义str和TTTAttributedLabel一样的行间距
    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrapStyle setLineSpacing:lineSpace];
    //设置行间距
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragrapStyle range:NSMakeRange(0, string.length)];
    //设置字体
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, string.length)];
    
    //得到自定义行间距的UILabel的高度
    CGFloat height = [TTTAttributedLabel sizeThatFitsAttributedString:attrString withConstraints:CGSizeMake(width, MAXFLOAT) limitedToNumberOfLines:0].height;
    
    //    //重新改变tttLabel的frame高度
    //    CGRect rect = tttLabel.frame;
    //    rect.size.height = height;
    //    tttLabel.frame = rect;
    
    return height;
}

//二维码的生成
+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)Imagesize logoImageSize:(CGFloat)waterImagesize{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];//通过kvo方式给一个字符串，生成二维码
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];//设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
    CIImage *outPutImage = [filter outputImage];//拿到二维码图片
    return [[self alloc] createNonInterpolatedUIImageFormCIImage:outPutImage withSize:Imagesize waterImageSize:waterImagesize];
}
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size waterImageSize:(CGFloat)waterImagesize{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    //创建一个DeviceGray颜色空间
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    //CGBitmapContextCreate(void * _Nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef  _Nullable space, uint32_t bitmapInfo)
    //width：图片宽度像素
    //height：图片高度像素
    //bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
    //bitmapInfo：指定的位图应该包含一个alpha通道。
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    //创建CoreGraphics image
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
    
    //原图
    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
    //给二维码加 logo 图
    UIGraphicsBeginImageContextWithOptions(outputImage.size, NO, [[UIScreen mainScreen] scale]);
    [outputImage drawInRect:CGRectMake(0,0 , size, size)];
    //logo图
    UIImage *waterimage = [UIImage imageNamed:@"icon_imgApp"];
    //把logo图画到生成的二维码图片上，注意尺寸不要太大（最大不超过二维码图片的%30），太大会造成扫不出来
    [waterimage drawInRect:CGRectMake((size-waterImagesize)/2.0, (size-waterImagesize)/2.0, waterImagesize, waterImagesize)];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;
}

//修改二维码的颜色,这一段是在网上找的，把生成的二维码图片传入，再传入想要的颜色即可
+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage); // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) // 将白色变成透明
        {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        } else {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, nil);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace, kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider, NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef]; // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}


//输出任意颜色大小的图片
+ (UIImage *)buttonImageFromColor:(UIColor *)color WithSize:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


+ (NSString *)getOrderStatusWithStatus:(NSInteger)status{
    
    NSString *statusString = @"";
    
    switch (status) {
        case 0:
            statusString = @"已取消";
            break;
        case 10:
            statusString = @"待支付";
            break;
        case 20:
            statusString = @"待发货";
            break;
        case 30:
            statusString = @"待收货";
            break;
        case 40:
            statusString = @"已收货";
            break;
        case 45:
            statusString = @"申请退货中";
            break;
        case 46:
            statusString = @"退货中";
            break;
        case 47:
            statusString = @"退货完成,已结束";
            break;
        case 48:
            statusString = @"卖家拒绝退货申请";
            break;
        case 49:
            statusString = @"退货失败";
            break;
        case 50:
            statusString = @"已完成,已评价";
            break;
        case 60:
            statusString = @"已结束";
            break;
        case 65:
            statusString = @"已结束,不可评价";
            break;
            
        default:
            break;
    }
    return statusString;
}


+(NSArray *)getOrderBottomStatusWithOrderStatus:(NSInteger)status{

    NSArray *array = @[];

    switch (status) {//@"已取消";
        case 0:
            array = @[@"删除订单"];
            break;
        case 10:     //@"待支付";
            array = @[@"取消订单",@"付款"];
            break;
        case 20:    //@"待发货";
            array = @[@"提醒发货"];
            break;
        case 30:    //@"待收货";
            array = @[@"查看物流",@"确认收货"];
            break;
        case 40:    // @"已收货";
            array = @[@"查看物流,删除订单"];
            break;
        case 45:    //@"申请退货中";
            array = @[@"查看物流",@"取消退货"];
            break;
        case 46:    //@"退货中";
           array = @[@"查看物流",@"取消退货"];
            break;
        case 47:    //@"退货完成,已结束";
            array = @[];
            break;
        case 48:    //@"卖家拒绝退货申请";
            array = @[@"查看物流",@"再次退货"];
            break;
        case 49:    //@"退货失败";
            array = @[@"删除订单",@"去评价"];
            break;
        case 50:    //@"已完成,已评价";
            array = @[@"删除订单"];
            break;
        case 60:    //@"已结束";
            array = @[@"删除订单"];
            break;
        case 65:    //@"已结束,不可评价";
            array = @[@"删除订单"];
            break;
            
        default:
            break;
    }
    return array;
}



+(NSArray *)getOrderDetailTopStatusWithOrderStatus:(NSInteger)status{
    
    NSArray *array = @[];
    
    switch (status) {//@"已取消";
        case 0:
            array = @[@"删除订单"];
            break;
        case 10:     //@"待支付";
            array = @[@"取消订单",@"付款"];
            break;
        case 20:    //@"待发货";
            array = @[@"提醒发货"];
            break;
        case 30:    //@"待收货";
            array = @[@"查看物流",@"确认收货"];
            break;
        case 40:    // @"已收货";
            array = @[@"查看物流,删除订单"];
            break;
        case 45:    //@"申请退货中";
            array = @[@"查看物流",@"取消退货"];
            break;
        case 46:    //@"退货中";
            array = @[@"查看物流",@"取消退货"];
            break;
        case 47:    //@"退货完成,已结束";
            array = @[];
            break;
        case 48:    //@"卖家拒绝退货申请";
            array = @[@"查看物流",@"再次退货"];
            break;
        case 49:    //@"退货失败";
            array = @[@"删除订单",@"去评价"];
            break;
        case 50:    //@"已完成,已评价";
            array = @[@"删除订单"];
            break;
        case 60:    //@"已结束";
            array = @[@"删除订单"];
            break;
        case 65:    //@"已结束,不可评价";
            array = @[@"删除订单"];
            break;
            
        default:
            break;
    }
    return array;
}


+(NSArray *)getOrderDetailTopTitlesWithOrderStatus:(NSInteger)status{
    
    NSArray *array = @[];
    
    switch (status) {//@"已取消";
        case 0:
            array = @[@"删除订单"];
            break;
        case 10:     //@"待支付";
            array = @[@"取消订单",@"付款"];
            break;
        case 20:    //@"待发货";
            array = @[@"提醒发货"];
            break;
        case 30:    //@"待收货";
            array = @[@"查看物流",@"确认收货"];
            break;
        case 40:    // @"已收货";
            array = @[@"查看物流,删除订单"];
            break;
        case 45:    //@"申请退货中";
            array = @[@"查看物流",@"取消退货"];
            break;
        case 46:    //@"退货中";
            array = @[@"查看物流",@"取消退货"];
            break;
        case 47:    //@"退货完成,已结束";
            array = @[];
            break;
        case 48:    //@"卖家拒绝退货申请";
            array = @[@"查看物流",@"再次退货"];
            break;
        case 49:    //@"退货失败";
            array = @[@"删除订单",@"去评价"];
            break;
        case 50:    //@"已完成,已评价";
            array = @[@"删除订单"];
            break;
        case 60:    //@"已结束";
            array = @[@"删除订单"];
            break;
        case 65:    //@"已结束,不可评价";
            array = @[@"删除订单"];
            break;
            
        default:
            break;
    }
    return array;
}
@end
