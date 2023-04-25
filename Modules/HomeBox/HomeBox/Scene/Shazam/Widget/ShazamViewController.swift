import Core
import Constants
import Resources

private extension GridConstants {
    var cellHeight: CGFloat { 170 }
}

private extension DataConstants {
    var title: String { Resources.strings.HomeBox.Shazam.desc }
}

// MARK: - ShazamViewControllerInterface

public protocol ShazamViewControllerInterface: BaseViewControllerInterface {}

// MARK: - ShazamViewController

public final class ShazamViewController: BaseViewController<
    ShazamViewInterface,
    ShazamViewModelInterface
> {
    public lazy var shape: WidgetShapeType = .fixedSize(grid.cellHeight)
    public lazy var sectionTitle: String = data.title

    public override func setup() {
        super.setup()

        pinContentViewFull()
    }
}

// MARK: - ShazamViewController

extension ShazamViewController: ShazamViewControllerInterface {}

extension ShazamViewController: WidgetCellController {}
