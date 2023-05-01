import UIComponents
import Core

protocol MediaCollectionViewModelDelegate: AnyObject {
    func cellDidTap(with id: String)
}

struct MediaCollectionViewModel: ConfigurableCollectionViewCellModel {
    var viewCellType: String {
        NSStringFromClass(MediaCollectionViewCell.self)
    }

    let artist: String?
    let song: String?
    let isDownloaded: Bool
    let imageUrl: URL?

    let id: String

    weak var delegate: MediaCollectionViewModelDelegate?
}
