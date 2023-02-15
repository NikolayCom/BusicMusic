import UIKit

public protocol ViewInterface: AnyObject {
    associatedtype ViewModel

    var viewModel: ViewModel! { get set }

    init()
}
