# VersioningMechanism
The task is to create a versioning mechanism that allows you to easily move from one version of the database to another.

Write SQL scripts that:

a. add / remove a column;
b. add / remove a primary key;
c. add / remove a foreign key;
d. create / remove a table.

For each of the scripts above, write another one that reverts the operation. Create a new table that holds the current version of the database schema. For simplicity, the version is assumed to be an integer number.

Place each of the scripts in a stored procedure. Use a simple, intuitive naming convention.

Write another stored procedure that receives as a parameter a version number and brings the database to that version.
