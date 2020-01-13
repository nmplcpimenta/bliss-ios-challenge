//
//  AppleReposViewController.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol AppleReposViewControllerContract {
    
    var appleRepos: PublishSubject<[AppleRepoViewModel]> { get set }
}

class AppleReposViewController: UIViewController, AppleReposViewControllerContract {
    
    var presenter: AppleReposPresenterContract?
    
    @IBOutlet weak var appleReposTableView: UITableView!
    
    var appleRepos = PublishSubject<[AppleRepoViewModel]>()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupScene()
        
        setupUI()
        
        setupBinding()
        
        loadData()
    }
    
    private func setupScene() {
        
        if let pre = Scene.appleRepos.configure() as? AppleReposPresenterContract {
            presenter = pre
            presenter?.view = self
        } else {
            fatalError(AppStrings.presenterInitErrorAppleRepos)
        }
    }
    
    private func setupUI() {
        
        appleReposTableView.delegate = self
    }
    
    private func setupBinding() {
        
        appleRepos.bind(to: appleReposTableView.rx.items(cellIdentifier: AppleReposTableViewCell.identifier, cellType: AppleReposTableViewCell.self)) { (_, appleRepo, cell) in
                
                cell.appleRepo = appleRepo
        }.disposed(by: disposeBag)
    }
    
    private func loadData() {
        
        loadNextPage()
    }
    
    private func loadNextPage() {
        presenter?.loadNextPage()
    }
}

extension AppleReposViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isNearBottomEdge() {
            loadNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
