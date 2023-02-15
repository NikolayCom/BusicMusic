import Foundation

public protocol UnsafeConfigurable {
    func make(with viewModel: Any)
}

// MARK: -

public protocol ConfigurableView: UIView, UnsafeConfigurable {
    associatedtype ViewModel

    func configure(with viewModel: ViewModel)
}

// MARK: -

public extension ConfigurableView {
    func make(with viewModel: Any) {
        if let concreteViewModel = viewModel as? ViewModel {
            configure(with: concreteViewModel)
        } else {
            assertionFailure(
                """
                    Invalid ViewModel type,
                    expect \(String(reflecting: ViewModel.self))
                    got: \(String(reflecting: viewModel.self))
                """
            )
        }
    }
}
