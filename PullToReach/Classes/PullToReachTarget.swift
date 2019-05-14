//
//  PullToReachTarget.swift
//  PullToReach
//
//  Created by Stefan Kofler on 17.02.19.
//  Copyright © 2019 QuickBird Studios GmbH. All rights reserved.
//

import UIKit

// MARK: - PullToReachTarget

public protocol PullToReachTarget {
    func callSelector()
    func applyStyle(isHighlighted: Bool, highlightColor: UIColor)
    func removeHighlight()
}

// MARK: - UIBarButtonItem: PullToReachTarget

extension UIBarButtonItem: PullToReachTarget {

    public func callSelector() {
        if let actionSelector = self.action {
            _ = self.target?.perform(actionSelector)
        }
    }

    public func removeHighlight() {
        removeSelectionIndicatorView()
    }

    @objc
    open func applyStyle(isHighlighted: Bool, highlightColor: UIColor) {
        guard let view = self.value(forKey: "view") as? UIView else { return }
        guard let selectionIndicator = addSelectionIndicatorView() else { return }
        guard let navigationBar = view.firstSuperview(ofType: UINavigationBar.self) else { return }

        let scale: CGFloat = isHighlighted ? 1.25 : 1.0
        let selectionIndicatorSize: CGFloat = view.bounds.height * 1.2

        selectionIndicator.layer.cornerRadius = selectionIndicatorSize / 2.0
        selectionIndicator.bounds.size = CGSize(width: selectionIndicatorSize, height: selectionIndicatorSize)

        guard let nestedView = view.subviews.first else { return }
        let targetPosition1 = view.convert(nestedView.center, to: navigationBar)
        let targetPosition2 = view.superview?.convert(view.center, to: navigationBar) ?? .zero
        let targetPosition = CGPoint(x: (targetPosition1.x + targetPosition2.x) / 2.0,
                                     y: (targetPosition1.y + targetPosition2.y) / 2.0)

        if selectionIndicator.center == .zero {
            selectionIndicator.center = targetPosition
        }

        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.5, options: [], animations: {
            view.transform = CGAffineTransform(scaleX: scale, y: scale)

            if isHighlighted {
                selectionIndicator.backgroundColor = highlightColor
                selectionIndicator.center = targetPosition
                selectionIndicator.transform = .identity
            }
        }, completion: nil)
    }

    private func removeSelectionIndicatorView() {
        guard let view = self.value(forKey: "view") as? UIView else { return }
        guard let navigationBar = view.firstSuperview(ofType: UINavigationBar.self) else { return }
        navigationBar.firstSubview(ofType: SelectionIndicatorView.self)?.removeFromSuperview()
    }

    private func addSelectionIndicatorView() -> UIView? {
        guard let view = self.value(forKey: "view") as? UIView else { return nil }
        guard let navigationBar = view.firstSuperview(ofType: UINavigationBar.self) else { return nil }

        if let selectionIndicator = navigationBar.firstSubview(ofType: SelectionIndicatorView.self) {
            return selectionIndicator
        } else {
            let selectionIndicator = SelectionIndicatorView()
            selectionIndicator.clipsToBounds = true
            navigationBar.insertSubview(selectionIndicator, at: 1)
            return selectionIndicator
        }
    }

}

// MARK: - UIControl: PullToReachTarget

extension UIControl: PullToReachTarget {

    public func callSelector() {
        let callees = allTargets.flatMap { target -> [(NSObject, String)] in
            actions(forTarget: target as NSObject, forControlEvent: .touchUpInside)?
                .map { (target as NSObject, $0) } ?? []
        }

        for (target, selector) in callees {
            target.perform(NSSelectorFromString(selector))
        }
    }

    public func removeHighlight() {}

    @objc
    open func applyStyle(isHighlighted: Bool, highlightColor: UIColor) {
        let scale: CGFloat = isHighlighted ? 2.25 : 1.0
        self.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
}
