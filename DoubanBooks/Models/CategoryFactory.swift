//
//  CategoryFactory.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/10/14.
//  Copyright © 2019年 2017yd. All rights reserved.
//  懒汉式
import CoreData
import Foundation
final class CategoryFactory{
    //var app: AppDelegate?
    var repository: CategoryRepository
    private static var instance: CategoryFactory?
    
    
    private init(_ app: AppDelegate) {
        repository = CategoryRepository(app)
    }
    
    static func getInstance(_ app: AppDelegate) -> CategoryFactory{
        if let obj = instance {
            return obj
        }else {
            let token = "net.lzzy.factory.category"
            DispatchQueue.once(token: token, block: {
                if instance == nil {
                    instance = CategoryFactory(app)
                }
            })
        }
        return instance!
    }
    
    
    func getAllCategories()throws -> [VMCategory] {
        return try repository.get()
    }
    func addCategory(category:VMCategory) -> (Bool,String?) {
        do {
            if try repository.isExists(name: category.name!) {
                return (false,"同样的类别已存在")
            }
            repository.insert(vm: category)
            return (true, nil)
        }catch DateError.entityExistsError(let info) {
            return(false, info)
        }catch {
            return (false, error.localizedDescription)
        }
    }
    
    

    
    
}

////扩展
extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    public class func once(token: String, block: () -> Void) {
        
        objc_sync_enter(self)
        
        defer {
            
            objc_sync_exit(self)
            
        }
        
        if _onceTracker.contains(token) {
            
            return
            
        }
        
        _onceTracker.append(token)
        
        block()
    }
    
}



