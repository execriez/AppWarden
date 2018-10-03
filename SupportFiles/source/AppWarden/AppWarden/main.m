//
//  main.m
//  AppWarden
//  Version 1.0.10
//
//  Created on 31/03/2009.
//  Updated on 28/09/2018
//  Copyright (c) 2017 Mark J Swift. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/NSWorkspace.h>




@interface ApplicationNotification : NSObject;

- (void)appWillLaunch:(NSNotification *)note;
- (void)appDidLaunch:(NSNotification *)note;
- (void)appDidTerminate:(NSNotification *)note;

@end




@implementation ApplicationNotification

-(NSString *) dateInFormat:(NSString*) stringFormat {
    char buffer[80];
    const char *format = [stringFormat UTF8String];
    time_t rawtime;
    struct tm * timeinfo;
    time(&rawtime);
    timeinfo = localtime(&rawtime);
    strftime(buffer, 80, format, timeinfo);
    return [NSString  stringWithCString:buffer encoding:NSUTF8StringEncoding];
}

- (void)appWillLaunch:(NSNotification *)note
{
    NSLog(@"Will launch: '%@'", [[note userInfo] objectForKey:@"NSApplicationName"]);
    
    NSString *cmd = [NSString stringWithFormat:@"'%@'-WillLaunch \"WillLaunch:%@:%@:%@:%@:%@\"",[[NSBundle bundleForClass:[self class]] executablePath], [self dateInFormat:@"%s"], [[note userInfo] objectForKey:@"NSApplicationBundleIdentifier"], [[note userInfo] objectForKey:@"NSApplicationName"], [[note userInfo] objectForKey:@"NSApplicationPath"], [[note userInfo] objectForKey:@"NSApplicationProcessIdentifier"] ];
    [self executeCMD:cmd];
    
}

- (void)appDidLaunch:(NSNotification *)note
{
    NSLog(@"Did launch: '%@'", [[note userInfo] objectForKey:@"NSApplicationName"]);
    
    NSString *cmd = [NSString stringWithFormat:@"'%@'-DidLaunch \"DidLaunch:%@:%@:%@:%@:%@\"",[[NSBundle bundleForClass:[self class]] executablePath], [self dateInFormat:@"%s"], [[note userInfo] objectForKey:@"NSApplicationBundleIdentifier"], [[note userInfo] objectForKey:@"NSApplicationName"], [[note userInfo] objectForKey:@"NSApplicationPath"], [[note userInfo] objectForKey:@"NSApplicationProcessIdentifier"] ];
    [self executeCMD:cmd];
}

- (void)appDidTerminate:(NSNotification *)note
{
    NSLog(@"Did terminate: '%@'", [[note userInfo] objectForKey:@"NSApplicationName"]);
    
    NSString *cmd = [NSString stringWithFormat:@"'%@'-DidTerminate \"DidTerminate:%@:%@:%@:%@:%@\"",[[NSBundle bundleForClass:[self class]] executablePath], [self dateInFormat:@"%s"], [[note userInfo] objectForKey:@"NSApplicationBundleIdentifier"], [[note userInfo] objectForKey:@"NSApplicationName"], [[note userInfo] objectForKey:@"NSApplicationPath"], [[note userInfo] objectForKey:@"NSApplicationProcessIdentifier"] ];
    [self executeCMD:cmd];
}

// execute a shell command, but don't wait around for it to finish
- (NSData *) executeCMD:(NSString *)cmd
{
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/bash"];
    
    NSArray *arguments = [NSArray arrayWithObjects: @"-c", cmd, nil];
    [task setArguments: arguments];
    
    //    NSPipe *pipe = [[NSPipe alloc] init];
    //    [task setStandardOutput: pipe];
    
    //    NSFileHandle *file  = [pipe fileHandleForReading];
    
    [task launch];
    
    NSData *data = NULL;
    //    NSData *data = [file readDataToEndOfFile];
    
    return data;
}

@end



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSNotificationCenter *  center;
        center = [[NSWorkspace sharedWorkspace] notificationCenter];
        
        NSObject * ano = [ApplicationNotification alloc];
        
        [center addObserver:ano
                   selector:@selector(appWillLaunch:)
                       name:NSWorkspaceWillLaunchApplicationNotification
                     object:nil
         ];
        [center addObserver:ano
                   selector:@selector(appDidLaunch:)
                       name:NSWorkspaceDidLaunchApplicationNotification
                     object:nil
         ];
        [center addObserver:ano
                   selector:@selector(appDidTerminate:)
                       name:NSWorkspaceDidTerminateApplicationNotification
                     object:nil
         ];
        
        [[NSRunLoop currentRunLoop] run];
    }
    return 0;
}
