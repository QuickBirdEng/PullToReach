//
//  PullToReach.swift
//  PullToReach
//
//  Created by Stefan Kofler on 17.02.19.
//  Copyright © 2019 QuickBird Studios GmbH. All rights reserved.
//

import UIKit

struct AssociatedKeys {
    static var observer: UInt8 = 0
}

private let maxOffset: CGFloat = 150
private let initialIgnoredOffset: CGFloat = 30

public protocol PullToReach {
    var scrollView: UIScrollView { get }
}

@available(iOS 11.0, *)
public extension PullToReach {

    func activatePullToReach(affectedTargets: [PullToReachTarget],
                             highlightColor: UIColor = UIColor.black.withAlphaComponent(0.1)) {
        let heavyFeedbackGenerator = UIImpactFeedbackGenerator()
        let lightFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)

        var lastSelection: Int = -1

        let observer = PullToReachObserver(scrollView: scrollView) { scrollOffset, didRelease, isTracking in
            guard scrollOffset >= initialIgnoredOffset else {
                lastSelection = -1
                for target in affectedTargets {
                    target.resetStyle()
                    target.applyStyle(isHighlighted: false, highlightColor: highlightColor)
                }
                return
            }
            let modifiedOffset = scrollOffset - initialIgnoredOffset

            let percent = min(modifiedOffset / maxOffset, 0.99)
            let currentSelection = Int(percent * CGFloat(affectedTargets.count))

            if didRelease {
                affectedTargets[currentSelection].callSelector()
                heavyFeedbackGenerator.impactOccurred()
            }

            if lastSelection != currentSelection {
                lightFeedbackGenerator.impactOccurred()
                lastSelection = currentSelection
            }

            for (index, target) in affectedTargets.enumerated() {
                target.applyStyle(isHighlighted: index == currentSelection && isTracking, highlightColor: highlightColor)
            }
        }

        objc_setAssociatedObject(self, &AssociatedKeys.observer, observer, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

}

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
            barButtonItems = (navigationItem.leftBarButtonItems ?? []) + (navigationItem.rightBarButtonItems ?? [])
        case .rightToLeft:
            barButtonItems = (navigationItem.rightBarButtonItems ?? []) + (navigationItem.leftBarButtonItems ?? [])
        }

        activatePullToReach(affectedTargets: barButtonItems, highlightColor: highlightColor)
    }

}

public extension PullToReach where Self: UITableViewController {
    var scrollView: UIScrollView {
        return tableView
    }
}
