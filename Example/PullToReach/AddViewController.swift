//
//  AddViewController.swift
//  PullToReach
//
//  Created by Stefan Kofler on 17.02.19.
//  Copyright © 2019 QuickBird Studios GmbH. All rights reserved.
//

import UIKit
import PullToReach

class AddViewController: UITableViewController, PullToReach {

    private lazy var refreshBarButtonItem = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(closeView))

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add new item"
        self.view.backgroundColor = .white
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always

        self.navigationItem.rightBarButtonItems = [refreshBarButtonItem]

        self.activatePullToReach(on: navigationItem, highlightColor: UIColor.red.withAlphaComponent(0.25))
    }

    // MARK: Button actions

    @objc func closeView() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

}
