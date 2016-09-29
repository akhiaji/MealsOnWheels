import UIKit

extension UIView {
    func prepareViewsForAutoLayout(_ viewsDict: [String: UIView]) {
        let _ = Array(viewsDict.values).map({$0.translatesAutoresizingMaskIntoConstraints = false; self.addSubview($0)})
    }
}
