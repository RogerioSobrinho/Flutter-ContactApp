String dbName = 'flutter_contacts.db';
int dbVersion = 1;

List<String> dbCreate = [
  // tb lista
  """CREATE TABLE contacts (
    id INTEGER PRIMARY KEY,
    firstName TEXT,
    lastName TEXT,
    phoneNumber TEXT,
    email TEXT,
    work TEXT,
    created TEXT
  )""",
];
