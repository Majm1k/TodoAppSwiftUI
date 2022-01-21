//
//  HomeViewModel.swift
//  TodoApp2
//
//  Created by Dima on 06.07.2021.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var addNewTasks = false
    
    @Published var taskings: [Tasking] = [
        
    ]
}

