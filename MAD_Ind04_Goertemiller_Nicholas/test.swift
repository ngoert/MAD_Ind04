//
//  test.swift
//  MAD_Ind04_Goertemiller_Nicholas
//
//  Created by Nicholas Goertemiller on 4/4/22.
//

import SwiftUI

struct TestView: View {
    
    @State var models: [ResponseModel] = []
    
    var body: some View {
        VStack {
            List (models) { (model) in
                HStack {
                    Text(model.name ?? "").bold()
                    Text(model.nickName ?? "")
                }
            }
        }
        .onAppear(perform: {
            guard let url: URL = URL(string: "https://cs.okstate.edu/~ngoerte/conn.php") else {
                print("Invalid URL")
                return
            }
            
            var urlRequest: URLRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                guard let data = data else {
                    print("invalid response")
                    return
                }
                
                do {
                    self.models = try JSONDecoder().decode([ResponseModel].self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            }).resume()
        })
    }
}

class Response1Model: Codable, Identifiable {
    var customerName: String? = ""
    var country: String? = ""
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

