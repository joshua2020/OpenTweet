//
//  Timeline.swift
//  NotTwitter
//
//  Created by Joshua on 11/12/2022.
//

import Foundation

// MARK: - Welcome
struct Timelines: Codable {
    let timeline: [Timeline]
}

// MARK: - Timeline
struct Timeline: Codable {
    let id, author, content: String
    let avatar: String?
    let date: Date
    let inReplyTo: String?
}
