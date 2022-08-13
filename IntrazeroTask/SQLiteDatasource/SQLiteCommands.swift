//
//  SQLliteCommands.swift
//  IntrazeroTask
//
//  Created by Bassam on 8/12/22.
//

import Foundation
import SQLite

class SQLiteCommands {
    static var table = Table("images")
    
    // Expressions
    static let id = Expression<String>("id")
    static let author = Expression<String>("author")
    static let photo = Expression<Data>("photo")
    
    // Creating Table
    static func createTable() {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return
        }
        
        do {
            // ifNotExists: true - Will NOT create a table if it already exists
            try database.run(table.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(author)
                table.column(photo)
            })
        } catch {
            print("Table already exists: \(error)")
        }
    }
    
    // Inserting Row
    static func insertRow(_ imageModel:imageModel) -> Bool? {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
        
        do {
            try database.run(table.insert(id <- imageModel.id ?? "",author <- imageModel.author ?? "",photo <- imageModel.photo!))
            return true
        } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            print("Insert row failed: \(message), in \(String(describing: statement))")
            return false
        } catch let error {
            print("Insertion failed: \(error)")
            return false
        }
    }
    
    // Present Rows
    static func presentRows() -> [imageModel]? {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
        
        // Images Array
        var imageArray = [imageModel]()
        
        do {
            for image in try database.prepare(table) {
                
                let idValue = image[id]
                let authorValue = image[author]
                let photoValue = image[photo]
                
                // Create object
                let imageObject = imageModel(id: idValue, author: authorValue, downloadURL: nil, photo: photoValue)
                
                // Add object to an array
                imageArray.append(imageObject)
                
               // print("id \(image[id]), author: \(image[author]), photo: \(image[photo])")
            }
        } catch {
            print("Present row error: \(error)")
        }
        return imageArray
    }
}
