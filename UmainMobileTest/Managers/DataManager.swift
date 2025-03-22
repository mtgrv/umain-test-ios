//
//  DataManager.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 21/03/25.
//

import Foundation

@Observable
class DataManager {
    
    var restaurants: [Restaurant] = []
    var filters: [Filter] = []
    var isLoading: Bool = false
    
    private var apiManager: APIManager
    
    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }
    
    func fetchData() async {
        
        isLoading = true
                
        do {
            let restaurants = try await apiManager.fetchRestaurants()
            
            // Populate filter ids
            let tempFiltersIds = restaurants.map { restaurant in
                restaurant.filterIds
            }.reduce([], +)
            // remove duplicates
            let filtersIds = Set(tempFiltersIds)
            // get filters data and save
            self.filters = try await apiManager.fetchFilters(for: filtersIds)
            // convert data in form of dictionary with id as keys
            var filtersDictionary = [String:Filter]()
            for filter in filters {
                filtersDictionary[filter.id] = filter
            }
            
            //populate filters property for every restaurant
            var restaurantsWithFilters: [Restaurant] = []
            for var restaurant in restaurants {
                restaurant.filters = restaurant.filterIds.compactMap { filtersDictionary[$0] }
                restaurantsWithFilters.append(restaurant)
            }
            
            self.restaurants = restaurantsWithFilters
            isLoading = false
        } catch {
            print(error.localizedDescription)
            isLoading = false
        }
    }
    
    func isRestaurantOpen(_ restaurant: Restaurant) async -> Bool {
                        
        do {
            return try await apiManager.fetchOpenStatus(for: restaurant)
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
