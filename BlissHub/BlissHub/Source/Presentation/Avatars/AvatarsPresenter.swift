//
//  AvatarsPresenter.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import RxSwift

protocol AvatarsPresenterContract: PresenterContract {
    
    var view: AvatarsViewControllerContract? { get set }
    
    func getUser(username: String)
    func getAvatars()
    func deleteAvatar(index: Int)
}

class AvatarsPresenter: AvatarsPresenterContract {
    
    var view: AvatarsViewControllerContract? {
        didSet {
            setupBinding()
        }
    }
    
    let interactor: AvatarsInteractorContract
    let avatars: PublishSubject<[AvatarViewModel]> = PublishSubject()
    var avatarMemoryBackup: [AvatarViewModel] = []
    
    private let disposeBag = DisposeBag()
    
    init(interactor: AvatarsInteractorContract) {
        
        self.interactor = interactor
    }
    
    private func setupBinding() {
        
        if let view = view {
            avatars
                .observeOn(MainScheduler.instance)
                .bind(to: view.avatars)
                .disposed(by: disposeBag)
        }
    }
}

extension AvatarsPresenter {
    
    func getUser(username: String) {
        
        let username = username.lowercased()
        
        interactor.getUser(username: username).subscribe(
            onSuccess: { [unowned self] wasUserFound in
                
                if wasUserFound {
                    self.getAvatars()
                }
        }, onError: { error in
            // Error handling
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    func getAvatars() {
        
        interactor.getAvatars().subscribe(
            onSuccess: { avatarModelList in
                
                let avatarModelList = avatarModelList.sorted { (avatarFirst, avatarSecond) in
                    return avatarFirst.username < avatarSecond.username
                }
                
                self.updateAvatars(avatarList: avatarModelList)
        }, onError: { error in
            // Error handling
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    func deleteAvatar(index: Int) {
        
        let avatarToDelete = avatarMemoryBackup[index].toModel()
        
        interactor.deleteAvatar(avatar: avatarToDelete).subscribe(
            onCompleted: {
                
                self.getAvatars()
        }, onError: { error in
            // Error handling
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}

extension AvatarsPresenter {
    
    private func updateAvatars(avatarList: [AvatarModel]) {
        
        let avatarViewList = avatarList.map { AvatarViewModel(fromModel: $0) }
        
        avatarMemoryBackup = avatarViewList
        
        avatars.onNext(avatarViewList)
    }
}
