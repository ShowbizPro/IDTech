//
//  MyScene.h
//  Asteriods
//

//  Copyright (c) 2014 iDTech. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Spaceship.h"
SKSpriteNode *sprite;
@interface MyScene : SKScene

@property (nonatomic, strong) SKSpriteNode *upButtonSprite;
@property (nonatomic, strong) SKSpriteNode *downButtonSprite;
@property (nonatomic, strong) SKSpriteNode *leftButtonSprite;
@property (nonatomic, strong) SKSpriteNode *rightButtonSprite;

@property (nonatomic, strong) Spaceship *playerSprite;
@end
