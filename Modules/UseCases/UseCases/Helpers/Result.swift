import Foundation

public enum UIResult<T> {
    case value(T)
    case error(UIError)
}
