import Foundation

extension String {
    public func matches(of regex: String) -> [String] {
        let range = NSRange(location: 0, length: utf16.count)
        let regex = try! NSRegularExpression(pattern: regex)
        
        return regex.matches(in: self, range: range).flatMap { match in
            (0..<match.numberOfRanges).map { i in
                String(self[Range(match.range(at: i), in: self)!])
            }
        }
    }
}
