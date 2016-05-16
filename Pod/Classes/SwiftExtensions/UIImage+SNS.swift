//
//  UIImage+SNS.swift
//  Pods
//
//  Created by Guillaume Bonnin on 16/05/2016.
//
//

extension UIImage {
  
  /**
   Init an image from another image scaled to desized sizes
   */
  convenience init?(image:UIImage, size:CGSize) {
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    image.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
    let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    if let cgImage = scaledImage.CGImage {
      self.init(CGImage: cgImage)
    } else {
      return nil
    }
  }
}
