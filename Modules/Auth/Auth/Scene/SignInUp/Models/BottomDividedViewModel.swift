// MARK: - BottomDividedModelDelegate

protocol BottomDividedModelDelegate: AnyObject {
    func didTap(with id: String)
}

// MARK: - BottomDividedViewModel

public struct BottomDividedViewModel {
    weak var delegate: BottomDividedModelDelegate?

    let id: String
    let title: String
    let image: UIImage?
}
