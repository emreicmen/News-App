//
//  NewsViewModel.swift
//  NewsAppTraining
//
//  Created by Emre İÇMEN on 6.06.2024.
//

import Foundation

class NewsViewModel {
    
    private var apiServie = ApiService()
    private var newsList = [News]()
    
    func fetchNews(completion: @escaping() -> ()) {
        
        apiServie.getNews { [weak self] result in
            
            switch result {
                
            case .success(let listOf):
                self?.newsList = listOf.results ?? []
                completion()
                
            case .failure(let error):
                print("Error processing json data: \(error.localizedDescription)")
            }
        }
    }
    
    func numberOfRowsInSeciton(section: Int) -> Int {
        if newsList.count != 0 {
            return newsList.count
        }
        return 0
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> News {
        return newsList[indexPath.row]
    }
}
