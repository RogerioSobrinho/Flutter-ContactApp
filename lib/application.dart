String dbName = 'flutter_contacts.db';
int dbVersion = 1;

List<String> dbCreate = [
  // tb lista
  """CREATE TABLE contacts (
    id INTEGER PRIMARY KEY,
    name TEXT,
    nickName TEXT,
    work TEXT,
    phoneNumber TEXT,
    email TEXT,
    webSite TEXT,
    favorite INTEGER,
    created TEXT
  )""",
];
