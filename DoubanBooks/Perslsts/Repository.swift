//
//  Repository.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/10/15.
//  Copyright © 2019年 2017yd. All rights reserved.
//
import CoreData
import Foundation
class Repository<T: DateViwModelDelegate> where T:NSObject{
    var app: AppDelegate
    var context: NSManagedObjectContext
    
    init(_ app: AppDelegate) {
        self.app = app
        context = app.persistentContainer.viewContext
    }
    
    func insert(vm: T){
        let description = NSEntityDescription.entity(forEntityName: T.entityName, in: context)
        let obj = NSManagedObject(entity: description!,insertInto:context)
        for (key, value) in vm.entityPairs() {
            obj.setValue(value, forKey: key)
        }
        app.saveContext()
    }
    
    //判断
    func isEntityExists(_ cols: [String], keyword: String)throws -> Bool {
        var fromat = ""
        var args = [String]()
        for col in cols {
            fromat += "\(col) = %@ || "
            args.append(keyword)
        }
        fromat.removeLast(3)
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
        fetch.predicate = NSPredicate(format: fromat, argumentArray: args)
        do {
            let result = try context.fetch(fetch)
            return result.count > 0
        } catch {
            throw DateError.readCollectionError("判断数据存储失败")
        }
    }
    func getBy(_ cols:[String],keyword:String) throws -> [T] {
        var format = ""
        var args = [String] ()
        for col in cols {
            format += "\(col) like[c] %@ || "
            args.append("*\(keyword)*")
        }
        format.removeLast(3)
        var items = [T] ()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName:T.entityName)
        fetch.predicate = NSPredicate(format: format,argumentArray:args)
        do {
            let result  = try context.fetch(fetch)
            for c in result {
                let t = T()
                t.packageSelf(result: c as! NSFetchRequestResult)
                items.append(t)
            }
            return items
        }
    }
    
    //删除
    func delete(id:UUID) throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
        fetch.predicate = NSPredicate(format: "id = %@", id.uuidString)
        do {
            let result = try context.fetch(fetch)
            for b in result {
                context.delete(b as! NSManagedObject)
            }
            app.saveContext()
        } catch {
            throw DateError.deleteEntityError("删除图书失败")
        }
    }
    
    //更新
    func update(vm: T) throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName:T.entityName)
        fetch.predicate = NSPredicate(format: "id = %@",vm.id.uuidString)
        do{
            let obj = try context.fetch(fetch)[0] as!
            NSManagedObject
            for (key,value) in vm.entityPairs() {
                obj.setValue(value, forKey: key)
            }
            app.saveContext()
        } catch {
            throw DateError.updateEntityError("更新数据失败")
        }
    }
    
    //
    func get() throws -> [T] {
        var items = [T]()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
        do {
            let result = try context.fetch(fetch)
            for c in result {
                let t = T ()
                t.packageSelf(result: c as! NSFetchRequestResult)
                items.append(t)
            }
            return items
        } catch {
            throw DateError.readCollectionError("读取集合数据失败")
        }
    }

    

    
    
    
}
