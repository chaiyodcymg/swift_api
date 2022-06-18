//
//  Editprofile.swift
//  swift_api
//
//  Created by Chaiyod Mali-ngam on 16/6/2565 BE.
//

import SwiftUI


struct dataEditprofile:Codable{
    var status:Bool
//    var text:String
//    var email:String
//    var name:String
    var imageUrl:String
}


struct Editprofile: View {
    @State var showImagePicker: Bool = false
    @State var image: UIImage?
    @StateObject  var URL_API   = UrlAPI()
  
    @State var imageStr: String?
    @State var imageData: Data?
    var width_height_image:Double = 100
    @State var imageUrl = ""
    @ObservedObject var personalData : PersonalData
    
    @State var progress = false
    @State var email = ""
    @State var name = ""
    @State var password = ""
    
    var body: some View {
        NavigationView{
            
            if(self.progress){
                Progressbar_screen()
            }else{
                
          
            VStack {

                ZStack{
                    if image != nil {
                        Image(uiImage: image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                         .clipShape(Circle())
                         .frame(width: width_height_image, height: width_height_image)
                         .overlay(Circle().stroke(Color(red: 0.90, green: 0.90, blue: 0.90), lineWidth: 10))
                    }else{
              
                        AsyncImage(url: URL(string: URL_API.URL+personalData.ImageUrl)){ image in

                                image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .frame(width: width_height_image, height: width_height_image)
                                .overlay(Circle().stroke(Color(red: 0.90, green: 0.90, blue: 0.90), lineWidth: 10))
                            } placeholder: {
//                                ProgressView()
                                Circle()
                                    .frame(width: width_height_image, height: width_height_image)
                                   
                                    .overlay(Circle().stroke(Color(red: 0.90, green: 0.90, blue: 0.90), lineWidth: 10))
                            }
                            
                            
                    }
                  
                    ZStack{
                        Image(systemName: "camera.fill")
                             .resizable()
                             .frame(width: 25, height:20)
                             .foregroundColor(Color.black)
        
                            
                    }
                    .frame(width: 40, height: 40)
                    .background(Color(red: 0.90, green: 0.90, blue: 0.90))
                    .cornerRadius(75)
                    .offset(x: 30, y: 40)
                    
                    }
                    .onTapGesture {
                        self.showImagePicker.toggle()
                    }
                .frame(width: 300, height: 150, alignment: .top)

//                VStack{
//
//                        HStack{
//                            Image(systemName: "envelope.circle")
//                                .resizable()
//                                .foregroundColor(Color.black)
//
//                                .frame(width: 25, height: 25)
//                            TextField("อีเมล",text: self.$email)
//
//
//                        }
//                        .padding()
//                    Divider()
//                    HStack{
//                        Image(systemName: "person.crop.circle")
//                            .resizable()
//                            .foregroundColor(Color.black)
//
//                            .frame(width: 25, height: 25)
//                        TextField("ชื่อ-นามสกุล",text: self.$name )
//
//
//                    }
//                    .padding()
//                Divider()
//                        HStack{
//                            Image(systemName: "lock.circle")
//                                .resizable()
//                                .foregroundColor(Color.black)
//
//                                .frame(width: 25, height: 25)
//                            SecureField("รหัสผ่าน",text: self.$password)
//
//                        }
//                        .padding()
//                }.frame(width: 300, height: 300, alignment: .top)
//                    .background(Color.white)
//                    .cornerRadius(5)
                Button {
                    UploadImage()
                } label: {
                    Text("บันทึก")
                }

        
            }
            .frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
         
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(sourceType: .photoLibrary) { image in
                        self.image = image
                       
                        self.imageData = image.jpegData(compressionQuality: 0.7)
                        print("image =",self.imageData)
//                        self.imageStr =  imageData.base64EncodedString()
                    }
                }
            }
            
        }
//        .navigationTitle("แก้ไขข้อมูลส่วนตัว")
//        .navigationBarHidden(true)
        .navigationBarItems( trailing:Text("แก้ไขข้อมูลส่วนตัว"))
        .navigationBarTitleDisplayMode(.inline)
  
  
    
    
        
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
                            print("Check =",res)
                          
                      
//                            self.progress = false
//                            self.session = res.session
                            
                        }
                    }
                }.resume()
        
      
     
    }
    func UploadImage(){
        // your image from Image picker, as of now I am picking image from the bundle
//        let image = UIImage(named: "myimg.jpg",in: Bundle(for: type(of:self)),compatibleWith: nil)
//        let imageData = image?.jpegData(compressionQuality: 0.7)
        self.progress = true
        let url =  "\(URL_API.URL)edit_profile"
        var urlRequest = URLRequest(url: URL(string: url)!)

        urlRequest.httpMethod = "post"
        let bodyBoundary = "--------------------------\(UUID().uuidString)"
        urlRequest.addValue("multipart/form-data; boundary=\(bodyBoundary)", forHTTPHeaderField: "Content-Type")
        urlRequest.allHTTPHeaderFields = [
            "x-api-key":URL_API.API_key
            ]
        //attachmentKey is the api parameter name for your image do ask the API developer for this
       // file name is the name which you want to give to the file
        let parameters: String = UserDefaults.standard.string(forKey: "session")!
       
        var requestData = createRequestBody(imageData: self.imageData!, boundary: bodyBoundary, attachmentKey: "profilePicture", fileName: "myTestImage.jpg",id: parameters)
      
        
      
            
     
         
        urlRequest.addValue("\(requestData.count)", forHTTPHeaderField: "content-length")
 
        urlRequest.httpBody = requestData
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    if let data = data {
                        if let res = try? JSONDecoder().decode(dataEditprofile.self, from: data) {
                           
//                            print("res = ",res.status)
//                         self.results.append(res)
                            if(res.status ){

                                person_data()
                                print("res = ",res)
                                
                            }
                            
                            self.progress = false
                        
                         
                            
                        }
                    }
                }.resume()
      
    }
    
    
    func createRequestBody(imageData: Data, boundary: String, attachmentKey: String, fileName: String,id: String) -> Data{
         let lineBreak = "\r\n"
        let user = "id"
        let user2 = "name"
       
         var requestBody = Data()
        
         requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
         requestBody.append("Content-Disposition: form-data; name=\"\(attachmentKey)\"; filename=\"\(fileName)\"\(lineBreak)" .data(using: .utf8)!)
         requestBody.append("Content-Type: image/jpg \(lineBreak + lineBreak)" .data(using: .utf8)!)
         requestBody.append(imageData)
        
        requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
        requestBody.append("Content-Disposition: form-data; name=\"\(user)\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
        requestBody.append(id.data(using: .utf8) ?? Data())
        
        requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
        requestBody.append("Content-Disposition: form-data; name=\"\(user2)\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
        requestBody.append(personalData.Name.data(using: .utf8) ?? Data())
        
        
         requestBody.append("\(lineBreak)--\(boundary)--\(lineBreak)" .data(using: .utf8)!)
   
         return requestBody
     }
    
}
//struct Editprofile_Previews: PreviewProvider {
//    static var previews: some View {
//        Editprofile()
//    }
//}
