//
//  UIButton+SNS.swift
//  Pods
//
//  Created by Guillaume Bonnin on 16/05/2016.
//
//

public extension UIButton {
  
  /**
   Set background color for states normal and highlighted
   */
  func setBackgroundColor(color: UIColor, highlightedColor: UIColor) {
    self.backgroundColor = color
    self.setBackgroundImage(UIImage(color:highlightedColor), forState:.Highlighted)
  }
 
  /**
   Center vertically the content of the button with specified padding
   */
  func centerVerticallyWithPadding(padding:CGFloat) {
    
    self.titleLabel!.numberOfLines = 0;
    self.titleLabel!.textAlignment = .Center;
    
    // get the size of the elements here for readability
    let imageSize = self.imageView!.frame.size
    let titleSize = self.titleLabel!.text!.sizeWithAttributes([NSFontAttributeName:self.titleLabel!.font])
    
    // get the height they will take up as a unit
    let totalHeight = (imageSize.height + titleSize.height + padding)
    
    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height), 0, 0, -titleSize.width)
    
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -(totalHeight - titleSize.height),0)
  }
  
}