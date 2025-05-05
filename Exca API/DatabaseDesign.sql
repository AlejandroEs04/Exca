USE ExcaDb

DROP TABLE IF EXISTS project_activity
DROP TABLE IF EXISTS project_activity_status
DROP TABLE IF EXISTS legal_case_conditions
DROP TABLE IF EXISTS legal_case
DROP TABLE IF EXISTS case_condition
DROP TABLE IF EXISTS [case]
DROP TABLE IF EXISTS case_type
DROP TABLE IF EXISTS condition_lease
DROP TABLE IF EXISTS technical_case_conditions
DROP TABLE IF EXISTS technical_case
DROP TABLE IF EXISTS lease_lessor
DROP TABLE IF EXISTS lease
DROP TABLE IF EXISTS rent_assigment
DROP TABLE IF EXISTS approval_request
DROP TABLE IF EXISTS approval_step
DROP TABLE IF EXISTS approval_flow
DROP TABLE IF EXISTS lease_request_condition
DROP TABLE IF EXISTS lease_request
DROP TABLE IF EXISTS owner
DROP TABLE IF EXISTS guarantee_type
DROP TABLE IF EXISTS condition
DROP TABLE IF EXISTS condition_type
DROP TABLE IF EXISTS condition_category
DROP TABLE IF EXISTS project_event
DROP TABLE IF EXISTS project_land
DROP TABLE IF EXISTS project_land_type
DROP TABLE IF EXISTS project
DROP TABLE IF EXISTS [status]
DROP TABLE IF EXISTS stage
DROP TABLE IF EXISTS land
DROP TABLE IF EXISTS residential_development
DROP TABLE IF EXISTS individual_document
DROP TABLE IF EXISTS individual
DROP TABLE IF EXISTS brand
DROP TABLE IF EXISTS client_document
DROP TABLE IF EXISTS client
DROP TABLE IF EXISTS document_entity
DROP TABLE IF EXISTS document
DROP TABLE IF EXISTS business_turn
DROP TABLE IF EXISTS document_type
DROP TABLE IF EXISTS client_type
DROP TABLE IF EXISTS company
DROP TABLE IF EXISTS company_type
DROP TABLE IF EXISTS [user]
DROP TABLE IF EXISTS user_area
DROP TABLE IF EXISTS area
DROP TABLE IF EXISTS [user_rol]

CREATE TABLE user_rol (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(45) NOT NULL
)

INSERT INTO user_rol (name)
VALUES ('Gerente'), ('Subdirector'), ('Director'), ('Analista'), ('User')

CREATE TABLE area (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(45) NOT NULL
)

INSERT INTO area (name)
VALUES ('Comercial'), ('Legal'), ('Gestión'), ('Desarrollo')

CREATE TABLE [user] (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    full_name VARCHAR(100) NOT NULL, 
    email VARCHAR(150) NOT NULL, 
    rol_id INT NOT NULL,
    area_id INT NOT NULL, 
    hashed_password VARCHAR(100) NOT NULL
    FOREIGN KEY (rol_id) REFERENCES user_rol (id), 
    FOREIGN KEY (area_id) REFERENCES area (id)
)

CREATE TABLE client_type (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(45) NOT NULL
)

INSERT INTO client_type (name)
VALUES ('Persona Moral'), ('Persona Física')

CREATE TABLE business_turn (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(45) NOT NULL
)

CREATE TABLE document (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(45) NOT NULL,
    use_legal_entity BIT NOT NULL, 
    use_physical_person BIT NOT NULL,
    use_individual BIT NOT NULL
)
INSERT INTO document (name, use_legal_entity, use_physical_person, use_individual) 
VALUES ('Acta Constitutiva c/Inscriptción RPP', 1, 0, 0),
('Poder Representante Legal C/Inscripción RPP', 1, 0, 0),
('Identificación Oficial Vigente', 1, 1, 1),
('Comprobante de Domicilio No Mayor a 3 Meses', 1, 1, 1),
('RFC', 1, 1, 0),
('Estado de Cuenta Bancario', 1, 1, 0),
('Escritura de la Propiedad en Garantia', 0, 0, 1),
('Otro', 1, 1, 0)

CREATE TABLE client (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    business_name VARCHAR(100) NOT NULL, 
    email VARCHAR(100) NULL,
    phone_number VARCHAR(15) NULL,
    tax_id VARCHAR(20) NULL, 
    address TEXT,
    type_id INT NOT NULL, 
    turn_id INT NULL,
    FOREIGN KEY (type_id) REFERENCES client_type (id), 
    FOREIGN KEY (turn_id) REFERENCES business_turn (id)
)

CREATE TABLE client_document (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    client_id INT NOT NULL, 
    document_id INT NOT NULL, 
    FOREIGN KEY (client_id) REFERENCES client (id),
    FOREIGN KEY (document_id) REFERENCES document (id)
)

CREATE TABLE brand (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(100) NOT NULL,
    client_id INT NOT NULL, 
    FOREIGN KEY (client_id) REFERENCES client (id)
)

CREATE TABLE individual (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    full_name VARCHAR(100) NOT NULL, 
    tax_id VARCHAR(20) NULL,
    address VARCHAR(100) NULL
)

CREATE TABLE individual_document (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    individual_id INT NOT NULL, 
    document_id INT NOT NULL, 
    FOREIGN KEY (individual_id) REFERENCES individual (id),
    FOREIGN KEY (document_id) REFERENCES document (id)
)

CREATE TABLE residential_development (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(60) NOT NULL
)

CREATE TABLE land (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    cadastral_file VARCHAR(45) NOT NULL UNIQUE,
    area DECIMAL(10,2) NOT NULL, 
    price_per_area DECIMAL(10,2) NOT NULL, 
    address VARCHAR(200) NOT NULL, 
    residential_development_id INT NOT NULL,
    FOREIGN KEY (residential_development_id) REFERENCES residential_development (id)
)

CREATE TABLE stage (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(45) NOT NULL
)

INSERT INTO stage (name)
VALUES ('Negociación'), ('Solicitud'), ('En Proceso'), ('Ratificación'), ('Cerrado')

CREATE TABLE [status] (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(45) NOT NULL
)

INSERT INTO status (name)
VALUES ('Nuevo'), ('En firmas'), ('Aceptado'), ('Cancelado')

CREATE TABLE project (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(45) NULL, 
    brand_id INT NOT NULL,
    stage_id INT NOT NULL,
    originator_id INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (brand_id) REFERENCES Brand (id),
    FOREIGN KEY (stage_id) REFERENCES stage (id), 
    FOREIGN KEY (originator_id) REFERENCES [user] (id)
)

CREATE TABLE project_land_type (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(45) NOT NULL
)
INSERT INTO project_land_type (name)
VALUES ('Local Construido'), ('Terreno en breña'), ('Terreno con mejoras')

CREATE TABLE project_land (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    project_id INT NOT NULL,
    land_id INT NOT NULL, 
    area DECIMAL(10,2) NOT NULL, 
    type_id INT NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (project_id) REFERENCES project (id), 
    FOREIGN KEY (land_id) REFERENCES land (id),
    FOREIGN KEY (type_id) REFERENCES project_land_type (id)
)

CREATE TABLE project_event (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    description TEXT NOT NULL, 
    tentativeDate DATE NOT NULL, 
    project_id INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(), 
    updated_at DATETIME NOT NULL DEFAULT GETDATE(), 
    FOREIGN KEY (project_id) REFERENCES project (id)
)

CREATE TABLE condition_category (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(45) NOT NULL
)
INSERT INTO condition_category (name)
VALUES 
('Condiciones Comerciales'), 
('Condiciones Generales'), 
('Contención de riesgos económicos'), 
('Contención de riesgos'), 
('Mitgación de riesgos'), 
('Construcción por GP')

CREATE TABLE condition_type (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(45) NOT NULL
)
INSERT INTO condition_type (name)
VALUES ('text'), ('number'), ('date'), ('boolean'), ('Two Options')

CREATE TABLE condition (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(150) NOT NULL, 
    type_id INT NOT NULL, 
    category_id INT NOT NULL, 
    options NVARCHAR(MAX),
    FOREIGN KEY (type_id) REFERENCES condition_type (id),
    FOREIGN KEY (category_id) REFERENCES condition_category (id)
)

CREATE TABLE guarantee_type (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(45) NOT NULL
)
INSERT INTO guarantee_type (name) 
VALUES ('Propiedad libre de gravamen'), ('Estados financieros / contables'), ('Obligado Solidario'), ('Rentas Anticipadas'), ('Sin garantia')

CREATE TABLE owner (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(45) NOT NULL
)
INSERT INTO [owner] (name)
VALUES ('FIMSA'), ('FEISA'), ('FIMSA / FEISA'), ('Otro')

CREATE TABLE lease_request (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    project_id INT NOT NULL, 
    guarantee_id INT NOT NULL, 
    guarantee_type_id INT NOT NULL, 
    owner_id INT NOT NULL,
    commission_agreement BIT NOT NULL, 
    assignment_income BIT NOT NULL, 
    property_file VARCHAR(20) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(), 
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    status_id INT NOT NULL DEFAULT 1, 
    FOREIGN KEY (project_id) REFERENCES project (id), 
    FOREIGN KEY (status_id) REFERENCES status (id),
    FOREIGN KEY (guarantee_id) REFERENCES individual (id), 
    FOREIGN KEY (guarantee_type_id) REFERENCES guarantee_type (id),
    FOREIGN KEY (owner_id) REFERENCES owner (id)
)

CREATE TABLE lease_request_condition (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    condition_id INT NOT NULL,
    lease_request_id INT NOT NULL,
    value TEXT,
    is_active BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (condition_id) REFERENCES condition (id), 
    FOREIGN KEY (lease_request_id) REFERENCES lease_request (id)
)

CREATE TABLE approval_flow (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(45)
)
INSERT INTO approval_flow (name)
VALUES ('Solicitud de contrato'), ('Caratula legal')

CREATE TABLE approval_step (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    next_step_id INT NULL, 
    flow_id INT NOT NULL, 
    signator_id INT NOT NULL, 
    FOREIGN KEY (next_step_id) REFERENCES approval_step (id), 
    FOREIGN KEY (flow_id) REFERENCES approval_flow (id), 
    FOREIGN KEY (signator_id) REFERENCES [user] (id)
)

CREATE TABLE approval_request (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    response BIT NULL,
    item_id VARCHAR(10) NOT NULL, 
    step_id INT NOT NULL, 
    FOREIGN KEY (step_id) REFERENCES approval_step (id)
)

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

INSERT INTO condition_category (name)
VALUES ('Electricidad'), ('Agua y Drenaje'), ('Gestiones requeridas'), ('Tecnicas')

INSERT INTO condition (name, options, category_id, type_id)
VALUES 
('Estatus del predio', '["Lote Comercial", "Área fuera de trámite"]', 10, 5),
('¿Está pagado el 7%?', null, 10, 4),
('En caso de NO, tiempos estimados para pagarlo', null, 10, 1),
('¿Tenemos el plano Ejecutivo de Ventas que ampare este proyecto?', null, 10, 4),

('¿Existe infraestructura frente al predio?', null, 7, 4),
('En caso de NO tiempos estimados para tenerlo', null, 7, 1),

('¿Existe infraestructura frente al predio?', null, 8, 4),
('Esta pagada la incorporación AyD', null, 8, 4),
('Esta pagada la aportación de Ay D?', null, 8, 4),
('¿El local / predio tiene o tuvo contrato de servicios?', null, 8, 4),
('¿Tenemos que tramitar factibilidad?', null, 8, 4),
('Tiempos para tramitarla', null, 8, 1),

('CLG', null, 9, 1),
('Alineamiento Vial', null, 9, 1),
('Amojonamiento', null, 9, 1),
('Licencias ', null, 9, 1),
('Fusión', null, 9, 1),
('Subdivisión', null, 9, 1),
('Uso de Suelo', null, 9, 1),
('Estudios Ambientales', null, 9, 1)

-- Condiciones Generales (category_id = 2)
INSERT INTO condition (name, options, category_id, type_id)
VALUES 
('Municipio', null, 2, 1),
('Estado', null, 2, 1),
('Vigencia Contrato en Años', null, 2, 2),
('Inicio de Vigencia', null, 2, 3),
('Prórroga de Vigencia en Años', null, 2, 2),
('Prórroga Condicionada o Automática', '["Condicionada", "Automática"]', 2, 5),
('Plazo Para Solicitar Prórroga en Días', null, 2, 2),
('Incremento de Renta en Prórroga', null, 2, 1),
('Riesgo de no recibir pago de Rentas', null, 2, 4),
('Fecha de Entrega de Posesión del Inmueble', null, 2, 3),
('Responsabilidad de Trámite de Licencias', '["Arrendadora", "Arrendataria"]', 2, 5),
('Fecha de Entrega de Licencias', null, 2, 3),
('Mantenimiento (Sin IVA)', null, 2, 2),
('Indexación Mantenimiento', null, 2, 1),
('Periodo de Gracia en Meses', null, 2, 2),
('Inicio de Periodo de Gracia', '["Entrega del Local Construido", "Firma de contrato", "Otro"]', 2, 5),
('Fecha de Inicio de Periodo de Gracia', null, 2, 3);

-- Contención de riesgos económicos (category_id = 3)
INSERT INTO condition (name, options, category_id, type_id)
VALUES 
('Depósito en Garantía en Meses', null, 3, 2),
('Cantidad Garantía en Meses', null, 3, 2),
('Actualización de Depósito en Garantía', null, 3, 1),
('Renta Anticipada en Meses', null, 3, 2),
('Cantidad de Renta Anticipada', null, 3, 2);

-- Contención de riesgos (category_id = 4)
INSERT INTO condition (name, options, category_id, type_id)
VALUES 
('GPV Autoriza Layout', null, 4, 4),
('GP Puede Cancelar el Contrato', null, 4, 4),
('Supuesto en el que GP puede Cancelar el Contrato', null, 4, 1),
('Plazo en días para que GP Termine el Contrato', null, 4, 2),
('Subarrendamiento Libre', null, 4, 4),
('Subarrendamiento a Filiales', null, 4, 4),
('Derecho de Preferencia en Venta para la Arrendataria', null, 4, 4),
('Tiempo en Días para Respuesta para Aceptación del Derecho de Preferencia', null, 4, 2),
('Derecho de Preferencia para Filiales de la Arrendataria', null, 4, 4),
('Aviso a Filiales de Derecho de Preferencia', null, 4, 4);

-- Mitigación de riesgos (category_id = 5)
INSERT INTO condition (name, options, category_id, type_id)
VALUES 
('Giro de Negocio de la Arrendataria', null, 5, 1),
('Riesgo por Distancia con Zona Habitacional', null, 5, 4),
('Distancia con Casa Habitación más Cercana', null, 5, 1),
('Riesgo de Olores', null, 5, 4),
('Visto Bueno de Área de Ventas', null, 5, 1),
('Riesgo de Generación de Tráfico', null, 5, 4),
('Visto Bueno de Proyectos', null, 5, 1),
('Riesgo de Residuos Peligrosos', null, 5, 4),
('Remediación por la Arrendataria en caso de Contaminación de Suelo', null, 5, 4),
('Riesgo de Contaminación de Suelo', null, 5, 4),
('Arrendataria Obligada a Contratación de Seguro por Obra y Operación', null, 5, 4),
('Giros Prohibidos', null, 5, 4),
('Listado de Giros Prohibidos', null, 5, 1),
('Lotes Afectados por Giros Prohibidos', null, 5, 1),
('Exclusividad de Giros en Contrato', null, 5, 4),
('Lotes Afectados por Exclusividad de Giros', null, 5, 1),
('Giros Exclusivos', null, 5, 1),
('Incumple Giros Exclusivos de Otros Contratos', null, 5, 4),
('Estado de Devolución del Inmueble al Termino del Contrato', null, 5, 1);

-- Construcción por GP (category_id = 6)
INSERT INTO condition (name, options, category_id, type_id)
VALUES 
('GP Construye', null, 6, 4),
('Superficie a Construir', null, 6, 2),
('Incluye Estacionamiento', null, 6, 4),
('Servicio de Agua y Drenaje', null, 6, 4),
('GP Administra el consumo de agua', null, 6, 4),
('Servicio de Electricidad', null, 6, 4),
('Preparación Eléctrica', null, 6, 4),
('Fecha de Entrega del Inmueble con Construcción', null, 6, 3),
('Aplica posibilidad de Entrega Parcial', null, 6, 4),
('Permite Terminación del Contrato por la No Entrega de la Construcción', null, 6, 4),
('Licencias a Cargo de', '["Arrendadora", "Arrendataria"]', 6, 5),
('Construcción de Totem', null, 6, 4),
('Posición de Rótulo', null, 6, 1),
('Entrega de Planos / Proyectos', null, 6, 4),
('Fecha de Entrega de Planos / Proyectos', null, 6, 3);

INSERT INTO [user] (full_name, email, rol_id, area_id, hashed_password)
VALUES ('Raphael Estrada', '2004.estrada.lopez@gmail.com', 1, 1, '$2b$12$5r1.bjr72xbAL0X3jZtvkuqtObxMZG8waRP1h43RK3GPBBzaogWVq')

CREATE TABLE case_type (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(30) NOT NULL
)
INSERT INTO case_type (name) VALUES ('Technical'), ('Legal')

CREATE TABLE [case] (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    project_id INT NOT NULL, 
    originator_id INT NOT NULL, 
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    sended_at DATETIME,
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    type_id INT NOT NULL
    FOREIGN KEY (project_id) REFERENCES project (id), 
    FOREIGN KEY (originator_id) REFERENCES [user] (id),
    FOREIGN KEY (type_id) REFERENCES [case_type] (id)
)

CREATE TABLE case_condition (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    case_id INT NOT NULL, 
    condition_id INT NOT NULL,
    value TEXT,
    is_active BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (condition_id) REFERENCES condition (id), 
    FOREIGN KEY (case_id) REFERENCES [case] (id)
)

CREATE TABLE technical_case (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    project_id INT NOT NULL, 
    originator_id INT NOT NULL, 
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    sended_at DATETIME,
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (project_id) REFERENCES project (id), 
    FOREIGN KEY (originator_id) REFERENCES [user] (id)
)

CREATE TABLE technical_case_conditions (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    technical_case_id INT NOT NULL, 
    condition_id INT NOT NULL,
    value TEXT,
    is_active BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (condition_id) REFERENCES condition (id), 
    FOREIGN KEY (technical_case_id) REFERENCES technical_case (id)
)

CREATE TABLE legal_case (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    project_id INT NOT NULL, 
    originator_id INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    sended_at DATETIME,
    updated_at DATETIME NOT NULL DEFAULT GETDATE(), 
    FOREIGN KEY (project_id) REFERENCES project (id), 
    FOREIGN KEY (originator_id) REFERENCES [user] (id)
)

CREATE TABLE legal_case_conditions (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    legal_case_id INT NOT NULL, 
    condition_id INT NOT NULL,
    value TEXT,
    is_active BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (condition_id) REFERENCES condition (id), 
    FOREIGN KEY (legal_case_id) REFERENCES legal_case (id)
)

CREATE TABLE project_activity_status (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(45)
)
INSERT INTO project_activity_status (name)
VALUES ('No visto'), ('Visto'), ('En proceso'), ('Finalizado'), ('Cancelado'), ('Retrasado')

CREATE TABLE project_activity (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    description TEXT NOT NULL, 
    responsible_area_id INT NOT NULL, 
    responsible_id INT NULL,
    due_date DATE NOT NULL, 
    status_id INT NOT NULL,
    FOREIGN KEY (responsible_area_id) REFERENCES area (id), 
    FOREIGN KEY (responsible_id) REFERENCES [user] (id), 
    FOREIGN KEY (status_id) REFERENCES [project_activity_status] (id)
)