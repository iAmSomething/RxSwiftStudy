//
//  CommonViewModel.swift
//  simpleMemo
//
//  Created by 김태훈 on 2020/08/19.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CommonViewModel : NSObject {
  let title : Driver<String>
  let sceneCoordinator : SceneCoordinatorType // 프로토콜로 선언하였다 이유 : 의존성을 해소
  let storage : MemoStorageType
  
  
  init(title :String,sceneCoordinator : SceneCoordinatorType, storage : MemoStorageType) {
    self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
    self.sceneCoordinator = sceneCoordinator
    self.storage = storage
  }
}
