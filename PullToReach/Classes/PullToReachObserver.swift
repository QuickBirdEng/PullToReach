//
//  PullToReachObserver.swift
//  PullToReach
//
//  Created by Stefan Kofler on 17.02.19.
//  Copyright © 2019 QuickBird Studios GmbH. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
class PullToReachObserver: NSObject {

    private var scrollOffsetChanged: ((CGFloat, Bool, Bool) -> Void)!
    private var scrollView: UIScrollView!

    private var lastOffset: CGFloat = 0
    private var wasTracking: Bool = false

    init(scrollView: UIScrollView, scrollOffsetChanged: @escaping (CGFloat, Bool, Bool) -> Void) {
        super.init()

        self.scrollOffsetChanged = scrollOffsetChanged
        self.scrollView = scrollView

        scrollView.addObserver(self, forKeyPath: #keyPath(UIScrollView.contentOffset), options: .new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let scrollView = object as? UIScrollView else { return }

        if keyPath == #keyPath(UIScrollView.contentOffset) {
            let scrollOffset = -(scrollView.contentOffset.y + scrollView.adjustedContentInset.top)

            if wasTracking && !scrollView.isTracking {
                self.scrollOffsetChanged?(lastOffset, true, false)
            } else {
                self.scrollOffsetChanged?(scrollOffset, false, scrollView.isTracking)
            }

            self.lastOffset = scrollOffset
            self.wasTracking = scrollView.isTracking
        }
    }

    deinit {
        scrollView.removeObserver(self, forKeyPath: #keyPath(UIScrollView.contentOffset))
    }

}
