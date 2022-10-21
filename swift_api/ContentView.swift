//
//  ContentView.swift
//  swift_api
//
//  Created by Chaiyod Mali-ngam on 4/6/2565 BE.
//

import SwiftUI
import Foundation





struct ContentView: View {

//    @State var showpage = [data_login]()
    @State var results :[data_login] = []
    
//    @State var session =  UserDefaults.standard.string(forKey: "session")

    @State var page = false
 
  
 
    @State var selection_page = 1

    @State var alert_infor = ""
    @StateObject var validate_email_data = Validate_Email_data()
    
   @StateObject var personalData = PersonalData()
    @ObservedObject var networkManager = NetworkManager()
//    @ObservedObject var personalData : PersonalData
   
//    init(){
//        UINavigationBar.appearance().backgroundColor =
//    }
       var body: some View {
           if !networkManager.isConnected {
               ZStack {
                   Color.white.ignoresSafeArea()

                          VStack {
                              Image(systemName: networkManager.imageName)
                                  .resizable()
                                  .scaledToFit()
                                  .frame(width: 200, height: 200)
                                  .foregroundColor(.black)

                              Text(networkManager.connectionDescription)
                                  .font(.system(size: 18, weight: .semibold))
                                  .foregroundColor(.black)
                                  .multilineTextAlignment(.center)
                                  .padding()


                                  Button {
                                      print("Handle action..")
                                  } label: {
                                      Text("ลองอีกครั้ง")
                                          .padding()
                                          .font(.headline)
                                          .foregroundColor(Color(.systemBlue))
                                  }
                                  .frame(width: 140)
                                  .background(Color.white)
                                  .clipShape(Capsule())
                                  .padding()

                          }
                      }




           }else{

               if (personalData.status || UserDefaults.standard.string(forKey: "session") != nil){
         
                 Home()
                      
                   
                      
                   
             

                   
               }else{
                   Login(personalData: personalData)
               }
           }
//
           
       }
  
   
  

    


}






//struct ContentView_Previews: PreviewProvider {
//   
//    static var previews: some View {
//        ContentView()
//    }
//}
