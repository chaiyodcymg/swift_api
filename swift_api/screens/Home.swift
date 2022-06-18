//
//  Home.swift
//  swift_api
//
//  Created by Chaiyod Mali-ngam on 6/6/2565 BE.
//

import SwiftUI

struct Home: View {
    @State var check = false
    @State private var showMenu: Bool = false
    @State var progress = false
  
    var list_menu = ["เช็คอินเข้างาน","ผู้ป่วย","ภาพรวม","สินค้าคงคลัง","ตารางเวร"
                     ,"การแจ้งเคือน","ตารางนัดผู้ป่วย","Admin","ค่าใช้จ่าย"]
    var menu = [1:"Check in เข้างาน",2:"ผู้ป่วย"]
    @State var alert = false
   
   @State var select_page = 1
    @State var header_page = "เช็คอินเข้างาน"
    @State var name_split  = ""
    @State var edit_profile  = false
    @State var imageUrl = ""
    
    @StateObject  var URL_API   = UrlAPI()
    @StateObject var personalDatavalue = PersonalData()
//    @ObservedObject var personalData : PersonalData
    
  
    
    
  
    var body: some View {
        
      
        
        if self.check  {
          
            ContentView()
        }else if(self.progress){
            Progressbar_screen()
        }else{
           
            NavigationView {
                
                  ZStack {
                     
//                      Color.purple.ignoresSafeArea(.all, edges: .all)
                  
                    VStack {
//                        HStack{
//                            Text(self.header_page)
//                                .padding(.leading)
//                                .font(.system(size: 22) .bold())
//                                .foregroundColor(.black)
//                        }
//                        .padding(.top,-32)
//                        .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0,maxHeight: 20,alignment: .topLeading)
                    

                        switch self.select_page {
                            case 1 :
                                Checkin(personalData: personalDatavalue)
                            case 2 :
                                Text("page 2")
                            case 3 :
                                Text("page 3")
                            case 4 :
                                Text("page 4")
                            case 5 :
                                Text("page 5")
                            case 6 :
                                Text("page 6")
                            case 7 :
                                Text("page 7")
                            case 8 :
                                Text("page 8")
                            case 9 :
                                Text("page 9")
                            

                        default:
                            Checkin(personalData: personalDatavalue)
                        }

                    }
//                    .background(Color(red: 0.95, green: 0.95, blue: 0.97))
                      
                    GeometryReader { _ in
                     
                      HStack {
                        
                        Spacer()
//                 ************************************************************************************
                          VStack {




                              NavigationLink {
                                 
                                  Editprofile(personalData: personalDatavalue)
                              } label: {
                                
                                  VStack{
                            

                                      AsyncImage(url: URL(string:URL_API.URL+personalDatavalue.ImageUrl)){ image in

                                  image.resizable()
                                  .clipShape(Circle())

                                  } placeholder: {
                                      ProgressView()
                                  }
                               .frame(width: 70, height: 70)
                              
                                      Text(personalDatavalue.Name)
                                  .font(.system(size: 17).weight(Font.Weight.bold))
                                  .foregroundColor(.black)
                                      
                                  }
                                  .onDisappear{
                                      self.showMenu.toggle()
                                  }
                                  
                                  
                              }
                             
//                            Text( UserDefaults.standard.string( forKey: "email")!)
//                                      .font(.custom("NotoSerifThai-Regular", size: 16))
//                                      .foregroundColor(.black)
                                  

                             
//                          .background(.black)
//                              .onTapGesture {
//                                  self.select_page = 10
//                                  self.header_page = "แก้ไขข้อมูลส่วนตัว"
//                                  self.showMenu.toggle()
//                              }
                            

                            Divider()
                              .frame(width: 200, height: 5)
                              .background(Color.white)
//                              .padding(.bottom, 5)
                              ScrollView{
                                  VStack{

                                      ForEach(list_menu.indices) { index in
                                        Button {

                                            self.select_page = index+1
                                            self.showMenu = false
                                            self.header_page = list_menu[index]
                                        } label: {

                                            Text("\(list_menu[index])")
                                                .padding(.vertical, 5)
                                        }
                                        .padding(.bottom, 5)
    //                                      Divider()
    //                                          .padding(.bottom, 5)
                                      }



                                  } .font(.system(size: 17))
                                      .foregroundColor(.black)
                                      .frame(width: 200)
                                    
                               
                              }
                              .background(Color.white)
                               
                                                
                              
                           
                              Divider()
                                  .frame(width: 200)
                              
                              VStack{
                                  Button {
    //                                    self.check = true
                                      self.alert = true

                                  } label: {
                                      Text("ออกจากระบบ")
                                  }
                                  .font(.system(size: 17))
                                  .foregroundColor(.red)
                                  
                              }
                              .frame(width: 200, height: 200, alignment: .top)
                            
                              

                          }
                          .padding(32)
                          .background(Color.white)
                          .edgesIgnoringSafeArea(.bottom)
                          
        //                 ************************************************************************************
                          .offset(x: showMenu ? 0 : UIScreen.main.bounds.width)
                          .animation(.easeInOut(duration: 0.4), value: showMenu)
//                          .frame( minHeight:UIScreen.main.bounds.height, maxHeight: .infinity, alignment: .center)
                  
                      
                          
                          
                      }
                      
                    }
                    
                    .background(Color.black.opacity(showMenu ? 0.5 : 0))
                 
                  }
            
                  .navigationTitle(" ")
                 
                  .navigationBarTitleDisplayMode(.inline)
               
                  .toolbar {
                    
                    Button {
                      self.showMenu.toggle()
                    } label: {
                      
                      if showMenu {
                        
                        Image(systemName: "xmark")
                              .resizable()
                          .font(.title)
                          .foregroundColor(.black)
                          .frame(width: 18, height: 18)
                          
                        
                      } else {
                        Image(systemName: "text.justify.right")
                              .resizable()
                          .font(.title)
                          .foregroundColor(.black)
                          .frame(width: 20, height: 20)
                      }
                      
                    }
                  }
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
                            self.progress = true
                            UserDefaults.standard.removeObject(forKey: "session")
                            self.check = true
                            self.progress = false
                        }
                    )
                )
            }
            
           
          
            
            
    }

    }
  
}

//struct Home_Previews: PreviewProvider {
//    @StateObject var personalData = PersonalData()
//    static var previews: some View {
//        Home(personalData: personalData)
//    }
//}
