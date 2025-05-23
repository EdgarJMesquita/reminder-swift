//
//  DBHelper.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 20/01/25.
//

import Foundation
import SQLite3

class DBHelper {
    static let shared = DBHelper()

    private var db: OpaquePointer?

    private init() {
        openDatabase()
        createTable()
    }

    private func openDatabase() {
        guard let fileURL = try? FileManager
            .default
            .url(for: .documentDirectory,
                 in: .userDomainMask,
                 appropriateFor: nil,
                 create: false)
            .appendingPathComponent("Reminder.sqlite")
        else {
            return
        }

        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Erro ao abrir o banco de dados")
        }
    }

    private func createTable() {
        let createTableQuery = """
            CREATE TABLE IF NOT EXISTS Receipts (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                remedy TEXT,
                time TEXT,
                recurrence TEXT,
             takeNow INTEGER
            );
        """

        var statement: OpaquePointer?

        if sqlite3_prepare_v2(db, createTableQuery, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Tabela criada com sucesso!")
            } else {
                print("Erro na criação da tabela")
            }
        } else {
            print("CreateTable statement não conseguiu executar.")
        }

        sqlite3_finalize(statement)
    }

    func insertReceipt(remedy: String, time: String, recurrence: String, takeNow: Bool) -> Int? {
        let insertQuery = "INSERT INTO Receipts (remedy, time, recurrence, takeNow) VALUES (?, ?, ?, ?);"

        var statement: OpaquePointer?

        var id: Int?

        if sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (remedy as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (time as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (recurrence as NSString).utf8String, -1, nil)
            sqlite3_bind_int(statement, 4, (takeNow ? 1: 0))

            if sqlite3_step(statement) == SQLITE_DONE {
                print("Receita inserida com sucesso!")
                id = Int(sqlite3_last_insert_rowid(db))
            } else {
                print("Falha ao inserir receita na tabela.")
            }
        } else {
            print("INSERT statement falhou.")
        }

        sqlite3_finalize(statement)

        return id
    }

    func fetchReceipts() async -> [Remedy] {
        let fetchQuery = "SELECT * from Receipts"
        var statement: OpaquePointer?

        var receipts: [Remedy] = []

        if sqlite3_prepare(db, fetchQuery, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let remedy = sqlite3_column_text(statement, 1).flatMap { String(cString: $0) } ?? ""

                let time = sqlite3_column_text(statement, 2).flatMap { String(cString: $0) } ?? ""
                let recurrence =  sqlite3_column_text(statement, 3).flatMap { String(cString: $0) } ?? ""
                let takeNow = Int(sqlite3_column_int(statement, 4))
                receipts.append(Remedy(id: id, name: remedy, time: time, recurrence: recurrence, takeNow: takeNow == 1 ? true : false))
            }
        } else {
            print("SELECT statement falhou")
        }

        sqlite3_finalize(statement)

        return receipts
    }

    func deleteReceipt(byId id: Int) {
        let deleteQuery = "DELETE FROM Receipts WHERE id = \(id)"
        var statement: OpaquePointer?

        if sqlite3_prepare_v2(db, deleteQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(id))

            if sqlite3_step(statement) == SQLITE_DONE {
                print("Receita deletada")
            } else {
                print("Erro ao deletar a receita")
            }
        } else {
            print("Delete statement falhou")
        }

        sqlite3_finalize(statement)
    }
}
