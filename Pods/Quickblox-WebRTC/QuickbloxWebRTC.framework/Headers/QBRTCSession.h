//
//  QBRTCSession.h
//  QuickbloxWebRTC
//
//  Copyright (c) 2017 QuickBlox. All rights reserved.
//

#import "QBRTCBaseSession.h"

#import "QBRTCTypes.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  QBRTCSession class interface.
 *  This class is storing information about rtc session, tracks and opponents.
 *
 *  @see QBRTCBaseSession
 */
@interface QBRTCSession : QBRTCBaseSession

/**
 *  Unique session identifier.
 */
@property (strong, nonatomic, readonly) NSString *ID;

/**
 *  Session initiator user ID.
 */
@property (strong, nonatomic, readonly) NSNumber *initiatorID;

/**
 *  Current user ID.
 */
@property (assign, nonatomic, readonly) NSNumber *currentUserID;

/**
 *  IDs of opponents in current session.
 */
@property (strong, nonatomic, readonly) NSArray <NSNumber *> *opponentsIDs;

/**
 *  Conference type.
 *  
 *  @remark
 QBRTCConferenceTypeAudio - audio conference
 QBRTCConferenceTypeVideo - video conference.
 *
 *  @see QBRTCConferenceType
 */
@property (assign, nonatomic, readonly) QBRTCConferenceType conferenceType;

/**
 *  Start call. Opponent will receive new session signal in QBRTCClientDelegate method 'didReceiveNewSession:userInfo:
 *  called by startCall: or acceptCall:
 *
 *  @param userInfo The user information dictionary for the stat call. May be nil.
 */
- (void)startCall:(nullable NSDictionary <NSString *, NSString *> *)userInfo;

/**
 *  Accept call. Opponent's will receive accept signal in QBRTCClientDelegate method 'session:acceptedByUser:userInfo:'
 *
 *  @param userInfo The user information dictionary for the accept call. May be nil.
 */
- (void)acceptCall:(nullable NSDictionary <NSString *, NSString *> *)userInfo;

/**
 *  Reject call. Opponent's will receive reject signal in QBRTCClientDelegate method 'session:rejectedByUser:userInfo:'
 *
 *  @param userInfo The user information dictionary for the reject call. May be nil.
 */
- (void)rejectCall:(nullable NSDictionary <NSString *, NSString *> *)userInfo;

/**
 *  Hang up. Opponent's will receive hung up signal in QBRTCClientDelegate method 'session:hungUpByUser:userInfo:'
 *
 *  @param userInfo The user information dictionary for the hang up. May be nil.
 */
- (void)hangUp:(nullable NSDictionary <NSString *, NSString *> *)userInfo;

@end

NS_ASSUME_NONNULL_END
