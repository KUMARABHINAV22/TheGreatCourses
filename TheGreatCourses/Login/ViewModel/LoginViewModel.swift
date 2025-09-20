//
//  LoginViewModel.swift
//  TheGreatCourses
//
//  Created by KUMAR ABHINAV on 20/09/25.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var rememberMe = false
    @Published var isLoggedIn = false
    @Published var errorMessage: String = "Username and Password should not be empty."
    
    let storageService: StorageServices
    
    private let service = "MockLoginApp"
    
    init(storageService: StorageServices = KeychainStorageServices()) {
        self.storageService = storageService
        loadSavedCredentials()
    }
    
    func login() {
        guard !username.isEmpty, !password.isEmpty else {
            return
        }
        errorMessage = ""
        isLoggedIn = true
        guard rememberMe else {
            clearCredentials()
            return
        }
        saveCredentials()
    }
    
    func delete() {
        clearCredentials()
    }
    
    private func saveCredentials() {
        if let usernameData = username.data(using: .utf8),
           let passwordData = password.data(using: .utf8) {
        
            storageService.save(service: service, usernameData, forKey: "username")
            storageService.save(service: service, passwordData, forKey: "password")
        }
    }
    
    private func loadSavedCredentials() {
        if let savedUsernameData = storageService.load(service: service, forKey: "username"),
           let savedPasswordData = storageService.load(service: service, forKey: "password") {
            
            username = String(data: savedUsernameData, encoding: .utf8) ?? ""
            password = String(data: savedPasswordData, encoding: .utf8) ?? ""
            rememberMe = true
        }
    }
    
    private func clearCredentials() {
        storageService.remove(service: service, forKey: "username")
        storageService.remove(service: service, forKey: "password")
    }
}
