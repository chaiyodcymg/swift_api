//
//  Checkin.swift
//  swift_api
//
//  Created by Chaiyod Mali-ngam on 11/6/2565 BE.
//

import SwiftUI

struct Time_check_in : Codable   {
    var date_day: [Date_Day]
}

struct Date_Day: Codable  ,Identifiable {
    let id = UUID()
    var date: String
    var users: [User_Time]
}

struct User_Time: Codable ,Identifiable{
     let id = UUID()
     var name: String
     var time: String
 }



struct Status_checkin : Codable {
    var status:Bool
    var text:String
   

}




//var time_check_in = Time_check_in(date_day: [
//    Date_Day(date: "11 มิ.ย. 2565", users: [
//        User_Time(name: "ไชยยศ มะลิงาม", time: "22:31"),
//        User_Time(name: "อัครเดช ผู้วิเศษ", time: "22:31"),
//        // ...
//    ]),
//    Date_Day(date: "10 มิ.ย. 2565", users: [
//        User_Time(name: "แมว แมวเหมียว", time: "22:31"),
//        User_Time(name: "อัครเดช ผู้วิเศษ", time: "22:31"),
//        // ...
//    ]),
//    // ...
//])

struct Checkin: View {
    
    @State var date_time = [Date_Day]()
    @State var status_checkin = [Status_checkin]()

    @StateObject  var URL_API   = UrlAPI()
   
    @State var show_data = false
    @State var alert_checkin = false
    @State var alert_text_checkin = ""
    @ObservedObject var personalData : PersonalData

    
//    init(){
//        UITableView.appearance().separatorStyle = .none
//        UITableViewCell.appearance().backgroundColor = UIColor(Color.white)
//        UITableView.appearance().backgroundColor = UIColor(Color.white)
//     }
 
    
    func list_check_in_users  ()   {
//        self.progress = true
        let url = URL(string: "\(URL_API.URL)list-users-checkin")!
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
                        if let res = try? JSONDecoder().decode(Time_check_in.self, from: data) {
                           
//                            print("res = ",res)
                            if(res.date_day[0].date != ""){
                                self.show_data = true
                                self.date_time = res.date_day
                            }else{
                                self.show_data = false
                            }
                            
//                            print("res = ", res.date_day[0])

                            
                        }
                    }
                }.resume()
        

     
    }
    
    func check_in_users  ()   {
//        self.progress = true
        let url = URL(string: "\(URL_API.URL)checkin")!
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
        let parameters: [String: String] = ["id": UserDefaults.standard.string(forKey: "session")!,"name":personalData.Name]
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            }catch let err{
                print(err)
            }
       
        URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data = data {
                        if let res = try? JSONDecoder().decode(Status_checkin.self, from: data) {
                           
//                            print("res = ",res)
//                            if(res.date_day[0].date != ""){
//                                self.show_data = true
//                                self.date_time = res.date_day
//                            }
                            if(res.status){
                                self.list_check_in_users()
                                self.alert_checkin = true
                                self.alert_text_checkin = res.text
                            }else{
                                self.alert_checkin = true
                                self.alert_text_checkin = res.text
                            }
                            print("res = ", res.status)

                            
                        }
                    }
                }.resume()
        

     
    }
    
    
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
                                personalData.Status = res.status

                                personalData.Email = res.email
                                personalData.Name = res.name
                                personalData.Admin =  res.admin
                                personalData.ImageUrl = res.imageUrl
                            }
//                            self.page = res.status
                            print("Check =",URL_API.URL+res.imageUrl)
                          
                      
//                            self.progress = false
//                            self.session = res.session
                            
                        }
                    }
                }.resume()
        
      
     
    }
    var body: some View {

        
         
     
     
     VStack{
       
         VStack{
             
             ZStack(alignment: .bottomLeading){
                     LinearGradient(gradient: Gradient(colors: [ Color(red: 0.80, green: 0.40, blue: 1.00), .white]), startPoint: .top, endPoint: .bottom)
                         .ignoresSafeArea(.all, edges: .all)
//                     Color(red: 0.80, green: 0.40, blue: 1.00)
//                         .ignoresSafeArea(.all, edges: .all)
                 HStack{
                     
               
                     AsyncImage(url: URL(string:URL_API.URL+personalData.ImageUrl )){ image in

                             image.resizable()
                             .clipShape(Circle())
                          
                         } placeholder: {
                             ProgressView()
                         }
                         .overlay(Circle().stroke(Color.white, lineWidth: 5))
                      
                         .frame(width: 80, height: 80)
                         .offset(x:40, y: 40)
                   
                     Text(personalData.Name)
                             .font(.system(size: 20))
                             .foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.15))
                             .offset(x:50, y: 40)
                             
                             
                    
                
                 }
                 
            }
                
        .frame( height:75 )
//             Spacer()
         }
         .padding(.bottom,50)
         
         Button {
             print("check in")
             check_in_users()
         } label: {

             HStack{
              
                 Image(systemName: "clock.badge.checkmark")
                 Text( "เช็คอิน")
                  
             }
             .frame(width: UIScreen.main.bounds.width - 40 , height: 45)
             .foregroundColor(Color.purple)
             .font(.system(size: 18))
              .overlay(
              RoundedRectangle(cornerRadius: 5)
                .stroke(Color.purple, lineWidth: 2)
              )
//             Label( "เช็คอิน",systemImage: "clock.badge.checkmark")
//                 .frame(width: UIScreen.main.bounds.width - 100 , height: 45)
//                 .foregroundColor(.blue)
//                 .font(.system(size: 18))
//                 .overlay(
//                 RoundedRectangle(cornerRadius: 5)
//                     .stroke(Color.blue, lineWidth: 2)
//                 )
         }
         .padding(.vertical,20)
       
         
        
//         .offset(x:40, y: 50)

//                     .buttonStyle(.bordered)
//         .offset(x:80, y: 40)
         
    
         
          
         
            if( self.show_data){
                
        
            List {

                ForEach(self.date_time) { date_day in

                    Section(header: Text("วันที่ "+date_day.date)) {

                        ForEach(date_day.users) { person in
                             VStack(alignment: .leading, spacing: 3) {
                                         Text(person.name)
                                             .foregroundColor(.primary)
                                             .font(.headline)
                             HStack(spacing: 3) {
                                 Label  {
                                     Text("เวลาเข้าทำงาน : "+person.time+" น.")
                                 } icon: {
                                     Image(systemName: "person.crop.circle.badge.checkmark")
                                         .foregroundColor(.green)
                                 }


                             }
                             .foregroundColor(.secondary)
                             .font(.subheadline)
                         }
                         }
                    }.listRowBackground(Color(red: 0.95, green: 0.95, blue: 0.95))
                 }
             }
            
            .refreshable {
                list_check_in_users()
            }
                
             
                
            }else{
                ScrollView{
                    Text("ไม่พบข้อมูล...")
                        .font(.system(size: 30) .bold())
                        .padding(.top,50)
                        .listRowBackground(Color(red: 0.95, green: 0.95, blue: 0.97))
                }
                .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity,alignment: .top)
//                .background(Color(red: 0.95, green: 0.95, blue: 0.97))
             
//                .refreshable {
//                    print("refesh")
//                    list_check_in_users()
//                }
                
            }

        }
         .onAppear{
             UITableView.appearance().separatorStyle = .none
             UITableViewCell.appearance().backgroundColor = UIColor(Color.white)
             UITableView.appearance().backgroundColor = UIColor(Color.white)
             
            list_check_in_users()
             person_data()
         }
        .frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0,
               maxHeight: UIScreen.main.bounds.height, alignment: .top)
       
      
        .alert(isPresented: self.$alert_checkin) {
            Alert(
                title:  Text("เช็คอิน"),
                message: Text(self.alert_text_checkin),
                dismissButton: Alert.Button.default(
                        Text("ตกลง"), action: {  }
                    )
            )
        }

     
       
        
        
    }
}

//struct Checkin_Previews: PreviewProvider {
//    static var previews: some View {
//        Checkin()
//    }
//}
