import Foundation
import RDCCore

enum HomesLocalization {
    static var statusForSale: LocalizedString { .homes("status_for_sale") }
    static var statusForRent: LocalizedString { .homes("status_for_rent") }
    
    static func status(_ value: String) -> LocalizedString {
        .homes("status", args: value)
    }
}

extension LocalizedString {
    static var homes: HomesLocalization.Type { HomesLocalization.self }
    
    fileprivate static func homes(_ key: String) -> LocalizedString {
        LocalizedString(key: key, bundle: .module)
    }
    
    fileprivate static func homes(_ key: String, args: CVarArg...) -> LocalizedString {
        LocalizedString(key: key, bundle: .module, args: args)
    }
}
