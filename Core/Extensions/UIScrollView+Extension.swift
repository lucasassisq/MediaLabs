import UIKit

public extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
    
    func screenshot() -> UIImage? {
        let savedContentOffset = contentOffset
        let savedFrame = frame
        
        UIGraphicsBeginImageContext(contentSize)
        contentOffset = .zero
        frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        contentOffset = savedContentOffset
        frame = savedFrame
        
        return image
    }
    
    func scrollToBottom(animated: Bool) {
         if self.contentSize.height < self.bounds.size.height { return }
         let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
         self.setContentOffset(bottomOffset, animated: animated)
      }
    
    func scrollToView(view: UIView, animated: Bool) {
        if let origin = view.superview {
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            self.scrollRectToVisible(CGRect(x: 0, y: childStartPoint.y, width: 1, height: self.frame.height), animated: animated)
        }
    }    
}
