//
//  content.swift
//  MAD_Ind04_Goertemiller_Nicholas
//
//  Created by Nicholas Goertemiller on 4/5/22.
//
//  Code References for CRUD PHP Script && API orders from web. https://www.hackingwithswift.com/books/ios-swiftui/sending-and-receiving-orders-over-the-internet
//
//  https://www.w3schools.com/php/php_mysql_update.asp
//
//
//
//
//
//

import SwiftUI

struct ContentView: View {
    
    @State var tests: [ResponseModel] = []
    
    var body: some View {
        // Create VStack
        VStack {
            //
            
            List (self.tests) { (test) in
                HStack {
                    // they are optional
                    Text(test.name ?? "").bold()
                    Text(test.nickName ?? "")
                }
            }
            
        }.onAppear(perform: {
            // Send the request to the server
            
            guard let url: URL = URL(string: "https://cs.okstate.edu/~ngoerte/conn.php") else {
                print("invalid URL")
                return
            }
            
            var urlRequest: URLRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                // check if response is okay
                
                guard let data = data else {
                    print("invalid response")
                    return
                }
                
                // convert JSON response into class model as an array
                do {
                    self.tests = try JSONDecoder().decode([ResponseModel].self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
                
            }).resume()
        })
    }
}

// create model class
class ResponseModel: Codable, Identifiable {
    var name: String? = ""
    var nickName: String? = ""
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
