//
//  TransitionModel.swift
//  simpleMemo
//
//  Created by 김태훈 on 2020/08/19.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import Foundation
enum TransitionStyle {
  case root
  case push
  case modal
}

enum TransitionErr : Error {
  case navigationControllerMissing
  case connotPop
  case unknown
}
