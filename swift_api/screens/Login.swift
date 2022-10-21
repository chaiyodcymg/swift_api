//
//  Login.swift
//  swift_api
//
//  Created by Chaiyod Mali-ngam on 6/6/2565 BE.
//

import SwiftUI

class progress_loading: ObservableObject {
    @Published var isLoading  = false

}


struct Login: View {
   
    @State var email = ""
    @State var password = ""
    @State var alert = false
    @State var progress = false
    @State var text_mes_api = ""
    @StateObject  var URL_API   = UrlAPI()
    
    @ObservedObject var personalData : PersonalData
    @StateObject var validate_email_data = Validate_Email_data()
    @StateObject  var progress_load = progress_loading()
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
                                print(res)
                                UserDefaults.standard.set(res.session, forKey: "session")
                                personalData.status = res.status
                      
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


                    VStack{


                            HStack{
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .foregroundColor(Color.purple)

                                    .frame(width: 25, height: 25)
                                TextField("อีเมล",text: self.$email)

                                    .foregroundColor(.black)
                                    .submitLabel(.go)
                                    .onSubmit {
                                        self.progress = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                                            self.progress = false
                                        }
                                        check_login(email: self.email, pass: self.password)
                                    }

                            }
                            .padding()
                        Divider()
                            HStack{
                                Image(systemName: "lock.circle")
                                    .resizable()
                                    .foregroundColor(Color.purple)

                                    .frame(width: 25, height: 25)
                                SecureField("รหัสผ่าน",text: self.$password)
                                    .foregroundColor(.black)
                                    .submitLabel(.go)
                                    .onSubmit {
                                        self.progress = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                                            self.progress = false
                                        }
                                        check_login(email: self.email, pass: self.password)
                                    }
                            }
                            .padding()
                    }.frame(width: 300, height: 150, alignment: .top)
                        .background(Color.white)
                        .cornerRadius(5)




    //                        .shadow(color: Color(red: 0.60, green: 0.80, blue: 1.00), radius:30, x: 5, y: 5)
    //               NavigationLink( destination:ApiLogin()){
    //                   Text("Menu 1")
    //               }
               HStack{

                   NavigationLink {

                        Forget_password()
                    } label: {
                        Text("ลืมรหัสผ่าน?")

                    }.foregroundColor(Color.teal)



                }
               .frame(width: UIScreen.main.bounds.width - 100, height: 30,alignment: .trailing )


                Button  {
                    self.progress = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                        self.progress = false
                    }
                    check_login(email: self.email, pass: self.password)
                } label: {
                    Text("เข้าสู่ระบบ")
                        .foregroundColor(.white)

                        .frame(width: UIScreen.main.bounds.width - 100 , height: 45)
                }
                .background(.purple)
                .cornerRadius(10)
                .padding(.bottom,10)

                HStack{
                    Rectangle()
                        .fill(Color(red: 0.95, green: 0.95, blue: 0.95))
                        .frame(width:135 ,height: 2)


                         Text("หรือ")
                        .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                    Rectangle()
                        .fill(Color(red: 0.95, green: 0.95, blue: 0.95))
                        .frame(width:135 ,height: 2)

                 }
                 .frame(width: UIScreen.main.bounds.width, height: 30 )
                HStack{

                    NavigationLink {

//                        Register(personalData: personalData, validate_email_data: validate_email_data, progress_load: progress_load)
                        Register_validate_email(validate_email_data: validate_email_data, personalData:personalData)
                    } label: {
                        Text(" สร้างบัญชีผู้ใช้")
                    }
                   
                        
                    }
                   


                }
    //                           .frame(width: 200, height: 45)





    //                       Text(email)
    //                       Text(password)



            }
            .navigationTitle("เข้าสู่ระบบ")
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment:.top)
            .background(.white)
            .edgesIgnoringSafeArea(.all)
            .alert( isPresented: self.$alert) {
                Alert(title: Text("เข้าสู่ระบบ"),message: Text(self.text_mes_api),dismissButton: .cancel())
            }
            .navigationBarHidden(true)
            .padding(.vertical,20)

            } .background(.white)

            if self.progress {
              Progressbar_screen()
            }
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
