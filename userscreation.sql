----------------------USUARIO ADMINISRADOR----------------------
-- Crear el usuario administrador
CREATE USER admin WITH PASSWORD 'admin';
-- Conceder todos los privilegios al usuario administrador
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin;


----------------------USUARIO GESTOR----------------------
-- Crear el usuario gestor
CREATE USER gestor WITH PASSWORD 'gestor';
-- Conceder permisos de inserción, actualización, borrado y selección en todas las tablas existentes
GRANT INSERT, UPDATE, DELETE, SELECT ON ALL TABLES IN SCHEMA public TO gestor;

-- Conceder permisos para manejar secuencias necesarias para la inserción
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO gestor;

-- Conceder permisos de inserción, actualización, borrado y selección en tablas que se creen en el futuro
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT INSERT, UPDATE, DELETE, SELECT ON TABLES TO gestor;

-- Conceder permisos para manejar secuencias que se creen en el futuro
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE, SELECT ON SEQUENCES TO gestor;


----------------------USUARIO CRITICO----------------------
-- Crear el usuario crítico
CREATE USER critico WITH PASSWORD 'critico';
-- Conceder permisos de selección en todas las tablas existentes
GRANT SELECT ON ALL TABLES IN SCHEMA public TO critico;

-- Conceder permisos de inserción en la tabla de críticas y en las tablas que dependan de esta
GRANT INSERT ON TABLE Critica TO critico;
GRANT INSERT ON TABLE PagWeb TO critico;
--GRANT INSERT ON TABLE Pelicula TO critico;

-- Conceder permisos de selección en tablas que se creen en el futuro
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO critico;

-- Conceder permisos de inserción en la tabla de críticas para tablas que se creen en el futuro
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT INSERT ON TABLE Critica TO critico;
-- Para tablas dependientes de Critica:


----------------------USUARIO CLIENTE----------------------
-- Crear el usuario cliente
CREATE USER cliente WITH PASSWORD 'cliente';
-- Conceder permisos de selección en todas las tablas existentes
GRANT SELECT ON ALL TABLES IN SCHEMA public TO cliente;

-- Conceder permisos de selección en tablas que se creen en el futuro
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO cliente;
