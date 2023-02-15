import Foundation
import SDWebImage

public class LoadImageView: UIImageView {
    public static func loadImage(
        stringUrl: String,
        placeholder: UIImage?,
        completed: ((_ image: UIImage?, _ url: String?) -> Void)? = nil
    ) {
        SDWebImageManager.shared.loadImage(
            with: URL(string: stringUrl),
            options: .continueInBackground,
            progress: nil,
            completed: { image, _, _, _, _, url in
                completed?(image, url?.absoluteString)
            }
        )
    }

    public func setImage(
        stringUrl: String,
        placeholder: UIImage? = nil,
        completed: ((String?) -> Void)? = nil
    ) {
        self.setImage(
            url: URL(string: stringUrl),
            placeholder: placeholder,
            completed: { imageUrl in
                completed?(imageUrl?.absoluteString)
            }
        )
    }

    public func setImage(
        url: URL?,
        placeholder: UIImage?,
        completed: ((URL?) -> Void)? = nil
    ) {
        sd_setImage(
            with: url,
            placeholderImage: placeholder,
            completed: { _, _, _, imageUrl in
                completed?(imageUrl)
            }
        )
    }
}
