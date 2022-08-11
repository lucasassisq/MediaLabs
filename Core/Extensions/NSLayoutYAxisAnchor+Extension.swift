import UIKit

public extension NSLayoutYAxisAnchor {
    func constraint(between anchor1: NSLayoutYAxisAnchor, and anchor2: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
        let anchor1Constraint = anchor1.anchorWithOffset(to: self)
        let anchor2Constraint = anchorWithOffset(to: anchor2)
        return anchor1Constraint.constraint(equalTo: anchor2Constraint)
    }
}
