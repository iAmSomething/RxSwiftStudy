//
//  TableViewCell.swift
//  simpleMemo
//
//  Created by 김태훈 on 2020/08/20.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
class TableViewCell: UITableViewCell {
  @IBOutlet weak var Title: UILabel!
  @IBOutlet weak var thumbNail: UIImageView!
  @IBOutlet weak var favorateBtn: UIButton!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
