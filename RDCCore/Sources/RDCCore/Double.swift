import Foundation

extension Double {
    public func toCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: self as NSNumber) ?? ""
    }
}
