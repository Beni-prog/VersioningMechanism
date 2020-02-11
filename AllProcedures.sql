USE Lab1
go
--a. add/remove a column;
ALTER PROCEDURE add_column
AS
BEGIN
   ALTER TABLE Client
   ADD Dob1 DATE
   SELECT * FROM Client
END
GO

ALTER PROCEDURE remove_column
AS
BEGIN
  ALTER TABLE Client
  DROP COLUMN Dob1
  SELECT * FROM Client
END
GO

--b.add / remove a primary key;

ALTER PROCEDURE add_primaryK
AS
BEGIN
  ALTER TABLE Feedback
  ADD CONSTRAINT pk_Feedback PRIMARY KEY(Fid)
  SELECT * FROM Feedback
END
GO

ALTER PROCEDURE remove_primaryK
AS
BEGIN
  ALTER TABLE Feedback
  DROP CONSTRAINT pk_Feedback
  SELECT * FROM Feedback
END
GO

--c.add / remove a foreign key;
ALTER PROCEDURE add_foreignK
AS
BEGIN
  ALTER TABLE Feedback
  ADD CONSTRAINT fk_Feedback FOREIGN KEY(FBid) REFERENCES FBRepo(FBNo)
  SELECT * FROM Feedback
END
GO

ALTER PROCEDURE remove_foreignK
AS
BEGIN
  ALTER TABLE Feedback
  DROP CONSTRAINT fk_Feedback
END
GO

--d. create/remove a table;
CREATE PROCEDURE create_table
AS
BEGIN
  CREATE TABLE Booking(Bid int PRIMARY KEY NOT NULL,
                       FirstName varchar(50) NOT NULL, 
					   LastName varchar(50), 
					   PhoneNo varchar(15));
END
GO

CREATE PROCEDURE remove_table
AS
BEGIN
  DROP TABLE Booking
END
GO

CREATE TABLE Version(Vid int PRIMARY KEY NOT NULL,
                     VersionNumber int);
GO

INSERT INTO Version VALUES(1,0)
SELECT * FROM Version
GO

--main
CREATE PROCEDURE main
@version int
AS
BEGIN
  DECLARE @v INT
  SET @v=(SELECT VersionNumber FROM Version WHERE Vid=1)
    if @version> @v
    BEGIN
      if @version=1
	  BEGIN
	    EXEC add_column
	  END
	  if @version=2
	  BEGIN
	    if @v=0
		BEGIN
	      EXEC add_column
	      EXEC add_primaryK
		END
		if @v=1
		BEGIN
		  EXEC add_primaryK
		END
	  END
	  if @version=3
	  BEGIN
	    if @v=0
		BEGIN
	      EXEC add_column
	      EXEC add_primaryK
	      EXEC add_foreignK
		END
		if @v=1
		BEGIN
		  EXEC add_primaryK
	      EXEC add_foreignK
		END
		if @v=2
		BEGIN
		  EXEC add_foreignK
		END
	  END
	  if @version=4
	  BEGIN
	    if @v=0
		BEGIN
	      EXEC add_column
	      EXEC add_primaryK
	      EXEC add_foreignK
	      EXEC create_table
		END
		if @v=1
		BEGIN
		  EXEC add_primaryK
	      EXEC add_foreignK
	      EXEC create_table
		END
		if @v=2
		BEGIN
		  EXEC add_foreignK
	      EXEC create_table
		END
		if @v=3
		BEGIN
		  EXEC create_table
		END
	  END
	END
	ELSE
    BEGIN
	  if @version=1
	  BEGIN
	    if @v=4
		BEGIN
		  EXEC remove_table
		  EXEC remove_foreignK
		  EXEC remove_primaryK
		END
		if @v=3
		BEGIN
		  EXEC remove_foreignK
		  EXEC remove_primaryK
		END
		if @v=2
		BEGIN
		  EXEC remove_primaryK
		END
	  END
	  if @version=2
	  BEGIN
	    if @v=4
		BEGIN
		  EXEC remove_table
		  EXEC remove_foreignK
		END
		if @v=3
		BEGIN
		  EXEC remove_foreignK
		END
	  END
	  if @version=3
	  BEGIN
	    if @v=4
		BEGIN 
		  EXEC remove_table
		END
	  END
    END
	UPDATE Version
	  SET VersionNumber=@version
	  WHERE Vid=1
END