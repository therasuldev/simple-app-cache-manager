#import "SimpleAppCacheManagerPlugin.h"
#if __has_include(<simple_app_cache_manager/simple_app_cache_manager-Swift.h>)
#import <simple_app_cache_manager/simple_app_cache_manager-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "simple_app_cache_manager-Swift.h"
#endif

@implementation SimpleAppCacheManagerPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSimpleAppCacheManagerPlugin registerWithRegistrar:registrar];
}

@end