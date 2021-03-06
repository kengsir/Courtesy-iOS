//
//  GlobalSettings.h
//  Courtesy
//
//  Created by Zheng on 2/23/16.
//  Copyright © 2016 82Flex. All rights reserved.
//  It is a singleton.

#import "CourtesyAccountModel.h"
//#import "CourtesyFontModel.h"
//#import "CourtesyCardStyleModel.h"
//#import "CourtesyCardPreviewStyleModel.h"
#import <YYKit/YYReachability.h>

#define kCourtesyQualityLow 0.33
#define kCourtesyQualityMedium 0.66
#define kCourtesyQualityBest 1.00

@interface GlobalSettings : NSObject
+ (id)sharedInstance;

@property (nonatomic, assign) BOOL hasLogin;
@property (nonatomic, copy) NSString<Ignore> *sessionKey;
@property (nonatomic, readonly) UIUserNotificationSettings<Ignore> *requestedNotifications;
@property (nonatomic, assign) BOOL hasNotificationPermission;
@property (nonatomic, strong) CourtesyAccountModel<Ignore> *currentAccount;
@property (nonatomic, assign) BOOL fetchedCurrentAccount;
@property (nonatomic, strong) YYReachability *localReachability;

@property (nonatomic, assign) BOOL switchAutoPublic;
@property (nonatomic, assign) BOOL switchMarkdown;
@property (nonatomic, assign) BOOL switchPreviewAvatar;
@property (nonatomic, assign) BOOL switchPreviewNeedsShadows;
@property (nonatomic, assign) NSUInteger preferredFontType;
@property (nonatomic, assign) CGFloat preferredFontSize;
@property (nonatomic, assign) NSUInteger preferredStyleID;
@property (nonatomic, assign) NSUInteger preferredPreviewStyleType;
@property (nonatomic, assign) float preferredImageQuality;
@property (nonatomic, assign) UIImagePickerControllerQualityType preferredVideoQuality;
@property (nonatomic, strong) NSMutableArray *addressArray;

- (void)fetchCurrentAccountInfo;
- (void)reloadAccount;

@end
