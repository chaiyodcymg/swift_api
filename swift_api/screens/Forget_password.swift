//
//  Forget_password.swift
//  swift_api
//
//  Created by Chaiyot Mali-ngam on 27/9/2565 BE.
//

import SwiftUI

struct Forget_password: View {
    @State var email = ""
    var body: some View {
        
        VStack{
           
            VStack{
                Text("ค้นหาอีเมล")
                HStack{
                    Image(systemName: "magnifyingglass.circle.fill")
                        .resizable()
                        .foregroundColor(Color.purple)

                        .frame(width: 25, height: 25)
                    TextField("",text: self.$email)
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .multilineTextAlignment(.center)
                        .frame(width: 280)
                }
             
                Rectangle()
                    .fill(.gray.opacity(0.3))
                    .frame(height: 2)
            }
            .frame(width: 325)
            .padding(.top,10)
            Button {
                
            } label: {
                Text("ค้นหา")
            }
            .padding(.top,20)
            .buttonStyle(.borderless)

        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment:.top)
        .padding(.top,30)
    }
}

struct Forget_password_Previews: PreviewProvider {
    static var previews: some View {
        Forget_password()
    }
}
