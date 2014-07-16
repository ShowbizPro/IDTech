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
		[self.playerSprite setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
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


		self.asteroids = [[NSMutableArray alloc] init];


		timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(spawnAsteroid) userInfo:nil repeats:YES];
		[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

		[self checkCollisions];
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

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
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

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if ([touches count] == 1) {
		[self.playerSprite setXVelocity:0];
		[self.playerSprite setYVelocity:0];
	}

	for (UITouch *touch in touches) {
		CGPoint location = [touch locationInNode:self];
		if (CGRectContainsPoint(self.upButtonSprite.frame, location) ||
		    CGRectContainsPoint(self.downButtonSprite.frame, location)) {
			[self.playerSprite setYVelocity:0];
		}
		if (CGRectContainsPoint(self.leftButtonSprite.frame, location) ||
		    CGRectContainsPoint(self.rightButtonSprite.frame, location)) {
			[self.playerSprite setXVelocity:0];
		}
	}
}

- (void)update:(CFTimeInterval)currentTime {
	/* Called before each frame is rendered */

	[self.playerSprite setPosition:CGPointMake(self.playerSprite.position.x + self.playerSprite.XVelocity, self.playerSprite.position.y + self.playerSprite.YVelocity)];

	for (FallingRocks *asteroid in self.asteroids) {
		[asteroid setPosition:CGPointMake(asteroid.position.x,
		                                  asteroid.position.y + asteroid.YVelocity)];
	}
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

- (void)spawnAsteroid {
	FallingRocks *asteroid = [FallingRocks spriteNodeWithImageNamed:@"Asteriod"];

	float randomXStartingPosition = (arc4random() % 280) + 50;
	[asteroid setPosition:CGPointMake(randomXStartingPosition, 400)];

	float randomY = (-(arc4random() % 20) / 10.0f);

	[asteroid setYVelocity:randomY];

	[self.asteroids addObject:asteroid];
	[self addChild:asteroid];
}

- (void)checkCollisions {
	for (FallingRocks *asteroid in self.asteroids) {
		if (CGRectIntersectsRect(asteroid.frame, self.playerSprite.frame)) {
			[self removeAllChildren];
			[timer invalidate];

			SKLabelNode *youLoseLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
			[youLoseLabel setText:@"You lose :("];
			[youLoseLabel setPosition:CGPointMake(CGRectGetMidX(self.frame),
			                                      CGRectGetMidY(self.frame))];
			[self addChild:youLoseLabel];
		}
	}
}

@end
