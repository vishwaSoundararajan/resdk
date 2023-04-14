#import "ResdkPlugin.h"
#if __has_include(<resdk/resdk-Swift.h>)
#import <resdk/resdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "resdk-Swift.h"
#endif

@implementation ResdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftResdkPlugin registerWithRegistrar:registrar];
}
@end
