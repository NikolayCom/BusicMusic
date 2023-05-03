import Core
import Constants
import Resources

// MARK: Constants

private extension GridConstants {
    var cellHeight: CGFloat { 170 }
}

private extension DataConstants {
    var title: String { Resources.strings.HomeBox.ArtistInfo.desc }
}

// MARK: - ArtistInfoWidgetViewControllerInterface

public protocol ArtistInfoWidgetViewControllerInterface: BaseViewControllerInterface {}

// MARK: - ArtistInfoWidgetViewController

public final class ArtistInfoWidgetViewController: BaseViewController<
    ArtistInfoWidgetViewInterface,
    ArtistInfoWidgetViewModelInterface
> {

    public lazy var shape: WidgetShapeType = .fixedSize(grid.cellHeight)
    
    public lazy var sectionTitle: String = data.title

    public override func setup() {
        super.setup()

        pinContentViewFull()
    }
}

// MARK: - ArtistInfoWidgetViewController

extension ArtistInfoWidgetViewController: ArtistInfoWidgetViewControllerInterface {}

// MARK: - ShazamViewControllerInterface

extension ArtistInfoWidgetViewController: WidgetCellController {}
