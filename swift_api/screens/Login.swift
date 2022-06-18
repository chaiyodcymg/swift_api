//
//  Login.swift
//  swift_api
//
//  Created by Chaiyod Mali-ngam on 6/6/2565 BE.
//

import SwiftUI

struct Login: View {
   
    @State var email = ""
    @State var password = ""
    @State var alert = false
    @State var progress = false
    @State var text_mes_api = ""
    @StateObject  var URL_API   = UrlAPI()
    
    @ObservedObject var personalData : PersonalData

    func check_login(email:String , pass:String)   {
        
        self.progress = true
        let url = URL(string: "\(URL_API.URL)login")!
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
        let parameters: [String: String] = ["email": email,"password": pass]
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
                           
                            if(res.status){
                                UserDefaults.standard.set(res.session, forKey: "session")
                                personalData.Status = res.status
                      
//                                personalData.Email = res.email
//                                personalData.Name = res.name
//                                personalData.Admin =  res.admin
//                                personalData.ImageUrl = res.imageUrl
                            }
//                            self.page = res.status
//                            print("Check =",UserDefaults.standard.string(forKey: "session"))
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
            

                VStack{
                    
                
                        HStack{
                            Image(systemName: "person.crop.circle")
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
                }.frame(width: 300, height: 150, alignment: .top)
                    .background(Color.white)
                    .cornerRadius(5)
            
                
            
            
//                        .shadow(color: Color(red: 0.60, green: 0.80, blue: 1.00), radius:30, x: 5, y: 5)
//               NavigationLink( destination:ApiLogin()){
//                   Text("Menu 1")
//               }
            
            Button  {
                check_login(email: self.email, pass: self.password)
            } label: {
                Text("เข้าสู่ระบบ")
                    .foregroundColor(.white)
                    
                    .frame(width: 200, height: 45)
            }
            .background(.purple)
            .cornerRadius(10)
//                           .frame(width: 200, height: 45)
            

            
            Button{
            
                print("Pressddsasdsad")
            } label: {
                Text("ลืมรหัสผ่าน?")
                    .frame(width: 150, height: 30 )
            }.foregroundColor(Color.teal)
            
//                       Text(email)
//                       Text(password)
            
            
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment:.top)
//                       .background(Color(red: 0.60, green: 0.20, blue: 0.60))
            .background(.white)
            .edgesIgnoringSafeArea(.all)
    
    
            .alert( isPresented: self.$alert) {
                Alert(title: Text("เข้าสู่ระบบ"),message: Text(self.text_mes_api),dismissButton: .cancel())
            }
        
                   
    }
    
   
}

//struct Login_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            Login( personalData: personalData)
//            
//        }
//    }
//}
