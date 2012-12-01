/* Base64.m created by josh on Mon 9-Mar-2012 */


#import "Base64.h"
#import "AboutPanel.h"

@implementation Base64

#define ArrayLength(x) (sizeof(x)/sizeof(*(x)))

static char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static char decodingTable[128];

+(void)initialize
{
long i;
        if (self == [Base64 class]) {
                memset(decodingTable, 0, ArrayLength(decodingTable));
                for (i = 0; i < ArrayLength(encodingTable); i++) {
                        decodingTable[encodingTable[i]] = i;
                }
        }
}

+(NSString*)encode:(const unsigned char*)input length:(long)length
{
long i;
long value;
long j;
long index;
unsigned char *output;

    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    output = (unsigned char*)[data mutableBytes];

    for (i = 0; i < length; i += 3) {
        value = 0;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;

            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }

        index = (i / 3) * 4;
        output[index + 0] =                    encodingTable[(value >> 18) & 0x3F];
        output[index + 1] =                    encodingTable[(value >> 12) & 0x3F];
        output[index + 2] = (i + 1) < length ? encodingTable[(value >> 6)  & 0x3F] : '=';
        output[index + 3] = (i + 2) < length ? encodingTable[(value >> 0)  & 0x3F] : '=';
    }

    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

+(NSString*)encode:(NSData*)rawBytes
{
    return [self encode:(const unsigned char*) [rawBytes bytes] length:[rawBytes length]];
}

+(NSData*)decode:(const char*)string length:(long)inputLength
{
	long outputLength = 0;
	unsigned char *output;
	long inputPoint = 0;
	long outputPoint = 0;
	NSMutableData * data = nil;

        /*

        if ((string == NULL) || (inputLength % 4 != 0)) {
                return nil;
        }
         */

        while (inputLength > 0 && string[inputLength - 1] == '=') {
                inputLength--;
        }

        outputLength = inputLength * 3 / 4;
        data = [NSMutableData dataWithLength:outputLength];
        output = [data mutableBytes];

        while (inputPoint < inputLength) {
                char i0 = string[inputPoint++];
                char i1 = string[inputPoint++];
                char i2 = inputPoint < inputLength ? string[inputPoint++] : 'A'; /* 'A' will decode to \0 */
                char i3 = inputPoint < inputLength ? string[inputPoint++] : 'A';

                output[outputPoint++] = (decodingTable[i0] << 2) | (decodingTable[i1] >> 4);
                if (outputPoint < outputLength) {
                        output[outputPoint++] = ((decodingTable[i1] & 0xf) << 4) | (decodingTable[i2] >> 2);
                }
                if (outputPoint < outputLength) {
                        output[outputPoint++] = ((decodingTable[i2] & 0x3) << 6) | decodingTable[i3];
                }
        }

        return data;
}

+(NSData*)decode:(NSString*)string
{
        return [self decode:[string cString] length:[string length]];
}

@end
