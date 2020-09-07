//
//  FilterViewController.swift
//  news-app
//
//  Created by Alex Mosunov on 07.09.2020.
//  Copyright © 2020 Alex Mosunov. All rights reserved.
//

import UIKit


class FilterViewController: UIViewController {
    
    
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var sourcePicker: UIPickerView!
    
    
    var selectedCountry = "us"
    var selectedCategory = ""
    var selectedSource = ""
    
    var countriesArr = ["ae", "ar", "at", "au", "be", "bg", "br", "ca", "ch", "cn", "co", "cu", "cz", "de", "eg", "fr", "gb", "gr", "hk", "hu", "id", "ie", "il", "in", "it", "jp", "kr", "lt", "lv", "ma", "mx", "my", "ng", "nl", "no", "nz", "ph", "pl", "pt", "ro", "rs", "ru", "sa", "se", "sg", "si", "sk", "th", "tr", "tw", "ua", "us", "ve", "za"]
    
    var categoriesArray = ["", "business", "entertainment", "general", "health", "science", "sports", "technology"]
    
    var sourcesArray = ["", "abc-news", "abc-news-au", "aftenposten","bbc-news","bbc-sport","bloomberg","business-insider","buzzfeed","cnn","football-italia","fox-sports","hacker-news","google-news-uk","google-news-ru","fox-news", ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.countryPicker.delegate = self
        self.countryPicker.dataSource = self
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        self.sourcePicker.delegate = self
        self.sourcePicker.dataSource = self
    }
    
    
    
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! MainViewController
        destVC.newsManager.fetchNews(country: selectedCountry, sources: selectedSource, category: selectedCategory)
    }

}



//MARK: - UIPickerViewDelegate,UIPickerViewDataSource

extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == countryPicker {
            return 1
        } else if pickerView == categoryPicker {
            return 1
        } else if pickerView == sourcePicker {
            return 1
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == countryPicker {
            return countriesArr.count
        } else if pickerView == categoryPicker {
            return categoriesArray.count
        } else if pickerView == sourcePicker {
            return sourcesArray.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == countryPicker {
            return countriesArr[row]
        } else if pickerView == categoryPicker {
            return categoriesArray[row]
        } else if pickerView == sourcePicker {
            return sourcesArray[row]
        } else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == countryPicker {
             selectedCountry = countriesArr[row]
        } else if pickerView == categoryPicker {
           selectedCategory = categoriesArray[row]
        } else if pickerView == sourcePicker {
           selectedSource = sourcesArray[row]
        }
        
    }
    
    
    
    
}
