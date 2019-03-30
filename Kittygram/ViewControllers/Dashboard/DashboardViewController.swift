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

class DashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var repos = [Repository]()
    var provider = MoyaProvider<GitHub>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "KittyTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "kittyCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        downloadRepositories("ashfurrow")
    }
    
    fileprivate func showAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - API Stuff
    
    func downloadRepositories(_ username: String) {
        provider.request(.userRepositories(username)) { result in
            switch result {
            case let .success(response):
                do {
                    let repos = try response.map(to: Array.self) as [Repository]
                    self.repos = repos
                } catch {
                    
                }
                self.tableView.reloadData()
            case let .failure(error):
                let error = error as CustomStringConvertible
                self.showAlert("GitHub Fetch", message: error.description)
            }
        }
    }
    
    // MARK: - Table View

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kittyCell", for: indexPath) as UITableViewCell
        let repo = repos[indexPath.row]
        cell.textLabel?.text = repo.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = repos[indexPath.row]
        if repo.name != "swift" {
            let viewController = KittyDetailsViewController(kitty: repo)
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            print("Unexpected behavior")
        }
    }
}
