import UIKit

extension NSLayoutConstraint {
    convenience init(_ view1: UIView, _ attr1: NSLayoutAttribute, _ view2: UIView, _ attr2: NSLayoutAttribute) {
        self.init(item: view1, attribute: attr1, relatedBy: .equal, toItem: view2, attribute: attr2, multiplier: 1.0, constant: 0.0)
    }
    
    static func constraintsWithSimpleFormat(_ format: String, views: [String: AnyObject]) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: views)
    }
}
