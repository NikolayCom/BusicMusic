import UIKit

public protocol ViewControllerInterface: AnyObject {
    associatedtype View
    associatedtype ViewModel

    var contentView: View! { get set }
    var viewModel: ViewModel! { get set }

    init()
}
