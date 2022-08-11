import Foundation
import UIKit

// MARK: - Class

open class AppLabel: UILabel {
    
    // MARK: - Initializers
    
    /// - Parameters:
    ///   - font: FontFamily.Calibri.regular
    ///   - fontSize: 14.0
    ///   - alignment: .left
    ///   - textColor: GPColors.edna.color
    ///   - numberOfLines: 0
    public init(text: String? = nil,
                font: FontConvertible? = FontFamily.OpenSans.regular,
                fontSize: CGFloat? = 14.0,
                alignment: NSTextAlignment? = .left,
                textColor: UIColor? = Colors.luann.color,
                numberOfLines: Int? = 0,
                adjustsFontToFitWidth: Bool? = false,
                accessibilityLabel: String? = nil) {
        
        super.init(frame: .zero)
        
        if let text = text {
            self.text = text
        }
        
        if let accessibilityLabel = accessibilityLabel {
            self.accessibilityLabel = accessibilityLabel
        } else {
            self.accessibilityLabel = text
        }
        
        if let alignment = alignment {
            self.textAlignment = alignment
        }
        
        if let numberOfLines = numberOfLines {
            self.numberOfLines = numberOfLines
        }
        
        if let color = textColor {
            self.textColor = color
        }
        
        if let font = font {
            if let size = fontSize {
                self.font = font.font(size: size)
            }
        }
        
        if let adjustsFontToFitWidth = adjustsFontToFitWidth {
            self.adjustsFontSizeToFitWidth = adjustsFontToFitWidth
        }
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
