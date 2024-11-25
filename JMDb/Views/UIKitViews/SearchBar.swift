//
//  SearchBar.swift
//  JMDb
//
//  Created by Emre Yılmaz on 5.08.2024.
//

import SwiftUI

struct SearchBarView: UIViewRepresentable {

    let placeholder: String
    @Binding var text: String
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.delegate = context.coordinator
        
        // Özelleştirme
        customizeSearchBar(searchBar)
        
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: self.$text)
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }

    private func customizeSearchBar(_ searchBar: UISearchBar) {
        // Arka plan rengini özelleştirme
        if let backgroundView = searchBar.subviews.first?.subviews.first {
            backgroundView.backgroundColor = UIColor(.black) 
        }
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = UIColor.white
            textField.tintColor = UIColor.white
            
            if let clearButton = textField.value(forKey: "clearButton") as? UIButton {
                clearButton.tintColor = UIColor.green
            }
            
            if let searchIconView = textField.leftView as? UIImageView {
                searchIconView.tintColor = UIColor.white
            }
            
            // TextField'in arka plan rengini değiştirme
            textField.backgroundColor = UIColor(named: "secondColor")
        }
    }
}
