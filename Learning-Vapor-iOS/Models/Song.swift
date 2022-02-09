//
//  Song.swift
//  Learning-Vapor-iOS
//
//  Created by Matthew Wylder on 2/9/22.
//

import Foundation

struct Song: Identifiable, Codable {
    let id: UUID?
    let title: String
}
