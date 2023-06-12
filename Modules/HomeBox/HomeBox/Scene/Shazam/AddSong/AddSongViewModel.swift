import Core
import Models

// MARK: - AddSongViewModelInterface

public protocol AddSongViewModelInterface: BaseViewModelInterface {
    func cancelButtonTapped()
    func addButtonTapped()
}

// MARK: - AddSongViewModel
//  swiftlint:disable line_length
public final class AddSongViewModel: BaseViewModel<
    AddSongViewControllerInterface,
    AddSongViewInterface,
    AddSongConfigModel
> {
    override public func viewLoaded() {
        super.viewLoaded()

        let data: [ShazamMedia] = [
            .init(
                title: "Song",
                subtitle: "Happier Then Ever",
                artistName: "Billie Eilish",
                albumArtURL: URL(string: "https://yt3.googleusercontent.com/ytc/AGIKgqOE2odAevc22sdCkQsZ3of410-sHBKA5ZhjeBxaZQ=s900-c-k-c0x00ffffff-no-rj"),
                genres: []
            ),
            .init(
                title: "Song",
                subtitle: "Black Magic",
                artistName: "Eminem",
                albumArtURL: URL(string: "https://yt3.googleusercontent.com/ytc/AGIKgqOf9-tqF76ZQiutagCoBxBE8RN5Pf2mOk5yStKRNA=s176-c-k-c0x00ffffff-no-rj"),
                genres: []
            ),
            .init(
                title: "Song",
                subtitle: "Umbrella",
                artistName: "Rihanna",
                albumArtURL: URL(string: "https://yt3.googleusercontent.com/YU2mwJNyBinBPRQRE4hLHK5zqb1ze5BgrdlFQSINRcYB3Ob-RgZiPWt_jGn8SuYEwovtWT5IB_s=s176-c-k-c0x00ffffff-no-rj"),
                genres: []
            ),
            .init(
                title: "Song",
                subtitle: "Урбан",
                artistName: "Баста",
                albumArtURL: URL(string: "https://yt3.googleusercontent.com/ytc/AGIKgqNTnzTcIPOeZJfP6cTO0TXbAhoyet4MsnbQWxQhUA=s176-c-k-c0x00ffffff-no-rj"),
                genres: []
            )
        ]

        let media = data.randomElement()!

        view.configureViewWith(title: media.artistName, subtitle: media.subtitle, imageUrl: media.albumArtURL)
    }
}

// MARK: - AddSongViewModel

extension AddSongViewModel: AddSongViewModelInterface {
    public func cancelButtonTapped() {
        self.config.output?.dismissScreen()
    }

    public func addButtonTapped() {
        print("Tapped")
    }
}

// MARK: - AddSongViewModel

extension AddSongViewModel: AddSongInputInterface {}
