// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

import Foundation

// MARK: - Welcome
struct NewsModel: Decodable {
    let status: String?
    let totalResults: Int?
    let results: [News]?
    let nextPage: String?
}

// MARK: - Result
struct News: Decodable {
    let title, link, description, pubDate: String?
    let imageURL: String?
    let sourceID: String?
    let sourceIcon: String?
    let language: Language?
    let category: [Category]?
    let sourceURL: String?
    let country: [String]?

    enum CodingKeys: String, CodingKey {
        case title, link, description, pubDate, imageURL = "image_url", sourceID = "source_id", sourceIcon = "source_icon"
        case language, category, sourceURL = "source_url", country
    }
}

enum Category: String, Decodable {
    case politics = "politics"
}

enum Language: String, Decodable {
    case english = "english"
    case french = "french"
    case turkish = "turkish"
}
