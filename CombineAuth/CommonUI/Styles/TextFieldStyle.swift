//
//  TextFieldStyle.swift
//  CombineAuth
//
//  Created by Darya Zhitova on 29.12.2022.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
      return configuration
            .textFieldStyle(.plain)
            .padding(.horizontal, 8)
            .frame(height: 45)
            .cornerRadius(10)
            .foregroundColor(.white)
            .accentColor(.pink)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
    }
}

