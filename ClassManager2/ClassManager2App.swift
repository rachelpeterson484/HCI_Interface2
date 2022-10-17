//
//  HCI_ProjectApp.swift
//  HCI_Project
//
//  Created by Rachel Peterson on 9/7/22.
//

import SwiftUI

@main
struct ClassManagerApp2: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                //MainMenu(number: 1)
                HomeworkView(assignmentList: Assignment.sampleData)
            }
        }
    }
}

