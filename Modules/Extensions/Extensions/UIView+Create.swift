import Then
import UIKit

public extension UIView {
    static func clear() -> UIView {
        UIView().then { view in
            view.backgroundColor = .clear
        }
    }

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { self.addSubview($0) }
    }

    func bringSubviewsToFront(_ subviews: [UIView]) {
        subviews.forEach { self.bringSubviewToFront($0) }
    }
}
