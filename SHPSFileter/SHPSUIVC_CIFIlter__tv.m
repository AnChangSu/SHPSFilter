//
//  SHPSUIVC_CIFIlter__tv.m
//  SHPSFileter
//
//  Created by anchang on 13-6-3.
//  Copyright (c) 2013年 shem. All rights reserved.
//

#import "SHPSUIVC_CIFIlter__tv.h"
#import <CoreImage/CoreImage.h>
#import "SHPSUIVC_CIFilter__example__tv.h"
#import "SHPSUIVC_CIFIlter__inputDetail.h"

@interface SHPSUIVC_CIFIlter__tv ()
{
    CIFilter * _filter;
    
    
    NSArray * _categories;
    NSArray * _inputs ;
    NSArray * _outputs;
}
@end

@implementation SHPSUIVC_CIFIlter__tv

@synthesize filterName;
@synthesize categoryName;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void) setObject:(id)object {
     _filter = (CIFilter*) object;
    
    
    _inputs = [_filter inputKeys];
    _outputs = [_filter outputKeys];
}

-(void)actionShowDemo:(id)sender{
    SHPSUIVC_CIFilter__example__tv *controller = [[SHPSUIVC_CIFilter__example__tv alloc] init];
    controller.filterName = self.filterName;
    controller.categoryName = self.categoryName;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CIFilter *filter = [CIFilter filterWithName:filterName];
    NSDictionary *dictionary = [filter attributes];
    
    NSLog(@"__________%@",[dictionary description]);

    self.navigationItem.title = [dictionary objectForKey:@"CIAttributeFilterDisplayName"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"example" style:UIBarButtonItemStyleDone target:self action:@selector(actionShowDemo:)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
   
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSString * ) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return @"Basics";
            
            break;
        case 1: {
            return @"Categories";
        }
        case 2: {
            return @"inputs";
        }
        case 3: {
            return  @"outputs";
            
            
        }
        default:
            return nil;
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:{
            return 1;
        }
            break;
        case 1:{
            CIFilter *filter = [CIFilter filterWithName:filterName];
            NSDictionary *dictionary = [filter attributes];
            NSArray *array = [dictionary objectForKey:@"CIAttributeFilterCategories"];
            return [array count];
        }
            
            break;
        case 2:{
            CIFilter *filter = [CIFilter filterWithName:filterName];
            NSArray *array = [filter inputKeys];
            return [array count];
        }
            
            break;
        case 3:{
            CIFilter *filter = [CIFilter filterWithName:filterName];
            NSArray *array = [filter outputKeys];
            return [array count];
        }
            
            break;
            
        default:
            return 0;
            break;
    }
    // Return the number of rows in the section.
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    CIFilter *filter = [CIFilter filterWithName:filterName];
    NSDictionary *dictionary = [filter attributes];
    NSArray *keyArray = [dictionary allKeys];
    
    for (NSString *key in keyArray) {
        if ( [key isEqualToString:@"CIAttributeFilterDisplayName"]
            || [key isEqualToString:@"CIAttributeFilterName"]
            || [key isEqualToString:@"CIAttributeFilterCategories"]) {
            continue;
        }else{
            [array addObject:key];
        }
    }
    
    switch (indexPath.section) {
        case 0:
            /*if ( indexPath.row == 0 ) {
                CIFilter *filter = [CIFilter filterWithName:filterName];
                NSDictionary *dictionary = [filter attributes];
                cell.textLabel.text = [NSString stringWithFormat:@"CIAttributeFilterDisplayName:%@",[dictionary objectForKey:@"CIAttributeFilterDisplayName"]];
            }else*/{
                CIFilter *filter = [CIFilter filterWithName:filterName];
                if ( ![[filter attributes] isKindOfClass:[NSDictionary class]] ) {
                    break;
                }
                NSDictionary *dictionary = [filter attributes];
                cell.textLabel.text = [dictionary objectForKey:@"CIAttributeFilterName"];
            }
            break;
        case 1:{
            CIFilter *filter = [CIFilter filterWithName:filterName];
            if ( ![[filter attributes] isKindOfClass:[NSDictionary class]] ) {
                break;
            }
            NSDictionary *dictionary = [filter attributes];
            NSArray *array = [dictionary objectForKey:@"CIAttributeFilterCategories"];
            cell.textLabel.text = [array objectAtIndex:indexPath.row];
        }
            break;
        case 2:{
            CIFilter *filter = [CIFilter filterWithName:filterName];
            if ( ![[filter attributes] isKindOfClass:[NSDictionary class]] ) {
                break;
            }
//            NSDictionary *dictionary = [filter attributes];
//            NSDictionary *valueDictionary = [dictionary objectForKey:[array objectAtIndex:indexPath.row]];
            NSArray *inputsArray = [filter inputKeys];
            
            NSMutableString *mutString = [[NSMutableString alloc] init];
            for (int i=0; i<[inputsArray count]; i++) {
                if ( [[inputsArray objectAtIndex:i] isKindOfClass:[NSString class]] ) {
                    [mutString appendString:[inputsArray objectAtIndex:i]];
                }
            }

            NSString *keyString = [inputsArray objectAtIndex:indexPath.row];
            cell.textLabel.text = keyString;
//            cell.detailTextLabel.text =[NSString stringWithFormat:@"%@:%@",typeString,defaultString];
//            cell.textLabel.numberOfLines = 0;
        }
            break;
        case 3:{
            CIFilter *filter = [CIFilter filterWithName:filterName];
            NSArray *array = [filter outputKeys];
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:indexPath.row]];
        }
            break;
            
        default:
            break;
    }
    // Configure the cell...
    
    
    /*CIFilter *filter = [CIFilter filterWithName:filterName];
    NSDictionary *dictionary = [filter attributes];
    NSArray *key = [dictionary allKeys];
    NSArray *value = [dictionary allValues];
    cell.textLabel.text = [NSString stringWithFormat:@"key:%@__value:%@",[key objectAtIndex:indexPath.row],[value objectAtIndex:indexPath.row]];
    cell.textLabel.numberOfLines = 0;*/
    
   // NSLog(@"key = %@,value = %@",[key objectAtIndex:indexPath.row],[value objectAtIndex:indexPath.row]);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
       /* NSMutableArray *array = [[NSMutableArray alloc] init];
        CIFilter *filter = [CIFilter filterWithName:filterName];
        NSDictionary *dictionary = [filter attributes];
        NSArray *keyArray = [dictionary allKeys];
        
        for (NSString *key in keyArray) {
            if ( [key isEqualToString:@"CIAttributeFilterDisplayName"]
                || [key isEqualToString:@"CIAttributeFilterName"]
                || [key isEqualToString:@"CIAttributeFilterCategories"]) {
                continue;
            }else{
                [array addObject:key];
            }
        }

        NSString *string = [NSString stringWithFormat:@"key:%@__value:%@",[array objectAtIndex:indexPath.row], [dictionary objectForKey:[array objectAtIndex:indexPath.row]]];;
        
        CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(200, 2000) lineBreakMode:NSLineBreakByCharWrapping];*/

        return 50;
    }else{
        return 50;
    }
   
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.section == 2 ) {
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        CIFilter *filter = [CIFilter filterWithName:filterName];
        NSDictionary *dictionary = [filter attributes];
        NSArray *keyArray = [dictionary allKeys];
        
        for (NSString *key in keyArray) {
            if ( [key isEqualToString:@"CIAttributeFilterDisplayName"]
                || [key isEqualToString:@"CIAttributeFilterName"]
                || [key isEqualToString:@"CIAttributeFilterCategories"]) {
                continue;
            }else{
                [array addObject:key];
            }
        }
    
        NSDictionary *valueDictionary = [dictionary objectForKey:[array objectAtIndex:indexPath.row]];
        NSString *keyString = [array objectAtIndex:indexPath.row];

        SHPSUIVC_CIFIlter__inputDetail *controller = [[SHPSUIVC_CIFIlter__inputDetail alloc] init];
        controller.keyString = keyString;
        controller.valueDic = valueDictionary;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
