//
//  ContentView.swift
//  AXRangeForLineElectronBug
//
//  Created by Guillaume Leclerc on 06/06/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var caretLocation: Int?
    @State private var lineNumber: Int?
    @State private var lineStartLocation: Int?
    @State private var lineLength: Int?
    
    var body: some View {
        VStack {
            Button("get AX info") {
                sleep(3)

                let axSystemWideElement = AXUIElementCreateSystemWide()
                    
                var axFocusedElement: AnyObject?
                guard AXUIElementCopyAttributeValue(axSystemWideElement, kAXFocusedUIElementAttribute as CFString, &axFocusedElement) == .success else {
                    print("can't get system wide element")
                        
                    return
                }

                var axSelectedTextRange: AnyObject?
                guard AXUIElementCopyAttributeValue(axFocusedElement as! AXUIElement, kAXSelectedTextRangeAttribute as CFString, &axSelectedTextRange) == .success else {
                    print("can't get text range")
                        
                    return
                }
                    
                var selectedTextRange = CFRange()
                AXValueGetValue(axSelectedTextRange as! AXValue, .cfRange, &selectedTextRange)
                caretLocation = selectedTextRange.location
                    
                var currentLine: AnyObject?
                guard AXUIElementCopyParameterizedAttributeValue(axFocusedElement as! AXUIElement, kAXLineForIndexParameterizedAttribute as CFString, selectedTextRange.location as CFTypeRef, &currentLine) == .success else {
                    print("can't get current line")
                        
                    return
                }
                lineNumber = currentLine as? Int

                var lineRangeValue: AnyObject?
                guard AXUIElementCopyParameterizedAttributeValue(axFocusedElement as! AXUIElement, kAXRangeForLineParameterizedAttribute as CFString, currentLine as CFTypeRef, &lineRangeValue) == .success else {
                    print("can't get line range")
                        
                    return
                }
                    
                var lineRange = CFRange()
                AXValueGetValue(lineRangeValue as! AXValue, .cfRange, &lineRange)
                lineStartLocation = lineRange.location
                lineLength = lineRange.length
            }

            Spacer()
            
            VStack(alignment: .leading) {
                Text("caret location (0 based): \(byeByeOptionalInStrings(for: caretLocation))")
                Text("line number (0 based): \(byeByeOptionalInStrings(for: lineNumber))")
                Text("line start location (0 based): \(byeByeOptionalInStrings(for: lineStartLocation))")
                Text("line length: \(byeByeOptionalInStrings(for: lineLength))")
            }
        }
        .padding()
    }
}

func byeByeOptionalInStrings(for int: Int?) -> String {
    int == nil ? "nil" : String(int!)
}

#Preview {
    ContentView()
}
