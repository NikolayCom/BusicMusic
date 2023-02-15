import Foundation

public extension NotificationCenter {
    static func addObserver(
        _ observer: Any,
        selector aSelector: Selector,
        name aName: NSNotification.Name? = nil,
        object anObject: Any? = nil
    ) {
        NotificationCenter.default.addObserver(observer, selector: aSelector, name: aName, object: anObject)
    }

    static func removeObserver(
        _ observer: Any,
        name aName: NSNotification.Name? = nil,
        object anObject: Any? = nil
    ) {
        NotificationCenter.default.removeObserver(observer, name: aName, object: anObject)
    }

    static func post(
        _ aName: NSNotification.Name
    ) {
        NotificationCenter.default.post(name: aName, object: nil)
    }
}
