import Foundation

public enum UIResult<T> {
    case value(T)
    case error(UIError)
}

public enum Result<T> {
    case value(T)
    case error(Error)
}
