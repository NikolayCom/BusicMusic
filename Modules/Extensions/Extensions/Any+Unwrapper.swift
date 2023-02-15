import Foundation

public extension Optional {
    var orEmpty: String {
        if let data = self as? String {
            return data
        } else if let data = self as? Int {
            return "\(data)"
        }

        return ""
    }
}

public extension Optional where Wrapped == Int {
    func orZero() -> Int {
        self ?? 0
    }
}

public extension Optional where Wrapped == Date {
    func orCurrent() -> Date {
        self ?? Date()
    }
}

public extension Optional where Wrapped == Float {
    func orZero() -> Float {
        self ?? 0
    }
}

public extension Optional where Wrapped == CGFloat {
    func orZero() -> CGFloat {
        self ?? 0
    }
}
