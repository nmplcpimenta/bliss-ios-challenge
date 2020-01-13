//
//  NotificationDescriptor.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 13/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import UIKit

struct NotificationDescriptor<Payload> {
    let name: Notification.Name
    let convert: (Notification) -> Payload
}

final class NotificationToken {
    private let token: NSObjectProtocol
    private let notificationCenter: NotificationCenter
    
    init(token: NSObjectProtocol, notificationCenter: NotificationCenter) {
        self.token = token
        self.notificationCenter = notificationCenter
    }
    
    deinit {
        notificationCenter.removeObserver(token)
    }
}

extension NotificationCenter {
    func addObserver<Payload>(with descriptor: NotificationDescriptor<Payload>, block: @escaping (Payload) -> Void) -> NotificationToken {
        let token = addObserver(forName: descriptor.name, object: nil, queue: nil) { (note) in
            block(descriptor.convert(note))
        }
        
        return NotificationToken(token: token, notificationCenter: self)
    }
}

extension UIViewController {
    static let keyboardWillShow = NotificationDescriptor(name: UIResponder.keyboardWillShowNotification, convert: KeyboardPayload.init)
    static let keyboardWillHide = NotificationDescriptor(name: UIResponder.keyboardWillHideNotification, convert: KeyboardPayload.init)
}
