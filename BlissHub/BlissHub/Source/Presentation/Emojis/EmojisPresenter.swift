//
//  EmojisPresenter.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import RxSwift

protocol EmojisPresenterContract: PresenterContract {
    
    var view: EmojisViewControllerContract? { get set }
    
    func getRandomEmoji()
    func getEmojis() -> Completable
    func deleteEmoji(index: Int)
}

class EmojisPresenter: EmojisPresenterContract {
    
    var view: EmojisViewControllerContract? {
        didSet {
            setupBinding()
        }
    }
    
    let interactor: EmojisInteractorContract
    let randomEmoji: PublishSubject<EmojiViewModel> = PublishSubject()
    var randomEmojiMemoryBackup: EmojiViewModel?
    let emojis: PublishSubject<[EmojiViewModel]> = PublishSubject()
    var emojiMemoryBackup: [EmojiViewModel] = []
    
    private let disposeBag = DisposeBag()
    
    init(interactor: EmojisInteractorContract) {
        
        self.interactor = interactor
    }
    
    private func setupBinding() {
        if let view = view {
            emojis
                .observeOn(MainScheduler.instance)
                .bind(to: view.emojis)
                .disposed(by: disposeBag)
            
            randomEmoji
                .observeOn(MainScheduler.instance)
                .bind(to: view.randomEmoji)
                .disposed(by: disposeBag)
        }
    }
}

extension EmojisPresenter {
    
    func getRandomEmoji() {
        if emojiMemoryBackup.count > 0 {
            let randomIdx: Int = Int.random(in: 0..<emojiMemoryBackup.count)
            let emoji: EmojiViewModel = emojiMemoryBackup[randomIdx]
            
            randomEmojiMemoryBackup = emoji
            
            randomEmoji.onNext(emoji)
        }
    }
    
    func getEmojis() -> Completable {
        return Completable.create { [unowned self] completable in
            
            _ = self.interactor.getEmojis().subscribe(
                onSuccess: { [unowned self] (emojiList) in
                
                    self.updateEmojis(emojiList: emojiList)
                    
                    completable(.completed)
            }, onError: { error in
                print(error.localizedDescription)
                completable(.error(error))
            })
            
            return Disposables.create()
        }
    }
    
    func deleteEmoji(index: Int) {
        
        let emojiToDelete = emojiMemoryBackup[index]
        
        emojiMemoryBackup.remove(at: index)
        
        emojis.onNext(emojiMemoryBackup)
        
        // If removing the current random emoji on screen, get another random emoji
        if let randomEmojiMemoryBackup = randomEmojiMemoryBackup,
            emojiToDelete.name == randomEmojiMemoryBackup.name {
            
            getRandomEmoji()
        }
    }
}

extension EmojisPresenter {
    
    private func updateEmojis(emojiList: [EmojiModel]) {
        
        let emojiViewList = emojiList.map { EmojiViewModel(fromModel: $0) }
        
        emojiMemoryBackup = emojiViewList
        
        emojis.onNext(emojiViewList)
        
        // Update random emoji
        getRandomEmoji()
    }
}
