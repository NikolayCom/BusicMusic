import Core

// MARK: WidgetCoordinator
public protocol WidgetCoordinator: Coordinator {
    func addWidget(to homeViewController: UIViewController)
}
