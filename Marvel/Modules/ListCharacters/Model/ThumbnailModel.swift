

import Foundation
struct ThumbnailModel : Codable {
	let path : String?
    let extensionImage : String?
    enum CodingKeys: String, CodingKey {

        case extensionImage = "extension"
        case path = "path"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        extensionImage = try values.decodeIfPresent(String.self, forKey: .extensionImage)
        path = try values.decodeIfPresent(String.self, forKey: .path)
}
}
