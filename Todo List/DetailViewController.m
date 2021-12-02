//
//  ViewController.m
//  Todo List
//
//  Created by Emil Makaev on 29.11.2021.
//

#import "DetailViewController.h"

// <UITextFieldDelegate> protocol subscription
@interface DetailViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *buttonSave;
//- (IBAction)buttonAction:(id)sender;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datePicker.minimumDate = [NSDate date];
    
    [self.datePicker addTarget:self action:@selector(datePickerValueChanged) forControlEvents:UIControlEventValueChanged];
    
    [self.buttonSave addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer * handleTab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleEndEditing)];
    
    [self.view addGestureRecognizer:handleTab];
}

- (void)datePickerValueChanged {
    self.eventDate = self.datePicker.date;
    // NSLog(@"date Picker %@", self.datePicker.date);
};

- (void) handleEndEditing {
    [self.view endEditing:YES];
};

- (void) save {
    NSString *eventInfo = self.textField.text;
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"HH:mm dd.MMMM.yyyy";
    NSString *eventDate = [formater stringFromDate:self.eventDate];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          eventInfo, @"eventInfo",
                          eventDate, @"eventDate",
                          nil];
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.userInfo = dict;
    notification.timeZone =  [NSTimeZone defaultTimeZone];
    notification.fireDate = self.eventDate;
    notification.alertBody = eventInfo;
    notification.applicationIconBadgeNumber = 1;
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    NSLog(@"Hi");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if([textField isEqual:self.textField]) {
        [self.textField resignFirstResponder];
    };
    
    return YES;
};

//- (IBAction)buttonAction:(id)sender {
//    NSLog(@"Button Action");
//}


@end
