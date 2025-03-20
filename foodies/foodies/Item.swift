//
//  Item.swift
//  foodies
//
//  Created by Bryan Bramaskara on 20/03/25.
//

import Foundation //This is a fundamental framework that provides core functionalities like dates, strings, and collections.
import SwiftData

@Model
//final prevents the class from being subclassed, which can improve performance and maintain model integrity.
final class Time {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
final class Name {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
}


