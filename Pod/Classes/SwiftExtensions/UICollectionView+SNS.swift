//
//  UIcollectionView+SNS.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 16/05/2016.
//
//

public extension UICollectionView {
  
  /**
   Correctly center the given cell at index paths to optimize the **vertical** center display.
   Use it for "expandable cells", if a cell is inserted into your collection view and there is no space to display it entirely, use this method.
   
   - parameter topCellPath:    The cell at the vertical top of your layout
   - parameter bottomCellPath: The cell, under your top cell, that you want to display entirely
   */
  public func scrollToVisiblePaths(top:NSIndexPath, bottom:NSIndexPath) {
    if let dataSource = self.dataSource {
      let topCell = dataSource.collectionView(self, cellForItemAtIndexPath: top)
      let bottomCell = dataSource.collectionView(self, cellForItemAtIndexPath: bottom)
      let diff = (bottomCell.frame.origin.y + bottomCell.frame.size.height) - (self.contentOffset.y + self.frame.size.height)
      
      if diff > 0 {
        if (diff < (topCell.frame.origin.y - self.contentOffset.y)) {
          dispatch_async(dispatch_get_main_queue()) {
            self.setContentOffset(CGPointMake(0, self.contentOffset.y + diff), animated: true)
          }
        }else {
          dispatch_async(dispatch_get_main_queue()) {
            self.setContentOffset(CGPointMake(0, self.contentOffset.y + (topCell.frame.origin.y - self.contentOffset.y)), animated: true)
          }
        }
      }
      
    }
  }
  
}