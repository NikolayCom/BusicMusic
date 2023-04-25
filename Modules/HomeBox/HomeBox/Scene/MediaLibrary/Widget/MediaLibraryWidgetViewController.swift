import Core
import Constants
import Resources

private extension GridConstants {
    var cellHeight: CGFloat { 170 }
}

private extension DataConstants {
    var title: String { Resources.strings.HomeBox.MyLibrary.desc }
}

// MARK: - MediaLibraryWidgetViewControllerInterface

public protocol MediaLibraryWidgetViewControllerInterface: BaseViewControllerInterface {}

// MARK: - MediaLibraryWidgetViewController

public final class MediaLibraryWidgetViewController: BaseViewController<
    MediaLibraryWidgetViewInterface,
    MediaLibraryWidgetViewModelInterface
> {
    public lazy var shape: WidgetShapeType = .fixedSize(grid.cellHeight)
    public lazy var sectionTitle: String = data.title

    public override func setup() {
        super.setup()

        pinContentViewFull()
    }
}

// MARK: - MediaLibraryWidgetViewController

extension MediaLibraryWidgetViewController: MediaLibraryWidgetViewControllerInterface {}

// MARK: WidgetCellController

extension MediaLibraryWidgetViewController: WidgetCellController {}
