//
//  AppleReposPresenter.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import RxSwift

protocol AppleReposPresenterContract: PresenterContract {
    
    var view: AppleReposViewControllerContract? { get set }
    
    func loadNextPage()
}

class AppleReposPresenter: AppleReposPresenterContract {
    
    let interactor: AppleReposInteractorContract
    
    var view: AppleReposViewControllerContract? {
           didSet {
               setupBinding()
           }
       }
    
    private let disposeBag = DisposeBag()
    
    var currentPage: Int = 0
    var isLoading: Bool = false
    
    let appleRepos: PublishSubject<[AppleRepoViewModel]> = PublishSubject()
    var appleReposMemoryBackup: [AppleRepoViewModel] = []
    
    init(interactor: AppleReposInteractorContract) {
        
        self.interactor = interactor
    }
    
    private func setupBinding() {
        if let view = view {
            appleRepos
                .observeOn(MainScheduler.instance)
                .bind(to: view.appleRepos)
                .disposed(by: disposeBag)
        }
    }
}

extension AppleReposPresenter {
    
    func loadNextPage() {
        
        if !isLoading {
            isLoading = true
            let nextPage = currentPage + 1
            
            interactor.getAppleReposPage(page: nextPage).subscribe(
                onSuccess: { appleRepoModelList in
                    if let appleRepoModelList = appleRepoModelList {
                        
                        self.currentPage += 1
                        
                        self.updateAppleRepos(appleRepoList: appleRepoModelList)
                        
                        self.isLoading = false
                    }
            }, onError: { error in
                print(error.localizedDescription)
                
                self.isLoading = false
            }).disposed(by: disposeBag)
        }
    }
}

extension AppleReposPresenter {
    
    private func updateAppleRepos(appleRepoList: [AppleRepoModel]) {
        
        let appleRepoViewList = appleRepoList.map { AppleRepoViewModel(fromModel: $0) }
        
        appleReposMemoryBackup.append(contentsOf: appleRepoViewList)
        
        appleRepos.onNext(appleReposMemoryBackup)
    }
}
