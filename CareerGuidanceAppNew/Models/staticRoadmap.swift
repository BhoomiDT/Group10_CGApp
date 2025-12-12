//
//  staticRoadmap.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 02/12/25.
//

import Foundation
import UIKit

struct Milestone: Codable {
    let title: String
    let subtitle: String
    let iconName: String
    let iconColor: String
    let iconBackgroundColor: String
}

struct StaticRoadmap: Codable {
    let title: String
    let description: String
    let imageName: String?
    let modules: [Module]?
    let milestones: [Milestone]
}

