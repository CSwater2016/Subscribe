# Subscribe

### 概要
> 每个项目中总有那么几个实例是全局并且是实时更新的，更改之后必须第一时间通知所有相关界面更新，比如最常见的 userInfo。  
> 用**通知中心**当然也能够胜任，但是要在每个使用的地方都添加监听、移除监听、实现代理并解析处理…… 就有点烦了。  
> 这个类别能够帮助直观地实现监听，减少零碎的监听步骤。  
> 当然，缺点还是有的，因为是 NSObject 的类别，所以使用之后会污染所有导入链下端的所有对象……

### 实现思路
仿照 RxSwift 的处理方法，使用了**订阅**的概念。    
但是 Swift 里面数组可以装函数对象，OC 里面可不行。所以大概思路是：  
**每个订阅动作，都创建一个能存储了回调(block)的对象，并将对象存储到数组中去。在监听对象set方法被调用的时候，遍历执行数组中所有对象并执行它们各自的回调(block)。 实现一处监听，处处可订阅的效果** 。  

### 使用

在需要订阅的类内，添加一个属性：  
```Objective-C
@property (nonatomic, strong) DisposeBag *disposeBag;
```
它将用于存储了删除回调对象的方法，并在 dealloc 的执行（界面没了就销毁对应的回调对象）  

接着，添加这个方法：
```Objective-C
    self.disposeBag = [[DisposeBag alloc] init];
    
    [[[UserContext shareInstant] subscribeUserContext:^(id subscriber) {
        // 响应动作
    }] addToDisposeBag: self.disposeBag] ;
```
没了。

不过，RN 那么强，OC 已没落。没多大意思。
