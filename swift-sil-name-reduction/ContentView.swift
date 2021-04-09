//
//  ContentView.swift
//  swift-sil-name-reduction
//
//  Created by 王林 on 2021/4/8.
//

import SwiftUI
import CwlDemangle

struct ContentView: View {
    @State private var mangledSymbol: String = ""
    @State private var unmangledString: String = ""
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack {
            TextEditor(text: $mangledSymbol)
                .onChange(of: mangledSymbol, perform: { value in
                    do {
                        let swiftSymbol = try parseMangledSwiftSymbol("_T0\(value)")
                        let result = swiftSymbol.print(using:
                           SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
                        unmangledString = result
                        errorMessage = ""
                    } catch {
                        errorMessage = "Error: \(error)"
                    }
                })
                .font(.system(size: 18, weight: .regular))
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
                .padding()
        
            Text(errorMessage)
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(.red)

            TextEditor(text: $unmangledString)
                .font(.system(size: 18, weight: .regular))
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.sizeThatFits)
    }
}
