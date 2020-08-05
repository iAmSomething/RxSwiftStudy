//
//  LogInModel.swift
//  MVVM 예제
//
//  Created by 김태훈 on 2020/08/05.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import Foundation
import RxSwift

struct User : Codable {
  let name : String
}
enum LoginErr : Error{
  case defaultError
  case error(code: Int)
  
  var msg : String {
    switch self {
    case .defaultError :
      return "ERROR"
    case .error(let code) :
      return "\(code) ERROR"
    }
  }
}


struct LogInModel {
  func requestLogIn(id : String, pw : String) -> Observable<Result<User, LoginErr>> {
    return Observable.create { (observer) -> Disposable in
      if id != "" && pw != "" {
        observer.onNext(.success(User(name: id)))
      } else {
        observer.onNext(.failure(.defaultError))
      }
      
      observer.onCompleted()
      return Disposables.create()
    }
  }
}
