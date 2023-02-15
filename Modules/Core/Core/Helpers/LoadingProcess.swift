import Foundation

public enum LoadingStatus {
    case inProcess
    case ended
}

public typealias LoadingProcess = (_ status: LoadingStatus) -> Void
