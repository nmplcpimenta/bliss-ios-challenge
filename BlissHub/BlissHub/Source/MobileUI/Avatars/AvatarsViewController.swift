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
    @IBOutlet weak var constraintBottom: NSLayoutConstraint!
    
    var avatars = PublishSubject<[AvatarViewModel]>()
    
    private let disposeBag = DisposeBag()
    
    private var notificationTokens: [NotificationToken] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupScene()
        
        setupUI()
        
        setupBinding()
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unregisterKeyboardNotifications()
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(sender:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
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
    
    @objc
    func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // MARK: - Keyboard Observations
    func registerKeyboardNotifications() {
        let center = NotificationCenter.default
        
        let keyboardWillShowToken = center.addObserver(with: UIViewController.keyboardWillShow) { (payload) in
            self.keyboardWillShow(payload: payload)
        }
        notificationTokens.append(keyboardWillShowToken)
        
        let keyboardWillHideToken = center.addObserver(with: UIViewController.keyboardWillHide) { _ in
            self.keyboardWillHide()
        }
        notificationTokens.append(keyboardWillHideToken)
    }
    
    func unregisterKeyboardNotifications() {
        notificationTokens.removeAll()
    }
    
    func keyboardWillShow(payload: KeyboardPayload) {
        constraintBottom.constant = payload.endFrame.height
    }
    
    func keyboardWillHide() {
        constraintBottom.constant = 0
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

extension AvatarsViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: avatarsCollectionView) ?? false {
            
            view.endEditing(true)
            
            return false
        }
        
        return true
    }
}
