
// const dbName = 'notes.db';
// const noteTable = 'note';
// const userTable = 'user';
// const idColumn = 'id';
// const emailColumn = 'email';
// const userIdColumn = 'user_id';
// const titleColumn = 'title';
// const contentColumn = 'content';
// const createUserTable = ''' CREATE TABLE IF NOT EXISTS "user"(
//    "id"	INTEGER NOT NULL,
// 	"email"	TEXT NOT NULL UNIQUE,
// 	PRIMARY KEY("id" AUTOINCREMENT)
//       ) ''';
// const createNotesTable = ''' CREATE TABLE IF NOT EXISTS "note"(
//         "id"	INTEGER NOT NULL,
// 	"user_id"	INTEGER NOT NULL,
// 	"title"	TEXT NOT NULL,
// 	"content"	TEXT NOT NULL,
// 	FOREIGN KEY("user_id") REFERENCES "user"("id"),
// 	PRIMARY KEY("id" AUTOINCREMENT)
//       )''';