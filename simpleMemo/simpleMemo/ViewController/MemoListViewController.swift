//
//  MemoListViewController.swift
//  simpleMemo
//
//  Created by 김태훈 on 2020/08/19.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class MemoListViewController: UIViewController ,  ViewModelBindableType{
  var viewModel : MemoListViewModel!
  
  
  @IBOutlet weak var add: UIBarButtonItem!
  @IBOutlet weak var listTableView: UITableView!
  override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
  func bindViewModel() {
    viewModel.title.drive(navigationItem.rx.title)
      .disposed(by: rx.disposeBag)
    
    
    viewModel.memoList
      .bind(to : listTableView.rx.items(dataSource: viewModel.dataSource))
      
      .disposed(by: rx.disposeBag)
//      .bind(to: listTableView.rx.items(cellIdentifier: "cell", cellType: TableViewCell.self) ) { row, memo, cell in
////      cell.textLabel?.text = memo.content
////      cell.imageView?.image = memo.thumbnail
//      if memo.favorate {
//        cell.favorateBtn.setImage(UIImage.init(named: "storeDetailIcStarActive"), for: .normal)
//      }
//      else {
//        cell.favorateBtn.setImage(UIImage.init(named: "storeDetailIcStarInactive"), for: .normal)
//      }
//      cell.Title.text = memo.content
//      cell.thumbNail.image = memo.thumbnail
//      cell.favorateBtn.rx.action = self.viewModel.toggleFavorate(memo: memo)
//    }
//    .disposed(by: rx.disposeBag)
    
    Observable.zip(listTableView.rx.modelSelected(Memo.self), listTableView.rx.itemSelected)
      .do(onNext: { [unowned self] (_, IndexPath) in
        self.listTableView.deselectRow(at: IndexPath, animated: true)
      })
      .map {$0.0}
      .bind(to : viewModel.detailAction.inputs)
      .disposed(by: rx.disposeBag)
    
    add.rx.action = viewModel.makeCreateAction()
    
    listTableView.rx.modelDeleted(Memo.self)
      .bind(to : viewModel.deleteAction.inputs)
      .disposed(by:rx.disposeBag)
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


