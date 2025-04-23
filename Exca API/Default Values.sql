USE ExcaDb

DELETE FROM condition

INSERT INTO condition (name, options, category_id, type_id)
VALUES 
('Tipo de contrato', '["Primer Contrato", "Renovación"]', 1, 5),
('Renta Mensual', null, 1, 2), 
('Renta Anterior', null, 1, 2), 
('Precio por m2 (LOCA)', null, 1, 2),
('Porcentaje de incremento', null, 1, 2),
('Referencia lista precios (Breña)', null, 1, 2), 
('Cuota de mantenimiento', null, 1, 2),
('¿Cumple lo mínimo autorizado', null, 1, 4),
('Vigencia', null, 1, 2),
('Prorroga', null, 1, 4),
('¿Automática?', null, 1, 4),
('Plazo forzoso GPV', null, 1, 2),
('Plazo forzoso arrendatario', null, 1, 2),
('Incremento anual', null, 1, 1),
('Incremento a partir de', '["Fecha de firma", "Obtención de permisos", "Inicio de operaciones"]', 1, 5),
('Incremento adicional', null, 1, 1),
('¿Cuándo?', null, 1, 1),
('Fecha de firma de contrato', null, 1, 3),
('Deposito de garantía (meses)', '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, "NO"]', 1, 5),
('Renta anticipada (meses)', null, 1, 2),
('Inicio de pago de renta', null, 1, 3),
('Periodo de gracia (meses)', '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, "NO"]', 1, 5),
('¿Cumple con la tabla autorizada de PG?', null, 1, 4),
('¿Cúando inicia el PG?', null, 1, 1),
('¿Hay que firmar acta de entrega?', null, 1, 4),
('¿Paga predial proporcional?', null, 1, 4),
('Derecho de preferencia en venta', '["No tiene derecho de preferencia, no se le tiene que avisar", "No tiene derecho de preferencia, si se le tiene que avisar", "Si tiene derecho, no aplica entre filiales GP, no se le avisa", "Si tiene derecho, no aplica entre filiales GP, si se le avisa"]', 1, 5)

