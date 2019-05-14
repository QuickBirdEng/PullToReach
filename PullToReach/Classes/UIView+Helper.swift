//
//  UIView+Helper.swift
//  PullToReach
//
//  Created by Stefan Kofler on 17.02.19.
//  Copyright © 2019 QuickBird Studios GmbH. All rights reserved.
//

import UIKit

extension UIView {

    func firstSuperview<T>(ofType type: T.Type) -> T? {
        guard let superview = superview else { return nil }

        if let correctSuperview = superview as? T {
            return correctSuperview
        } else {
            return superview.firstSuperview(ofType: type)
        }
    }

    func firstSubview<T>(ofType type: T.Type) -> T? {
        if let self = self as? T { return self }

        for subview in subviews {
            if let firstSubview = subview.firstSubview(ofType: T.self) {
                return firstSubview
            }
        }

        return nil
    }

}
