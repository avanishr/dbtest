//
//  DBQuery.swift
//  DBAccess
//
//  Created by Avanish Rayankula on 10/20/18.
//  Copyright © 2018 Epic. All rights reserved.
//

import Foundation
import SQLite3

public class DBQuery {
    private static var db: OpaquePointer?
    private static let DB_NAME: String = "LocalData.sqllite"
    
    public static func insert(record: DBRecord) {
        initDB()
        insertDataFor(record: record)
    }
    
    public static func update(record: DBRecord) {
        print("record updated")
    }
    
    public static func delete(recordWithID: String) {
        print("record deleted")
    }
    
    public static func close() {
        if (db != nil) {
            sqlite3_close(db)
        }
    }
    
    public static func find(recordWithID: String) -> DBRecord {
        initDB()
        fetch(recordWithID: recordWithID)
        let properties: [DBProperty] = []
        let record: DBRecord = DBRecord(identifier: "aaa", type: DBRecordType.category, properties: properties)
        return record
    }
    
    public static func find(recordsOfType: DBRecordType) -> [DBRecord] {
        let properties: [DBProperty] = []
        let record: DBRecord = DBRecord(identifier: "aaa", type: DBRecordType.category, properties: properties)
        return [record]
    }
    
    private static func initDB() {
        if (db != nil) {
            return
        }
        let fileURL = try! FileManager.default.url(for: .applicationDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(DB_NAME)
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        createRecordsTable()
    }
    
    private static func createRecordsTable() {
        let createRecordsTableQuery: String = """
                                                CREATE TABLE IF NOT EXISTS Records (
                                                    id CHAR(255) PRIMARY KEY NOT NULL,
                                                    propertyName CHAR(255),
                                                    propertyValue CHAR(255));
                                                """
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createRecordsTableQuery, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Records table created.")
            } else {
                print("Records table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    private static func insertDataFor(record: DBRecord) {
        let insertQueryString = "INSERT INTO Records (id, propertyName, propertyValue) VALUES (?,?,?);"
        var insertStatement: OpaquePointer?
        
        if (sqlite3_prepare_v2(db, insertQueryString, -1, &insertStatement, nil) == SQLITE_OK) {
            let nsRecordID: NSString = record.identifier as NSString
            
            for property in record.properties {
                let nsPropertyName: NSString = property.type.name as NSString
                let nsPropertyValue: NSString = property.value as! NSString
                sqlite3_bind_text(insertStatement, 1, nsRecordID.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, nsPropertyName.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, nsPropertyValue.utf8String, -1, nil)
            
            
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("Successfully inserted row.")
                } else {
                    print("Could not insert row.")
                }
                sqlite3_reset(insertStatement)
            }
        
        } else {
            print("error preparing insert statement")
        }
        sqlite3_finalize(insertStatement)
    }
    
    private static func fetch(recordWithID: String) {
        let queryString: String = "SELECT * FROM Records WHERE id = ?;"
        var queryStatement: OpaquePointer? = nil
        var dataPrinted: Bool = false
        
        if sqlite3_prepare_v2(db, queryString, -1, &queryStatement, nil) == SQLITE_OK {
            
            let nsRecordID: NSString = recordWithID as NSString
            sqlite3_bind_text(queryStatement, 1, nsRecordID.utf8String, -1, nil)
            
            while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                
                let queryResultCol1 = sqlite3_column_text(queryStatement, 0)
                let queryResultCol2 = sqlite3_column_text(queryStatement, 1)
                let queryResultCol3 = sqlite3_column_text(queryStatement, 2)
                
                let recordID = String(cString: queryResultCol1!)
                let propertyName = String(cString: queryResultCol2!)
                let propertyValue = String(cString: queryResultCol3!)
                dataPrinted = true
                print("Query Result:")
                print("\(recordID) | \(propertyName) | \(propertyValue)")
            }
                
            if (dataPrinted == false) {
                print("Query returned no results")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
    }

}
