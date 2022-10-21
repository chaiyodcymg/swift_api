//
//  Register_validate_email.swift
//  swift_api
//
//  Created by Chaiyot Mali-ngam on 24/9/2565 BE.
//

import SwiftUI


struct Register_validate_email: View {
  
    @State var OTP = ""
    @State var email = ""
    @State var countTimer =  0
    @State var timerRunning = true
    @State var time = ""
    @StateObject  var URL_API   = UrlAPI()
    @ObservedObject var validate_email_data : Validate_Email_data
    @ObservedObject var personalData : PersonalData
    @State var  errAlert = false
    @State var pregress = false
    let timer   = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @FocusState var activeField

    func validate_email(email:String)   {
      
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
        let parameters: [String: String] = ["email": email ,"otp":""]
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        }catch let err{
            print(err)
        }
       
        URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data = data {
                        if let res = try? JSONDecoder().decode(Validate_Email.self, from: data) {
                          
                            DispatchQueue.main.async{
                                countTimer =  res.time_end
                                timerRunning = true
                            }
                           
                         
                            print("Check =",res)
                      
//                            self.alert = true
//                            self.text_mes_api = res.text
//                            self.progress = false
//                            self.session = res.session
                            
                        }
                    }
                }.resume()
        

     
    }
    func send_otp_register (email:String,otp:String)  {
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
        let parameters: [String: String] = ["email": email ,"otp":otp]
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        }catch let err{
            print(err)
        }
       
        URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data = data {
                        if let res = try? JSONDecoder().decode(data_login.self, from: data) {
                           
                            if(res.status){
                                print(res)
                                DispatchQueue.main.async{
                                    UserDefaults.standard.set(res.session, forKey: "session")
                                    personalData.status = res.status
                                    personalData.email = res.email
                                    personalData.name = res.name
                                    personalData.role =  res.role
                                    personalData.imageUrl = res.imageUrl
                                  
                                }
                                
                      

                            }else{
                                DispatchQueue.main.async{
                                    personalData.text = res.text
                                    errAlert = true
                                }
                              
                            }

                         
                            print("Check =",res)
                      
//                            self.alert = true
//                            self.text_mes_api = res.text
//                            self.progress = false
//                            self.session = res.session
                            
                        }
                    }
                }.resume()
    }
    
    var body: some View {
        
        if pregress {
            ZStack{
                Progressbar_screen()
            }
            
        }else{
            
      
        VStack{
            Text("ใส่รหัส 6 หลักจากอีเมลของคุณ")
                .padding(.bottom,20)
                .font(.system(size: 20, weight: .bold))
            Divider()
            Text("ป้อนรหัสจากอีเมลที่ส่งไปที่ :")
                .padding(.top,10)
            Text("\(email)")
                .padding(.bottom,10)
                .font(.system(size: 16, weight: .bold))
        
            TextField("ยืนยันรหัส 6 หลัก",text: self.$OTP)
                .keyboardType(.numberPad)
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(activeField ?  Color.blue : Color.gray, lineWidth: 1))
                .focused($activeField)
               .frame(width: UIScreen.main.bounds.width - 80 )
               
//                .font(.title)
               
           
            
         
            Button {
                send_otp_register(email:self.email,otp: self.OTP)
            } label: {
                Text("ดำเนินการต่อ")
                    .frame(width: UIScreen.main.bounds.width - 100 , height: 30)
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom,10)
            .padding(.top,20)
            if timerRunning{
                
                
                Text("OTP จะหมดอายุในอีก : \(time) นาที")
                    .onReceive(timer){ _ in
                        
                        
                        if countTimer >= 0 && timerRunning{
                            let minutes = countTimer / 60
                            let second = countTimer % 60
                            countTimer -= 1
                            time = String(format: "%02i:%02i",minutes,second)
                        
                            
                            
                        }else{
                            timerRunning = false
                        }
                    }
                    .padding(.bottom,10)
                    .padding(.top,10)
            }else{
                HStack{
                    Text("ยังไม่ได้รับ OTP ")
                    Button {
                        validate_email(email: self.email)
                    } label: {
                        Text("ส่งอีกครั้ง")
                            .underline()
                            .foregroundColor(.black)
                    }
                }
               
            }
//            Divider()
//                .padding(.top,15)
          
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment:.top)
        .padding(30)
        .onAppear{
            countTimer = validate_email_data.time_end
            email = validate_email_data.email
        }
        .alert(isPresented: $errAlert) {
            Alert(title: Text("ยืนยันตัวตน"), message: Text("\(personalData.text)"), dismissButton: .default(Text("ตกลง")))
        }
        }
    }


        
}

//struct Register_validate_email_Previews: PreviewProvider {
//    static var previews: some View {
//        Register_validate_email(validate_email_data: validate_email_data, personalData:personalData)
//    }
//}
