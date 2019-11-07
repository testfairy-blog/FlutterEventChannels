//
//  EventHandler.h
//  Runner
//
//  Created by Diego Perini on 7.11.2019.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//
#import <Flutter/Flutter.h>
#import <Foundation/Foundation.h>

#ifndef EventHandler_h
#define EventHandler_h

@interface EventHandler : NSObject<FlutterStreamHandler>

- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events;
- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments;

@end

#endif /* EventHandler_h */
