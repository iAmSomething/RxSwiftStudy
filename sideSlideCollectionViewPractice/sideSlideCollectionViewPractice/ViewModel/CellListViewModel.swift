//
//  CellListViewModel.swift
//  sideSlideCollectionViewPractice
//
//  Created by 김태훈 on 2020/08/21.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Action
import RxDataSources
class CellCommonViewModel : NSObject{
  let storage : CellStorageType
  init(storage : CellStorageType){
    self.storage = storage
  }
}
class CellListViewModel : CellCommonViewModel {
  var cellList : Observable<[CellModel]> {
    return storage.cellList()
  }
}
