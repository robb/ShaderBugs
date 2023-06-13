//
//  ContentView.swift
//  ShaderBugs
//
//  Created by Robert Böhnke on 13.06.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let img = Image("gradient")

        ScrollView {
            Grid {
                let library = ShaderLibrary.default

                GridRow {
                    Example("Reference") {
                        exampleView
                    }

                    Spacer()
                }

                Divider().padding(.vertical, 8)

                let maxOffset = CGSize(width: 50, height: 50)

                GridRow {
                    Example("Distortion Effect", result: .success) {
                        exampleView
                            .distortionEffect(library.distortionEffectWithoutTexture(.boundingRect), maxSampleOffset: maxOffset)

                    }

                    Example("Distortion Effect + Texture", result: .failure) {
                        exampleView
                            .distortionEffect(library.distortionEffectWithTexture(.boundingRect, .image(img)), maxSampleOffset: maxOffset)
                    }
                }

                GridRow {
                    Example("Layer Effect", result: .success) {
                        exampleView
                            .layerEffect(library.layerEffectWithoutTexture(.boundingRect), maxSampleOffset: maxOffset)
                    }

                    Example("Layer Effect + Texture", result: .failure) {
                        exampleView
                            .layerEffect(library.layerEffectWithTexture(.boundingRect, .image(img)), maxSampleOffset: maxOffset)
                    }
                }

                Divider().padding(.vertical, 8)

                GridRow {
                    Example("Layer Effect", result: .success) {
                        exampleView
                            .layerEffect(library.layerEffectNoExtraArguments(), maxSampleOffset: maxOffset)
                    }
                    
                    Example("Layer Effect + `float2`", result: .success) {
                        exampleView
                            .layerEffect(library.layerEffectFloat2(.float2(0, 1)), maxSampleOffset: maxOffset)
                    }
                }

                GridRow {
                    Example("Layer Effect + 2×`float2`", result: .success) {
                        exampleView
                            .layerEffect(library.layerEffectFloat2Float2(.float2(0, 1), .float2(0, 1)), maxSampleOffset: maxOffset)
                    }

                    Example("Layer Effect + 2×`float2` + `float3`", result: .failure) {
                        exampleView
                            .layerEffect(library.layerEffectFloat2Float2Float3(.float2(0, 1), .float2(0, 1), .float3(0, 1, 2)), maxSampleOffset: maxOffset)
                    }
                }
            }
            .padding()
        }
    }

    var exampleView: some View {
        VStack(spacing: 8) {
            Image(systemName: "figure.wave")
                .foregroundStyle(.blue.gradient)

            Text("Hello World")
                .font(.system(.caption, design: .rounded, weight: .semibold).leading(.tight))
        }
        .padding(12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)

        .background(.white.opacity(0.8), in: RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(.blue.gradient, lineWidth: 2)
        }
    }


}

struct Example<Content: View>: View {
    enum Result {
        case success
        case failure
    }

    var title: String

    var content: Content

    var result: Result?

    init(_ title: String, result: Result? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.result = result
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(try! AttributedString(markdown: title))
                .font(.system(.caption, design: .rounded, weight: .medium).leading(.tight))
                .lineLimit(2, reservesSpace: true)

            content
        }
        .padding(12)
        .overlay(alignment: .bottomTrailing) {
            if result == .success {
                Image(systemName: "checkmark.circle.fill")
            } else if result == .failure {
                Image(systemName: "xmark.circle.fill")
            }
        }
        .padding(4)
        .background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 14))
        .symbolRenderingMode(.multicolor)
        .imageScale(.large)
    }
}
#Preview {
    ContentView()
}
