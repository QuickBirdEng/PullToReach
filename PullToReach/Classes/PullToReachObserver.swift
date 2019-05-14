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

    // MARK: - Stored properties

    private let scrollOffsetChanged: (CGFloat, Bool, Bool) -> Void
    private let scrollView: UIScrollView

    private var lastOffset: CGFloat = 0
    private var wasTracking: Bool = false

    // MARK: - Init

    init(scrollView: UIScrollView, scrollOffsetChanged: @escaping (CGFloat, Bool, Bool) -> Void) {
        self.scrollOffsetChanged = scrollOffsetChanged
        self.scrollView = scrollView

        super.init()

        scrollView.addObserver(self, forKeyPath: #keyPath(UIScrollView.contentOffset), options: .new, context: nil)
    }

    deinit {
        scrollView.removeObserver(self, forKeyPath: #keyPath(UIScrollView.contentOffset))
    }

    // MARK: - Overrides

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let scrollView = object as? UIScrollView else { return }

        if keyPath == #keyPath(UIScrollView.contentOffset) {
            let scrollOffset = -(scrollView.contentOffset.y + scrollView.adjustedContentInset.top)

            if wasTracking && !scrollView.isTracking {
                self.scrollOffsetChanged(lastOffset, true, false)
            } else {
                self.scrollOffsetChanged(scrollOffset, false, scrollView.isTracking)
            }

            self.lastOffset = scrollOffset
            self.wasTracking = scrollView.isTracking
        }
    }

}
