//
//  CellModel.swift
//  sideSlideCollectionViewPractice
//
//  Created by 김태훈 on 2020/08/21.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import Foundation
import UIKit

struct CellModel : Equatable, Comparable {
  static func < (lhs: CellModel, rhs: CellModel) -> Bool {
    return lhs.insertDate > rhs.insertDate
  }
  var cellImg:UIImage
  var cellName : String
  var cellSubText :String
  var cellDate:Date
  var insertDate :String
  init(cellImg : UIImage = UIImage(), cellName:String, cellSubText : String, cellDate : Date = Date()){
    self.cellImg = cellImg
    self.cellName = cellName
    self.cellSubText = cellSubText
    self.cellDate = cellDate
    self.insertDate = "\(cellDate.timeIntervalSinceReferenceDate)"
  }
}
