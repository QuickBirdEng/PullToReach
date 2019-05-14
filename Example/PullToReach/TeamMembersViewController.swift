//
//  MainViewController.swift
//  PullToReach
//
//  Created by Stefan Kofler on 17.02.19.
//  Copyright © 2019 QuickBird Studios GmbH. All rights reserved.
//

import PullToReach
import UIKit

class TeamMembersViewController: UITableViewController, PullToReach {

    private let searchController = UISearchController(searchResultsController: nil)
    private var dataSource = TeamMembersDataSource()

    private lazy var addBarButtonItem = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(addItem))
    private lazy var searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(searchItems))
    private lazy var refreshBarButtonItem = UIBarButtonItem(image: UIImage(named: "refresh"), style: .plain, target: self, action: #selector(reloadItems))

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Team members"
        self.view.backgroundColor = .white

        self.tableView.tableHeaderView = searchController.searchBar
        self.tableView.dataSource = dataSource

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always

        self.navigationItem.rightBarButtonItems = [
            addBarButtonItem,
            searchBarButtonItem,
            refreshBarButtonItem
        ]

        self.activatePullToReach(on: navigationItem)
    }

    // MARK: Button actions

    @objc func addItem() {
        let addViewController = AddViewController()
        let navigationController = UINavigationController(rootViewController: addViewController)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }

    @objc func searchItems() {
        searchController.searchBar.becomeFirstResponder()
    }

    @objc func reloadItems() {
        let barButtonItem = self.navigationItem.rightBarButtonItems?[2]
        guard let view = barButtonItem?.value(forKey: "view") as? UIView else { return }

        view.transform = CGAffineTransform(rotationAngle: CGFloat())

        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2.0)
        rotationAnimation.duration = 0.6
        rotationAnimation.repeatCount = 2.0

        view.layer.add(rotationAnimation, forKey: "rotationAnimation")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            self?.dataSource = TeamMembersDataSource()
            self?.tableView.dataSource = self?.dataSource
            self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }

}

// MARK: - UITableViewDelegate

extension TeamMembersViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileViewController = ProfileViewController()
        self.navigationController?.pushViewController(profileViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
