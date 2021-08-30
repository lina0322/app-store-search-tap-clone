import Foundation

struct TestModel: Codable {
    let resultCount: Int
    let results: [Results]
}

struct Results: Codable {
    let ipadScreenshotUrls: [String]
//    let appletvScreenshotUrls: [Any?]
    let artworkUrl60, artworkUrl512, artworkUrl100: String
    let artistViewURL: String
    let screenshotUrls: [String]
    let supportedDevices, advisories: [String]
    let isGameCenterEnabled: Bool
//    let features: [Feature]
//    let kind: Kind
    let minimumOSVersion, trackCensoredName: String
    let languageCodesISO2A: [String]
    let fileSizeBytes: String
    let sellerURL: String?
//    let formattedPrice: FormattedPrice
//    let contentAdvisoryRating: Rating
    let averageUserRatingForCurrentVersion: Double
    let userRatingCountForCurrentVersion: Int
    let averageUserRating: Double
    let trackViewURL: String
//    let trackContentRating: Rating
    let genreIDS: [String]
    let trackID: Int
    let trackName: String
    let releaseDate: Date
    let sellerName, primaryGenreName: String
    let isVppDeviceBasedLicensingEnabled: Bool
    let currentVersionReleaseDate: Date
    let releaseNotes: String
    let primaryGenreID: Int
//    let currency: Currency
    let resultDescription: String
    let artistID: Int
    let artistName: String
    let genres: [String]
    let price: Double
    let bundleID, version: String
//    let wrapperType: Kind
    let userRatingCount: Int
}

enum Rating {
    case the12
    case the17
    case the4
    case the9
}

enum Currency {
    case krw
}

enum Feature {
    case gameCenter
    case iosUniversal
}

enum FormattedPrice {
    case the1200
    case the2500
    case 무료
}

enum Kind {
    case software
}

