//
//  MyViewModel.swift
//  TableDemo
//
//  Created by Gabriel Theodoropoulos.
//  Copyright © 2019 Appcoda. All rights reserved.
//

import Foundation

//枚举类型
enum DisplayMode {
    //简单类型
    case plain
    //复杂类型
    case detail
}

//继承object类型
class MyViewModel: NSObject {

    // MARK: - Properties
    //声明Model对象数组
    var baseNetInfos = [BaseNetInfo]()
    static var baseNetInfoArray = [String]()
    //设置默认简单类型
    private(set) var displayMode: DisplayMode = .plain

    // MARK: - Init
    override init() {
        super.init()
        //  Load dummy data. 加载数据
        loadDummyData()
    }


    // MARK: - 私有方法 Methods读取本地JSON加载数据并解析到对象

    private func loadDummyData() {
        //Bundle 存储程序及其资源的对象
        //.main 获取Bundle对象
        //.url 获取指定地址的数据 json配置文件
        guard let dummyDataURL = Bundle.main.url(forResource: "JSON_DATA", withExtension: "json"),
              let dummyData = try? Data(contentsOf: dummyDataURL)
                else {
            return
        }
        //声明json工具
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            //解析数据到对象 自动封装成数组
            baseNetInfos = try decoder.decode([BaseNetInfo].self, from: dummyData)
        } catch {

            print(error.localizedDescription)
        }

    }

    static public func loadNetInfos() {
        //赋值并判断空
        guard  let arrayNameString = NetworkManager.getNetBaseNameArray() else {
            return
        }

        var i = 0

        baseNetInfoArray.removeAll()
        for nameString in arrayNameString {
            if i == 0 {
                i = i + 1
                continue
            }
            baseNetInfoArray.append(nameString)
            i = i + 1
        }
        print(baseNetInfoArray)
    }

   static public func setNetSort() {


    }


    // MARK: - Public Methods
    //选择模型，简单数据还是复杂数据
    func switchDisplayMode() {
        if displayMode == .plain {
            displayMode = .detail
        } else {
            displayMode = .plain
        }
    }

    //获取指定资源数据
    func getPurchase(withID id: Int) -> BaseNetInfo? {
        return baseNetInfos.filter {
            $0.id == id
        }.first
    }

    //移除
    func removePurchase(atIndex index: Int) {
        baseNetInfos.remove(at: index)
    }

    //排序
    func sortPurchases(ascending: Bool) {
        baseNetInfos.sort { (p1, p2) -> Bool in
            guard let id1 = p1.id, let id2 = p2.id else {
                return true
            }
            if ascending {
                return id1 < id2
            } else {
                return id2 < id1
            }
        }
    }

    //参数 旧的位置 新的位置
    static func move1(_ indexes: Int, _ toIndex: Int) {
        let count = baseNetInfoArray.count
        if (indexes == toIndex){
            return
        }
        if (toIndex > count) {
            return
        }
        if (indexes > count) {
            return
        }
        print(String(indexes)+"->"+String(toIndex))

        //取出要移动列shanch丶
        let movingData = baseNetInfoArray[indexes]
        baseNetInfoArray.remove(at: indexes)

        var targetIndex = toIndex - 1
        if (targetIndex<0) {targetIndex=0}
        baseNetInfoArray.insert(movingData, at: targetIndex)
        print("---------111----------")
        print(baseNetInfoArray)
        print("---------222---------")
    }

    func getAvatarData(forUserWithID userID: Int?) -> Data? {
        guard let id = userID, let url = Bundle.main.url(forResource: "\(id)", withExtension: "png") else {
            return nil
        }
        return try? Data(contentsOf: url)
    }
}
