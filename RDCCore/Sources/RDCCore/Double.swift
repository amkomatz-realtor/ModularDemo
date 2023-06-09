import Foundation

extension Double {
    public func toCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter.string(from: self as NSNumber) ?? ""
    }
}
