//
//  DashboardViewModel.swift
//  Kittygram
//
//  Created by Lukasz Mroz on 21.10.2016.
//  Copyright © 2016 Sunshinejr. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

final class DashboardViewModel: DashboardViewModelType {
    
    private let error = PublishSubject<String>()
    private let repos = Variable<[(Repository, KittyTableViewModelType)]>([])
    private let provider = MoyaProvider<GitHub>()
    private let disposeBag = DisposeBag()
    
    var kittySelected = PublishSubject<Repository>()
    
    let itemSelected = PublishSubject<IndexPath>()
    
    lazy var errorObservable: Observable<String> = self.error.asObservable()
    lazy var reposObservable: Observable<[KittyTableViewModelType]> = self.repos.asObservable().map { $0.map { $0.1 } }
    
    init() {
        itemSelected
            .map { [weak self] in self?.repos.value[$0.row] }
            .subscribe(onNext: { [weak self] repo in
                guard let `self` = self, let repo = repo else { return }
                `self`.kittySelected
                    .onNext(repo.0)
            })
            .addDisposableTo(disposeBag)
        
        downloadRepositories("apple")
    }
    
    func downloadRepositories(_ username: String) {
        provider.request(.userRepositories(username)) { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case let .success(response):
                do {
                    let repos = try response.mapArray() as [Repository]
                    self.repos.value = repos.map { ($0, KittyTableViewModel(kitty: $0)) }
                    // reload table view
                } catch {
                    self.error.onNext("Parsing error. Try again later.")
                }
            case .failure:
                self.error.onNext("Request error. Try again later.")
            }
        }
    }
}
