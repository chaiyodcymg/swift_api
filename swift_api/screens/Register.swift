//
//  Register.swift
//  swift_api
//
//  Created by Chaiyod Mali-ngam on 18/6/2565 BE.
//

import SwiftUI

struct Register: View {
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @State var alert = false
    @State var progress = false
    
    @State var text_mes_api = ""
    
    @StateObject  var URL_API   = UrlAPI()
    
    @ObservedObject var personalData : PersonalData
    
    func check_register(email:String , pass:String,name:String)   {
        self.progress = true
        let url = URL(string: "\(URL_API.URL)register")!
        var request = URLRequest(url: url)
     
    //    var status:Bool
    //    var text:String
    //    request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "x-api-key": URL_API.API_key
            
        ]
        request.httpMethod = "POST"
        let parameters: [String: String] = ["email": email,"password": pass,"name":name]
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        }catch let err{
            print(err)
        }
       
        URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data = data {
                        if let res = try? JSONDecoder().decode(data_login.self, from: data) {
                           
//                            print("res = ",res.status)
//                         self.results.append(res)
                            if(res.status ){
                                UserDefaults.standard.set(res.session, forKey: "session")
                                personalData.Status = res.status
//                                personalData.Email = res.email
//                                personalData.Name = res.name
//                                personalData.Admin =  res.admin
//                                personalData.ImageUrl = res.imageUrl
                              
                            }
                            
                           
                            print("Check =",res)
                            self.alert = true
                            self.text_mes_api = res.text
                            self.progress = false
//                            self.session = res.session
                            
                        }
                    }
                }.resume()
        

     
    }
    
    
    var body: some View {
        
               VStack {
                   
                   Image("logo")
                       .resizable()
                       .aspectRatio(contentMode: .fit)
                       .frame(width: 150, height: 150)
                       .clipShape(Circle())
                       .overlay(Circle().stroke(Color.purple, lineWidth: 5))
                       .padding()
                   
//                    Text("Login")
//                        .font(.custom("NotoSerifThai-Regular", size: 38))
//                        .foregroundColor(.white)
//                    Text("Chaiyot Mali-Ngam")
//                        .font(.custom("Teko-Light", size: 32))
//                        .foregroundColor(.white)
                   
                  
                       VStack{
                           HStack{
                               Image(systemName: "person.crop.circle")
                                   .resizable()
                                   .foregroundColor(Color.purple)
                                   
                                   .frame(width: 25, height: 25)
                               TextField("ชื่อ - นามสกุล",text: self.$name)
                               
                       
                           }
                           .padding()
                           Divider()
                               HStack{
                                   Image(systemName: "envelope.circle")
                                       .resizable()
                                       .foregroundColor(Color.purple)
                                       
                                       .frame(width: 25, height: 25)
                                   TextField("อีเมล",text: self.$email)
                                   
                           
                               }
                               .padding()
                           Divider()
                               HStack{
                                   Image(systemName: "lock.circle")
                                       .resizable()
                                       .foregroundColor(Color.purple)
                                       
                                       .frame(width: 25, height: 25)
                                   SecureField("รหัสผ่าน",text: self.$password)
                                      
                               }
                               .padding()
                       }.frame(width: 300, alignment: .top)
                           .background(Color.white)
                           .cornerRadius(5)
                   
                      
                   
                   
//                        .shadow(color: Color(red: 0.60, green: 0.80, blue: 1.00), radius:30, x: 5, y: 5)
    //               NavigationLink( destination:ApiLogin()){
    //                   Text("Menu 1")
    //               }
                  
                   Button  {
                       self.email =  self.email.trimmingCharacters(in: .whitespacesAndNewlines)
                       self.password = self.password.trimmingCharacters(in: .whitespacesAndNewlines)
                       self.name = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
                       self.text_mes_api = "คุณไม่ได้ให้ข้อมูลที่สมบูรณ์ กรุณากรอก ชื่อ-นามสกุล หรือ อีเมล์ และ/หรือ รหัสผ่าน รหัสผ่านควรมีความยาวอย่างน้อย 8 ตัวอักษร"
                       
                       if(!self.email.isEmpty && !self.password.isEmpty && !self.name.isEmpty){
                          
                        
                           if( self.password.count < 8 || self.email.count < 0){
                               self.alert = true
                               
                           }else{
                               print("not empty")
                               check_register(email: self.email, pass: self.password,name: self.name)
                           }
//                                   print(self.email.trimmingCharacters(in: .whitespacesAndNewlines).count)
//                                   print(self.password.count)
//                                   check_register(email: self.email, pass: self.password)
                       }else{
                           self.alert = true
                           print("empty")
                       }
                   } label: {
                       Text("สมัครสมาชิก")
                           .foregroundColor(.white)
                           
                           .frame(width: 200, height: 45)
                   }
                   .background(.purple)
                   .cornerRadius(10)

                   
               }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment:.top)
//                       .background(Color(red: 0.60, green: 0.20, blue: 0.60))
                   .background(.white)
                   .edgesIgnoringSafeArea(.all)
               
                   
           
                   .alert( isPresented: self.$alert) {
                       Alert(title:  Text("สมัครสมาชิก"), message: Text(self.text_mes_api), dismissButton: .cancel())
                   }
//                           .alert( isPresented: self.$alert_infor) {
//                               Alert(title: Text("Register"), message: Text("You have not provided complete information. Please enter email address and/or Password. Password should be at least 8 characters long."), dismissButton: .cancel())
//                           }
           
    }
}

//struct Register_Previews: PreviewProvider {
//    static var previews: some View {
//        Register()
//    }
//}
