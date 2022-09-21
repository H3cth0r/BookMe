//
//  ObjectListingView.swift
//  BookMe
//
//  Created by Héctor Miranda García on 21/09/22.
//

import SwiftUI

struct ObjectListingView: View {
    
    var softwareTitleName: [String] = ["Software: Adobe XD",
                                       "Software: Autocad",
                                       "Software: Blender",
                                       "Software: VIM",
                                       "Software: Inkscape",
                                       "Software: Figma",
                                       "Software: Terminal",
                                       "Software: Ubuntu",
                                       "Software: Word",
                                       "Software: AutoDesk",
                                       "Software: Powerpoint",
                                       "Software: Excel",
                                       "Software: Android"]
    
    var theTypeOfObject = "Software"
    var stackView = UIStackView()
    
    var body: some View {
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ObjectListingView_Previews: PreviewProvider {
    static var previews: some View {
        ObjectListingView()
    }
}
