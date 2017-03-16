//
//  KittyDetailsViewController.swift
//  Kittygram
//
//  Created by Lukasz Mroz on 21.10.2016.
//  Copyright © 2016 Sunshinejr. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class KittyDetailsViewController: UIViewController {

    var kittyDetailsViewModel: KittyDetailsViewModel!
    let disposeBag = DisposeBag()
    
    convenience init(kitty: Repository) {
        self.init()
        self.kittyDetailsViewModel = KittyDetailsViewModel(repository: kitty)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRx()
    }
    
    private func setUpRx() {
        kittyDetailsViewModel
            .language
            .bindTo(self.navigationItem.rx.title)
            .addDisposableTo(disposeBag)
    }
}
