
import UIKit

class ActivityIndicatorView: UIActivityIndicatorView {

    public static func customIndicator(at center: CGPoint, backgroundColor:UIColor = UIColor.gray) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
        indicator.layer.cornerRadius = 10
        indicator.center = center
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.backgroundColor = backgroundColor
        return indicator
    }
}
