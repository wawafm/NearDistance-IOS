//
//  NDHttpCache.h
//  JNDFramework
//
//  Created by Peter Jin (https://github.com/JNDSir) on  15/2/19.
//  Copyright (c) 2015年 PeterJin.   Email:i@jND.name      All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, NDHttpResponseCacheOption){
    NDHttpCacheNone        = 1 << 0,
    NDHttpCacheMemory      = 1 << 1,
    NDHttpCacheDisk        = 1 << 2,
};

typedef void(^NDHttpCacheNoParamsBlock)();
typedef void(^NDHttpCalculateSizeBlock)(NSUInteger fileCount, NSUInteger totalSize);

@interface NDHttpCache : NSObject

/**
 * The maximum "total cost" of the in-memory image cache. The cost function is the number of pixels held in memory.
 */
@property (assign, nonatomic) NSUInteger maxMemoryCost;

/**
 * The maximum length of time to keep an image in the cache, in seconds
 */
@property (assign, nonatomic) NSInteger maxCacheAge;

/**
 * The maximum size of the cache, in bytes.
 */
@property (assign, nonatomic) NSUInteger maxCacheSize;

+ (NDHttpCache*) sharedInstance;

/**
 * Cache main functions
 * response can be
 */
- (void) storeResponse: (id)response forUrl: (NSString *) url byParam:(NSDictionary *)params toDisk: (BOOL)toDisk;
- (id)   fetchResponseForUrl: (NSString *) url byParam: (NSDictionary *) params;

/**
 * Clear all memory cached images
 */
- (void)clearMemory;

/**
 * Clear all disk cached images. Non-blocking method - returns immediately.
 * @param completionBlock An block that should be executed after cache expiration completes (optional)
 */
- (void)clearDiskOnCompletion:(NDHttpCacheNoParamsBlock)completion;

/**
 * Clear all disk cached images
 * @see clearDiskOnCompletion:
 */
- (void)clearDisk;

/**
 * Remove all expired cached image from disk. Non-blocking method - returns immediately.
 * @param completionBlock An block that should be executed after cache expiration completes (optional)
 */
- (void)cleanDiskWithCompletionBlock:(NDHttpCacheNoParamsBlock)completionBlock;

/**
 * Remove all expired cached image from disk
 * @see cleanDiskWithCompletionBlock:
 */
- (void)cleanDisk;

/**
 * Get the size used by the disk cache
 */
- (NSUInteger)getSize;

/**
 * Get the number of images in the disk cache
 */
- (NSUInteger)getDiskCount;

/**
 * Asynchronously calculate the disk cache's size.
 */
- (void)calculateSizeWithCompletionBlock:(NDHttpCalculateSizeBlock)completionBlock;

@end
