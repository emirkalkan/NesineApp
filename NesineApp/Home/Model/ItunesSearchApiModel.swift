//
//  ItunesSearchApiModel.swift
//  NesineApp
//
//  Created by Emir Kalkan on 19.12.2022.
//

import Foundation

// MARK: - ItunesSearchApiModel

struct ItunesSearchApiModel: Codable {
    let resultCount: Int?
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let screenshotUrls: [String]?

    enum CodingKeys: String, CodingKey {
        case screenshotUrls
    }
}
