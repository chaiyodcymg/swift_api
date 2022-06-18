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
    
    
   @StateObject var personalData = PersonalData()
    
//    @ObservedObject var personalData : PersonalData
   
    
       var body: some View {
           
           if (personalData.Status || UserDefaults.standard.string(forKey: "session") != nil){
               
               Home( )

           }
           else{
       
               VStack{
                   VStack{
                       Picker("", selection: self.$selection_page) {
                           Text("เข้าสู่ระบบ")
                               .tag(1)
                           Text("สมัครสมาชิก")
                               .tag(2)
                       }
                   }
                   .pickerStyle(.segmented)
                   .background(.white)
                   .padding(.horizontal,10)
                   .padding(.top,20)
                   
                   if( self.selection_page == 1 ){
                       Login(personalData: personalData)
                   }else{
                       Register(personalData: personalData )
                   }
                
                    
               }
               
           
           }
           
           
           
       }
  
   
  

    


}

struct Progressbar_screen: View {


    var body: some View {
        VStack{
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(1.5)
        }
       
//        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .center)
//        .background(.white)
        
    }


}




struct ContentView_Previews: PreviewProvider {
    @StateObject var personalData = PersonalData()
    static var previews: some View {
        ContentView()
    }
}
