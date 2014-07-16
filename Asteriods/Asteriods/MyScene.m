//
//  MyScene.m
//  Asteriods
//
//  Created by iD Student on 7/16/14.
//  Copyright (c) 2014 iDTech. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

- (id)initWithSize:(CGSize)size {
	if (self = [super initWithSize:size]) {
		/* Setup your scene here */

		self.backgroundColor = [SKColor colorWithRed:0.65 green:0.05 blue:0.23 alpha:1.0];
        [self createDPad];
        
        
        
        
        self.playerSprite = [Spaceship spriteNodeWithImageNamed:@"Spaceship"];
        [self.playerSprite setPosition: CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
        [self addChild:self.playerSprite];
        
        
		SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];

		myLabel.text = @"Welcome to My World!";
		myLabel.fontSize = 10;
		myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
		                               CGRectGetMidY(self.frame));

		[self addChild:myLabel];
		/*sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];

		sprite.position = CGPointMake(CGRectGetMidX(self.frame),
		                              CGRectGetMidY(self.frame));
		SKAction *action = [SKAction rotateByAngle:M_PI duration:1];

		[sprite runAction:[SKAction repeatActionForever:action]];

		[self addChild:sprite];*/

			}
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	/* Called when a touch begins */

	/*for (UITouch *touch in touches) {
		CGPoint location = [touch locationInNode:self];

		sprite.position = location;
	}*/
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        if (CGRectContainsPoint(self.upButtonSprite.frame, location)) {
            [self.playerSprite setYVelocity:1];
        }
        
        if (CGRectContainsPoint(self.downButtonSprite.frame, location)) {
            [self.playerSprite setYVelocity:-1];
        }
        
        if (CGRectContainsPoint(self.leftButtonSprite.frame, location)) {
            [self.playerSprite setXVelocity:-1];
        }
        
        if (CGRectContainsPoint(self.rightButtonSprite.frame, location)) {
            [self.playerSprite setXVelocity:1];
        }
    }
    
    
    
    
    
    
    
}

- (void)update:(CFTimeInterval)currentTime {
	/* Called before each frame is rendered */
    
    [self.playerSprite setPosition:CGPointMake(self.playerSprite.position.x + self.playerSprite.XVelocity, self.playerSprite.position.y +self.playerSprite.YVelocity)];
    
    
    
    
}

- (void)createDPad {
	self.upButtonSprite = [SKSpriteNode spriteNodeWithImageNamed:@"arrow"];
	self.downButtonSprite = [SKSpriteNode spriteNodeWithImageNamed:@"arrow"];
	self.leftButtonSprite = [SKSpriteNode spriteNodeWithImageNamed:@"arrow"];
	self.rightButtonSprite = [SKSpriteNode spriteNodeWithImageNamed:@"arrow"];

	[self.upButtonSprite setPosition:CGPointMake(55, 100)];
	[self.downButtonSprite setPosition:CGPointMake(55, 50)];
	[self.leftButtonSprite setPosition:CGPointMake(25, 75)];
	[self.rightButtonSprite setPosition:CGPointMake(85, 75)];


	[self.downButtonSprite setZRotation:M_PI];
	[self.leftButtonSprite setZRotation:M_PI_2];
	[self.rightButtonSprite setZRotation:-M_PI_2];


	[self addChild:self.upButtonSprite];
	[self addChild:self.downButtonSprite];
	[self addChild:self.leftButtonSprite];
	[self addChild:self.rightButtonSprite];
}

@end
