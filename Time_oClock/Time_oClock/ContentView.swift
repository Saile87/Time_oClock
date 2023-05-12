//
//  ContentView.swift
//  Time
//
//  Created by Elias Breitenbach on 12.05.23.
//

import SwiftUI

struct ContentView: View {
    @State private var time = Date()
    @Environment(\.colorScheme) var colorScheme
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        Text("\(timeFormatter(time))")
            .font(.system(size: fontSize()))
            .foregroundColor(timeInRange(time) ? .green : .red)
            .background(colorScheme == .dark ? Color.black : Color.white)
            .onReceive(timer) { input in
                self.time = input
            }
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                screenWidth = UIScreen.main.bounds.width
            }
    }
    
    func fontSize() -> CGFloat {
        screenWidth > 500 ? 120 : 200
    }
    
    func timeFormatter(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone.current
        return formatter.string(from: date)
    }
    
    func timeInRange(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return hour >= 6 && hour <= 21
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

