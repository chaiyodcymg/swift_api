//
//  DataObject.swift
//  swift_api
//
//  Created by Chaiyod Mali-ngam on 18/6/2565 BE.
//

import Foundation
import SwiftUI
import Combine

struct data_login:Codable ,Hashable{
    
    var status:Bool
    var text:String
    var session:String
    var email:String
    var name:String
    var imageUrl:String
    var role:Int
 
}


class UrlAPI: ObservableObject {
    @Published var URL  = "http://localhost:3000/"
    @Published var API_key = "813c33ee-d292-4060-884e-ec2897401990asd99sd"
}


class PersonalData: ObservableObject {
    @Published var session = ""
    @Published var imageUrl = ""
    @Published var name = ""
    @Published var email = ""
    @Published var status  = false
    @Published var text = ""
    @Published var role = 0
}


class CheckLogout: ObservableObject {
    
    @Published var Statuslogout  = false
    
}
class CheckProgress: ObservableObject {
    
    @Published var StatusProgress  = false
    
}
struct Validate_Email: Codable ,Hashable {
    var email  :String
    var time_end :Int
}
class Validate_Email_data: ObservableObject {
    @Published var email  = ""
    @Published var time_end = 0
}
