//
//  CategoryRepository.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/10/12.
//  Copyright © 2019年 2017yd. All rights reserved.
//
import CoreData
import Foundation

class CategoryRepository{
    var app: AppDelegate
    var context: NSManagedObjectContext
    
    init(_ app: AppDelegate) {
        self.app = app
        context = app.persistentContainer.viewContext
    }
    
    func isExists(name:String)throws -> Bool{
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: VMCategory.entityName)
        fetch.predicate = NSPredicate(format: "\(VMCategory.colName)=%@",name)
        do{
            let result = try context.fetch(fetch) as![VMCategory]
            return result.count > 0
        }catch{
            throw DateError.entityExistsError("判断数据失败")
        }
        
    }
    
    func insert(vm: VMCategory){
        let description = NSEntityDescription.entity(forEntityName: VMCategory.entityName, in: context)
        let category = NSManagedObject(entity: description!, insertInto:context)
        category.setValue(vm.id, forKey: VMCategory.colId)
        category.setValue(vm.name, forKey: VMCategory.colName)
        category.setValue(vm.image, forKey: VMCategory.colImage)
        app.saveContext()
    }
    
    func get() throws -> [VMCategory]{
        var categorys = [VMCategory]()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: VMCategory.entityName)
        do {
            let result = try context.fetch(fetch) as! [VMCategory]
            for item in result {
                let vm = VMCategory()
                vm.id = item.id
                vm.name = item.name
                vm.image = item.image
                categorys.append(vm)
            }
        } catch {
            throw DateError.readCollectionError("读取集合数据失败")
        }
        
        return categorys
    }
    
    func getCategory(keyword:String? = nil) throws -> [VMCategory] {
        var categorys = [VMCategory]()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: VMCategory.entityName)
        if let kw = keyword {
            fetch.predicate = NSPredicate(format: "name like[c] %@ || address like[c] %@", "*\(kw)*","*\(kw)*")
        }
        let result = try context.fetch(fetch) as! [Category]
        for item in result {
            let vm = VMCategory()
            vm.id = item.id!
            vm.name = item.name
            vm.image = item.image
            categorys.append(vm)
        }
        return categorys
    }
    
    func delete(id: UUID) throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: VMCategory.entityName)
        fetch.predicate = NSPredicate(format: "id = %@", id.uuidString)
        let result = try context.fetch(fetch) as! [Category]
        for m in result {
            context.delete(m)
        }
        app.saveContext()
    }
    
    func update(_ upCateory:VMCategory)throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: VMCategory.entityName)
        fetch.predicate = NSPredicate(format: "id = %@", upCateory.id.uuidString)
        let result = try context.fetch(fetch) as! [Category]
        for item in result {
            item.setValue(upCateory.name, forKey: VMCategory.colName)
            item.setValue(upCateory.image, forKey: VMCategory.colImage)
            app.saveContext()
        }
    }
    
    
}
