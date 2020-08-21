//
//  ViewController.swift
//  React
//
//  Created by 김태훈 on 2020/08/21.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {


  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    
    // Observable을 만드는 방법 -1 : 직접 구현
    Observable<Int>.create { (observer) -> Disposable in
      observer.on(.next(0))
      observer.onNext(1)
      
      observer.onCompleted()
      return Disposables.create()
    }
    
    // Observable을 만드는 방법 -2
    Observable.from([0,1]) //단순히 순서대로 방출하는 연산자 from - 방출,complete
    
    
    let disposBag = DisposeBag()
    
    enum MyErr : Error {
      case error
    }
    
    
    let subject = PublishSubject<String>() // 이벤트를 저장한다.
    //subject는 옵저버블이면서 동시에 옵저버
    subject.onNext("Hello")
    
    let o1 = subject.subscribe{print(">>1", $0)}
    o1.disposed(by: disposBag)
    
    subject.onNext("RxSwift")
    
    let o2 = subject.subscribe{print(">>2", $0)}
    o2.disposed(by: disposBag)
    subject.onNext("Subject")
    
    subject.onCompleted()
    
    subject.onError(MyErr.error)
    let o3 = subject.subscribe{print(">>3", $0)}
    o3.disposed(by: disposBag)
    
    //create를 수행하는 연산자
    let element = "🐶"
    //just 연산자 -> 그대로 방출
    Observable.just(element) // element를 바로 방출
      .subscribe{event in print(event)}
      .disposed(by: disposBag)
    
    Observable.just([1,2,3,4,5])
      .subscribe{event in print(event)}
      .disposed(by: disposBag)
    
    //or 연산자 - 가변 element
    let apple = "apple"
    let orange = "org"
    let kiwi = "kiwi"
    Observable.of(apple,orange,kiwi)
    .subscribe{event in print(event)}
    .disposed(by: disposBag)
    
    Observable.of([1,2],[3,4],[5,6])
    .subscribe{event in print(event)}
    .disposed(by: disposBag)
    
    //from 연산자
    let fr = [apple,orange,kiwi]
    Observable.from(fr)
    .subscribe{event in print(event)}
    .disposed(by: disposBag)
    
    
    //filter연산자
    let numbers = [1,2,3,4,5,6,7,8,9,0]
    Observable.from(numbers)
      .filter{ $0 % 2 == 0 }
      .subscribe{print($0)}
      .disposed(by: disposBag)
    
    //flatMap
    
    let a = BehaviorSubject(value: 1)
    let b = BehaviorSubject(value: 2)
    
    let subject2 = PublishSubject<BehaviorSubject<Int>>()
    subject2
      .flatMap{$0.asObservable()}
      .subscribe{print($0)}
      .disposed(by: disposBag)
    
    subject2.onNext(a)
    subject2.onNext(b)
    
    a.onNext(11)
    b.onNext(21)
  }
  

}

