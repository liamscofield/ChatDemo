//
//  ChatViewController.m
//  ChatDemo
//
//  Created by AlienLi on 14-8-28.
//  Copyright (c) 2014年 AlienLi. All rights reserved.
//

#import "ChatViewController.h"
#import "LMTableViewCell.h"
#import "LMMessageFrame.h"
#import "LMMessage.h"
#import "ALIENKeyBoardView.h"

@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *DataModel;
@property (nonatomic,strong) LMMessageFrame *messageFrame;
@property (nonatomic,strong) LMMessageFrame *tempMessageFrame;
@property (nonatomic,strong) LMMessage *message;



@property (nonatomic,strong)NSMutableArray *cellHeightArray;
@property (nonatomic,strong)NSMutableArray *cellMessageArray;
@property (nonatomic,strong)ALIENKeyBoardView *keyboardView;
@end

@implementation ChatViewController

static NSString *reuserIdentifier = @"Cell";
static const int keyBoardHeight = 44.0;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *backGroundImage= [[UIImageView alloc] initWithFrame:self.view.bounds];
    backGroundImage.image = [UIImage imageNamed:@"scene"];
    
    [self.view addSubview:backGroundImage];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height-keyBoardHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerClass:[LMTableViewCell class]forCellReuseIdentifier:reuserIdentifier];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    [self.view addSubview:self.tableView];
    
    
    self.keyboardView = [[ALIENKeyBoardView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height -keyBoardHeight, self.view.bounds.size.width, keyBoardHeight)];
    self.keyboardView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.keyboardView];
    
    
    

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupDataModel];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.cellMessageArray.count -1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    [self registerForKeyboardNotifications];
}

#pragma mark - setup dataModel
-(void)setupDataModel
{
    self.DataModel = [@[@{@"text":@"1",
                          @"time":@"2014-08-29",
                          @"avatar":@"1",
                          @"messageType":@"1",
                          },
                    @{@"text":@"dada014-08-2014-08-2014-08-2014-08-2014-08-2014-08-2014-08-2014-08-2",
                          @"time":@"2014-08-30",
                          @"avatar":@"1",
                          @"messageType":@"1"
                          },
                        @{@"text":@"3",
                          @"time":@"2014-08-29",
                          @"avatar":@"1",
                          @"messageType":@"1"
                          
                          },
                        @{@"text":@"4",
                          @"time":@"2014-08-29",
                          @"avatar":@"1",
                          @"messageType":@"1"
                          
                          },
                        @{@"text":@"5",
                          @"time":@"2014-08-29",
                          @"avatar":@"1",
                          @"messageType":@"1"
                          
                          },
                        @{@"text":@"6",
                          @"time":@"2014-08-29",
                          @"avatar":@"1",
                          @"messageType":@"1"
                          },
                    @{@"text":@"dada014-08-2014-08-2014-08-2014-08-2014-08-2014-08-2014-08-2014-08-2",
                          @"time":@"2014-08-30",
                          @"avatar":@"1",
                          @"messageType":@"1"
                          },
                        @{@"text":@"8",
                          @"time":@"2014-08-29",
                          @"avatar":@"1",
                          @"messageType":@"0"
                          
                          },
                        @{@"image":@"scene",
                          @"time":@"2014-08-29",
                          @"avatar":@"1",
                          @"messageType":@"3"
                          
                          },
                        @{@"image":@"scene",
                          @"time":@"2014-08-29",
                          @"avatar":@"1",
                          @"messageType":@"2"
                          }]mutableCopy];
    
    self.cellHeightArray = [NSMutableArray array];
    self.cellMessageArray =[NSMutableArray array];
    
    
    _messageFrame = [[LMMessageFrame alloc] init];
    self.tempMessageFrame = [[LMMessageFrame alloc] init];
    
    
    [self.DataModel enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        _message = [[LMMessage alloc] initWithContent:self.DataModel[idx]];
        [self.cellMessageArray addObject:_message];
        
        _messageFrame.message = _message;
        [self.cellHeightArray addObject:@(_messageFrame.cellHeight)];
    }];
}

#pragma mark -dataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.cellMessageArray.count;
}

-(LMTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentifier forIndexPath:indexPath];

    self.tempMessageFrame.message = self.cellMessageArray[indexPath.row];
    cell.messageFrame = self.tempMessageFrame;
    

    return cell;
}

#pragma mark -delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [self.cellHeightArray[indexPath.row] floatValue];
    
    
    return height;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - keyboard

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)keyboardWasShown:(NSNotification*)notification
{
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
//    self.tableView.contentInset = contentInsets;
//    self.tableView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
//    CGRect aRect = self.view.frame;
//    aRect.size.height -= kbSize.height;
//    if (!CGRectContainsPoint(aRect, self.keyboardView.textView.frame.origin) ) {
//        [self.tableView scrollRectToVisible:self.keyboardView.textView.frame animated:YES];
//    }
    
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(self.view.bounds.origin.x,self.view.bounds.origin.y - kbSize.height, self.view.bounds.size.width,self.view.bounds.size.height);
    } completion:^(BOOL finished) {
        if(finished){
            
        }
            
    }];
    
}
-(void)keyboardWillBeHidden:(NSNotification*)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    __weak UITableView *weakTableView = self.tableView;
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITableView *StrongTableView = weakTableView;
        UITouch *touch = (UITouch*)obj;
        CGPoint point = [touch locationInView:self.view];
        CGRect  frame = StrongTableView.frame;
        
        
        if (CGRectContainsPoint(frame, point)) {
//            如果在tableview内；
        }

        
    }];
}

@end
