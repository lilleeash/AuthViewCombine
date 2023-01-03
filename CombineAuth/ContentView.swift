//
//  ContentView.swift
//  CombineAuth
//
//  Created by Darya Zhitova on 29.12.2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color.dark
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                Image("Boy")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width / 1.25, height: UIScreen.main.bounds.width / 1.25)
                
                VStack(spacing: 30) {
                    
                    Text("Authorization")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .padding(8)
                    
                    VStack(spacing: 20) {
                        CustomTextField(title: "E-mail", text: $viewModel.email, prompt: viewModel.emailPrompt)
                        
                        CustomTextField(title: "Phone", text: $viewModel.phone, prompt: viewModel.phonePrompt)
                            .onChange(of: viewModel.phone) { newValue in
                                DispatchQueue.main.async {
                                    viewModel.phone = viewModel.phone.formattedMask(text: viewModel.phone, mask: "+X (XXX) XXX-XX-XX")
                                }
                            }
                        
                        CustomTextField(title: "Password", text: $viewModel.password, prompt: viewModel.passwordPrompt, isSecure: true)
                    }
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding()
                    
                    Button {} label: {
                        ZStack {
                            if viewModel.canSubmit {
                                AnimatedGradient(colors: [Color.cyan, Color.purple])
                            } else  {
                                Rectangle()
                                    .foregroundColor(.gray)
                            }
                            Text("Login")
                                 .foregroundColor(.white)
                                 .fontDesign(.rounded)
                                 .fontWeight(.semibold)
                        }
                        .frame(width: 120, height: 45)
                        .cornerRadius(10)
                    }
                    .disabled(!viewModel.canSubmit)

                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
