import Foundation
import Core

public enum WidgetShapeType {
    case rectangle
    case fixedSize(CGFloat)
}

// MARK: WidgetCellController
public protocol WidgetCellController: UIViewController, BaseViewControllerInterface {
    var shape: WidgetShapeType { get }

    var sectionTitle: String { get }
}
