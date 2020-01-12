//
//  EmojisViewController.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 10/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol EmojisViewControllerContract {
    
    var emojis: PublishSubject<[EmojiViewModel]> { get set }
    var randomEmoji: PublishSubject<EmojiViewModel> { get set }
}

class EmojisViewController: UIViewController, EmojisViewControllerContract {

    var presenter: EmojisPresenterContract?
    
    @IBOutlet weak var emojisCollection: UICollectionView!
    @IBOutlet weak var randomEmojiImage: UIImageView!
    
    var emojis = PublishSubject<[EmojiViewModel]>()
    var randomEmoji = PublishSubject<EmojiViewModel>()
    
    private let disposeBag = DisposeBag()
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupScene()
        
        setupUI()
        
        setupBinding()
        
        loadData()
    }
    
    private func setupScene() {
        if let pre = Scene.emojis.configure() as? EmojisPresenterContract {
            presenter = pre
            presenter?.view = self
        } else {
            fatalError("Unable to initialize presenter for Emojis module")
        }
    }
    
    private func setupUI() {
        emojisCollection.delegate = self
        
        refreshControl.addTarget(self, action: #selector(refreshEmojis(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            emojisCollection.refreshControl = refreshControl
        } else {
            emojisCollection.addSubview(refreshControl)
        }
    }
    
    private func setupBinding() {
        emojis.bind(to: emojisCollection.rx.items(
            cellIdentifier: "EmojisCollectionViewCell",
            cellType: EmojisCollectionViewCell.self)) { (_, emoji, cell) in
            
                cell.emoji = emoji
        }.disposed(by: disposeBag)
        
        _ = randomEmoji.subscribe { [unowned self] event in
            switch event {
            case .next(let emojiViewModel):
                self.randomEmojiImage.kf.setImage(with: URL(string: emojiViewModel.url))
            default: break
            }
        }
    }
    
    private func loadData() {
        loadEmojis()
    }
    
    @objc
    private func refreshEmojis(_ sender: Any) {
        loadEmojis(refreshing: true)
    }
    
    private func loadEmojis(refreshing: Bool = false) {
        _ = presenter?.getEmojis().subscribe(onCompleted: { [unowned self] in
            if refreshing {
                self.refreshControl.endRefreshing()
            }
        }, onError: { _ in
            // Something...
        })
    }
    
    @IBAction func didPressRandomizeButton(_ sender: UIButton) {
        presenter?.getRandomEmoji()
    }
}

extension EmojisViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        presenter?.deleteEmoji(index: indexPath.item)
    }
}
