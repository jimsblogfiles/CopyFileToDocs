//
//  ViewController.m
//  CopyFileToDocs
//
//  Created by James Border on 6/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

-(void)copyFileFromBundleToDocs:(NSString*)fileName;

@end

@implementation ViewController

-(void)copyFileFromBundleToDocs:(NSString*)fileName {

	NSFileManager *filemgr = [NSFileManager defaultManager];
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	NSLog(@"documentsDir:%@",documentsDir);

	NSError *error = nil;
	
	if ([filemgr fileExistsAtPath: [documentsDir stringByAppendingPathComponent:fileName] ] == YES) {

		NSLog (@"File exists, done");
		
	} else {
		
		NSLog (@"File not found, copying next.");
		
		if([filemgr copyItemAtPath:[[NSBundle mainBundle] pathForResource:fileName ofType:@""] toPath:[documentsDir stringByAppendingPathComponent:fileName] error:&error]){
			
			NSLog(@"File successfully copied to:%@",documentsDir);
			
		} else {

			NSLog(@"Error description - %@ \n", [error localizedDescription]);
			NSLog(@"Error reason - %@", [error localizedFailureReason]);

		}
		
	}
	
}


- (void)viewDidLoad {

    [super viewDidLoad];

	[self copyFileFromBundleToDocs:@"TargetFile.txt"];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
