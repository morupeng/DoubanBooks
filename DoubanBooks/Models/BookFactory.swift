//
//  BookFactory.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/10/14.
//  Copyright © 2019年 2017yd. All rights reserved.
//
import CoreData
import Foundation

class BookFactory {
    var repository : BookRepository
    static var instance : BookFactory?
    
    private init(_ app:AppDelegate) {
        repository = BookRepository(app)
    }
    
    func addBook(book:VMBook) -> (Bool,String?) {
        do {
            if try repository.isExists(book.title!){
                return (false,"同样的图书已经存在")
            }
            repository.insert(vm: book)
            return (true,nil)
        } catch DateError.entityExistsError(let info)  {
            return (false,info)
        }catch {
            return (false,error.localizedDescription)
        }
    }
    
    static func getInstance(_ app:AppDelegate) -> BookFactory{
        if let obj = instance {
            return obj
        }else{
            let token = "net.lzzy.factory.category"
            DispatchQueue.once(token: token, block: {
                if instance == nil{
                    instance = BookFactory(app)
                }
            })
        }
        return instance!
    }
    
    func getAllBooks() throws  -> [VMBook] {
        return try repository.get()
}
}
