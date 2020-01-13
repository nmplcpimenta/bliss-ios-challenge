//
//  KeyboardPayload.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 13/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import UIKit

struct KeyboardPayload {
    let beginFrame: CGRect
    let endFrame: CGRect
    let curve: UIView.AnimationCurve
    let duration: TimeInterval
    let isLocal: Bool
}

extension KeyboardPayload {
    init(notification: Notification) {
        let userInfo = notification.userInfo
        beginFrame = userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect // swiftlint:disable:this force_cast
        endFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect // swiftlint:disable:this force_cast
        curve = UIView.AnimationCurve(rawValue: userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! Int)! // swiftlint:disable:this force_cast
        duration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval // swiftlint:disable:this force_cast
        isLocal = userInfo?[UIResponder.keyboardIsLocalUserInfoKey] as! Bool // swiftlint:disable:this force_cast
    }
}
