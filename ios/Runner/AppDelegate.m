#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include "EventHandler.h"

@implementation AppDelegate
{
    FlutterEventChannel* channel;
}

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];

    // Prepare channel
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    self->channel = [FlutterEventChannel eventChannelWithName:@"events" binaryMessenger:controller];

    [self->channel setStreamHandler:[EventHandler new]];

    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
