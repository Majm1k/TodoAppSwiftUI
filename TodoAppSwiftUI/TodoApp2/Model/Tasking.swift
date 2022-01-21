//
//  Tasking.swift
//  TodoApp2
//
//  Created by Dima on 06.07.2021.
//

import SwiftUI

struct Tasking: Identifiable {
    
    var id = UUID().uuidString
    var title: String
    var timing: Date
    var cardColor: Color = Color("Blue")
    var turnedOn: Bool = true
    var attribute: String
}

