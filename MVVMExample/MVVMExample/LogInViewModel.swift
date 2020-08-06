//
//  LogInViewModel.swift
//  MVVMExample
//
//  Created by 김태훈 on 2020/08/05.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
struct LogInViewModel {
  let idTfChanged = PublishRelay<String>()
  let pwTfChanged = PublishRelay<String>()
  let logInBtnTouched = PublishRelay<Void>()
  let result : Signal<Result<User,LoginErr>>
  init (model : LogInModel = LogInModel()) {
    result = logInBtnTouched
      .withLatestFrom(Observable.combineLatest(idTfChanged, pwTfChanged))
      .flatMapLatest { model.requestLogIn(id: $0.0, pw: $0.1)}
      .asSignal(onErrorJustReturn: .failure(.defaultError))
  }
}


