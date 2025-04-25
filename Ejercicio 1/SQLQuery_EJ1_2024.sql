--Para especificar que BASE usar
USE EJ_1_2024
GO

Select * 
From Profesores
GO

/*
Para comentar varias lineas
*/
--Para comentar una sola linea

Select Nombre_PR
FROM Profesores
GO

Select DNI_ES,Nombre_ES 
From Estudiantes
GO

/*
Para CADENAS DE CARACTERES, va entre COMILLAS SIMPLES
Los espacios en blanco no se tienen en cuenta
*/

Select Nombre_ES 
From Estudiantes 
Where DNI_ES = '12345'
GO

