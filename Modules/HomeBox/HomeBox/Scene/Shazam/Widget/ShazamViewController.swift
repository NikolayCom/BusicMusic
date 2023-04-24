import Core
import Constants

private extension GridConstants {
    var cellHeight: CGFloat { 170 }
}

// MARK: - ShazamViewControllerInterface

public protocol ShazamViewControllerInterface: BaseViewControllerInterface {}

// MARK: - ShazamViewController

public final class ShazamViewController: BaseViewController<
    ShazamViewInterface,
    ShazamViewModelInterface
> {
    public lazy var shape: WidgetShapeType = .fixedSize(grid.cellHeight)

    public override func setup() {
        super.setup()

        pinContentViewFull()
    }
}

// MARK: - ShazamViewController

extension ShazamViewController: ShazamViewControllerInterface {}

extension ShazamViewController: WidgetCellController {}
