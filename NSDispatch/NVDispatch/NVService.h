//
//  NVService.h
//  NSDispatch
//
//  Created by LeixSnake on 10/17/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NVService : NSObject

- (void)addBlock: (dispatch_block_t)block;

- (void)addBlock: (dispatch_block_t)block
      completion: (dispatch_block_t)completion;

@end
