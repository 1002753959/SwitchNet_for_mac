//
//  NetworkTableCell.swift
//  SwitchNet
//
//  Created by YiEN on 2021/1/23.
//

 
import Cocoa
 

class NetworkTableCell:NSTableCellView {
    
 
    var nameTextfield:NSTextField?
    var cgColor:CGColor?
 
 
 
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.addTrackingRect(self.bounds, owner: self, userData: nil, assumeInside: false)
    }
  
    override func mouseEntered(with event: NSEvent)
     {
        print("移入鼠标")
        print(self.textField?.stringValue)
        cgColor=self.layer?.backgroundColor
        self.layer?.backgroundColor=CGColor.init(red: CGFloat.init(211), green: CGFloat.init(122), blue: CGFloat.init(1), alpha: CGFloat.init(0.2))
//        self.backgroundStyle=BackgroundStyle.light
     }
    override func mouseExited(with event: NSEvent) {
//        print("移出鼠标")
        self.layer?.backgroundColor=cgColor
    }
    
}
