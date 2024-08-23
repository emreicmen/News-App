//
//  ApiService.swift
//  NewsAppTraining
//
//  Created by Emre İÇMEN on 6.06.2024.
//

import Foundation

private let apiKey = "pub_45747ecc3c8c57cd076a2fe3865a45b4d8983"
private let baseUrl = "https://newsdata.io/api/1/latest?country=tr&category=politics&apikey="
//private let breakingNewsUrl = "https://newsdata.io/api/1/latest?apikey=\(apiKey)&q=pegasus&language=tr"

private let requestUrl = "\(baseUrl)\(apiKey)"


private var dataTask: URLSessionDataTask?

class ApiService {
    
    func getNews(completion: @escaping(Result<NewsModel,Error>) -> Void) {
        
        guard let newsListUrl = URL(string: requestUrl) else {return}
        //guard let breakingBewsUrl = URL(string: breakingNewsUrl) else {return}
        
        dataTask = URLSession.shared.dataTask(with: newsListUrl, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Empty response")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            //MARK: Data çekme işlemi burada yapılacak
            do{
               
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(NewsModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
                
            }catch let error {
                completion(.failure(error))
            }
        })
        dataTask?.resume()
    }
}
