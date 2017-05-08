//
//  ReachabilityManager.m
//  Reachability
//
//  Created by 許仲恩 on 11/8/8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ReachabilityManager.h"

@interface ReachabilityManager (private)
- (void) updateInterfaceWithReachability: (Reachability*) curReach;
- (void) reachabilityChanged: (NSNotification* )note;
- (void) configureConnectTag:(Reachability *) curReach;
@end

@implementation ReachabilityManager
@synthesize delegate;
@synthesize isConnectHost;
@synthesize isConnectInternet;
@synthesize isConnectWiFi;
@synthesize hostReach;
@synthesize internetReach;
@synthesize wifiReach;


- (id)init
{
    self = [super init];
    if (self) {
		[self setHostReach:[Reachability reachabilityWithHostName: @"www.apple.com"]];
		[self setInternetReach:[Reachability reachabilityForInternetConnection]];
		[self setWifiReach:[Reachability reachabilityForLocalWiFi]];
    }
    return self;
}

- (id) initWithHostName:(NSString *) hostName{
	self = [super init];
    if (self) {
		[self setHostReach:[Reachability reachabilityWithHostName:hostName]];
		[self setInternetReach:[Reachability reachabilityForInternetConnection]];
		[self setWifiReach:[Reachability reachabilityForLocalWiFi]];
    }
    return self;
}
 
 - (void) startManager{
	 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];

	 [self.hostReach startNotifier];
	 [self updateInterfaceWithReachability:self.hostReach];
	 
	 [self.internetReach startNotifier];
	 [self updateInterfaceWithReachability:self.internetReach];

	 [self.wifiReach startNotifier];
	 [self updateInterfaceWithReachability:self.wifiReach];
}

- (void) stopManager{
	[self.hostReach stopNotifier];
	[self.internetReach stopNotifier];
	[self.wifiReach stopNotifier];
}

- (void) configureConnectTag:(Reachability *) curReach
{
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    switch (netStatus)
    {
        case NotReachable:
        {
			if (curReach == self.wifiReach) [self setIsConnectHost:NO];
			else if (curReach == self.hostReach) [self setIsConnectWiFi:NO];
			else if (curReach == self.internetReach) [self setIsConnectInternet:NO];
			
            break;
        }
        case ReachableViaWWAN:
        {
			if (curReach == self.wifiReach) [self setIsConnectWiFi:YES];
			else if (curReach == self.hostReach) [self setIsConnectHost:YES];
			else if (curReach == self.internetReach) [self setIsConnectInternet:YES];
			
            break;
        }
        case ReachableViaWiFi:
        {
			if (curReach == self.wifiReach) [self setIsConnectWiFi:YES];
			else if (curReach == self.hostReach) [self setIsConnectHost:YES];
			else if (curReach == self.internetReach) [self setIsConnectInternet:YES];
			
            break;
		}
    }
}

- (void) updateInterfaceWithReachability: (Reachability*) curReach
{
	[self configureConnectTag:curReach];	
}

- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	[self updateInterfaceWithReachability: curReach];
    
    if ([delegate respondsToSelector:@selector(reachabilityChangeWithHost:)]) [delegate reachabilityChangeWithHost:self.isConnectHost];
	if ([delegate respondsToSelector:@selector(reachabilityChangeWithInternet:)]) [delegate reachabilityChangeWithInternet:self.isConnectInternet];
	if ([delegate respondsToSelector:@selector(reachabilityChangeWithWiFi:)]) [delegate reachabilityChangeWithWiFi:self.isConnectWiFi];
}

- (void) dealloc{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[self stopManager];
	
	self.delegate = nil;
}

@end
