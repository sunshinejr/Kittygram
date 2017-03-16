//
//  DashboardViewController.swift
//  Kittygram
//
//  Created by Lukasz Mroz on 19.10.2016.
//  Copyright © 2016 Sunshinejr. All rights reserved.
//

import Foundation
import Moya
import Moya_ModelMapper
import UIKit
import RxSwift
import RxCocoa

protocol DashboardViewControllerDelegate: class {
    func kittySelected(repo: Repository)
}

class DashboardViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var progressView = UIView()
    var viewModel: DashboardViewModelType!
    
    let disposeBag = DisposeBag()
    
    convenience init(viewModel: DashboardViewModelType) {
        self.init()
        
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "KittyTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "kittyCell")
        
        tableView.rx.itemSelected
            .bindTo(viewModel.itemSelected)
            .addDisposableTo(disposeBag)
        
        viewModel.reposObservable
            .bindTo(tableView.rx.items) { tableView, i, item in
                let indexPath = IndexPath(row: i, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: "kittyCell", for: indexPath) as! KittyTableViewCell
                cell.viewModel = item
                
                return cell
            }
            .addDisposableTo(disposeBag)
        
        viewModel.errorObservable
            .subscribe(onNext: { [weak self] error in
                self?.showAlert("Error", message: error)
            })
            .addDisposableTo(disposeBag)
    }
    
    fileprivate func showAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
}
