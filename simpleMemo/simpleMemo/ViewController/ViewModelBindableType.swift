//
//  ViewModelBindableType.swift
//  simpleMemo
//
//  Created by 김태훈 on 2020/08/19.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import UIKit

protocol ViewModelBindableType {
  associatedtype ViewModelType
  
  var viewModel : ViewModelType! { get set }
  func bindViewModel()
}

extension ViewModelBindableType where  Self : UIViewController {
  mutating func bind(viewModel : Self.ViewModelType) {
    self.viewModel = viewModel
    loadViewIfNeeded()
    
    bindViewModel()
  }
  
}
