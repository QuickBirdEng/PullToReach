//
//  PullToReach.swift
//  PullToReach
//
//  Created by Stefan Kofler on 17.02.19.
//  Copyright © 2019 QuickBird Studios GmbH. All rights reserved.
//

import UIKit

// MARK: - PullToReach

public protocol PullToReach {
    var scrollView: UIScrollView { get }
}

public extension PullToReach {

    func activatePullToReach(affectedTargets: [PullToReachTarget],
                             highlightColor: UIColor = UIColor.black.withAlphaComponent(0.1)) {
        let heavyFeedbackGenerator = UIImpactFeedbackGenerator()
        let lightFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)

        var lastSelectedIndex: Int?

        let observer = PullToReachObserver(scrollView: scrollView) { scrollOffset, didRelease, isTracking in
            guard scrollOffset >= initialIgnoredOffset else {
                lastSelectedIndex = nil

                for target in affectedTargets {
                    target.applyStyle(isHighlighted: false, highlightColor: highlightColor)
                    target.removeHighlight()
                }

                return
            }
            
            let modifiedOffset = scrollOffset - initialIgnoredOffset

            let percent = min(modifiedOffset / maxOffset, 0.99)
            let currentSelectedIndex = Int(percent * CGFloat(affectedTargets.count))

            if didRelease {
                affectedTargets[currentSelectedIndex].callSelector()
                heavyFeedbackGenerator.impactOccurred()
            }

            if lastSelectedIndex != currentSelectedIndex {
                lightFeedbackGenerator.impactOccurred()
                lastSelectedIndex = currentSelectedIndex
            }

            for (index, target) in affectedTargets.enumerated() {
                target.applyStyle(isHighlighted: index == currentSelectedIndex && isTracking, highlightColor: highlightColor)
            }
        }

        objc_setAssociatedObject(self, &AssociatedKeys.observer, observer, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

}

// MARK: - PTRDirection

public enum PTRDirection {
    case leftToRight
    case rightToLeft
}

@available(iOS 11.0, *)
public extension PullToReach {

    func activatePullToReach(on navigationItem: UINavigationItem,
                             direction: PTRDirection = .rightToLeft,
                             highlightColor: UIColor = UIColor.black.withAlphaComponent(0.1)) {
        let barButtonItems: [UIBarButtonItem]

        switch direction {
        case .leftToRight:
            barButtonItems = (navigationItem.leftBarButtonItems ?? []) + (navigationItem.rightBarButtonItems ?? []).reversed()
        case .rightToLeft:
            barButtonItems = (navigationItem.rightBarButtonItems ?? []) + (navigationItem.leftBarButtonItems ?? []).reversed()
        }

        activatePullToReach(affectedTargets: barButtonItems, highlightColor: highlightColor)
    }

}

// MARK: - UITableViewController: PullToReach

public extension PullToReach where Self: UITableViewController {
    var scrollView: UIScrollView {
        return tableView
    }
}

// MARK: Helpers

private struct AssociatedKeys {
    static var observer: UInt8 = 0
}

private let maxOffset: CGFloat = 150
private let initialIgnoredOffset: CGFloat = 30
