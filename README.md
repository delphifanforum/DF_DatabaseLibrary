# DF_DatabaseLibrary
DFDatabaseLibrary is a powerful Delphi library that simplifies database operations using the FireDAC component. It provides a convenient set of functions and procedures to connect to various database systems, create tables, drop tables, perform parameterized queries, and execute update and insert operations.
# DFDatabaseLibrary

DFDatabaseLibrary is a Delphi library that provides convenient functions and procedures for working with databases using the FireDAC component. It allows you to connect to various database systems, create tables, drop tables, perform queries with parameters, and execute update and insert operations.

## Usage

1. Add the `DFDatabaseLibrary.pas` unit to your Delphi project.

2. Create an instance of the `TDFDatabaseLibrary` class:
```delphi
var
  DB: TDFDatabaseLibrary;
begin
  DB := TDFDatabaseLibrary.Create;
  try
    // Use the library functions and procedures here
  finally
    DB.Free;
  end;
end;

1.Connect to a database using the Connect method:

DB.Connect('localhost', 'mydatabase', 'username', 'password', 3306, 'MySQL');

1.Perform database operations:
.Create a table:

DB.CreateTable('MyTable', 'ID INT, Name VARCHAR(50), Age INT');

1.Perform database operations:
.Create a table:

DB.CreateTable('MyTable', 'ID INT, Name VARCHAR(50), Age INT');

.Drop a table:

DB.DropTable('MyTable');

.Execute a query:

var
  Query: TFDQuery;
begin
  Query := DB.ExecuteQuery('SELECT * FROM MyTable WHERE Age > :Param0', [25]);
  try
    // Process the query results here
  finally
    Query.Free;
  end;
end;

.Execute an update statement:

DB.ExecuteUpdate('UPDATE MyTable SET Name = :Param0 WHERE ID = :Param1', ['John Doe', 1]);

.Execute an insert statement:

DB.ExecuteInsert('INSERT INTO MyTable (ID, Name, Age) VALUES (:Param0, :Param1, :Param2)', [1, 'John Doe', 30]);

1.Disconnect from the database:

DB.Disconnect;


Supported Database Systems
DFDatabaseLibrary supports the following database systems through FireDAC's drivers:

MySQL
SQLite
Oracle
Microsoft SQL Server
To connect to a specific database system, provide the appropriate value for the ADatabaseType parameter when calling the Connect method.

Contributing
Contributions are welcome! If you have any suggestions, improvements, or bug fixes, please submit a pull request.


