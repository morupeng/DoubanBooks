//
//  VMBook.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/10/15.
//  Copyright © 2019年 retey. All rights reserved.
//
import CoreData
import Foundation
class VMBook:NSObject,DateViwModelDelegate{
    
    
     var id: UUID
     var author: String?
     var authorIntro: String?
     var categoryId: UUID?
     var image: String?
     var isban13: String?
     var isbn10: String?
     var pages: Int32?
     var price: String?
     var pubdate: String?
     var publisher: String?
     var summary: String?
     var title: String?
     var binding: String?
    
    override init() {
        id=UUID()
    }
    
    static let entityName = "book"
    static let cloAuthor = "author"
    static let cloAuthorIntro = "authorintro"
    static let cloCategoryId = "categoryid"
    static let cloId = "id"
    static let cloImage = "image"
    static let cloIsban13 = "isban13"
    static let cloIsban10 = "isban10"
    static let cloPages = "pages"
    static let cloPrice = "price"
    static let cloPubdate = "pubdate"
    static let cloPublisher = "publisher"
    static let cloSummary = "summary"
    static let cloTitle = "title"
    static let cloBinding = "binding"
    
    func entityPairs() -> Dictionary<String, Any?> {
        var dic:Dictionary<String,Any?> = Dictionary<String,Any?>()
        dic[VMBook.cloId] = id
        dic[VMBook.cloAuthor] = author
        dic[VMBook.cloAuthorIntro] = authorIntro
        dic[VMBook.cloCategoryId] = categoryId
        dic[VMBook.cloImage] = image
        dic[VMBook.cloIsban13] = isban13
        dic[VMBook.cloIsban10] = isbn10
        dic[VMBook.cloPages] = pages
        dic[VMBook.cloPrice] = price
        dic[VMBook.cloPubdate] = pubdate
        dic[VMBook.cloPublisher] = publisher
        dic[VMBook.cloSummary] = summary
        dic[VMBook.cloTitle] = title
        dic[VMBook.cloBinding] = binding
        return dic
    }
    
    func packageSelf(result: NSFetchRequestResult) {
        let book = result as! Book
        id = book.id!
        author = book.author
        authorIntro = book.authorIntro
        categoryId = book.categoryId
        image = book.image
        isbn10 = book.isbn10
        isban13 = book.isban13
        pages = book.pages
        price = book.price
        pubdate = book.pubdate
        publisher = book.publisher
        summary = book.summary
        title = book.title
        binding = book.binding
    }
   
}
