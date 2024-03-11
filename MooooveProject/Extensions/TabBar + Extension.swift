import UIKit

extension UITabBarController {
    func setTabBarVisible(_ visible: Bool, animated: Bool) {
        if (isTabBarVisible() == visible) { return }
        
        let frame = tabBar.frame
        let height = frame.size.height
        let offsetY = (visible ? -height : height)
        
        // Анимированное изменение transform для скрытия и открытия таббара
        UIView.animate(withDuration: animated ? 0.3 : 0.0) {
            self.tabBar.frame = frame.offsetBy(dx: 0, dy: offsetY)
            self.view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width, height: self.view.frame.height + offsetY))
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }
    
    func isTabBarVisible() -> Bool {
        return tabBar.frame.origin.y < UIScreen.main.bounds.height
    }
}
