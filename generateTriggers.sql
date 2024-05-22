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
        INSERT INTO Auditoria (tabla, tipo_evento, usuario, fecha_hora)
        VALUES (TG_TABLE_NAME, 'INSERT', SESSION_USER, NOW());
        RETURN NEW;
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO Auditoria (tabla, tipo_evento, usuario, fecha_hora)
        VALUES (TG_TABLE_NAME, 'UPDATE', SESSION_USER, NOW());
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO Auditoria (tabla, tipo_evento, usuario, fecha_hora)
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



CREATE TRIGGER check_insert_critica BEFORE INSERT ON Críticas
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Pag_Web WHERE id_url = NEW.id_url) THEN
        INSERT INTO Pag_Web ( Url, Tipo)
        VALUES ( NEW.url, NEW.url); 
    END IF;
END //

CREATE TRIGGER check_insert_caratula BEFORE INSERT ON Carátulas
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Pag_Web WHERE id_url = NEW.id_url) THEN
        INSERT INTO Pag_Web (Url, Tipo)
        VALUES (NEW.Url, NEW.Tipo); 
    END IF;
END //

CREATE TRIGGER update_media AFTER INSERT ON Critica
FOR EACH ROW
BEGIN
    DECLARE total_puntuacion DECIMAL(5,2);
    DECLARE total_criticas INT;

    SELECT SUM(Puntuacion), COUNT(*)
    INTO total_puntuacion, total_criticas
    FROM Críticas
    WHERE id_pelicula = NEW.id_pelicula;

    IF total_criticas > 0 THEN
        INSERT INTO PuntuacionMedia (id_pelicula, puntuacion_media)
        VALUES (NEW.id_pelicula, total_puntuacion / total_criticas)
        ON DUPLICATE KEY UPDATE puntuacion_media = total_puntuacion / total_criticas;
    END IF;
END //