import Core

// MARK: - CommonAssembly

protocol CommonAssembly {
    var validator: Validator { get }
}

// MARK: - RequestsAssemblyImpl

class CommonAssemblyImpl: CommonAssembly {
    lazy var validator: Validator = ValidatorImpl()
}
