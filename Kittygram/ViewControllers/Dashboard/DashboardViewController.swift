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
    
    var progressView = UIView()
    var repos = [Repository]()
    var provider = MoyaProvider<GitHub>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "KittyTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "kittyCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        progressView.frame = CGRect(origin: .zero, size: CGSize(width: 0, height: 2))
        progressView.backgroundColor = .blue
        navigationController?.navigationBar.addSubview(progressView)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "zen", style: .plain, target: self, action: #selector(zenWasPressed))
        
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
                    let repos = try response.mapArray() as [Repository]
                    self.repos = repos
                } catch {
                    
                }
                self.tableView.reloadData()
            case let .failure(error):
                guard let error = error as? CustomStringConvertible else {
                    break
                }
                self.showAlert("GitHub Fetch", message: error.description)
            }
        }
    }
    
    func downloadZen() {
        provider.request(.zen) { result in
            var message = "Couldn't access API"
            if case let .success(response) = result {
                let jsonString = try? response.mapString()
                message = jsonString ?? message
            }
            
            self.showAlert("Zen", message: message)
        }
    }
    
    // MARK: - Progress Helpers
    
    lazy var progressClosure: ProgressBlock = { response in
        UIView.animate(withDuration: 0.3) {
            self.progressView.frame.size.width = self.view.frame.size.width * CGFloat(response.progress)
        }
    }
    
    lazy var progressCompletionClosure: Completion = { result in
        let color: UIColor
        switch result {
        case .success:
            color = .green
        case .failure:
            color = .red
        }
        
        UIView.animate(withDuration: 0.3) {
            self.progressView.backgroundColor = color
            self.progressView.frame.size.width = self.view.frame.size.width
        }
        
        UIView.animate(withDuration: 0.3, delay: 1, options: [],
                       animations: {
                            self.progressView.alpha = 0
                        }, completion: { _ in
                            self.progressView.backgroundColor = .blue
                            self.progressView.frame.size.width = 0
                            self.progressView.alpha = 1
                        }
        )
    }
    
    // MARK: - Actions
    
    func searchWasPressed(_ sender: UIBarButtonItem) {
        var usernameTextField: UITextField?
        
        let promptController = UIAlertController(title: "Username", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { action in
            if let username = usernameTextField?.text {
                self.downloadRepositories(username)
            }
        }
        promptController.addAction(ok)
        promptController.addTextField { textField in
            usernameTextField = textField
        }
        present(promptController, animated: true, completion: nil)
    }
    
    func zenWasPressed(_ sender: UIBarButtonItem) {
        downloadZen()
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
