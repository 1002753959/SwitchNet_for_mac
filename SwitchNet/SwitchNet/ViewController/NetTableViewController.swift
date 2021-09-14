//
//  NetTableViewController.swift
//  Converter
//
//  Created by YiEN on 2021/1/21.
//  Copyright © 2021 AppCoda. All rights reserved.
//

import Cocoa

class NetTableViewController: NSViewController {

    //全局加入的tableView
    @IBOutlet weak var tableView: NSTableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        //加载布局
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerForDraggedTypes([.string, .tableViewIndex])
        tableView.setDraggingSourceOperationMask([.copy, .delete], forLocal: false)
        //添加以后可以执行鼠标进入退出事件
        tableView.addTrackingRect(tableView.bounds, owner:self, userData: nil, assumeInside: true)
        

    }

    //退出
    @IBAction func quit(_ sender: Any) {
        print("quit")
        NSApplication.shared.terminate(self)
   

    }
    @IBAction func openDiskSetting(_ sender: Any){
       //打开其他app
        NSWorkspace.shared.open(URL(fileURLWithPath: "/System/Applications/Utilities/Disk Utility.app"))
    }
    @IBAction func openSetting(_ sender: Any) {
        print("quit")
        //替换%PrefsNsme%为位于“ / System / Library / PreferencePanes /”的任何所需文件名
        // NSWorkspace.shared.open(URL(fileURLWithPath: "/System/Library/PreferencePanes/%PrefsNsme%.prefPane"))
        /**
         Accessibility Preference Pane
         Main    x-apple.systempreferences:com.apple.preference.universalaccess
         Display x-apple.systempreferences:com.apple.preference.universalaccess?Seeing_Display
         Zoom    x-apple.systempreferences:com.apple.preference.universalaccess?Seeing_Zoom
         VoiceOver   x-apple.systempreferences:com.apple.preference.universalaccess?Seeing_VoiceOver
         Descriptions    x-apple.systempreferences:com.apple.preference.universalaccess?Media_Descriptions
         Captions    x-apple.systempreferences:com.apple.preference.universalaccess?Captioning
         Audio   x-apple.systempreferences:com.apple.preference.universalaccess?Hearing
         Keyboard    x-apple.systempreferences:com.apple.preference.universalaccess?Keyboard
         Mouse & Trackpad    x-apple.systempreferences:com.apple.preference.universalaccess?Mouse
         Switch Control  x-apple.systempreferences:com.apple.preference.universalaccess?Switch
         Dictation   x-apple.systempreferences:com.apple.preference.universalaccess?SpeakableItems

         Security & Privacy Preference Pane
         Main    x-apple.systempreferences:com.apple.preference.security
         General x-apple.systempreferences:com.apple.preference.security?General
         FileVault   x-apple.systempreferences:com.apple.preference.security?FDE
         Firewall    x-apple.systempreferences:com.apple.preference.security?Firewall
         Advanced    x-apple.systempreferences:com.apple.preference.security?Advanced
         Privacy x-apple.systempreferences:com.apple.preference.security?Privacy
         Privacy-Camera x-apple.systempreferences:com.apple.preference.security?Privacy_Camera
         Privacy-Microphone  x-apple.systempreferences:com.apple.preference.security?Privacy_Microphone
         Privacy-Automation  x-apple.systempreferences:com.apple.preference.security?Privacy_Automation
         Privacy-AllFiles    x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles
         Privacy-Accessibility   x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility
         Privacy-Assistive   x-apple.systempreferences:com.apple.preference.security?Privacy_Assistive
         Privacy-Location Services   x-apple.systempreferences:com.apple.preference.security?Privacy_LocationServices
         Privacy-SystemServices  x-apple.systempreferences:com.apple.preference.security?Privacy_SystemServices
         Privacy-Advertising x-apple.systempreferences:com.apple.preference.security?Privacy_Advertising
         Privacy-Contacts    x-apple.systempreferences:com.apple.preference.security?Privacy_Contacts
         Privacy-Diagnostics & Usage x-apple.systempreferences:com.apple.preference.security?Privacy_Diagnostics
         Privacy-Calendars   x-apple.systempreferences:com.apple.preference.security?Privacy_Calendars
         Privacy-Reminders   x-apple.systempreferences:com.apple.preference.security?Privacy_Reminders
         Privacy-Facebook    x-apple.systempreferences:com.apple.preference.security?Privacy_Facebook
         Privacy-LinkedIn    x-apple.systempreferences:com.apple.preference.security?Privacy_LinkedIn
         Privacy-Twitter x-apple.systempreferences:com.apple.preference.security?Privacy_Twitter
         Privacy-Weibo   x-apple.systempreferences:com.apple.preference.security?Privacy_Weibo
         Privacy-Tencent Weibo   x-apple.systempreferences:com.apple.preference.security?Privacy_TencentWeibo

         macOS Catalina 10.15:
         Privacy-ScreenCapture   x-apple.systempreferences:com.apple.preference.security?Privacy_ScreenCapture
         Privacy-DevTools    x-apple.systempreferences:com.apple.preference.security?Privacy_DevTools
         Privacy-InputMonitoring x-apple.systempreferences:com.apple.preference.security?Privacy_ListenEvent
         Privacy-DesktopFolder   x-apple.systempreferences:com.apple.preference.security?Privacy_DesktopFolder
         Privacy-DocumentsFolder x-apple.systempreferences:com.apple.preference.security?Privacy_DocumentsFolder
         Privacy-DownloadsFolder x-apple.systempreferences:com.apple.preference.security?Privacy_DownloadsFolder
         Privacy-NetworkVolume   x-apple.systempreferences:com.apple.preference.security?Privacy_NetworkVolume
         Privacy-RemovableVolume x-apple.systempreferences:com.apple.preference.security?Privacy_RemovableVolume
         Privacy-SpeechRecognition   x-apple.systempreferences:com.apple.preference.security?Privacy_SpeechRecognition
         Privacy-DevTools    x-apple.systempreferences:com.apple.preference.security?Privacy_DevTools

         macOS Big Sur 10.11/10.16:
         Privacy-Bluetooth   x-apple.systempreferences:com.apple.preference.security?Privacy_Bluetooth
         Privacy-Music   x-apple.systempreferences:com.apple.preference.security?Privacy_Media
         Privacy-Home    x-apple.systempreferences:com.apple.preference.security?Privacy_HomeKit


         Dictation & Speech Preference Pane
         Dictation   x-apple.systempreferences:com.apple.preference.speech?Dictation
         Text to Speech  x-apple.systempreferences:com.apple.preference.speech?TTS
         Sharing Preference Pane
         Main    x-apple.systempreferences:com.apple.preferences.sharing
         Screen Sharing  x-apple.systempreferences:com.apple.preferences.sharing?Services_ScreenSharing
         File Sharing    x-apple.systempreferences:com.apple.preferences.sharing?Services_PersonalFileSharing
         Printer Sharing x-apple.systempreferences:com.apple.preferences.sharing?Services_PrinterSharing
         Remote Login    x-apple.systempreferences:com.apple.preferences.sharing?Services_RemoteLogin
         Remote Management   x-apple.systempreferences:com.apple.preferences.sharing?Services_ARDService
         Remote Apple Events x-apple.systempreferences:com.apple.preferences.sharing?Services_RemoteAppleEvent
         Internet Sharing    x-apple.systempreferences:com.apple.preferences.sharing?Internet
         Bluetooth Sharing   x-apple.systempreferences:com.apple.preferences.sharing?Services_BluetoothSharing

         Software update x-apple.systempreferences:com.apple.preferences.softwareupdate?client=softwareupdateapp
         */

        NSWorkspace.shared.open(URL(fileURLWithPath: "/System/Library/PreferencePanes/Network.prefPane"))
    
   

    }
    override func viewDidDisappear() {
        super.viewDidDisappear()
        print("关闭窗口执行命令行")
        MyViewModel.setNetSort()
        var  asdtt="networksetup -ordernetworkservices "
        for temp_a in  MyViewModel.baseNetInfoArray{
            asdtt = asdtt + "\""+temp_a+"\" "

                
        }
        print(asdtt)
        var routerCommand = ["-c", asdtt," "]
        //执行命令接受返回值
//        maint()
       let  routerOutput = Commands.execute(executablePath: .shell, args: routerCommand)
        print(routerOutput)

    }
}


extension NetTableViewController: NSTableViewDataSource {
    //返回model数据
    func numberOfRows(in tableView: NSTableView) -> Int {
//        return ViewModel.baseNetInfoArray.count

        return MyViewModel.baseNetInfoArray.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        // 继承NSUserInterfaceItemIdentifier接口 也就是默认布局中cellTable 用它作为模版 生成一个新的cell
        var cell:NetworkTableCell?
         cell = tableView.makeView(withIdentifier: .listCellView, owner: nil) as? NetworkTableCell
        //设置cell列中的显示值
        cell?.textField?.stringValue=MyViewModel.baseNetInfoArray[row]
//        cell?.nameTextfield?.stringValue =
        //cell.addTrackingRect(CGRect.Type.self, owner: self, userData: nil, assumeInside: true)
    
        print("cell初始化"+MyViewModel.baseNetInfoArray[row])
        return cell
    }
  
}


extension NetTableViewController: NSTableViewDelegate {
    // Due to a bug with NSTableView, this method has to be implemented to get
    // the draggingDestinationFeedbackStyle.gap animation to look right.
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 20
    }
    

    func tableView(_ tableView: NSTableView, pasteboardWriterForRow row: Int) -> NSPasteboardWriting? {
        return PasteboardUtil(fruit: MyViewModel.baseNetInfoArray[row], at: row)
    }


    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
        guard dropOperation == .above else {
            return []
        }

        // If dragging to reorder, use the gap feedback style. Otherwise, draw insertion marker.
        if let source = info.draggingSource as? NSTableView, source === tableView {
            tableView.draggingDestinationFeedbackStyle = .gap
        } else {
            tableView.draggingDestinationFeedbackStyle = .regular
        }
        return .move
    }

    //拖拽完成调用该方法
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {
        guard let items = info.draggingPasteboard.pasteboardItems else {
            return false
        }

        let oldIndexes = items.compactMap {
            $0.integer(forType: .tableViewIndex)
        }
        if !oldIndexes.isEmpty {

           
            MyViewModel.baseNetInfoArray.move(with: IndexSet(oldIndexes), to: row)
            print("-------------------")
            print(MyViewModel.baseNetInfoArray)
            print("-------------------")
            // The ol' Stack Overflow copy-paste. Reordering rows can get pretty hairy if
            // you allow multiple selection. https://stackoverflow.com/a/26855499/7471873

            tableView.beginUpdates()
            var oldIndexOffset = 0
            var newIndexOffset = 0

            for oldIndex in oldIndexes {
                if oldIndex < row {
                    tableView.moveRow(at: oldIndex + oldIndexOffset, to: row - 1)
                    oldIndexOffset -= 1
                } else {
                    tableView.moveRow(at: oldIndex, to: row + newIndexOffset)
                    newIndexOffset += 1
                }
            }
            tableView.endUpdates()

            return true
        }

        let newFruits = items.compactMap {
            $0.string(forType: .string)
        }
        MyViewModel.baseNetInfoArray.insert(contentsOf: newFruits, at: row)
        tableView.insertRows(at: IndexSet(row...row + newFruits.count - 1), withAnimation: .slideDown)
        return true
    }


    func tableView(_ tableView: NSTableView, draggingSession session: NSDraggingSession, endedAt screenPoint: NSPoint, operation: NSDragOperation) {
        // Handle items dragged to Trash
        if operation == .delete, let items = session.draggingPasteboard.pasteboardItems {
            let indexes = items.compactMap {
                $0.integer(forType: .tableViewIndex)
            }

            for index in indexes.reversed() {
                MyViewModel.baseNetInfoArray.remove(at: index)
            }
            tableView.removeRows(at: IndexSet(indexes), withAnimation: .slideUp)
        }
    }
 
    
}

//继承cellView接口
extension NSUserInterfaceItemIdentifier {
    //cellId 需要手动加载
    static let listCellView = NSUserInterfaceItemIdentifier("listCellViewId")
}
