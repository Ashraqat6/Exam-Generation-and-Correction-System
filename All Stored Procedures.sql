use ExamSYS

											/*******STUDENT TABLE PROCEDURES************/

/********SELECT FOR 1ST REPORT******/
create procedure StudentInfoByDeptId @DeptId int
as
	select *
	from Student
	where Dept_Id=@DeptId

/********TRIAL******/
execute StudentInfoByDeptId 10

/******INSERT INTO TABLE STUDENT*********/

create procedure AddToStudent  @Fname nvarchar(50), @Lname nchar(20), @Address nvarchar(100), @Age int,@DeptId int,@email varchar(50)
as
	insert into Student
	values(@Fname,@Lname,@Address,@Age,@DeptId,@email)

/****TRIAL******/
execute AddToStudent ash,magdy,shdfjdj,23,10,hgdshj@dds


/***********DELETE FROM TABLE STUDENT**********/
create procedure DeleteStudentRecord @StuId int
as
	delete from Student where St_Id=@StuId

/*******TRIAL********/

execute DeleteStudentRecord 50

/**********UPDATE STUDENT IN STUDENT TABLE************/

create procedure UpdateStudentRecord @StuId int,@Fname nvarchar(50), @Lname nchar(20), @Address nvarchar(100), @Age int,@DeptId int,@email varchar(50)
as
	update Student set St_Fname=@Fname, St_Lname=@Lname,St_Address=@Address,St_Age=@Age,Dept_Id=@DeptId,email=@email
	where St_Id=@StuId

/************TRIAL********/

execute UpdateStudentRecord 49,	Sharf,Sherif ,"Kafr abdo",24,40,"Sharf49@gmail.com"


											/*******STUDENT COURSE TABLE PROCEDURES************/

/********SELECT FOR 2nd REPORT******/

create procedure StudentGradesById @StuId int
as
	select Grade
	from Stud_Course
	where St_Id=@StuId


/******INSERT INTO TABLE STUDENT COURSE*********/

create procedure StudentCourseGrade @CrsId int,@StId int,@grade int
as
	insert into Stud_Course
	values(@CrsId,@StId,@grade)


/***********DELETE FROM TABLE STUDENT COURSE**********/
create procedure DeleteStudentCourseGrade @StuId int, @CrsId int
as
	delete from Stud_Course where St_Id=@StuId AND Crs_Id=@CrsId

/**********UPDATE STUDENT COURSE IN STUDENT COURSE TABLE************/

create procedure UpdateStudentCourseGrade @CrsId int,@StuId int,@grade int
as
	update Stud_Course set Crs_Id=@StuId,St_Id=@StuId,Grade=@grade
	where St_Id=@StuId AND Crs_Id=@CrsId


	
	                                         /******************Student_answer table******************/ 
	/******************select******************/
	create procedure SelectStudentAnswer @Stid int
as
	select *
	from  Stu_Answer
	where  St_Id =@Stid


	execute SelectStudentAnswer 1

	/******************update******************/
		create procedure UpdateStudentAnswer @Stid int,@Qid int, @Exid int, @Answer nchar(100)
		as
			update Stu_Answer set St_Answer=@Answer, date = GETDATE()
			where St_Id=@Stid and Q_Id=@Qid and Ex_Id=@Exid 
	

			execute UpdateStudentAnswer  1,4,1,"a)amira"
	/******************insert******************/     
	create procedure AddAnswer @Stid int,@Qid int, @Exid int, @Answer nchar(100)
as
	insert into Stu_Answer
	values(@Exid,@Stid,@Qid ,GETDATE(),@Answer)

	execute AddAnswer 1,3,1,vafsref
	/******************delete******************/
			create procedure DeleteAnswer @Stid int,@Qid int, @Exid int
as
	delete from Stu_Answer where St_Id=@Stid and Q_Id=@Qid and Ex_Id=@Exid 


	execute DeleteAnswer 1,3,1

	/******************Report that takes exam number and the student ID then returns the Questions in this exam with the student answers******************/
		create procedure ViewQuest_and_Ans_for_Student @EXid int,@Stid int 
as
	select Q_Title , St_Answer from Question as q ,Stu_Answer
	where q.Q_Id=(select Q_Id 
	from  Stu_Answer
	where  St_Id =@Stid and Ex_Id = @EXid)
	


	execute ViewQuest_and_Ans_for_Student 1,1

	/******************instructor_course tabel******************/
	
	/******************select******************/
	/******************Report that takes the instructor ID and returns the name of the courses that he teaches and the number of student per course.******************/
create procedure NameOfCourseAndNumOfStudByInsId @InsId int  
as
		select count(St_Id) as st_num, Crs_Name from stud_Course as sc , Course where sc.Crs_Id = 
	(select Crs_Id from Ins_Course where Ins_Id = @InsId ) and Course.Crs_Id = 
	(select Crs_Id from Ins_Course where Ins_Id = @InsId )
	group by sc.Crs_Id,Course.Crs_Name


	execute NameOfCourseAndNumOfStudByInsId 4
	/******************update******************/
	create procedure Update_ins_course @InsId int,@crsid int
		as
			update Ins_Course set Crs_Id=@crsid
			where Ins_Id=@InsId  
	

			execute Update_ins_course  1,5
	/******************insert******************/
	create procedure Add_Ins_Course  @InsId int,@crsid int
as
	insert into Ins_Course 
	values(@InsId,@crsid)

	execute Add_Ins_Course 1,3
	/******************delete******************/
		create procedure Deleteinscourse @InsId int
as
	delete from Ins_Course where Ins_Id=@InsId 


	execute Deleteinscourse 1



	--Course TABLE
--insert
CREATE PROCEDURE new_course @Crs_Name NVARCHAR(50)
AS
INSERT INTO Course
VALUES (@Crs_Name)


--update 
CREATE PROCEDURE update_course @Crs_Id INT,@Crs_Name NVARCHAR(50)
AS
UPDATE Course SET Crs_Name=@Crs_Name
WHERE Crs_Id=@Crs_Id


--delete
CREATE PROCEDURE delete_course @Crs_Id INT
AS
DELETE FROM Course
WHERE Crs_Id=@Crs_Id


--Exam TABLE
--insert
CREATE PROCEDURE new_exam @time INT,@Crs_Id INT
AS
INSERT INTO Exam VALUES(@time,@Crs_Id)

--update
CREATE PROCEDURE update_exam @Ex_Id INT,@time INT ,@Crs_Id INT
AS
UPDATE Exam SET time=@time,Crs_Id=@Crs_Id
WHERE Ex_Id=@Ex_Id

--delete
CREATE PROCEDURE delete_exam @Ex_Id INT
AS
DELETE FROM Exam 
WHERE Ex_Id=@Ex_Id


--topic TABLE
--insert
CREATE PROCEDURE new_topic @Top_Name nvarchar(50),@Crs_Id INT
AS
INSERT INTO Topic VALUES(@Top_Name,@Crs_Id)

--update
CREATE PROCEDURE update_topic @Top_Id INT,@Top_Name nvarchar(50),@Crs_Id INT
AS
UPDATE Topic SET Top_Name=@Top_Name,Crs_Id=@Crs_Id
WHERE Top_Id=@Top_Id

--delete
CREATE PROCEDURE delete_topic @Top_Id INT
AS
DELETE FROM Topic
WHERE Top_Id=@Top_Id

--Report that takes course ID and returns its topics 
CREATE PROCEDURE  course_topics @Crs_Id INT
AS
SELECT Top_Name FROM Topic
WHERE Crs_Id=@Crs_Id


--Report that takes exam number and returns the Questions in it and chocies [freeform report]-->skipped
CREATE PROCEDURE exam_Questions_choices @Ex_Id INT 
AS
SELECT * FROM Question Q
INNER JOIN Exam_Q EQ
ON Q.Q_Id=EQ.Q_Id
INNER JOIN Choices C
ON C.Q_Id=Q.Q_Id
WHERE EQ.Ex_Id=@Ex_Id



--Department Table-----------------------------------------------------------------------------

Go
CREATE PROCEDURE AddToDepartment @DeptName nvarchar(50)
AS
INSERT INTO Department(Dept_Name)
VALUES (@DeptName);
Go

AddToDepartment "test"

------------------------------------------------------------------------------------------------

Go
CREATE PROCEDURE UpdateDepartmentName (@Dept_Id int, @DeptName nvarchar(50))
AS
UPDATE Department
SET Dept_Name = @DeptName
WHERE Dept_Id=@Dept_Id;
Go

UpdateDepartmentName 60,'Update test'

------------------------------------------------------------------------------------------------
Go
CREATE PROCEDURE DeleteFromDepartment @Dept_Id int
AS
DELETE FROM Department
WHERE Dept_Id=@Dept_Id
Go

DeleteFromDepartment 50

------------------------------------------------------------------------------------------------


--Instructor table------------------------------------------------------------------------------
Go
CREATE PROCEDURE AddToInstructor (@name nvarchar(50),@salary money,@dept_id int,@email varchar(50),@age int)
AS
INSERT INTO Instructor(Ins_Name,Salary,Dept_Id,email,age)
VALUES (@name,@salary,@dept_id,@email,@age);
Go

AddToInstructor 'test',12000,20,'test@gmail.com',20

------------------------------------------------------------------------------------------------

Go
CREATE PROCEDURE DeleteFromInstructor @Ins_Id int
AS
DELETE FROM Instructor
WHERE Ins_Id=@Ins_Id
Go

DeleteFromInstructor 16
------------------------------------------------------------------------------------------------

Go
CREATE PROCEDURE UpdateInstructor (@Ins_Id int,@name nvarchar(50),@salary money,@dept_id int,@email varchar(50),@age int)
AS
UPDATE Instructor
SET Ins_Name=@name,Salary=@salary,Dept_Id=@dept_id,email=@email,age=@age
WHERE Ins_Id=@Ins_Id;
Go

UpdateInstructor 15,'Nada',12000,40,'Nada@gmail,com',33
------------------------------------------------------------------------------------------------

GO

----------------------- Table Question-------------------------------------------
--Stored Procedure for:
--1.Insert new Question

create procedure Insert_Question @Model_Answer nchar(200),@Q_Title nchar(200),
@grade int,@type nchar(10),@Crs_Id int
as
begin

insert into Question(Model_Answer,Q_Title,grade,type,Crs_Id)
values(@Model_Answer,@Q_Title,@grade,@type,@Crs_Id)

end
--Testing
execute Insert_Question kkk,mmmm,10,mcq,5; 
select* from Question;
----------------------------------------------------------------------------------------
--2.Update Question
create procedure Update_Question @Q_Id int,@Model_Answer nchar(200),@Q_Title nchar(200),
@grade int,@type nchar(10),@Crs_Id int
as
begin
update Question

set 
Model_Answer=@Model_Answer,
Q_Title=@Q_Title,
grade=@grade,
type=@type,
Crs_Id=@Crs_Id
where Q_Id=@Q_Id
end
-----------------------------------------------------------------------
--Testing
execute Update_Question 101,mmm,hhhhhhhhhhhhhhhhh,10,mcq,5; 
-----------------------------------------------------------------------------------------
--3.Delete Question
create procedure Delete_Question @Q_Id int, @Model_Answer nchar(200),@Q_Title nchar(200),
@grade int,@type nchar(10),@Crs_Id int

as
begin
delete from Question 
where Q_Id=@Q_Id

end
--Testing
execute Delete_Question 101,mmm,hhhhhhhhhhhhhhhhh,10,mcq,5; 
---------------------------------------------------------------------------------------

-----------------------Table CHOICES-------------------------------------------
--Stored Procedure for:
--1.Insert new Choice
create procedure Insert_Choices  @Q_Id int ,@choice nchar(200)
as
begin

insert into choices(Q_Id,choice)
values( @Q_Id,@choice)

end
---------------------------------------------------------
--Testing
execute Insert_Choices 100,not_given;
execute Insert_Choices 100,given;
select* from  choices;
-------------------------------------------------------------------------------------------------------
--2-Update Choice

create proc update_question_choice @Q_Id int,@choice nvarchar(200),@oldchoice nvarchar(200)
as
begin 
update Choices set choice=@choice
where Q_Id=@Q_Id and choice=@oldchoice
end 

--Testing
execute update_question_choice 100,nn,given
---------------------------------------------------------------------------
--3.Delete a Choice
create procedure Delete_Choice @Q_Id int ,@choice nchar(200)
as
begin
	delete from  Choices 
	where Q_Id=@Q_Id and choice=@choice

	end
--------------------------------------------------------------------
select * from Choices;

execute Delete_Choice 100,not_given;


/********** GENERATE EXAM PROCEDURE***********/

alter procedure GenerateExam @Course int
as
	insert into Exam (Crs_Id)
	values(@Course)

	insert into Exam_Q (Q_Id,Ex_Id)
	select Top(10)Q_Id,e.Ex_Id
	from Question q, Exam e
	where q.Crs_Id=@Course and e.Ex_Id=(SELECT top(1)Ex_Id FROM Exam ORDER BY Ex_Id DESC )
	order by NEWID() 


execute GenerateExam @Course= 4

/*************SHOW EXAM **********/

ALTER procedure [dbo].[ShowExam] @Course int
as
	select Ex_Id
	from Exam e
	where e.Ex_Id=(select top(1)Ex_Id from Exam order by NEWID()) and e.Crs_Id=@Course


/*********COLLECT ANSWERS********/
GO
ALTER procedure [dbo].[AddAnswer] @Stid int,@Qid int, @Exid int, @Answer nchar(100)
as
	insert into Stu_Answer
	values(@Exid,@Stid,@Qid ,GETDATE(),@Answer)

/********** EXAM CORRECTION*********/

GO
ALTER PROCEDURE [dbo].[ExamCorrection] (@St_Id int,@crs_Id int)
AS
DECLARE @Grade int=0,@st_Ans varchar(50),@model_Ans varchar(50),@counter int =0

declare c1 cursor
for Select St_Answer,Model_Answer from Stu_Answer,Question WHERE Stu_Answer.Q_Id=Question.Q_Id AND Stu_Answer.St_Id = @St_Id AND Question.Crs_Id=@crs_Id
for read only 
open c1
fetch c1 into @st_Ans,@model_Ans
WHILE @@FETCH_STATUS=0
BEGIN
	fetch c1 into @st_Ans,@model_Ans
	IF (@st_Ans=@model_Ans)   
BEGIN
    set @Grade=@Grade+1
END
END
Deallocate c1
exec dbo.UpdateStudentCourseGrade @crs_Id,@St_Id,@Grade
