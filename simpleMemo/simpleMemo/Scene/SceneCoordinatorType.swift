//
//  SceneCoordinatorType.swift
//  simpleMemo
//
//  Created by 김태훈 on 2020/08/19.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
  @discardableResult // 사용 안해도 됨
  func transition(to scene : Scene, using style : TransitionStyle, animated : Bool) -> Completable
  
  @discardableResult
  func close(animated:Bool) -> Completable
}

