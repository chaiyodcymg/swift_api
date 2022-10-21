//
//  Progressbar_screen.swift
//  swift_api
//
//  Created by Chaiyod Mali-ngam on 20/6/2565 BE.
//

import SwiftUI

struct Progressbar_screen: View {

  
    var body: some View {
       
        VStack{
            
      
      
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(1.5)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
           
                .ignoresSafeArea(.all)
        
        }
        .background(Color(red: 0.50, green: 0.50, blue: 0.50).opacity(0.3))
  
    }


}

struct Progressbar_screen_Previews: PreviewProvider {
    static var previews: some View {
        Progressbar_screen()
    }
}
