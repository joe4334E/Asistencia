-- =====================================================================
-- MIGRACION 12: cambio de marca a UNITEPC - Universidad Privada Cosmos
--
-- El dominio institucional pasa de @istpet.edu.ec a @unitepc.edu.bo.
-- La validacion del sistema (Catalogo::DOMINIO) ya exige el dominio nuevo,
-- asi que las cuentas antiguas deben migrarse o no podran volver a entrar.
--
-- Uso:
--   mysql -u root asistencia_qr < database/migracion_12_marca_unitepc.sql
--
-- Despues de ejecutarlo, avisa a los docentes que su correo de acceso cambio.
-- La contrasena no se toca.
-- =====================================================================

DROP TEMPORARY TABLE IF EXISTS tmp_correos_unitepc;

CREATE TEMPORARY TABLE tmp_correos_unitepc AS
SELECT id,
       CONCAT(SUBSTRING_INDEX(correo, '@', 1), '@unitepc.edu.bo') AS correo_nuevo
FROM usuarios
WHERE correo LIKE '%@istpet.edu.ec';

-- Se actualiza solo si el correo nuevo no pertenece ya a otra cuenta:
-- la columna correo es UNIQUE y un choque abortaria toda la migracion.
UPDATE usuarios u
JOIN tmp_correos_unitepc t ON t.id = u.id
LEFT JOIN usuarios otro
       ON otro.correo = t.correo_nuevo
      AND otro.id <> u.id
SET u.correo = t.correo_nuevo
WHERE otro.id IS NULL;

-- Cualquier fila que aparezca aqui necesita revision manual: hay otra cuenta
-- ocupando ese mismo correo nuevo.
SELECT u.id,
       u.nombre,
       u.apellido,
       u.correo AS correo_actual,
       t.correo_nuevo
FROM usuarios u
JOIN tmp_correos_unitepc t ON t.id = u.id
WHERE u.correo <> t.correo_nuevo;

DROP TEMPORARY TABLE IF EXISTS tmp_correos_unitepc;
