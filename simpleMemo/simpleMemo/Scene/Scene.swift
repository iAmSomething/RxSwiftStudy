//
//  Scene.swift
//  simpleMemo
//
//  Created by 김태훈 on 2020/08/19.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import UIKit

enum Scene {
  case list(MemoListViewModel)
  case detail(MemoDetailViewModel)
  case compose(MemoComposeViewModel)
}


extension Scene {
  func instantiate(from storyboard : String = "Main") -> UIViewController {
    let storyboard = UIStoryboard(name: storyboard, bundle: nil)
    
    switch self {
    case .list(let viewModel):
      guard let navi = storyboard.instantiateViewController(withIdentifier: "ListNavigation") as? UINavigationController else {
        fatalError()
      }
      guard var listVC = navi.viewControllers.first as? MemoListViewController else  { fatalError()}
      listVC.bind(viewModel: viewModel)
      return navi
    case .detail(let viewModel):
      guard var detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? MemoDetailViewController else {fatalError()}
      detailVC.bind(viewModel: viewModel)
      return detailVC
    case .compose(let viewModel) :
      guard let navi = storyboard.instantiateViewController(withIdentifier: "ComposeNavi") as? UINavigationController  else {
        fatalError()
      }
      guard var composeVC = navi.viewControllers.first as? MomoComposeViewController else {
        fatalError()
      }
      composeVC.bind(viewModel: viewModel)
      return navi
    }
  }
}
