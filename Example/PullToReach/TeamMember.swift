//
//  TeamMember.swift
//  PullToReach_Example
//
//  Created by Paul Kraft on 14.05.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit.UIImage

struct TeamMember {

    // MARK: - Stored properties

    let firstName: String
    let lastName: String
    let imageName: String

    // MARK: - Computed properties

    var email: String {
        return "\(firstName.lowercased()).\(lastName.lowercased())@quickbirdstudios.com"
    }

    var image: UIImage? {
        return UIImage(named: imageName)
    }

}
