//
//  TeamMemberDataSource.swift
//  PullToReach
//
//  Created by Stefan Kofler on 17.02.19.
//  Copyright © 2019 QuickBird Studios GmbH. All rights reserved.
//

import UIKit

private let allTeamMembers = [
    TeamMember(firstName: "Stefan", lastName: "Kofler", imageName: "Stefan_Kofler"),
    TeamMember(firstName: "Malte", lastName: "Bucksch", imageName: "Malte_Bucksch"),
    TeamMember(firstName: "Sebastian", lastName: "Sellmair", imageName: "Sebastian_Sellmair"),
    TeamMember(firstName: "Julian", lastName: "Bissekkou", imageName: "Julian_Bissekkou"),
    TeamMember(firstName: "Klaus", lastName: "Niedermair", imageName: "Klaus_Niedermair"),
    TeamMember(firstName: "Ghulam", lastName: "Nasir", imageName: "Ghulam_Nasir"),
    TeamMember(firstName: "Nikolaos", lastName: "Tzioras", imageName: "Nikolaos_Tzioras"),
    TeamMember(firstName: "Mathias", lastName: "Quintero", imageName: "Mathias_Quintero"),
    TeamMember(firstName: "Michael", lastName: "Schlicker", imageName: "Michael_Schlicker"),
    TeamMember(firstName: "Patrick", lastName: "Sattler", imageName: "Patrick_Sattler"),
    TeamMember(firstName: "Paul", lastName: "Kraft", imageName: "Paul_Kraft"),
    TeamMember(firstName: "Balazs", lastName: "Toth", imageName: "Balazs_Toth"),
    TeamMember(firstName: "Lizzie", lastName: "Studeneer", imageName: "Lizzie_Studeneer"),

]

class TeamMembersDataSource: NSObject, UITableViewDataSource {

    // MARK: - Stored properties

    private let teamMembers = allTeamMembers.shuffled()

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamMembers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let teamMember = teamMembers[indexPath.row]

        cell.textLabel?.text = "\(teamMember.firstName) \(teamMember.lastName)"
        cell.detailTextLabel?.text = teamMember.email
        cell.imageView?.image = teamMember.image
        cell.accessoryType = .disclosureIndicator

        return cell
    }

}
