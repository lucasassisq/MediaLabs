import UIKit

public extension NSLayoutXAxisAnchor {
    func constraint(between anchor1: NSLayoutXAxisAnchor, and anchor2: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        let anchor1Constraint = anchor1.anchorWithOffset(to: self)
        let anchor2Constraint = anchorWithOffset(to: anchor2)
        return anchor1Constraint.constraint(equalTo: anchor2Constraint)
    }
}
