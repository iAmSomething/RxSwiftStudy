//
//  MemoDetailViewController.swift
//  simpleMemo
//
//  Created by 김태훈 on 2020/08/19.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class MemoDetailViewController: UIViewController, ViewModelBindableType {
  var viewModel : MemoDetailViewModel!

  @IBOutlet weak var listTableView: UITableView!
  @IBOutlet weak var deleteBtn: UIBarButtonItem!
  @IBOutlet weak var editBtn: UIBarButtonItem!
  @IBOutlet weak var shareBtn: UIBarButtonItem!
  
  override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
  }
  func bindViewModel() {
    viewModel.title
      .drive(navigationItem.rx.title)
      .disposed(by: rx.disposeBag)
    viewModel.contents
      .bind(to : listTableView.rx.items) { tableView, row, value in
        switch row {
        case 0 :
          let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell")!
          cell.textLabel?.text = value
          return cell
        case 1:
          let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell")!
          cell.textLabel?.text = value
          return cell
        default :
          fatalError()
        }
    }
    .disposed(by: rx.disposeBag)
    
    editBtn.rx.action = viewModel.makeEditAction()
    
    shareBtn.rx.tap // 탭속성
      .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
      .subscribe(onNext : { [weak self] _ in
        guard let memo = self?.viewModel.memo.content else {return}
        let vc = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
        self?.present(vc, animated: true, completion: nil)
      })
      .disposed(by: rx.disposeBag)
    deleteBtn.rx.action = viewModel.makeDeleteAction()
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
