//
//  cellStorageType.swift
//  sideSlideCollectionViewPractice
//
//  Created by 김태훈 on 2020/08/21.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import Foundation
import RxSwift

protocol CellStorageType {
  @discardableResult
  func createCell(cellImg : UIImage, text:String, subText:String) -> Observable<CellModel>
  
  @discardableResult
  func cellList() -> Observable<[CellModel]>
  
  @discardableResult
  func deleteCell(cell : CellModel) ->Observable<CellModel>
}
