//
//  StyleUIApp.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 05/09/2022.
//

import SwiftUI

class MainAppStates: ObservableObject {
	@Published var showAnimation: Bool = false
	@Published var imageView: Bool = false
	@Published var roundedButton: Bool = false
	@Published var navBar: Bool = false
	@Published var animations: Bool = false
	@Published var textFields: Bool = false
}

@main
struct StyleUIApp: App {
	
	@StateObject var appStates: MainAppStates = .init()
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(appStates)
        }
    }
}
