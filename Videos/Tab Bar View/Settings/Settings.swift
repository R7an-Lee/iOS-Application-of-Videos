//
//  Settings.swift
//  Companies
//
//  Created by Osman Balci on 3/23/23.
//  Copyright © 2023 Osman Balci. All rights reserved.
//

import SwiftUI

struct Settings: View {
    
    @AppStorage("darkMode") private var darkMode = false
    
    var body: some View {
        Form {
            Section(header: Text("Dark Mode Setting").padding(.top, 30)) {
                Toggle("Dark Mode", isOn: $darkMode)
            }
        }
        .navigationBarTitle(Text("Settings"), displayMode: .inline)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
