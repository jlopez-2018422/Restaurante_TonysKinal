DROP DATABASE DBTonysKinal_2018422;
CREATE DATABASE DBTonysKinal_2018422;

USE DBTonysKinal_2018422;

CREATE TABLE Empresas(
 CodigoEmpresa INT NOT NULL,
 NombreEmpresa VARCHAR(150) NOT NULL,
 Direccion VARCHAR(150) NOT NULL,
 Telefono VARCHAR(10) NOT NULL,
 PRIMARY KEY PK_CodigoEmpresa (CodigoEmpresa) 
);

CREATE TABLE Presupuesto(
  CodigoPresupuesto INT NOT NULL,
  FechaSolicitud DATE NOT NULL,
  CantidadPresupuesto DECIMAL(10,2),
  F_CodigoEmpresa INT NOT NULL,
  PRIMARY KEY PK_CodigoPresupuesto (CodigoPresupuesto),
  CONSTRAINT FK_Empresas_Presupuesto FOREIGN KEY (F_CodigoEmpresa)
  REFERENCES Empresas(CodigoEmpresa)
);


-------------------------------------------------------------------------
CREATE TABLE TipoEmpleado(
   CodigoTipoEmple INT NOT NULL,
   Descripcion VARCHAR(100) NOT NULL,
   PRIMARY KEY PK_CodigoTipoEmpleado (CodigoTipoEmple)
);

CREATE TABLE Empleados(
  CodigoEmpleado INT NOT NULL,
  NumeroEmpleado INT NOT NULL,
  ApellidosEmpleado VARCHAR(150) NOT NULL,
  NombresEmpleado VARCHAR(150) NOT NULL,
  DireccionEmpleado VARCHAR(150) NOT NULL, 
  TelefonoContacto VARCHAR(10) NOT NULL,
  GradoCocinero VARCHAR(50) NOT NULL,
  f_CodigoTipoEmpleado INT NOT NULL,
  PRIMARY KEY PK_CodigoEmpleado (CodigoEmpleado),
  CONSTRAINT FK_Empleados_TipoEmpleado FOREIGN KEY (f_CodigoTipoEmpleado)
  REFERENCES TipoEmpleado(CodigoTipoEmple)
);

----------------------------------------------------------------------------------
CREATE TABLE Servicios(
 CodigoServicio INT NOT NULL,
 FechaServicio DATE NOT NULL,
 TipoServicio VARCHAR(100) NOT NULL,
 HoraServicio TIME NOT NULL,
 LugarServicio VARCHAR(100) NOT NULL,
 TelefonoContacto VARCHAR (10) NOT NULL,
 F_CodigoEmpresa INT NOT NULL,
 PRIMARY KEY PK_CodigoServicio (CodigoServicio),
 CONSTRAINT FK_Servicios_Empresa FOREIGN KEY (F_CodigoEmpresa) 
 REFERENCES Empresas (CodigoEmpresa)
);
---------------------------------------------------------------------------
CREATE TABLE Servicios_has_Empleados(
 Servicios_CodigoServicio INT NOT NULL,
 F_Codigo_Servicios INT NOT NULL,
 F_Codigo_Empleados INT NOT NULL,
 FechaEvento DATE NOT NULL,
 HoraEvento TIME NOT NULL,
 LugarEvento VARCHAR(150),
 PRIMARY KEY PK_Sevicios_codigoServicio (Servicios_CodigoServicio),
 CONSTRAINT FK_Servicios_has_Empleados_Servicios1 FOREIGN KEY (F_Codigo_Servicios)
 REFERENCES Servicios (CodigoServicio),
 CONSTRAINT FK_Servicios_has_Empleados_Empleados1 FOREIGN KEY (F_Codigo_Empleados) 
 REFERENCES Empleados (CodigoEmpleado)
); 
-------------------------------------------------------------------------
CREATE TABLE TipoPlato(
 CodigoTipoPlato INT NOT NULL,
 DescripcionTipo VARCHAR(100),
 PRIMARY KEY PK_CodigoTipoProducto (CodigoTipoPlato)
);
-------------------------------------------------------------------------
CREATE TABLE Productos(
 CodigoProducto INT NOT NULL,
 NombreProducto VARCHAR(150) NOT NULL,
 Cantidad INT NOT NULL,
 PRIMARY KEY PK_CodigoProducto (CodigoProducto)
);

-------------------------------------------------------------------------
CREATE TABLE Platos(
 CodigoPlato INT NOT NULL,
 Cantidad INT NOT NULL,
 NombrePlato VARCHAR(50) NOT NULL,
 DescripcionPlato VARCHAR(150) NOT NULL,
 PrecioPlato DECIMAL (10,2) NOT NULL,
 F_CodigoTipoPlato INT NOT NULL,
 PRIMARY KEY PK_CodigoPlato (CodigoPlato),
 CONSTRAINT FK_Platos_TipoPlato FOREIGN KEY (F_CodigoTipoPlato)
 REFERENCES TipoPlato (CodigoTipoPlato)
);

CREATE TABLE Servicios_has_Platos(
 Servicios_CodigoServicio INT NOT NULL,
 F_CodigoServicio INT NOT NULL,
 F_CodigoPlato INT NOT NULL,
 PRIMARY KEY PK_Servicios_CodigoServicio (Servicios_CodigoServicio),
 CONSTRAINT FK_Servicios_has_Platos_Servicio1 FOREIGN KEY (F_CodigoServicio)
 REFERENCES Servicios (CodigoServicio),
 CONSTRAINT FK_Servicios_has_Platos_Platos1 FOREIGN KEY (F_CodigoPlato)
 REFERENCES Platos (CodigoPlato)
);
-------------------------------------------------------------------------
CREATE TABLE Productos_has_Platos(
 Productos_CodigoProducto INT NOT NULL,
 F_CodigoProducto INT NOT NULL,
 F_CodigoPlatos INT NOT NULL,
 PRIMARY KEY PK_Productos_CodigoProducto (Productos_CodigoProducto),
 CONSTRAINT FK_Productos_has_Platos_Productos1 FOREIGN KEY (F_CodigoProducto)
 REFERENCES Productos(CodigoProducto),
 CONSTRAINT FK_Productos_has_Platos_Platos1 FOREIGN KEY (F_CodigoPlatos)
 REFERENCES Platos (CodigoPlato)
);

-----------------------------------------------------------EMPLEADOS--------------------------------------------------------------------

/*--------Agregar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_AgregarEmpleados(IN CodigoEm INT, IN NumeroEm INT, IN ApellidosEm VARCHAR(150),
  IN NombresEm VARCHAR(150), IN DireccionEm VARCHAR(150), IN TelefonoCon VARCHAR(10), IN GradoCo VARCHAR(50),
  IN F_CodigoTipoEm INT)
     BEGIN
         INSERT INTO Empleados (CodigoEmpleado, NumeroEmpleado, ApellidosEmpleado, NombresEmpleado,
         DireccionEmpleado, TelefonoContacto, GradoCocinero, F_CodigoTipoEmpleado)
         VALUES (CodigoEm, NumeroEm, ApellidosEm, NombresEm,DireccionEm, TelefonoCon, GradoCo, F_CodigoTipoEm);
     END$$
DELIMITER ;

CALL SP_AgregarEmpleados('1', '1', 'López Herrera', 'Justin Alfredo', '5 nta. Calle 1, Zona 9', '23456781', 'Senior Chef', '1'); 

/*-------Listar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_ListarEmpleados()
     BEGIN
         SELECT
         E.CodigoEmpleado, E.NumeroEmpleado, E.ApellidosEmpleado, E.NombresEmpleado,
         E.DireccionEmpleado, E.TelefonoContacto, E.GradoCocinero, E.F_CodigoTipoEmpleado
         FROM Empleados E;
	END$$
DELIMITER ;

CALL SP_ListarEmpleados();

/*-------Buscar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_BuscarEmpleados (IN CodEm INT)
    BEGIN 
       SELECT 
           E.CodigoEmpleado,
           E.NombresEmpleado,
           E.ApellidosEmpleado
           FROM Empleados E WHERE CodigoEmpleado = CodEm;
	END$$
DELIMITER ;

CALL SP_BuscarEmpleados(1);

/*-------Eliminar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EliminarEmpleados(IN CodEm INT)
      BEGIN 
         DELETE FROM Empleados 
			WHERE CodigoEmpleado = CodEm;
	 End $$
DELIMITER ;

CALL SP_EliminarEmpleados();
CALL SP_ListarEmpleados();

/*-------update---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EditarEmpleados(IN CodigoEm INT, IN NumeroEm INT, IN ApellidosEm VARCHAR(150),
  IN NombresEm VARCHAR(150), IN DireccionEm VARCHAR(150), IN TelefonoCon VARCHAR(10), IN GradoCo VARCHAR(50),
  IN F_CodigoTipoEm INT)
        BEGIN 
            UPDATE Empleados E 
               SET  CodigoEmpleado = CodigoEm, NumeroEmpleado =  NumeroEm, ApellidosEmpleado = ApellidosEm, NombresEmpleado = NombresEm,
         DireccionEmpleado = DireccionEm, TelefonoContacto = TelefonoCon, GradoCocinero = GradoCo, F_CodigoTipoEmpleado = F_CodigoTipoEm
                   WHERE CodigoEmpleado = CodigoEm;
		END$$
DELIMITER ;

CALL SP_EditarEmpleados('1', '1', 'López Rivas', 'Justin Alfredo', '5 nta. Calle 1, Zona 9', '23456781', 'Senior Chef', '1');
CaLL SP_ListarEmpleados();

------------------------------------------------------EMPRESAS--------------------------------------------------------------------
                                                
/*--------Agregar---------------*/
DELIMITER $$
   CREATE PROCEDURE SP_AgregarEmpresas (IN CodigoEmp INT, IN NombreEmp VARCHAR(150), IN Direc VARCHAR(150), IN Tel VARCHAR(10))
       BEGIN 
           INSERT INTO Empresas (CodigoEmpresa, NombreEmpresa, Direccion, Telefono)
           VALUES (CodigoEmp, NombreEmp, Direc, Tel);
           End $$
DELIMITER ;
		
CALL SP_AgregarEmpresas ('1','Distribuidora Getafe (Frutas y verduras)',' 8ava. Calle 2, Zona 15','43019823');

/*-------Listar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_ListarEmpresas()
     BEGIN
         SELECT
         EM.CodigoEmpresa, EM.NombreEmpresa, EM.Direccion, EM.Telefono
         FROM Empresas EM;
	END$$
DELIMITER ;

CALL SP_ListarEmpresas();

/*-------Buscar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_BuscarEmpresas(IN CodEmp INT)
    BEGIN 
       SELECT 
           EM.CodigoEmpresa, EM.NombreEmpresa, EM.Direccion, EM.Telefono
           FROM Empresas EM WHERE CodigoEmpresa = CodEmp;
	END$$
DELIMITER ;

CALL SP_BuscarEmpresas(1);

/*-------Eliminar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EliminarEmpresas(IN CodEmp INT)
      BEGIN 
         DELETE FROM Empresas 
			WHERE CodigoEmpresa = CodEmp;
	 End $$
DELIMITER ;

CALL SP_EliminarEmpresas();
CALL SP_ListarEmpresas();

/*-------update---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EditarEmpresas (IN CodEmp INT, IN NombreEmp VARCHAR(150), IN Direc VARCHAR(150), IN Tel VARCHAR(10))
        BEGIN 
            UPDATE Empresas
               SET CodigoEmpresa = CodEmp, NombreEmpresa = NombreEmp, Direccion = Direc, Telefono = Tel
                   WHERE CodigoEmpresa = CodEmp;
		END$$
DELIMITER ;

CALL SP_EditarEmpresas('1','Distribuidora Aldria (Frutas y verduras)',' 8ava. Calle 2, Zona 15','43019823');
CaLL SP_ListarEmpresas();

--------------------------------------------------------------PLATOS--------------------------------------------------------------------------------
										
/*--------Agregar---------------*/
DELIMITER $$
   CREATE PROCEDURE SP_AgregarPlatos ( IN CodPla INT, IN Canti INT, IN NombrePl VARCHAR(50),
   IN DescripcionPl VARCHAR(150), IN PrecioPl DECIMAL (10,2), IN F_CodigoTipoPl INT)
       BEGIN 
           INSERT INTO Platos (CodigoPlato, Cantidad, NombrePlato, DescripcionPlato, PrecioPlato, F_CodigoTipoPlato)
           VALUES (CodPla, Canti, NombrePl, DescripcionPl, PrecioPl, F_CodigoTipoPl);
           End $$
DELIMITER ;
		
CALL SP_AgregarPlatos ('1', '15', 'Poutine', 'La poutine es un plato de la gastronomía quebecesa.', '80.00', '1');

/*-------Listar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_ListarPlatos()
     BEGIN
         SELECT
         PL.CodigoPlato, PL.Cantidad, PL.NombrePlato, PL.DescripcionPlato, PL.PrecioPlato, PL.F_CodigoTipoPlato
         FROM Platos PL;
	END$$
DELIMITER ;

CALL SP_ListarPlatos();

/*-------Buscar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_BuscarPlatos(IN CodPla INT)
    BEGIN 
       SELECT 
        PL.CodigoPlato, PL.Cantidad, PL.NombrePlato, PL.DescripcionPlato, PL.PrecioPlato, PL.F_CodigoTipoPlato
           FROM Platos PL WHERE CodigoPlato = CodPla;
	END$$
DELIMITER ;

CALL SP_BuscarPlatos(1);

/*-------Eliminar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EliminarPlatos(IN CodPla INT)
      BEGIN 
         DELETE FROM Platos 
			WHERE CodigoPlato = CodPla;
	 End $$
DELIMITER ;

CALL SP_EliminarPlatos();
CALL SP_ListarPlatos();

/*-------update---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EditarPlatos ( IN CodPla INT, IN Canti INT, IN NombrePl VARCHAR(50),
   IN DescripcionPl VARCHAR(150), IN PrecioPl DECIMAL (10,2), IN F_CodigoTipoPl INT)
        BEGIN 
            UPDATE Platos
               SET CodigoPlato = CodPla, Cantidad = Canti, NombrePlato = NombrePl, DescripcionPlato = DescripcionPl,
               PrecioPlato = PrecioPl, F_CodigoTipoPlato = F_CodigoTipoPl
                   WHERE CodigoPlato = CodPla;
		END$$
DELIMITER ;

CALL SP_EditarPlatos( '1', '1', 'Poutine', 'La poutine es un plato de la gastronomía quebecesa.', '80.00', '1');
CaLL SP_ListarPlatos();

-----------------------------------------------------------PRESUPUESTO--------------------------------------------------------------------------------

/*--------Agregar---------------*/
DELIMITER $$
   CREATE PROCEDURE SP_AgregarPresupuesto (CodP INT, FechaSoL DATE, CantidadPres DECIMAL(10,2), F_CodigoEmp INT)
       BEGIN 
           INSERT INTO Presupuesto (CodigoPresupuesto, FechaSolicitud, CantidadPresupuesto, F_CodigoEmpresa) 
                VALUES (CodP, FechaSol, CantidadPres, F_CodigoEmp);
           End $$
DELIMITER ;

CALL SP_AgregarPresupuesto ('1','2022-10-12','50000.00','1');

/*-------Listar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_ListarPresupuesto()
     BEGIN
         SELECT
         P.CodigoPresupuesto, P.FechaSolicitud, P.CantidadPresupuesto, P.F_CodigoEmpresa
         FROM Presupuesto P;
	END$$
DELIMITER ;

CALL SP_ListarPresupuesto();

/*-------Buscar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_BuscarPresupuesto (IN CodP INT)
    BEGIN 
       SELECT 
           P.CodigoPresupuesto, P.FechaSolicitud, P.CantidadPresupuesto, P.F_CodigoEmpresa
           FROM Presupuesto P WHERE CodigoPresupuesto = CodP;
	END$$
DELIMITER ;

CALL SP_BuscarPresupuesto('1');

/*-------Eliminar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EliminarPresupuesto(IN CodP INT)
      BEGIN 
         DELETE FROM Presupuesto
			WHERE CodigoPresupuesto = CodP;
	 End $$
DELIMITER ;

CALL SP_EliminarPresupuesto('');
CALL SP_ListarPresupuesto();

/*-------update---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EditarPresupuesto (CodP INT, FechaSol DATE, CantidadPres DECIMAL(10,2), F_CodigoEmp INT)
        BEGIN 
            UPDATE Presupuesto P
               SET CodigoPresupuesto = CodP, FechaSolicitud = FechaSol,
               CantidadPresupuesto = CantidadPres, F_CodigoEmpresa = F_CodigoEmp 
                   WHERE CodigoPresupuesto = CodP;
		END$$
DELIMITER ;

CALL SP_EditarPresupuesto ('1','2022-10-12','35000.00','1');
CALL SP_ListarPresupuesto();

-------------------------------------------------------------PRODUCTOS--------------------------------------------------------------------------------
/*--------Agregar---------------*/
DELIMITER $$
   CREATE PROCEDURE SP_AgregarProductos (IN CodigoPro INT, IN NombrePro VARCHAR(150), 
   IN Canti INT)
       BEGIN 
           INSERT INTO Productos (CodigoProducto, NombreProducto, Cantidad) 
                VALUES (CodigoPro, NombrePro, Canti);
           End $$
DELIMITER ;

CALL SP_AgregarProductos ('1','Manzanas','5000');

/*-------Listar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_ListarProductos()
     BEGIN
         SELECT
         PR.CodigoProducto, PR.NombreProducto, PR.Cantidad
         FROM Productos PR;
	END$$
DELIMITER ;

CALL SP_ListarProductos();

/*-------Buscar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_BuscarProductos (IN CodPr INT)
    BEGIN 
       SELECT 
           PR.CodigoProducto, PR.NombreProducto, PR.Cantidad
           FROM Productos Pr WHERE CodigoProducto = CodPr;
	END$$
DELIMITER ;

CALL SP_BuscarProductos('1');

/*-------Eliminar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EliminarProductos(IN CodPr INT)
      BEGIN 
         DELETE FROM Productos
			WHERE CodigoProductos = CodPr;
	 End $$
DELIMITER ;

CALL SP_EliminarProductos('');
CALL SP_ListarProductos();

/*-------update---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EditarProductos (IN CodPr INT, IN NombrePr VARCHAR(150), 
   IN Canti INT)
        BEGIN 
            UPDATE Productos
               SET CodigoProducto = CodPr, NombreProducto = NombrePr, Cantidad = Canti
                   WHERE CodigoProducto = CodPr;
		END$$
DELIMITER ;

CALL SP_EditarProductos ('1','Manzanas','5780');
CALL SP_ListarProductos();

--------------------------------------------------------------SERVICIOS--------------------------------------------------------------------------------
/*--------Agregar---------------*/
DELIMITER $$
   CREATE PROCEDURE SP_AgregarServicios (IN CodSer INT, IN FechaSer DATE, IN TipoSer VARCHAR(100), IN HoraSer TIME, IN LugarSer VARCHAR(100),
   IN TelefonoCo VARCHAR (10), IN F_CodigoEmpr INT)
       BEGIN 
           INSERT INTO Servicios (CodigoServicio, FechaServicio, TipoServicio, HoraServicio, LugarServicio,
                        TelefonoContacto, F_CodigoEmpresa) 
                VALUES (CodSer, FechaSer, TipoSer, HoraSer, LugarSer,TelefonoCo, F_CodigoEmpr);
           End $$
DELIMITER ;

CALL SP_AgregarServicios ('1','2022-10-12','Alimentos','8:00:00','Zona 15','34009143','1');

/*-------Listar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_ListarServicios()
     BEGIN
         SELECT
         Se.CodigoServicio, Se.FechaServicio, Se.TipoServicio, Se.HoraServicio, Se.LugarServicio,
		 Se.TelefonoContacto, Se.F_CodigoEmpresa
         FROM Servicios Se;
	END$$
DELIMITER ;

CALL SP_ListarServicios();

/*-------Buscar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_BuscarServicios (IN CodSer INT)
    BEGIN 
       SELECT 
           Se.CodigoServicio, Se.FechaServicio, Se.TipoServicio, Se.HoraServicio, Se.LugarServicio,
           Se.TelefonoContacto, Se.F_CodigoEmpresa
           FROM  Servicios Se
           WHERE CodigoServicio = CodSer;
	END$$
DELIMITER ;

CALL SP_BuscarServicios('1');

/*-------Eliminar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EliminarServicios(IN CodSer INT)
      BEGIN 
         DELETE FROM Servicios
			WHERE CodigoServicio = CodSer;
	 End $$
DELIMITER ;

CALL SP_EliminarServicios('');
CALL SP_ListarServicios();

/*-------update---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EditarServicios (IN CodSer INT, IN FechaSer DATE, IN TipoSer VARCHAR(100), IN HoraSer TIME, IN LugarSer VARCHAR(100),
 IN TelefonoCo VARCHAR (10), IN F_CodigoEmpr INT)
        BEGIN 
            UPDATE Servicios S
               SET CodigoServicio = CodSer, FechaServicio =  FechaSer, TipoServicio = TipoSer, HoraServicio = HoraSer,
			   LugarServicio = LugarSer, TelefonoContacto = TelefonoCo, F_CodigoEmpresa = F_CodigoEmpr 
                   WHERE CodigoServicio = CodSer;
		END$$
DELIMITER ;

CALL SP_EditarServicios ('1','2022-10-12','Alimentos','8:00:00','Zona 15','11114509','1');
CALL SP_ListarServicios();

-------------------------------------------------------------PRODUCTOS_HAS_PLATOS--------------------------------------------------------------------------------
/*--------Agregar---------------*/
DELIMITER $$
   CREATE PROCEDURE SP_AgregarPro_has_Pla (IN Productos_CodigoPro INT, IN F_CodigoPro INT, 
   IN F_CodigoPla INT)
       BEGIN 
           INSERT INTO Productos_has_platos (Productos_CodigoProducto, F_CodigoProducto, F_CodigoPlatos) 
                VALUES (Productos_CodigoPro, F_CodigoPro, F_CodigoPla);
           End $$
DELIMITER ;

CALL SP_AgregarPro_has_Pla ('1','1','1');

/*-------Listar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_ListarPro_has_Pla()
     BEGIN
         SELECT
         PRO.Productos_CodigoProducto, PRO.F_CodigoProducto, PRO.F_CodigoPlatos
         FROM Productos_has_platos PRO;
	END$$
DELIMITER ;

CALL SP_ListarPro_has_Pla();

/*-------Buscar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_BuscarPro_has_Pla (IN CodPr_Pl INT)
    BEGIN 
       SELECT 
           PRO.Productos_CodigoProducto, PRO.F_CodigoProducto, PRO.F_CodigoPlatos
           FROM Productos_has_platos PRO WHERE Productos_CodigoProducto = CodPr_Pl;
	END$$
DELIMITER ;

CALL SP_BuscarPro_has_Pla('1');

/*-------Eliminar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EliminarPro_has_Pla(IN CodPr_Pl INT)
      BEGIN 
         DELETE FROM Productos_has_platos
			WHERE Productos_CodigoProducto = CodPr_Pl;
	 End $$
DELIMITER ;

CALL SP_EliminaPro_has_Pla('');
CALL SP_ListarPro_has_Pla();

/*-------update---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EditarPro_has_Pla (IN  Productos_CodigoPro INT, IN F_CodigoPro INT, 
   IN F_CodigoPla INT)
        BEGIN 
            UPDATE Productos_has_platos
               SET Productos_CodigoProducto = Productos_CodigoPro, F_CodigoProducto = F_CodigoPro, F_CodigoPlatos = F_CodigoPla
                   WHERE  Productos_CodigoProducto = Productos_CodigoPro;
		END$$
DELIMITER ;

CALL SP_EditarPro_has_Pla ('1','1','1');
CALL SP_ListarPro_has_Pla();

-------------------------------------------------------------SERVICIOS_HAS_EMPLEADOS--------------------------------------------------------------------------------

/*--------Agregar---------------*/
DELIMITER $$
   CREATE PROCEDURE SP_AgregarSer_has_Emp (IN Servicios_CodigoSer INT, IN F_Codigo_Ser INT, 
   IN  F_Codigo_Emp INT, IN FechaEv DATE, IN HoraEv TIME, IN LugarEv VARCHAR(150) )
       BEGIN 
           INSERT INTO Servicios_has_Empleados (Servicios_CodigoServicio, F_Codigo_Servicios,
                        F_Codigo_Empleados, FechaEvento, HoraEvento, LugarEvento) 
                VALUES (Servicios_CodigoSer, F_Codigo_Ser, F_Codigo_Emp, FechaEv, HoraEv, LugarEv );
           End $$
DELIMITER ;

CALL SP_AgregarSer_has_Emp ('1','1','1','2022-10-13','10:00:00','Zona 15');

/*-------Listar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_ListarSer_has_Emp()
     BEGIN
         SELECT
         Servicios_CodigoServicio, F_Codigo_Servicios,F_Codigo_Empleados, FechaEvento, HoraEvento, LugarEvento
         FROM Servicios_has_Empleados SHE;
	END$$
DELIMITER ;

CALL SP_ListarSer_has_Emp();

/*-------Buscar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_BuscarSer_has_Emp (IN CodSer_Em INT)
    BEGIN 
       SELECT 
           SHE.Servicios_CodigoServicio, SHE.F_Codigo_Servicios, SHE.F_Codigo_Empleados, SHE.FechaEvento, SHE.HoraEvento, SHE.LugarEvento
           FROM Servicios_has_Empleados SHE WHERE Servicios_CodigoServicio = CodSer_Em;
	END$$
DELIMITER ;

CALL SP_BuscarSer_has_Emp('1');

/*-------Eliminar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EliminarSer_has_Emp(IN  CodSer_Em INT)
      BEGIN 
         DELETE FROM Servicios_has_Empleados
			WHERE Servicios_CodigoServicio = CodSer_Em;
	 End $$
DELIMITER ;

CALL SP_EliminaSer_has_Emp('');
CALL SP_ListarSer_has_Emp();

/*-------update---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EditarSer_has_Emp (IN CodSer_Em INT, IN Servicios_CodigoSer INT, IN F_Codigo_Ser INT, 
   IN  F_Codigo_Emp INT, IN FechaEv DATE, IN HoraEv TIME, IN LugarEv VARCHAR(150))
        BEGIN 
            UPDATE Servicios_has_Empleados
               SET Servicios_CodigoServicio = Servicios_CodigoSer, F_Codigo_Servicios = F_Codigo_Ser, F_Codigo_Empleados = F_Codigo_Emp,
               FechaEvento = FechaEv, HoraEvento = HoraEv, LugarEvento =LugarEv
                   WHERE  Servicios_CodigoServicio = CodSer_Em;
		END$$
DELIMITER ;

CALL SP_EditarSer_has_Emp ('1','1','1','1','2022-10-13','11:00:00','Zona 15');
CALL SP_ListarSer_has_Emp();

-------------------------------------------------------------SERVICIOS_HAS_PLATOS--------------------------------------------------------------------------------

/*--------Agregar---------------*/
DELIMITER $$
   CREATE PROCEDURE SP_AgregarSer_has_Plat (IN Servicios_CodigoServ INT, IN F_CodigoServ INT, 
   IN F_CodigoPla INT)
       BEGIN 
           INSERT INTO Servicios_has_platos (Servicios_CodigoServicio, F_CodigoServicio, F_CodigoPlato ) 
                VALUES (Servicios_CodigoServ, F_CodigoServ, F_CodigoPla);
           End $$
DELIMITER ;

CALL SP_AgregarSer_has_Plat ('1','1','1');

/*-------Listar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_ListarSer_has_Plat()
     BEGIN
         SELECT
         SHP.Servicios_CodigoServicio, SHP.F_CodigoServicio, SHP.F_CodigoPlato
         FROM Servicios_has_platos SHP;
	END$$
DELIMITER ;

CALL SP_ListarSer_has_Plat();

/*-------Buscar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_BuscarSer_has_Plat (IN CodSer_Plat INT)
    BEGIN 
       SELECT 
           SHP.Servicios_CodigoServicio, SHP.F_CodigoServicio, SHP.F_CodigoPlato
           FROM Servicios_has_platos SHP WHERE Servicios_CodigoServicio = CodSer_Plat;
	END$$
DELIMITER ;

CALL SP_BuscarSer_has_Plat('1');

/*-------Eliminar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EliminarSer_has_Plat(IN CodSer_Plat INT)
      BEGIN 
         DELETE FROM Servicios_has_platos
			WHERE Servicios_CodigoServicio = CodSer_Plat;
	 End $$
DELIMITER ;

CALL SP_EliminaSer_has_Plat('');
CALL SP_ListarSer_has_Plat();

/*-------update---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EditarSer_has_Plat (IN CodSer_Plat INT, IN Servicios_CodigoServ INT, IN F_CodigoServ INT, 
   IN F_CodigoPla INT)
        BEGIN 
            UPDATE Servicios_has_platos
               SET Servicios_CodigoServicio = Servicios_CodigoServ, F_CodigoServicio = F_CodigoServ, F_CodigoPlato = F_CodigoPla
                   WHERE  Servicios_CodigoServicio = CodSer_Plat;
		END$$
DELIMITER ;

CALL SP_EditarSer_has_Plat ('1','1','1','1');
CALL SP_ListarSer_has_Plat();
-------------------------------------------------------------TIPO_EMPLEADO--------------------------------------------------------------------------------

/*--------Agregar---------------*/
DELIMITER $$
   CREATE PROCEDURE SP_AgregarTipo_Empleado (IN CodigoTipoEmp INT, IN Descri VARCHAR(100) )
       BEGIN 
           INSERT INTO TipoEmpleado (CodigoTipoEmple, Descripcion ) 
                VALUES (CodigoTipoEmp, Descri);
           End $$
DELIMITER ;

CALL SP_AgregarTipo_Empleado ('1','Empleado el positivo');

/*-------Listar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_ListarTipo_Empleado()
     BEGIN
         SELECT
         TP.CodigoTipoEmple, TP.Descripcion
         FROM TipoEmpleado TP;
	END$$
DELIMITER ;

CALL SP_ListarTipo_Empleado();

/*-------Buscar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_BuscarTipo_Empleado (IN CodTip_Em INT)
    BEGIN 
       SELECT 
           TP.CodigoTipoEmple, TP.Descripcion
           FROM TipoEmpleado TP WHERE CodigoTipoEmple = CodTip_Em;
	END$$
DELIMITER ;

CALL SP_BuscarTipo_Empleado('1');

/*-------Eliminar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EliminarTipo_Empleado(IN CodTip_Em INT)
      BEGIN 
         DELETE FROM TipoEmpleado 
			WHERE CodigoTipoEmple = CodTip_Em;
	 End $$
DELIMITER ;

CALL SP_EliminaTipo_Empleado('');
CALL SP_ListarTipo_Empleado();

/*-------update---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EditarTipo_Empleado (IN CodTip_Em INT, IN CodigoTipoEmp INT, IN Descri VARCHAR(100))
        BEGIN 
            UPDATE TipoEmpleado
               SET CodigoTipoEmple = CodigoTipoEmp, Descripcion = Descri
                   WHERE  CodigoTipoEmple = CodTip_Em;
		END$$
DELIMITER ;

CALL SP_EditarTipo_Empleado ('1','1','Empleado el líder');
CALL SP_ListarTipo_Empleado();

-------------------------------------------------------------TIPO_PLATO--------------------------------------------------------------------------------

/*--------Agregar---------------*/
DELIMITER $$
   CREATE PROCEDURE SP_AgregarTipo_Plato (IN CodigoTipoPla INT, IN Descri VARCHAR(100) )
       BEGIN 
           INSERT INTO TipoPlato (CodigoTipoPlato, DescripcionTipo ) 
                VALUES (CodigoTipoPla, Descri);
           End $$
DELIMITER ;

CALL SP_AgregarTipo_Plato ('1','Postres');

/*-------Listar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_ListarTipo_Plato()
     BEGIN
         SELECT
         TP.CodigoTipoPlato, TP.DescripcionTipo
         FROM TipoPlato TP;
	END$$
DELIMITER ;

CALL SP_ListarTipo_Plato();

/*-------Buscar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_BuscarTipo_Plato (IN CodTip_Pla INT)
    BEGIN 
       SELECT 
           TP.CodigoTipoPlato, TP.DescripcionTipo
           FROM TipoPlato  TP WHERE CodigoTipoPlato = CodTip_Pla;
	END$$
DELIMITER ;

CALL SP_BuscarTipo_Plato('1');

/*-------Eliminar---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EliminarTipo_Plato(IN CodTip_Pla INT)
      BEGIN 
         DELETE FROM TipoPlato 
			WHERE CodigoTipoPlato = CodTip_Pla;
	 End $$
DELIMITER ;

CALL SP_EliminaTipo_Plato('');
CALL SP_ListarTipo_Plato();

/*-------update---------------*/
DELIMITER $$
    CREATE PROCEDURE SP_EditarTipo_Plato (IN  CodTip_Pla INT,IN CodigoTipoPla INT, IN Descri VARCHAR(100))
        BEGIN 
            UPDATE TipoPlato
               SET CodigoTipoPlato = CodigoTipoPla, DescripcionTipo = Descri
                   WHERE  CodigoTipoPlato  =  CodTip_Pla;
		END$$
DELIMITER ;

CALL SP_EditarTipo_Plato ('1','1','Plato Fuerte');
CALL SP_ListarTipo_Plato();