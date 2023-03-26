public extension NSRegularExpression {
    convenience init(_ pattern: String) throws {
        try self.init(pattern: pattern)
    }

    func matches(_ string: String) -> Bool {
        let stringRange = NSRange(location: .zero, length: string.utf16.count)
        guard let firstMatchRange = try? rangeOfFirstMatch(in: string, range: stringRange) else { return false }
        return stringRange == firstMatchRange
    }
}
