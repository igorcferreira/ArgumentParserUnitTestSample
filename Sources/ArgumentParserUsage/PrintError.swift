//
//  File.swift
//  
//
//  Created by Igor Ferreira on 08/07/2021.
//

import Foundation

public enum PrintError: LocalizedError {
    case emptyMessage
    
    public var errorDescription: String? { "Please, inform a message" }
}
