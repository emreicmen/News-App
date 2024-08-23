//
//  ViewController.swift
//  NewsAppTraining
//
//  Created by Emre İÇMEN on 6.06.2024.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var apiService = ApiService()
    private var viewModel = NewsViewModel()
    var chosenNew: News?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadNews()
    }


    private func loadNews(){
        viewModel.fetchNews { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.delegate = self
            self?.tableView.reloadData()
        }
    }
}


extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSeciton(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        let news = viewModel.cellForRowAt(at: indexPath)
        cell.setCellWithValues(news)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.selectedNew = chosenNew
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenNew = viewModel.cellForRowAt(at: indexPath)
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    
}
