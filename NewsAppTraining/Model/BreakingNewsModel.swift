import Foundation

// MARK: - BreakingNewsModel
struct BreakingNewsModel: Decodable {
    let status: String
    let totalResults: Int
    let results: [BreakingNews]
    let nextPage: String
}

// MARK: - News
struct BreakingNews: Decodable {
    let title: String?
    let link: String?
    let keywords, creator: [String]?
    let description: String?
    let pubDate: String?
    let imageURL: String?
    let sourceID: String?
    let sourceIcon: String?
    let category: [Categories]
    
    enum CodingKeys: String, CodingKey {
        case title, link, keywords, creator
        case description, pubDate
        case imageURL = "image_url"
        case sourceID = "source_id"
        case sourceIcon = "source_icon"
        case category
    }
}

enum Categories: String, Codable {
    case business = "business"
    case top = "top"
    case world = "world"
}

