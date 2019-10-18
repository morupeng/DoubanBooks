//
//  DateError.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/10/14.
//  Copyright © 2019年 retey. All rights reserved.
//


import Foundation
enum DateError:Error{
    case readCollectionError(String)
    case readSingleError(String)
    case entityExistsError(String)
    case deleteEntityError(String)
    case updateEntityError(String)
}
