//
//  ViewModel.swift
//  CombineAuth
//
//  Created by Darya Zhitova on 29.12.2022.
//

import Foundation
import Combine

final class ViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var phone = ""
    
    @Published var canSubmit = false
    
    @Published private var isValidPhone = false
    @Published private var isValidEmail = false
    @Published private var isValidPassword = false
    
    var emailPrompt: String? {
        if isValidEmail == true || email.isEmpty {
            return nil
        } else {
            return "Enter valid Email. Example: test@test.com"
        }
    }

    var phonePrompt: String? {
        if isValidPhone == true || phone.isEmpty {
            return nil
        } else {
            return "Enter full phone number"
        }
    }
    
    var passwordPrompt: String? {
        if isValidPassword == true || password.isEmpty {
            return nil
        } else {
            return "Password - requerid field"
        }
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private let emailPredicate = NSPredicate(format: "SELF MATCHES %@", Regex.email.rawValue)
    private let phonePredicate = NSPredicate(format: "SELF MATCHES %@", Regex.phone.rawValue)
    
    init() {
        $email
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { email in
                return self.emailPredicate.evaluate(with: email)
            }
            .assign(to: \.isValidEmail, on: self)
            .store(in: &cancellableSet)
        
        $password
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { password in
                return password.count >= 8
            }
            .assign(to: \.isValidPassword, on: self)
            .store(in: &cancellableSet)
        
        $phone
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { phone in
                return self.phonePredicate.evaluate(with: phone)
            }
            .assign(to: \.isValidPhone, on: self)
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest3($isValidEmail, $isValidPhone, $isValidPassword)
            .map { first, second, third in
                return (first && second && third)
            }
            .assign(to: \.canSubmit, on: self)
            .store(in: &cancellableSet)
        
    }
}
