Use EJ_3_2024
GO

--Anexo Ejercico 3

--3.6
Select Nombre_CL,Apellido_CL
From Clientes
Where Nombre_CL Like '[^a]e%'
Go

Select Nombre_CL,Apellido_CL
From Clientes
GO

--3.7
Select Nombre_CL,Apellido_CL
From Clientes
Where Apellido_CL Like '[^SL]%'
GO