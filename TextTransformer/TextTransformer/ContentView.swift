//
//  ContentView.swift
//  TextTransformer
//
//  Created by Zoltan Ulrich on 24.06.2024.
//

import SwiftUI

enum Constant {

    static let input = "@My Very First Commit@ $by AdiR$ #s. f.# (#Med.#) This fixes most important bugs #2020-10-10# @Weather App@"
}

let emphasizedTextPattern = /@(?<bold>.*?)@/
let italicizedTextPattern = /\$(?<italic>.*?)\$/
let removableTextPattern = /#(?<remove>.*?)#/

struct CommitsView: View {

    private var markdownCommitMessage: String = ""

    init(input: String = Constant.input) {
        markdownCommitMessage = createMarkdown(from: input)
    }

    var body: some View {
        VStack {
            Text(try! AttributedString(markdown: markdownCommitMessage))
                .padding()
        }
    }

    private func createMarkdown(from input: String) -> String {
        var output = input
        var input = input
        
        for match in input.matches(of: removableTextPattern) {
            output = output.replacingOccurrences(of: match.output.0, with: "")
        }
        
        input = output
        for match in input.matches(of: emphasizedTextPattern) {
            output = output.replacingOccurrences(of: match.output.0, with: "**\(match.bold)**")
        }
        
        input = output
        for match in input.matches(of: italicizedTextPattern) {
            output = output.replacingOccurrences(of: match.output.0, with: "*\(match.italic)*")
        }
        return output
    }
}

#Preview {
    CommitsView(input: Constant.input)
}
