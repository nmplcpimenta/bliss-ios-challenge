//
//  AvatarsViewController.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol AvatarsViewControllerContract {
    
    var avatars: PublishSubject<[AvatarViewModel]> { get set }
}

class AvatarsViewController: UIViewController, AvatarsViewControllerContract {
    
    var presenter: AvatarsPresenterContract?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var avatarsCollectionView: UICollectionView!
    
    var avatars = PublishSubject<[AvatarViewModel]>()
    
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
        
        if let pre = Scene.avatars.configure() as? AvatarsPresenterContract {
            presenter = pre
            presenter?.view = self
        } else {
            fatalError("Unable to initialize presenter for Avatars module")
        }
    }
    
    private func setupUI() {
        searchBar.delegate = self
        searchBar.placeholder = "username"
        searchBar.searchBarStyle = .minimal
        
        avatarsCollectionView.delegate = self
    }
    
    private func setupBinding() {
        avatars.bind(to: avatarsCollectionView.rx.items(
            cellIdentifier: AvatarsCollectionViewCell.identifier,
            cellType: AvatarsCollectionViewCell.self)) { (_, avatar, cell) in
                cell.avatar = avatar
        }.disposed(by: disposeBag)
    }
    
    private func loadData() {
        loadAvatars()
    }
    
    private func loadAvatars() {
        presenter?.getAvatars()
    }
}

extension AvatarsViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        presenter?.deleteAvatar(index: indexPath.item)
    }
}

extension AvatarsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text != "" {
            presenter?.getUser(username: text)
        }
    }
}
