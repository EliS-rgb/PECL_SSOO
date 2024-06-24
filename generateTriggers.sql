-- Creamos la tabla de auditoría.
CREATE TABLE Auditoria(
    id SERIAL PRIMARY KEY,
    tabla VARCHAR(255),
    evento VARCHAR(255),
    usuario VARCHAR(255),
    fecha_hora TIMESTAMP
);
-- Creamos la tabla de puntuaciones media.
CREATE TABLE PuntuacionMedia (
    id_pelicula INT PRIMARY KEY,
    puntuacion_media DECIMAL(3,2)
);


CREATE OR REPLACE FUNCTION trigger_aud() RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO Auditoria (tabla, evento, usuario, fecha_hora)
        VALUES (TG_TABLE_NAME, 'INSERT', SESSION_USER, NOW());
        RETURN NEW;
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO Auditoria (tabla, evento, usuario, fecha_hora)
        VALUES (TG_TABLE_NAME, 'UPDATE', SESSION_USER, NOW());
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO Auditoria (tabla, evento, usuario, fecha_hora)
        VALUES (TG_TABLE_NAME, 'DELETE', SESSION_USER, NOW());
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER auditoria_personal AFTER INSERT OR UPDATE OR DELETE ON Personal
FOR EACH ROW EXECUTE FUNCTION trigger_aud();


--Prueba

INSERT INTO Personal (nombre, nacimiento, fallecimiento)VALUES ('Nombre',1900,NULL);
UPDATE Personal SET fallecimiento=1999 WHERE nombre='Nombre';
DELETE FROM Personal WHERE nombre='Nombre';
SELECT * FROM auditoria;

CREATE TRIGGER auditoria_actor AFTER INSERT OR UPDATE OR DELETE ON Personal
FOR EACH ROW EXECUTE FUNCTION trigger_aud();
CREATE TRIGGER auditoria_director AFTER INSERT OR UPDATE OR DELETE ON Personal
FOR EACH ROW EXECUTE FUNCTION trigger_aud();
CREATE TRIGGER auditoria_guionista AFTER INSERT OR UPDATE OR DELETE ON Personal
FOR EACH ROW EXECUTE FUNCTION trigger_aud();
CREATE TRIGGER auditoria_pelicula AFTER INSERT OR UPDATE OR DELETE ON Personal
FOR EACH ROW EXECUTE FUNCTION trigger_aud();
CREATE TRIGGER auditoria_actua AFTER INSERT OR UPDATE OR DELETE ON Personal
FOR EACH ROW EXECUTE FUNCTION trigger_aud();
CREATE TRIGGER auditoria_dirige AFTER INSERT OR UPDATE OR DELETE ON Personal
FOR EACH ROW EXECUTE FUNCTION trigger_aud();
CREATE TRIGGER auditoria_critica AFTER INSERT OR UPDATE OR DELETE ON Personal
FOR EACH ROW EXECUTE FUNCTION trigger_aud();
CREATE TRIGGER auditoria_caratulas AFTER INSERT OR UPDATE OR DELETE ON Personal
FOR EACH ROW EXECUTE FUNCTION trigger_aud();
CREATE TRIGGER auditoria_alojadas AFTER INSERT OR UPDATE OR DELETE ON Personal
FOR EACH ROW EXECUTE FUNCTION trigger_aud();
CREATE TRIGGER auditoria_pagweb AFTER INSERT OR UPDATE OR DELETE ON Personal
FOR EACH ROW EXECUTE FUNCTION trigger_aud();



CREATE OR REPLACE FUNCTION check_insert_critica() RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Pag_Web WHERE id_pagweb = NEW.id_pagweb) THEN
        INSERT INTO Pag_Web (Url, tipo) VALUES (NEW.url, NEW.tipo);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_check_insert_critica
BEFORE INSERT ON "critica"
FOR EACH ROW
EXECUTE FUNCTION check_insert_critica();



CREATE OR REPLACE FUNCTION check_insert_caratula() RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Pag_Web WHERE id_pagweb = NEW.id_pagweb) THEN
        INSERT INTO Pag_Web (Url, tipo) VALUES (NEW.url, NEW.tipo);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_check_insert_caratula 
BEFORE INSERT ON Caratulas
FOR EACH ROW
EXECUTE FUNCTION check_insert_caratula();



CREATE OR REPLACE FUNCTION update_media() RETURNS TRIGGER AS $$
DECLARE
    total_puntuacion DECIMAL(5,2);
    total_criticas INT;
BEGIN
    -- Calcular la suma de puntuaciones y el total de críticas para la película
    SELECT COALESCE(SUM(puntuacion), 0), COUNT(*)
    INTO total_puntuacion, total_criticas
    FROM Critica
    WHERE id_pelicula = NEW.id_pelicula;

    -- Actualizar la puntuación media si hay críticas
    IF total_criticas > 0 THEN
        INSERT INTO PuntuacionMedia (id_pelicula, puntuacion_media)
        VALUES (NEW.id_pelicula, total_puntuacion / total_criticas)
        ON CONFLICT (id_pelicula) DO UPDATE 
        SET puntuacion_media = EXCLUDED.puntuacion_media;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_update_media 
AFTER INSERT ON Critica
FOR EACH ROW
EXECUTE FUNCTION update_media();

