import Foundation

public protocol ConfigModelInterface: AnyObject {
    associatedtype Input
    associatedtype Output
    associatedtype Dependency

    var input: Input! { get set }
    var output: Output? { get set }
    var dependency: Dependency?  { get set }
}
