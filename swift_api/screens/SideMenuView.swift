//
//  SideMenuView.swift
//  swift_api
//
//  Created by Chaiyod Mali-ngam on 9/6/2565 BE.
//

import SwiftUI

struct SideMenuView: View {
    @State var loading = false
    var body: some View {
        VStack {
            VStack{
                AsyncImage(url: URL(string: "https://scontent.fbkk9-2.fna.fbcdn.net/v/t39.30808-6/265037037_4583606948423513_6845078172086085211_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeFnJMFayYs-lTj0LeL1-vEmgXLU6bpkhRuBctTpumSFG9qq3aIGeq5SvvL3cIwfb3YPPtjfyTfdKhXMJ9l1PgIu&_nc_ohc=xe1iZd0v-iAAX8VVoo5&_nc_ht=scontent.fbkk9-2.fna&oh=00_AT9qKppgy9vQiAcUi0719MZAH1kbtwRg-ug9mRLZrnOvDg&oe=62A721CE")){ image in
                   
                image.resizable()
                .clipShape(Circle())
                    
                } placeholder: {
                    ProgressView()
                }
             .frame(width: 50, height: 50)
           
                    
                Text("chaiyod@gmail.com")
                    .font(.custom("NotoSerifThai-Regular", size: 20))
                    .foregroundColor(.black)
                Button {
                   
                    UserDefaults.standard.set("", forKey: "session")
                 
                   
                } label: {
                    Text("Logout")
                }
                .font(.custom("NotoSerifThai-Regular", size: 18))
                .foregroundColor(.red)

            }
        
          
          Divider()
            .frame(width: 200, height: 2)
            .background(Color.white)
            .padding(.horizontal, 16)
          
           
          Link(destination: URL(string: "https://apple.com")!) {
            Text("Apple")
          }
          .font(.title)
          .foregroundColor(.black)
          
          Spacer()
        }
        .padding(32)
        .background(Color.white)
        .edgesIgnoringSafeArea(.bottom)
      }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
