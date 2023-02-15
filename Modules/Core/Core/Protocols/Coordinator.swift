import UIKit

public protocol Coordinator: AnyObject {
    // MARK: - Properties

    var rootViewController: UIViewController { get }

    var children: [Coordinator] { get }

    // MARK: - Methods

    func start()
}
