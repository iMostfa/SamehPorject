//
//  ContentView.swift
//  Emorror
//
//  Created by mostfa on 8/2/20.
//  Copyright © 2020 mostfaE. All rights reserved.
//

import SwiftUI
import UIKit
struct ContentView: View {
   @ObservedObject var viewModel: FinesViewModel

    var body: some View {
      NavigationView {

        List(viewModel.users) { user in
          NavigationLink(destination: Color.blue) {
            ZStack {
              Color.white
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 0)
                .frame(height: 50)
              Text(user.plateNumber)
                .padding(.vertical, 30)
            }
          }
          

        }
        .navigationBarTitle("موقع المرور المصري")
        .onAppear {
          self.viewModel.fetchFines()
          UITableView.appearance().separatorStyle = .none

        }

      }


  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      let vm = FinesViewModel()
      vm.addMore()
    return  ContentView(viewModel: vm)
        .environment(\.colorScheme, .light)
    }
}



struct Fine: Identifiable {
  var id = UUID().uuidString
  var location: String
  var time: String
}
var data:[Fine] = [
  Fine(location: "deeded", time: "DEdeeded"),
  Fine(location: "deeded", time: "DEdeeded"),
  Fine(location: "edde", time: "DEdeeded"),
  Fine(location: "eded", time: "DEdeeded"),
  Fine(location: "ddede", time: "DEdeeded"),


]



