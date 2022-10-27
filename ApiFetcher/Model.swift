//
//  Model.swift
//  ApiFetcher
//
//  Created by Jakub Chodara on 27/10/2022.
//

import Foundation

struct ToDo: Decodable{
    let userId:Int
    let id:Int
    let title:String
    let completed:Bool
}

