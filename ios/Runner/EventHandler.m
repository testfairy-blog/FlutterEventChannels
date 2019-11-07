//
//  EventHandler.m
//  Runner
//
//  Created by Diego Perini on 7.11.2019.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#include "EventHandler.h"

@implementation EventHandler
{
    // Listeners
    NSMutableDictionary* listeners;
}

- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events {
    [self startListening:arguments emitter:events];
    return nil;
}


- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    [self cancelListening:arguments];
    return nil;
}

- (void) startListening:(id)listener emitter:(FlutterEventSink)emitter {
    // Prepare callback dictionary
    if (self->listeners == nil) self->listeners = [NSMutableDictionary new];
    
    // Get callback id
    NSString* currentListenerId =
        [[NSNumber numberWithUnsignedInteger:[((NSObject*) listener) hash]] stringValue];
    
    // Prepare a timer like self calling task
    void (^callback)(void) = ^() {
        void (^callback)(void) = [self->listeners valueForKey:currentListenerId];
        if ([self->listeners valueForKey:currentListenerId] != nil) {
            int time = (int) CFAbsoluteTimeGetCurrent();
            
            emitter([NSString stringWithFormat:@"Hello Listener! %d", time]);
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), callback);
        }
    };
    
    // Run task
    [self->listeners setObject:callback forKey:currentListenerId];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), callback);
}

- (void) cancelListening:(id)listener {
    // Get callback id
    NSString* currentListenerId =
        [[NSNumber numberWithUnsignedInteger:[((NSObject*) listener) hash]] stringValue];
    
    // Remove callback
    [self->listeners removeObjectForKey:currentListenerId];
}
@end
