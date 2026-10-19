-- 1(Clustered Index)
SELECT Id AS PatientId, Name AS PatientName, DOB, WardId
INTO PatientIndexDemo
FROM Patients;

CREATE CLUSTERED INDEX IX_PatientIndexDemo_PatientId
ON PatientIndexDemo (PatientId);

GO

-- 2(Clustered Index)
SELECT Id AS ConsultantId, Name AS ConsultantName, Salary
INTO ConsultantIndexDemo
FROM Consultants;

CREATE CLUSTERED INDEX IX_ConsultantIndexDemo_ConsultantId
ON ConsultantIndexDemo (ConsultantId);

GO

-- 3(Ward)
CREATE NONCLUSTERED INDEX IX_Patients_WardId
ON Patients (WardId);

GO

-- 4(Salary)
CREATE NONCLUSTERED INDEX IX_Consultants_Salary
ON Consultants (Salary);

GO

-- 5(Composite Nonclustered Index)
CREATE NONCLUSTERED INDEX IX_DrugAdministrations_PatientId_DrugCode
ON DrugAdministrations (PatientId, DrugCode);

GO

-- 6 (Included Columns)
CREATE NONCLUSTERED INDEX IX_Patients_WardId_Include_Details
ON Patients (WardId)
INCLUDE (Name, DOB);

GO

-- 7 (Unique Index)
CREATE UNIQUE NONCLUSTERED INDEX IX_Consultants_Name_Unique
ON Consultants (Name);

GO

-- 8 (Composite Unique Index)
CREATE TABLE PatientDrugAssignmentDemo (
    PatientId INT,
    DrugCode VARCHAR(50),
    StartDate DATE
);

CREATE UNIQUE NONCLUSTERED INDEX IX_PatientDrugAssignmentDemo_Unique
ON PatientDrugAssignmentDemo (PatientId, DrugCode);

GO

-- 9
INSERT INTO PatientDrugAssignmentDemo (PatientId, DrugCode, StartDate)
VALUES (1, 'DRG-01', '2026-01-10');

INSERT INTO PatientDrugAssignmentDemo (PatientId, DrugCode, StartDate)
VALUES (1, 'DRG-01', '2026-02-15');

GO

-- 10
EXEC sp_helpindex 'Patients';

GO

-- 11
SELECT 
    t.name AS TableName,
    i.name AS IndexName,
    i.type_desc AS IndexType
FROM sys.indexes i
INNER JOIN sys.tables t ON i.object_id = t.object_id
WHERE i.name IS NOT NULL
ORDER BY TableName, IndexName;

GO

-- 12
DROP INDEX IX_Consultants_Salary ON Consultants;

GO

-- 13
CREATE NONCLUSTERED INDEX IX_Patients_WardId_DOB
ON Patients (WardId, DOB);

GO

-- 14
CREATE NONCLUSTERED INDEX IX_DrugAdministrations_Reporting
ON DrugAdministrations (PatientId, DATE)
INCLUDE (DrugCode, Dosage, Quantity);