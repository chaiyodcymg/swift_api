//
//  Editprofile.swift
//  swift_api
//
//  Created by Chaiyod Mali-ngam on 16/6/2565 BE.
//

import SwiftUI


struct dataEditprofile:Codable{
    var status:Bool
    var text:String


}


struct Editprofile: View {
    @State var showImagePicker: Bool = false
    @State var image: UIImage?
    @StateObject  var URL_API   = UrlAPI()
  
    @State var imageStr: String?
    @State var imageData: Data? = nil
    var width_height_image:Double = 100
    @State var imageUrl = ""
    @ObservedObject var personalData : PersonalData
    
    @State var progress = true
    @State var email = ""
    @State var name = ""
    @State var password = ""
    @FocusState var nameFocus :Bool
    @State var name2 = ""
   @State var Change = false
    
    @ObservedObject var status_progress : CheckProgress
    var body: some View {
       
      
      
    NavigationView{
      
          
                
          
       
            
          
            VStack{

                
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

                             AsyncImage(url: URL(string: URL_API.URL+personalData.imageUrl)){ image in

                                     image
                                     .resizable()
                                     .aspectRatio(contentMode: .fill)
                                     .clipShape(Circle())
                                     .frame(width: width_height_image, height: width_height_image)

                                     .overlay(Circle().stroke(Color(red: 0.90, green: 0.90, blue: 0.90), lineWidth: 10))


                                 } placeholder: {
                                     Image(systemName: "person.circle.fill")
                                   .resizable()
                                         .frame(width: width_height_image, height: width_height_image)
                                         .foregroundColor(Color(red: 0.90, green: 0.90, blue: 0.90))
                                         .overlay(Circle().stroke(Color(red: 0.90, green: 0.90, blue: 0.90), lineWidth: 10))
                                 }




                         }


                     Image(systemName: "camera.fill")
                             .resizable()
                             .frame(width: 25, height:20)
                             .foregroundColor(Color.black)
                         .frame(width: 40, height: 40)
                         .background(Color(red: 0.90, green: 0.90, blue: 0.90))
                         .cornerRadius(75)
                         .offset(x: 30, y: 40)

                      

                     }
                 
               

//            Text("เปลี่ยนรูปโปรไฟล์")
//                .foregroundColor(Color.blue)
//                .padding(.top,20)
                    }
                .frame(width:150, height:130, alignment: .top )
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(sourceType: .photoLibrary) { image in
                        self.image = image
                        self.imageData = image.jpegData(compressionQuality: 0.7)
                        print("image =",self.imageData)

                    }
                } .onTapGesture {

                        self.showImagePicker.toggle()
                }
                    .onAppear{
                        person_data()
                    }

                    VStack{
                        HStack{
                            TextField(personalData.name, text: self.$name )
                
                                .multilineTextAlignment( self.nameFocus ? .leading  :  .center)
                                .frame(width:270, height:60 )
                                .padding(.trailing,0)
                                .font(.system(size: 20).weight(Font.Weight.bold))
                                .focused($nameFocus)

                            if(self.nameFocus ){

                                if(!self.name.isEmpty){


                                Image(systemName: "x.circle.fill")
                                    .resizable()
                                    .frame(width:22, height:21 )
                                    .foregroundColor(Color(red: 0.65, green: 0.65, blue: 0.65))
                                    .padding(.leading,0)
                                    .onTapGesture{

                                        self.name = ""
                                    }


                                }
                            } else{
                                ZStack{

                                }
                                .onAppear{
                                    if(self.name.isEmpty){
                                        self.name = personalData.name
                                    }
                                }
                            }

                            }
                        Rectangle()
                            .fill(Color(red: 0.95, green: 0.95, blue: 0.95))
                            .frame(height: 2)
                            .padding(.top,-20)
                        }
                    .frame(width: UIScreen.main.bounds.width - 100)



                    }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            
        
    }

//    .toolbar{
//        ToolbarItemGroup(placement: .navigationBarTrailing) {
//
//            if( (!self.name.isEmpty && self.name != personalData.Name) ||  self.imageData != nil){
//                Button {
//                    self.nameFocus = false
//                    status_progress.StatusProgress = true
//                    UploadImage()
//                    DispatchQueue.main.asyncAfter(deadline: .now()+2){
//
//                        status_progress.StatusProgress = false
//                    }
//
//
//
//                } label: {
//                    Text("บันทึก")
//                }
//            }
//
//
//
//
//        }
//        ToolbarItemGroup(placement:.navigationBarLeading){
//            Text("แก้ไขโปรไฟล์")
//                .frame(minWidth: 0, maxWidth: .infinity,alignment: .center)
//
//                .padding(.leading,90)
//        }
//
//
//    }
      
      
    
      
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
                                personalData.status = res.status

                                personalData.email = res.email
                                self.name = res.name
                                
                                personalData.name = res.name
                                personalData.role =  res.role
                                personalData.imageUrl = res.imageUrl
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

        urlRequest.httpMethod = "PATCH"
        let bodyBoundary = "--------------------------\(UUID().uuidString)"
        urlRequest.addValue("multipart/form-data; boundary=\(bodyBoundary)", forHTTPHeaderField: "Content-Type")
        urlRequest.allHTTPHeaderFields = [
            "x-api-key":URL_API.API_key
            ]
        //attachmentKey is the api parameter name for your image do ask the API developer for this
       // file name is the name which you want to give to the file
        let parameters: String = UserDefaults.standard.string(forKey: "session")!
     
     
        let  requestData = createRequestBody(imageData: self.imageData ?? Data() , boundary: bodyBoundary, attachmentKey: "profilePicture", fileName: "myTestImage.jpg",id: parameters)

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
        print("imageData = ", imageData.count)
        if(imageData.count > 0){
            
        
         requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
         requestBody.append("Content-Disposition: form-data; name=\"\(attachmentKey)\"; filename=\"\(fileName)\"\(lineBreak)" .data(using: .utf8)!)
         requestBody.append("Content-Type: image/jpg \(lineBreak + lineBreak)" .data(using: .utf8)!)
         requestBody.append(imageData)
        }
      
        if(self.name != personalData.name){
            requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
            requestBody.append("Content-Disposition: form-data; name=\"\(user2)\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
            requestBody.append(self.name.data(using: .utf8) ?? Data())
        }
      
        
        requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
        requestBody.append("Content-Disposition: form-data; name=\"\(user)\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
        requestBody.append(id.data(using: .utf8) ?? Data())
        
        
         requestBody.append("\(lineBreak)--\(boundary)--\(lineBreak)" .data(using: .utf8)!)
   
         return requestBody
     }
    
}
//struct Editprofile_Previews: PreviewProvider {
//    static var previews: some View {
//        Editprofile()
//    }
//}
