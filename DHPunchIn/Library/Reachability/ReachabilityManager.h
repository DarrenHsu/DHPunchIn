//
//  ReachabilityManager.h
//  Reachability
//
//  Created by 許仲恩 on 11/8/8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
/*!
 @header ReachabilityManager.h
 */

#import "Reachability.h"

@protocol ReachabilityManagerDelegate;

/*!
 @class ReachabilityManager
 @@abstract 此物件為網路連線class
 @discussion 在此物件中可以做到偵測到網路連線狀態，是透過那一種方式連線
 @namespace ReachabilityUtility
 @updated 2011-07-29
 */
@interface ReachabilityManager : NSObject{
@public
	/*! @property delegate callback的委派物件 */
	id<ReachabilityManagerDelegate> delegate;
	/*! @property isConnectHost 佈林值，回傳連線到ＨHost是否正常 */
	BOOL isConnectHost;
	/*! @property isConnectInternet 佈林值，回傳連線到Internat是否正常 */
	BOOL isConnectInternet;
	/*! @property isConnectWiFi 佈林值，回傳連線wifi是否正常 */
	BOOL isConnectWiFi;
	
@private
	Reachability* hostReach;
    Reachability* internetReach;
    Reachability* wifiReach;
}

@property (nonatomic, retain) id<ReachabilityManagerDelegate> delegate;
@property (nonatomic, assign) BOOL isConnectHost;
@property (nonatomic, assign) BOOL isConnectInternet;
@property (nonatomic, assign) BOOL isConnectWiFi;
@property (nonatomic, retain) Reachability* hostReach;
@property (nonatomic, retain) Reachability* internetReach;
@property (nonatomic, retain) Reachability* wifiReach;

/*!
 @method initWithHostName:
 @@abstract 初始化物件
 @discussion 呼叫初始化物件方法可以先傳入HostName。
 @param hostName host名字
 @result 回傳實例化物件
 */
- (id) initWithHostName:(NSString *) hostName;
/*!
 @method startManager
 @@abstract 開始進行連線偵測
 @discussion 呼叫初始化物件方法後，便會開始進行偵測連線狀態，並告知是什麼方式連線。
 */
- (void) startManager;
/*!
 @method stopManager
 @@abstract 停止進行連線偵測
 @discussion 呼叫停止進行偵測連線狀態。
 */
- (void) stopManager;

@end

/*!
 @protocol ReachabilityManagerDelegate 
 @@abstract 此protocol為連線狀態改變時呼叫
 @discussion 在此可以實作所提供的 Methods，並達到連線狀態改變時呼叫的動作。
 */
@protocol ReachabilityManagerDelegate <NSObject>
@optional
/*!
 @method reachabilityChangeWithHost:
 @@abstract CallBack方法
 @discussion 當連線到host狀態改變時，便會呼叫此方法並傳入狀態。
 @param isConnect 連線狀態
 */
- (void) reachabilityChangeWithHost:(BOOL) isConnect;
/*!
 @method reachabilityChangeWithInternet:
 @@abstract CallBack方法
 @discussion 當連線到internat狀態改變時，便會呼叫此方法並傳入狀態。
 @param isConnect 連線狀態
 */
- (void) reachabilityChangeWithInternet:(BOOL) isConnect;
/*!
 @method reachabilityChangeWithWiFi:
 @@abstract CallBack方法
 @discussion 當連線wifi狀態改變時，便會呼叫此方法並傳入狀態。
 @param isConnect 連線狀態
 */
- (void) reachabilityChangeWithWiFi:(BOOL) isConnect;
@end