/* Base64.h created by josh on Mon 9-Mar-2012 */


#import <Foundation/Foundation.h>

@interface Base64 : NSObject {

}

+(void)initialize;

+(NSString*)encode:(const unsigned char*)input length:(long)length;
+(NSString*)encode:(NSData*) rawBytes;

+(NSData*)decode:(const char*)string length:(long)inputLength;
+(NSData*)decode:(NSString*)string;

@end