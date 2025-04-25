Use Clase_16_04_24
GO

--Inner Join / Join
Select NombreDepartamento_D,Apellido_E,IdDepartamento_D
From Departamentos Inner Join Empleados As E
On Departamentos.IdDepartamento_D = E.IdDepartamento_E
GO

/*
Para referenciar un campo
Empleados.IdDepartamento
*/

--Left Join. Muestra todos los departamentos, sin necesidad de tener coicidencia
Select NombreDepartamento_D,IdDepartamento_D,Apellido_E,IdDepartamento_E
From Departamentos Left Join Empleados As E
On Departamentos.IdDepartamento_D = E.IdDepartamento_E
GO

--Right Join. Muestra todos los empleados, sin necesidad de tener coicidencia
Select NombreDepartamento_D,IdDepartamento_D,Apellido_E,IdDepartamento_E
From Departamentos Right Join Empleados As E
On Departamentos.IdDepartamento_D = E.IdDepartamento_E
GO

--Full Join
Select NombreDepartamento_D,IdDepartamento_D,Apellido_E,IdDepartamento_E
From Departamentos Full Join Empleados As E
On Departamentos.IdDepartamento_D = E.IdDepartamento_E
GO