//
//  Menu.swift
//  swift_api
//
//  Created by Chaiyod Mali-ngam on 20/6/2565 BE.
//

import SwiftUI

struct Menu: View {
 
    @StateObject  var URL_API   = UrlAPI()
    @StateObject var personalData = PersonalData()
    @State var alert = false
    @ObservedObject var StatusLogout : CheckLogout
    @ObservedObject var status_progress : CheckProgress
    func person_data ()   {
        
//        self.progress = true
        let url = URL(string: "\(URL_API.URL)personal_data")!
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
        let parameters: [String: String] = ["id": UserDefaults.standard.string(forKey: "session")!]
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
//
                                personalData.status = res.status

                                personalData.email = res.email
                                personalData.name = res.name
                                personalData.role =  res.role
                                personalData.imageUrl = res.imageUrl
                            }
//                            self.page = res.status
                            print("Check =",URL_API.URL+res.imageUrl)
                          
                      
//                            self.progress = false
//                            self.session = res.session
                            
                        }
                    }
                }.resume()
        
      
     
    }
    var list_menu = ["ภาพรวม","ตารางเวร"
                     ,"ตารางนัดผู้ป่วย","แอดมิน","ค่าใช้จ่าย"]
    var body: some View {
        
       
            
       
        NavigationView{

            ScrollView{
                
                    
                
                VStack(alignment: .center){

                  
                        
                 
                    VStack(alignment: .leading){
                        
                       
                          
                            NavigationLink {
                                Editprofile(personalData: personalData,status_progress:  status_progress)
                            }  label: {
                            

                                    HStack{
                                        AsyncImage(url: URL(string:URL_API.URL+personalData.imageUrl)){ image in

                                              image.resizable()
                                              .clipShape(Circle())
                                              .frame(width: 70, height: 70)
                                              .padding(.trailing,10)
                                              } placeholder: {
                                                  Image(systemName: "person.circle.fill")
                                                .resizable()
                                                  .frame(width: 70, height: 70)
                                                  .padding(.trailing,10)
                                                  .foregroundColor(.gray)
                                              }



                                        VStack(alignment: .leading){
                                            Text(personalData.name)
                                            .font(.system(size:20).weight(Font.Weight.bold))
                                            .foregroundColor(.purple)
                                            .padding(.bottom,3)

                                            HStack{
                                                Text("แก้ไขข้อมูลส่วนตัว")
                                                .font(.system(size: 15).weight(Font.Weight.black))


                                                Image(systemName: "chevron.right")
                                                     .font(.system(size: 12))
                                                 }
                                            .foregroundColor(Color(red: 0.50, green: 0.50, blue: 0.50))
                                            }

                                        }
                                    .frame(height: 80)


                            }
                       
                        Rectangle()
                            .fill(Color(red: 0.95, green: 0.95, blue: 0.95))
                            .frame(height: 10)
                            .padding(.leading,-20)
                        
                        VStack(alignment: .leading){


                        NavigationLink {
                            Text("ภาพรวม")
                        } label: {
                            HStack {
                                Image(systemName: "checklist")
                                    .font(.system(size: 21))
                                    .padding(.trailing,3)
                                    .foregroundColor(Color(red: 0.20, green: 0.60, blue: 0.20))
                                Text("ภาพรวม")
                                    .font(.system(size: 18))

                                Spacer()
                                Image(systemName: "chevron.right")
                                     .font(.system(size: 12))
                                     .foregroundColor(Color(red: 0.50, green: 0.50, blue: 0.50))

                            }
                            .foregroundColor(Color.black)
                            .frame( height: 40)
                            .padding(.trailing,20)
                        }

                        Divider()
                            .padding(.leading,-20)


                        NavigationLink {
                            Text("ตารางเวร")
                        } label: {
                            HStack {
                                Image(systemName: "calendar.badge.clock")
                                    .font(.system(size: 21))
                                    .padding(.trailing,3)
                                    .foregroundColor(Color(red: 0.70, green: 0.00, blue: 0.00))
                                Text("ตารางเวร")
                                    .font(.system(size: 18))
                                Spacer()
                                Image(systemName: "chevron.right")
                                     .font(.system(size: 12))
                                     .foregroundColor(Color(red: 0.50, green: 0.50, blue: 0.50))
                            }
                            .foregroundColor(Color.black)
                            .frame( height: 40)
                            .padding(.trailing,20)

                        }

                        Divider()
                            .padding(.leading,-20)

                        NavigationLink {
                            Text("ตารางนัดผู้ป่วย")
                        } label: {
                            HStack {
                                Image(systemName: "person.crop.circle.badge.clock")
                                    .font(.system(size: 21))
                                    .padding(.trailing,3)
                                    .foregroundColor(Color(red: 0.00, green: 0.60, blue: 1.00))
                                Text("ตารางนัดผู้ป่วย")
                                    .font(.system(size: 18))
                                Spacer()
                                Image(systemName: "chevron.right")
                                     .font(.system(size: 12))
                                     .foregroundColor(Color(red: 0.50, green: 0.50, blue: 0.50))
                            }
                            .foregroundColor(Color.black)
                            .frame( height: 40)
                            .padding(.trailing,20)
                        }

                        Divider()
                            .padding(.leading,-20)

                        NavigationLink {
                            Text("แอดมิน")
                        } label: {
                            HStack {
                                Image(systemName: "person.badge.key")
                                    .font(.system(size: 21))
                                    .padding(.trailing,3)
                                    .foregroundColor(Color(red: 0.20, green: 0.60, blue: 0.20))
                                Text("แอดมิน")
                                    .font(.system(size: 18))
                                Spacer()
                                Image(systemName: "chevron.right")
                                     .font(.system(size: 12))
                                     .foregroundColor(Color(red: 0.50, green: 0.50, blue: 0.50))
                            }
                            .foregroundColor(Color.black)
                            .frame( height: 40)
                            .padding(.trailing,20)
                        }

                            Divider()
                                .padding(.leading,-20)

                        NavigationLink {
                            Text("ค่าใช้จ่าย")
                        } label: {
                            HStack {
                                Image(systemName: "bahtsign.circle")
                                    .font(.system(size: 21))
                                    .padding(.trailing,3)
                                    .foregroundColor(Color.orange)
                                Text("ค่าใช้จ่าย")
                                    .font(.system(size: 18))
                                Spacer()
                                Image(systemName: "chevron.right")
                                     .font(.system(size: 12))
                                     .foregroundColor(Color(red: 0.50, green: 0.50, blue: 0.50))
                            }
                            .foregroundColor(Color.black)
                            .frame( height: 40)
                            .padding(.trailing,20)
                        }
                            Divider()
                                .padding(.leading,-20)
                        }
                       
                        
                      
                      
                     
                        }.padding(.leading,20)
                    
                       
                        
                        Button {
                            print("logout")
                            self.alert = true
                            
                        } label: {
                            HStack{
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                     .font(.system(size: 20))
                                     .foregroundColor(Color.red)
                                Text("ออกจากระบบ")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color.black)
                            }
                          
                        }
                        .padding(.top,20)
                        .padding(.leading,0)
        //                .buttonStyle(.bordered)
              
                    
                }
                .padding(.vertical,60)
                
               
            }
            .alert(isPresented: self.$alert) {
                         Alert(
                             title: Text("Logout"),
                             message: Text("Do you want to logout?"),
                             primaryButton: .default(
                                 Text("Cancle"),
                                 action: {
         
                                 }
                             ),
                             secondaryButton: .destructive(
                                 Text("Logout"),
                                 action: {
                                                                        
                                    
                                   
                                         UserDefaults.standard.removeObject(forKey: "session")
                                         StatusLogout.Statuslogout = true
                                       

                                    
                                 }
                             )
                         )
                     }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
         
            .background(Color.white)
            .navigationBarHidden(true)
            .navigationTitle("เมนู")
            .ignoresSafeArea(.all)
            
        }
        
    }
}

//struct Menu_Previews: PreviewProvider {
//    static var previews: some View {
//        Menu()
//    }
//}
