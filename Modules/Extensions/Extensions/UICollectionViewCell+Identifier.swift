import UIKit

public extension UICollectionViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
