//
//  StatusItemManagerUtil.swift
//  Converter
//
//  Created by Gabriel Theodoropoulos.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import Cocoa
//管理状态栏图标
class StatusItemManager: NSObject {

    // MARK: - Properties
    //状态栏列表的列表对象
    var statusItem: NSStatusItem?
    //在屏幕上显示与现有内容相关的附加内容的一种方法。
    var popover: NSPopover?
    //ConverterViewController类的对象引用
    var converterVC: NetTableViewController?
    
    
    // MARK: - Init
    
    override init() {
        super.init()

        initStatusItem()
        initPopover()
    }
    
    //应用唤醒事件，在点击状态栏时唤醒这个事件
    override func awakeFromNib() {
        super.awakeFromNib()
        //初始化状态栏图标事件等
        initStatusItem()
        //
        initPopover()
    }
    
    
    
    // MARK: - Fileprivate Methods
    
    fileprivate func initStatusItem() {
        //设置状态栏图标等信息
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
 
        
        
        let itemImage = NSImage(named: "tubiao")
        let asd=NSStatusBar.system.thickness-2
                   //设置状态栏缩放
        itemImage?.size.width=asd
        itemImage?.size.height=asd
 
        itemImage?.isTemplate = true
        statusItem?.button?.image = itemImage
        //从单元接收操作消息的目标对象
        statusItem?.button?.target = self
        //与控件关联的默认动作-消息选择器。 设置回调的方法 也就是状态栏图标点击事件
        statusItem?.button?.action = #selector(showConverterVC)
    }
 
    
    fileprivate func initPopover() {
        //用于让弹窗跟随图标？？？
        //在屏幕上显示与现有内容相关的附加内容的一种方法。
        popover = NSPopover()
        popover?.behavior = .transient
    }
    
        
    @objc fileprivate func showConverterVC() {
        //点击事件重新载入数据
        MyViewModel.loadNetInfos()
        //如果 为空直接退出
        guard let popover = popover, let button = statusItem?.button else { return }
        //如果未加载加载一次
        converterVC = nil
        if converterVC == nil {

            //加载Main.storyboard文件
            let storyboard = NSStoryboard(name: "Main", bundle: nil)
            //视图里的id converterID
            guard let vc = storyboard.instantiateController(withIdentifier: .init(stringLiteral: "tableId")) as? NetTableViewController else { return }
            converterVC = vc
        }
        //管理弹出窗口内容的视图控制器，设置要显示的视图
        popover.contentViewController = converterVC
        //显示弹出窗口
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)

    }
 
    
    
    // MARK: - Internal Methods

 
    
    func hideAbout() {
        guard let popover = popover else { return }
        //隐藏当前About视图
        popover.contentViewController?.view.isHidden = true
        //置空
        popover.contentViewController?.dismiss(nil)
        //展示另一个
        showConverterVC()
        //展示属性关闭
        popover.contentViewController?.view.isHidden = false
    }
}
