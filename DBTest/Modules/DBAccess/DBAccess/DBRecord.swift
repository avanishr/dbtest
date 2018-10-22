//
//  DBRecord.swift
//  DBAccess
//
//  Created by Avanish Rayankula on 10/20/18.
//  Copyright © 2018 Epic. All rights reserved.
//

import Foundation

public enum DBPropertyType {
    case int
    case double
    case string
    case boolean
    case date
    case custom
}

public enum DBRecordType {
    case category
    case timelog
}

public struct DBPropertyDefinition {
    let name: String
    let type: DBPropertyType
    let isMultipleResponse: Bool
    
    public init(name: String, type: DBPropertyType, isMultipleResponse: Bool) {
        self.name = name
        self.type = type
        self.isMultipleResponse = isMultipleResponse
    }
}

public struct DBProperty {
    let type: DBPropertyDefinition
    let value: Any
    
    public init(type: DBPropertyDefinition, value: Any) {
        self.type = type
        self.value = value
    }
}

public struct DBRecord {
    let identifier: String
    let type: DBRecordType
    let properties: [DBProperty]
    
    public init(identifier: String, type: DBRecordType, properties: [DBProperty]) {
        self.identifier = identifier
        self.type = type
        self.properties = properties
    }
}
