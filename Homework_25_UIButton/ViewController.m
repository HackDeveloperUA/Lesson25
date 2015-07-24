#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic)   IBOutlet UILabel *display;
@property (assign, nonatomic) double firstNumber;
@property (assign, nonatomic) double secondNumber;
@property (assign, nonatomic) BOOL   enter;

@property (strong, nonatomic) NSMutableString *lableValue;
@property (assign, nonatomic) NSInteger operationNumber;

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstNumber = 0;
    self.secondNumber = 0;
    
    self.lableValue = [NSMutableString stringWithFormat:@""];
    
    // закругляем все кнопки на экране
    for ( UIButton *obj in self.view.subviews) {
        obj.layer.cornerRadius = 4;
    }
    
}

- (IBAction)digital:(UIButton *)sender {
    
    // записываем значния тэга в nsstring
    NSString* value = [NSString stringWithFormat:@"%d",(int) sender.tag];
    [self.lableValue appendFormat:value];
    
    // вытаскиваем из строки значение и конвертируем его в double
    self.firstNumber  = [[NSString stringWithFormat:@"%@", self.lableValue] doubleValue];
    // выводим на экран
    self.display.text = [NSString stringWithFormat:@"%@",self.lableValue];
    
    
    
    // Логика следующая : если self.enter == YES , то при нажатии одну из кнопок операциий (* / + -)
    // запоминаем какая кнопка операций была нажата ,
    // запоминаем в self.secondNumber наш self.firstNumber , что бы потом ввести второе число в self.firstNumber
    // обнуляем label экрана
    if (self.secondNumber == 0) {
        self.enter = YES;
    }
   
    // Если же self.enter == NO , то проводим саму операцию , то есть (умножаем , делим и т.д.)
    // После чего переменную double result (сейчас она выглядит примерно так 194.0000000) , конвертируем в строку
    // и передаем в метод doubleToString для того что бы убрать не нужные нули в переменной
    // После выводим на экран и обнуляем все переменные кроме self.firstNumber , для дальнейшего использования
    // Говорим , что self.enter = YES для того что бы можно было опять совершить какое либо действие (+ - * /)
    
    else {
        self.enter = NO;
    }
   
    
}


- (IBAction)operations:(UIButton *)sender {

    
    if (self.enter) {
        self.operationNumber = sender.tag;
        self.secondNumber    = self.firstNumber;
        
        self.lableValue   = [NSMutableString stringWithFormat:@""];
        self.firstNumber  = 0;
        self.display.text = [NSString stringWithFormat:@"0"];
        
    }else {
        
        double result;
        
        switch (self.operationNumber) {
            case 100:
                result = self.secondNumber / self.firstNumber;
                break;
                
            case 101:
                result = self.secondNumber * self.firstNumber;
                break;
                
            case 102:
                result = self.secondNumber - self.firstNumber;
                break;
                
            case 103:
                result = self.secondNumber + self.firstNumber;
                break;
                
            default:
                break;
        }
        // максимум 7 символов после точки
        NSString* value = [NSString stringWithFormat:@"%.7f",result];
        value = [self doubleToString:0 andString:value];
        self.display.text = [NSString stringWithFormat:@"%@",value];
        
        self.firstNumber     = result;
        self.secondNumber    = 0;
        self.operationNumber = 0;
        self.enter = YES;
        
    }
}


- (IBAction)decimal:(UIButton *)sender {

    // ставим точку пока что только в строке
    [self.lableValue appendFormat:@"."];
    
    // а вот теперь преобразуем строку в число
    self.firstNumber  = [[NSString stringWithFormat:@"%@", self.lableValue] doubleValue];
    self.display.text = [NSString stringWithFormat:@"%@",self.lableValue];

}



- (IBAction)clearButton:(UIButton *)sender {

    self.display.text = [NSString stringWithFormat:@"0"];
    [self.lableValue setString:@""];
    

}


-(NSString*) doubleToString:(double) doubleNumber andString:(NSString*) myString {
    
    NSString* string = [NSString stringWithFormat:@"%@",myString];
    NSInteger indexOfRange = [string length];
    
    // убераем не нужные нули
    while ([[string substringWithRange:NSMakeRange(indexOfRange-1, 1)] isEqualToString:@"0"]) {
        indexOfRange--;
        
    }
    string = [string substringWithRange:NSMakeRange(0, indexOfRange)];
    
    
    NSRange range = [string rangeOfString:@"."];
    
    // убераем точку если это целочисленное значение
    if (string.length-1 == range.location) {
        string = [string stringByReplacingOccurrencesOfString:@"." withString:@""];
    }
    
    return string;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
