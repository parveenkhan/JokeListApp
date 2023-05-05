//
//  ViewController.swift
//  JokeListApp
//
//  Created by Parveen Khan on 04/05/23.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    let tableView = UITableView()
    var timer: Timer?
    
    lazy var jokeViewModel: JokeViewModel = {
        let viewModel = JokeViewModel()
        return viewModel
    }()
    
    private var cancellable: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setTableViewConstraints()
        setTableViewConfiguration()
        jokeViewModel.fetchLocalJokes()
        //fetchData()
        setTimer()
        bindJokeViewModel()
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    /// to set the Autolayout constraint of tablview
    func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    /// to set the configuration of tableview
    func setTableViewConfiguration() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: AppConstant.jokeCellIdentifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.bounces = false
    }
    
    /// to set the timer to call API continue within certain duration.
    func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(fetchData), userInfo: nil, repeats: true)
        
    }
    
    @objc func fetchData() {
        DispatchQueue.main.async {
            self.tableView.showLoadingFooter()
        }
        jokeViewModel.fetchJoke()
    }
    
    /// to bind the joke viewModel
    private func bindJokeViewModel() {
        jokeViewModel.$jokeList.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.hideLoadingFooter()
                self?.tableView.reloadData()
            }
            
        }.store(in: &cancellable)
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokeViewModel.jokeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstant.jokeCellIdentifier, for: indexPath) as UITableViewCell
        cell.textLabel?.text = jokeViewModel.jokeList[indexPath.row].jokeMessage
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

