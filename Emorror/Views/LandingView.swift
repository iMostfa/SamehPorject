//
//  ContentView.swift
//  Emorror
//
//  Created by mostfa on 8/2/20.
//  Copyright © 2020 mostfaE. All rights reserved.
//

import SwiftUI
import UIKit
import MapKit
struct LandingView: View {
  @ObservedObject var viewModel: FinesViewModel



  var body: some View {
    NavigationView {

      List(viewModel.users) { user in
        NavigationLink(destination: DetailsView(user: user)) {
          ZStack {

            Text(user.plateNumber)
              .padding(.vertical, 30)
          }
        }


      }
      .navigationBarTitle("موقع المرور المصري")
      .onAppear {
        self.viewModel.fetchFines()
      }

    }


  }
}

struct LandingView_Previews: PreviewProvider {
  static var previews: some View {
    let vm = FinesViewModel()
    vm.addMore()
    return  LandingView(viewModel: vm)
      .environment(\.colorScheme, .dark)
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





struct DetailsView: View {
  var user: FirebaseUser
  var body: some View {
    NavigationView {
      VStack {
        VStack(spacing: 5) {
          SubDetailView(title: "Name", subTitle: user.firstName + user.lastName)
          SubDetailView(title: "Email", subTitle: user.email)
          SubDetailView(title: "Phone", subTitle: user.phoneNumber)
          SubDetailView(title: "Plate Numbwe", subTitle: user.plateNumber)
          SubDetailView(title: "Reported Stolen", subTitle: "\(user.isStolen)")


        }
        .padding(.trailing, 5)
        .navigationBarTitle("Personal Info")

        VStack {
          Text("Fines")
            .font(.system(size: 30, weight: .semibold, design: .rounded))
          List(user.finesTime,id:\.self) { time in

            NavigationLink(destination: MapWrapper(long: 32.2746, lat: 30.6104)) {
              HStack {
                Spacer()
                Text(time)
                Spacer()
              }
            }

          }
        }
        Spacer()

      }
    }

  }
}

struct MapWrapper: View {
  var long: Double
  var lat: Double
  @State var  appeared = false
  var body: some View {
    MapView(lat: lat, long: long)
      .offset(x: appeared ? 0: -3000)
      .onAppear {
        withAnimation(Animation.easeIn(duration: 1)) {
          self.appeared.toggle()
        }
    }
  }


}

struct DetailsView_Previews: PreviewProvider {
  static var previews: some View {
    DetailsView(user: gloablUser)
  }
}

struct SubDetailView: View {
  var title: String
  var subTitle: String
  var body: some View {
    HStack(spacing: 0 ) {
      Text(title+":")
      Spacer()
      Text(subTitle)
    }
    .padding(.horizontal, 30)
  }
}


struct MapView: UIViewRepresentable {
  var lat: Double
  var long: Double

  func makeUIView(context: Context) -> MKMapView {
    MKMapView(frame: .zero)
  }

  func updateUIView(_ view: MKMapView, context: Context) {
    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
    let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    let annotation = MKPointAnnotation()
    let centerCoordinate = CLLocationCoordinate2D(latitude: 48.210033, longitude: 16.363449)
    annotation.coordinate = centerCoordinate
    annotation.title = "Fine Location"
    view.addAnnotation(annotation)
    view.setRegion(region, animated: true)
  }
}
