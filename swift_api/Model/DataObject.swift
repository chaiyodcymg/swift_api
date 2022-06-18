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
    var admin:Int
 
}


class UrlAPI: ObservableObject {
    @Published var URL  = "https://a2a7-14-207-201-133.ap.ngrok.io/"
    @Published var API_key = "813c33ee-d292-4060-884e-ec2897401990asd99sd"
}


class PersonalData: ObservableObject {
    @Published var ImageUrl = ""
    @Published var Name = ""
    @Published var Email = ""
    @Published var Status  = false
    @Published var Text = ""
    @Published var Admin = 0
}
