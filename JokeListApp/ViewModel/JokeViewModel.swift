//
//  JokeViewModel.swift
//  JokeListApp
//
//  Created by Parveen Khan on 04/05/23.
//

import Foundation
import Combine

class JokeViewModel: ObservableObject {
    
    private var jokeServiceManager: JokeServiceProtocol?
    @Published var jokeList: [JokeModel] = []
    
    init(jokeService: JokeServiceProtocol = JokeService()) {
        self.jokeServiceManager = jokeService
    }
    
    func setApiManager(manager: JokeServiceProtocol) {
        self.jokeServiceManager = manager
    }
    
    /// to fetch the jokeList local data from userdefaults
    func fetchLocalJokes() {
        jokeList = LocalStorageManager.getLocalJokes()
        if jokeList.count == 0 {
            fetchJoke()
        }
    }
    
    
    /// to fetch the jokes data from remote url and post the jokelist data
    func fetchJoke() {
        jokeServiceManager?.getJoke { success, model, error in
            if success, let joke = model {
                var tempJokeLList = self.jokeList
                if tempJokeLList.count >= 10 {
                    tempJokeLList.removeFirst()
                }
                
                tempJokeLList.append(joke)
                LocalStorageManager.setLocalJokes(self.jokeList)
                self.jokeList = tempJokeLList
                
            } else {
                print("error!")
            }
        }
    }
}
