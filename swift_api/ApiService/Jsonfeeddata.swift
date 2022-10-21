//
//  Jsonfeeddata.swift
//  swift_api
//
//  Created by Chaiyod Mali-ngam on 4/6/2565 BE.
//

import Foundation
import SwiftUI

struct datajson:Codable{
    var userId:Int
    var id:Int
    var title : String
    var body :String
}

struct Jsonfeeddata: View{
    @State var array_json = [datajson]()
    var ar:[String] = ["pack"]
    var body: some View{
        ScrollView{
        VStack{
            ForEach(array_json,id: \.id) { index in
                Text(index.title)
            }
        }
            .task {
                await fetchdata()
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,maxHeight: 400,alignment: .center)
       
     
    }
    
    
    func fetchdata() async{
      
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else{
            print("errorrr!")
            return
        }
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            if let decodeRes = try?  JSONDecoder().decode([datajson].self, from: data){
                print(decodeRes)
                array_json = decodeRes
                
            }
        }catch{
            print("erererer")
        }
  
    }
}

struct Jsonfeeddata_preview: PreviewProvider{
    static var previews: some View{
        
        Jsonfeeddata()
    }
}

