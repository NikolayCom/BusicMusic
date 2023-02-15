import UIKit

public extension UIViewController {
    func hideNavBar(animated _: Bool = false) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func showNavBar(animated _: Bool = false) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
