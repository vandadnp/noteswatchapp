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
    
    
    private let difficulty: Difficulty
    @State private var currentNote: Note?
    @State private var gameTimer: GameTimer?
    @State private var rows = [AnswerRow]()
    @State private var showResults = false
    @State private var shouldCancelTimer = false
    @State private var correctAnswers = 0
    @State private var incorrectAnswers = 0
    
    init(difficulty: Difficulty) {
        self.difficulty = difficulty
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 1.0) {
            if !showResults {
                Spacer()
                    .frame(height: 5.0)
                HStack {
                    Text("❌: \(incorrectAnswers)")
                        .font(.caption)
                    Spacer()
                    Text("✅: \(correctAnswers)")
                        .font(.caption)
                }
                Spacer()
                ForEach(rows) { row in
                    row
                }
            } else {
                Text(answerText)
                    .multilineTextAlignment(.center)
                    .font(.title)
            }
            
        }
        .onReceive(NotificationCenter.default.publisher(for: .NSExtensionHostDidBecomeActive), perform: { _ in
            self.setupTimer()
        })
        .onReceive(NotificationCenter.default.publisher(for: .NSExtensionHostDidEnterBackground), perform: { _ in
            self.currentNote?.stop()
            self.gameTimer?.stop()
        })
        .onAppear {
            self.setupTimer()
        }.onDisappear {
            self.shouldCancelTimer = true
            self.currentNote?.stop()
            self.gameTimer?.stop()
        }
    }
    
    func processAnswer(noteType: Note.NoteType) {
        gameTimer?.stop()
        guard let currentNote = currentNote else { return }
        if currentNote.noteType == noteType {
            correctAnswers += 1
            //correct answer
            answerText = "✅\nThat's correct!"
        } else {
            incorrectAnswers += 1
            answerText = "❌\nCorrect answer: \(currentNote.noteType.name)"
        }
        showResults = true
        restartTimer()
    }
    
    @State var answerText = "🔊"
    
    private func restartTimer(afterSeconds: Int = 2) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + .seconds(afterSeconds),
            execute: {
                if !self.shouldCancelTimer {
                    self.answerText = "🔊"
                    self.setupTimer()
                }
            }
        )
    }
    
    private func setupTimer() {
        self.shouldCancelTimer = false
        self.gameTimer?.stop()
        self.gameTimer = GameTimer(onStarted: {
            self.setupButtonsAndPlayRandomNote()
        })
    }
    
    func setupButtonsAndPlayRandomNote() {
        currentNote?.stop()
        let currentNote = Note.randomNote()
        self.currentNote = currentNote
        
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
        showResults = false
        self.rows = rows
        
        currentNote.play()
        
    }
    
}
