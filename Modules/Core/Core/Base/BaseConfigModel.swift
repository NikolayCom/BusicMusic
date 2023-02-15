import Foundation

// MARK: - BaseConfigModel

open class BaseConfigModel<Input, Output>: ConfigModelInterface {
    private weak var storageInput: AnyObject?
    public var input: Input! {
        get {
            self.storageInput as? Input
        }
        set {
            self.storageInput = newValue as? AnyObject
        }
    }

    private weak var storageOutput: AnyObject?
    public var output: Output? {
        get {
            self.storageOutput as? Output
        }
        set {
            self.storageOutput = newValue as? AnyObject
        }
    }

    public init(
        output: Output?
    ) {
        self.output = output
    }
}
