//
//  ViewController.swift
//  sideSlideCollectionViewPractice
//
//  Created by 김태훈 on 2020/08/21.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
class ViewController: UIViewController {
  @IBOutlet weak var mainCollectionViewList: UICollectionView!
  var viewModel = CellListViewModel(storage: cellStorage())
  override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
    // Do any additional setup after loading the view.
  }
  func bindViewModel() {
    let layout = mainCollectionViewList.collectionViewLayout as? UICollectionViewFlowLayout
    layout?.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 10)
    layout?.minimumInteritemSpacing = 10
    viewModel.cellList
      .bind(to: mainCollectionViewList.rx.items(cellIdentifier: "cell", cellType: CollectionViewCell.self)) { row, cellmodel , cell in
        cell.MainImg.image = cellmodel.cellImg
        cell.text.text = cellmodel.cellName
        cell.subText.text = cellmodel.cellSubText
    }
    .disposed(by: rx.disposeBag)
  }
}

