import Foundation

public protocol ViewModelInterface: AnyObject {
    associatedtype ViewController
    associatedtype View
    associatedtype ConfigModel

    var controller: ViewController! { get set }
    var view: View! { get set }
    var config: ConfigModel { get }

    init(config: ConfigModel)
}
