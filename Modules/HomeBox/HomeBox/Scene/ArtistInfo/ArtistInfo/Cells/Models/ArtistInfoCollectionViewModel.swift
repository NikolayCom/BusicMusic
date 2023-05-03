import UIComponents
import Core

struct ArtistInfoCollectionViewModel: ConfigurableCollectionViewCellModel {
    var viewCellType: String {
        NSStringFromClass(ArtistInfoCollectionViewCell.self)
    }

    let id: String
    let score: Int

    let type: String?
    let name: String?
    let gender: String?
    let country: String?
    let disambiguation: String?
}
