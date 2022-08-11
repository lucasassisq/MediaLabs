import UIKit

public enum AttributtedAlignment {
    case center, left, right
}

public extension NSMutableAttributedString {
    @discardableResult func customize(_ text: String,
                                      withFont font: UIFont,
                                      color: UIColor? = nil,
                                      lineSpace: CGFloat? = nil,
                                      alignment: AttributtedAlignment? = nil) -> NSMutableAttributedString {
        
        var attrs: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        if color != nil {
            attrs[NSAttributedString.Key.foregroundColor] = color
        }
        if lineSpace != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpace ?? 0
            attrs[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        
        if let alignment = alignment {
            let paragraph = NSMutableParagraphStyle()
            switch alignment {
            case .center:
                paragraph.alignment = .center
            case .left:
                paragraph.alignment = .left
            case .right:
                paragraph.alignment = .right
            }
            attrs[NSAttributedString.Key.paragraphStyle] = paragraph
        }

        let customStr = NSMutableAttributedString(string: "\(text)", attributes: attrs)
        self.append(customStr)
        return self
    }

    @discardableResult func underline(_ text: String,
                                      withFont font: UIFont,
                                      color: UIColor? = nil) -> NSMutableAttributedString {
        
        var attrs: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue as AnyObject,
            NSAttributedString.Key.font: font
        ]
        
        if color != nil {
            attrs[NSAttributedString.Key.foregroundColor] = color
        }
        
        let underString = NSMutableAttributedString(string: "\(text)", attributes: attrs)
        self.append(underString)
        return self
    }

    @discardableResult func linkTouch(_ text: String,
                                      url: String, withFont font: UIFont,
                                      color: UIColor = UIColor.blue) -> NSMutableAttributedString {
        let linkTerms: [NSAttributedString.Key: Any]  = [
            NSAttributedString.Key.link: NSURL(string: url) ?? NSURL(),
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.underlineColor: color,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.font: font
        ]
        
        let linkString = NSMutableAttributedString(string: "\(text)", attributes: linkTerms)
        self.append(linkString)
        return self
    }
    
    @discardableResult func supperscript(_ text: String,
                                         withFont font: UIFont,
                                         color: UIColor? = nil,
                                         offset: CGFloat) -> NSMutableAttributedString {
        
        var attrs: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.baselineOffset: offset,
            NSAttributedString.Key.font: font
        ]
        
        if color != nil {
            attrs[NSAttributedString.Key.foregroundColor] = color
        }
        
        let underString = NSMutableAttributedString(string: "\(text)", attributes: attrs)
        self.append(underString)
        return self
    }
    
    func makeAttributted(){
        self.append(self)
    }
    
    func attributtedString() -> NSMutableAttributedString {
        return self
    }

    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal =  NSAttributedString(string: text)
        self.append(normal)
        return self
    }

    func setAsLink(textToFind: String, linkURL: String) -> Bool {

        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(NSAttributedString.Key.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }

    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.width)
    }
}
