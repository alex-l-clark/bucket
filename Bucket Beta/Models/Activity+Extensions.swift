import Foundation

extension Activity {
    var hasLinks: Bool {
        websiteURL != nil || instagramURL != nil || beliURL != nil
    }
} 