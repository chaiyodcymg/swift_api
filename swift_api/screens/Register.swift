//
//  Register.swift
//  swift_api
//
//  Created by Chaiyod Mali-ngam on 18/6/2565 BE.
//

import SwiftUI



struct Register: View {
    @State var name = "pack haha"
    @State var email = "chaiyod.cymg@gmail.com"
    @State var password = "12345678"
    @State var role = "1"
    @State var alert = false
    @State var progress = true
    
    @State var text_mes_api = ""
    
    @StateObject  var URL_API   = UrlAPI()
    @ObservedObject var personalData : PersonalData
    @ObservedObject var validate_email_data : Validate_Email_data
    @State var changepage = false
    @State var  errAlert = false
    @State var pregress = false
    
    @ObservedObject  var progress_load : progress_loading
    
    @Environment(\.presentationMode) var presentationMode
    
    func validate_email(email:String , pass:String,name:String,role:String)   {
      
        let url = URL(string: "\(URL_API.URL)validatemail")!
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
        let parameters: [String: String] = ["email": email,"password": pass,"name":name,"role":role]
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        }catch let err{
            print(err)
        }
       
        URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data = data {
                        if let res = try? JSONDecoder().decode(Validate_Email.self, from: data) {
                           
                            if(!res.email.isEmpty){
                                
                          
                            DispatchQueue.main.async{
                                validate_email_data.email = res.email
                                validate_email_data.time_end = res.time_end
                            }
                                print("Check =",res)
                                self.changepage = true
           
                    
                            }else{
                                errAlert = true
                            }
                     
//                            self.alert = true
//                            self.text_mes_api = res.text
//                            self.progress = false
//                            self.session = res.session
                            
                        }
                    }
                }.resume()
        

     
    }
  
    
    var body: some View {
     if(changepage){
            Register_validate_email(validate_email_data: validate_email_data, personalData:personalData)
        }else{
           
       
            
        
//                VStack{
//                    ProgressView()
//
//                  .edgesIgnoringSafeArea(.all)
//
//                }
//                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment:.center)
//                .background(Color(red: 0.50, green: 0.50, blue: 0.50).opacity(0.3))
                
                NavigationView{
                    ZStack{
                        
                   
                    ScrollView{



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
                                           .foregroundColor(Color.black)

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
                                   HStack{
                                       Text("ตำแหน่ง :")
                                           .padding(.trailing,10)

                                       Picker(selection:$role) {
                                           Text("พยาบาล").tag("1")
                                           Text("ผู้ช่วยพยาบาล").tag("2")
                                           Text("ผู้ดูแลระบบ").tag("3")
                                       } label: {
                                           Text("พยาบาล")
                                       }
                                   }




                               }.frame(width: 300, alignment: .top)
                                   .background(Color.white)
                                   .cornerRadius(5)
                                   .padding(.bottom,10)



        //                        .shadow(color: Color(red: 0.60, green: 0.80, blue: 1.00), radius:30, x: 5, y: 5)
            //               NavigationLink( destination:ApiLogin()){
            //                   Text("Menu 1")
            //               }

                           Button  {

                               self.email =  self.email.trimmingCharacters(in: .whitespacesAndNewlines)
                               self.password = self.password.trimmingCharacters(in: .whitespacesAndNewlines)
                               self.name = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
                               self.text_mes_api = "คุณไม่ได้ให้ข้อมูลที่สมบูรณ์ กรุณากรอก ชื่อ-นามสกุล หรือ อีเมล์ และ/หรือ รหัสผ่านควรมีความยาวอย่างน้อย 8 ตัวอักษร"

                               if(!self.email.isEmpty && !self.password.isEmpty && !self.name.isEmpty){


                                   if( self.password.count < 8 || self.email.count < 0){
                                       self.alert = true

                                   }else{

                                       validate_email(email: self.email, pass: self.password,name: self.name,role: self.role)
                                   }
        //                                   print(self.email.trimmingCharacters(in: .whitespacesAndNewlines).count)
        //                                   print(self.password.count)
        //                                   check_register(email: self.email, pass: self.password)
                               }else{
                                   self.alert = true

                               }
                           } label: {
                               Text("สมัครสมาชิก")
                                   .foregroundColor(.white)

                                   .frame(width: UIScreen.main.bounds.width - 100, height: 45)
                           }
                           .background(.purple)
                           .cornerRadius(10)


                       }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment:.top)
        //                       .background(Color(red: 0.60, green: 0.20, blue: 0.60))
                           .background(.white)
                           .navigationBarHidden(true)



                           .alert( isPresented: self.$alert) {
                               Alert(title:  Text("สมัครสมาชิก"), message: Text(self.text_mes_api), dismissButton: .cancel())
                           }
                    }
                    .background(.white)
                    if self.progress {
//                      Progressbar_screen()
                     
                    }
                    }
                }.alert(isPresented: $errAlert) {
                    Alert(title: Text("สมัครสมาชิก"), message: Text("อีเมลนี้มีผู้ใช้งานแล้ว กรุณาใส่อีเมลอื่น"), dismissButton: .default(Text("ตกลง")))
                }
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            if !self.progress {
                                presentationMode.wrappedValue.dismiss()
                            }
                           
                        } label: {
                            Image(systemName: "arrow.backward")
                                .resizable()
                                .foregroundColor(Color.purple)

                                .frame(width: 25, height: 20)
                        }
                      

                    }
                }
                .navigationBarBackButtonHidden(true)
                
                    
                
                
            }
         
  
//        .onAppear{
//            UINavigationBar.appearance().backgroundColor = UIColor(displayP3Red: 44/255, green: 65/255, blue: 80/255, alpha: 1.0)
//        }
           
    }
        
}

//struct Register_Previews: PreviewProvider {
//    static var previews: some View {
//        Register()
//    }
//}
