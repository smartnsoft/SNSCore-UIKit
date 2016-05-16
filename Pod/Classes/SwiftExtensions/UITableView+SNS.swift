//
//  UITableView+SNS.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 16/05/2016.
//
//

//MARK: UITableView
public extension UITableView {
  /**
   Set the tableFooterView and applu the optimized size constraint to content height. This will update the footer's frame
   
   - parameter footer: UIView Footer
   */
  public func setAndLayoutTableFooterView(footer: UIView) {
    self.tableFooterView = footer
    footer.setNeedsLayout()
    footer.layoutIfNeeded()
    layoutTableFooterView()
  }
  
  /**
   Apply automatic height for your footer. Call it on didLayoutSubviews for quickly setup
   */
  public func layoutTableFooterView() {
    if let footer = self.tableFooterView{
      let height = footer.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
      var frame = footer.frame
      frame.size.height = height
      footer.frame = frame
      self.tableFooterView = footer
    }
  }
  
  /**
    Set the tableHeaderView and applu the optimized size constraint to content height. This will update the header's frame
   
   - parameter header: UIView Header
   */
  public func setAndLayoutTableHeaderView(header: UIView) {
    self.tableHeaderView = header
    header.setNeedsLayout()
    header.layoutIfNeeded()
    layoutTableHeaderView()
  }
  
  /**
   Apply automatic height for your header. Call it on didLayoutSubviews for quickly setup
   */
  public func layoutTableHeaderView() {
    if let header = self.tableHeaderView{
      let height = header.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
      var frame = header.frame
      frame.size.height = height
      header.frame = frame
      self.tableHeaderView = header
    }
  }
}