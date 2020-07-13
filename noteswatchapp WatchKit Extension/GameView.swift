//
//  GameView.swift
//  noteswatchapp WatchKit Extension
//
//  Created by Vandad Nahavandipoor on 2020-07-11.
//  Copyright © 2020 Pixolity AB. All rights reserved.
//

import SwiftUI

enum Difficulty: Int {
    case beginner = 2, intermediate = 4, expert = 6
    
    var buttonsRequired: Int {
        rawValue
    }
    
}

struct AnswerRow: View, Identifiable {

    let buttons: [AnswerButton]

    var body: some View {
        HStack(content: {
            buttons[0]
            buttons[1]
        })
    }
    
    var id: UUID { .init() }
    
}

struct AnswerButton: View {
    let noteType: Note.NoteType
    let onPressed: (Note.NoteType) -> Void
    var body: some View {
        Button(action: {
            self.onPressed(self.noteType)
        }, label: { Text(noteType.name) })
    }
}

struct GameView: View {
    
    let difficulty: Difficulty
    
    init(difficulty: Difficulty) {
        self.difficulty = difficulty
    }
    
    var body: some View {
        let viewModel = GameViewModel(difficulty: difficulty)
        return VStack {
            ForEach(viewModel.rows) { row in
                row
            }
        }
    }
}

class GameViewModel: ObservableObject {
    @Published var rows: [AnswerRow]!
    private var currentNote: Note?
    let difficulty: Difficulty
    
    func processAnswer(noteType: Note.NoteType) {
        
    }
    
    func setupButtonsAndPlayRandomNote() {
        currentNote?.stop()
        let currentNote = Note.randomNote()
        self.currentNote = currentNote
        
        print(currentNote)
        var noteTypesForButtons =
            currentNote.noteType.noteTypesExcludingThis(
                count: difficulty.buttonsRequired - 1
        )
        
        noteTypesForButtons.append(currentNote.noteType)
        noteTypesForButtons.shuffle()
        
        let buttons = noteTypesForButtons.map {
            AnswerButton(noteType: $0) {
                self.processAnswer(noteType: $0)
            }
        }
        
        var rows = [AnswerRow]()
        
        for i in stride(from: 0, to: buttons.count, by: 2) {
            let row = AnswerRow(
                buttons: [buttons[i], buttons[i + 1]]
            )
            rows += [row]
        }
        self.rows = rows
        
        currentNote.play()
        
    }
    
    init(difficulty: Difficulty) {
        self.difficulty = difficulty
        setupButtonsAndPlayRandomNote()
    }
    
}
