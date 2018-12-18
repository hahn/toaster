#import "ToasterPlugin.h"
#import <toaster/toaster-Swift.h>

@implementation ToasterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftToasterPlugin registerWithRegistrar:registrar];
}
@end
