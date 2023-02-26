import Constants
import Core
import UIKit

// MARK: - Constants

private extension GridConstants {}

private extension DataConstants {}

private extension AppearanceConstants {
    var backgroundColor: UIColor? { .clear }
}

// MARK: - BaseViewInterface

public protocol BaseViewInterface: ViewInterface {}

// MARK: - BaseViewProtocol

protocol BaseViewProtocol {
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewLoaded()
    func setup()
    func setupUI()
    func setupConstraints()
}

// MARK: - BaseViewController

open class BaseView<ViewModel>: UIView {
    
    public var viewModel: ViewModel!

    open func viewWillAppear() {}

    open func viewDidAppear() {}

    open func viewWillDisappear() {}

    open func viewLoaded() {}

    open func setup() {
        backgroundColor = appearance.backgroundColor
    }

    open func setupUI() {}

    open func setupConstraints() {}
}

// MARK: - BaseViewInterface

extension BaseView: BaseViewInterface {}

extension BaseView: BaseViewProtocol {}
