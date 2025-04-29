USE ExcaDb

DROP TABLE IF EXISTS condition_lease
DROP TABLE IF EXISTS lease_lessee
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
VALUES ('Originator'), ('Approver'), ('Administrator')

CREATE TABLE area (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(45) NOT NULL
)

INSERT INTO area (name)
VALUES ('Comercial'), ('Legal'), ('Proyectos')

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

CREATE TABLE document_type (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(45) NOT NULL
)
INSERT INTO document_type (name)
VALUES ('Company (Legal Entity)'), ('Company (Physical person)'), ('Individual')

CREATE TABLE document (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(45) NOT NULL
)

CREATE TABLE document_entity (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    document_type_id INT NOT NULL, 
    document_id INT NOT NULL, 
    FOREIGN KEY (document_type_id) REFERENCES document_type (id),
    FOREIGN KEY (document_id) REFERENCES document (id)
)

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

-- Guarantors (obligado solidario)
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
    name VARCHAR(45) NOT NULL, 
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
VALUES ('Condiciones Comerciales'), ('Condiciones Generales'), ('Contención de riesgos económicos'), ('Contención de riesgos'), ('Mitgación de riesgos'), ('Construcción por GP')

CREATE TABLE condition_type (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(45) NOT NULL
)
INSERT INTO condition_type (name)
VALUES ('text'), ('number'), ('date'), ('boolean'), ('Two Options')

-- conditions types // Otras
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
    -- Settings
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

-- HASTA AQUIIIII
/**
-- Asign company for rent assigments (cesión de renta)
CREATE TABLE rent_assigment (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    assignee_id INT NOT NULL, 
    assigment_date DATE, 
    document_link VARCHAR(MAX), -- assignment contract
    FOREIGN KEY (assignee_id) REFERENCES company (id) 
)

-- Contract
CREATE TABLE lease (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    contract_date DATE NOT NULL,  
    guarantor_id INT,
    rent_assigment_id INT, 
    FOREIGN KEY (guarantor_id) REFERENCES individual(id), 
    FOREIGN KEY (rent_assigment_id) REFERENCES rent_assigment(id), 
)

-- Lessor of lease
CREATE TABLE lease_lessor (
    lease_id INT NOT NULL, 
    company_id INT NOT NULL, 
    ownership_percentage DECIMAL(10,2), 
    FOREIGN KEY (lease_id) REFERENCES lease (id), 
    FOREIGN KEY (company_id) REFERENCES company(id), 
    PRIMARY KEY (lease_id, company_id)
)

CREATE TABLE lease_lessee (
    lease_id INT NOT NULL, 
    company_id INT NOT NULL, 
    FOREIGN KEY (lease_id) REFERENCES lease (id), 
    FOREIGN KEY (company_id) REFERENCES company(id), 
    PRIMARY KEY (lease_id, company_id)
)

-- relation of conditions with lease
CREATE TABLE condition_lease (
    condition_id INT NOT NULL,
    lease_id INT NOT NULL,
    value TEXT, 
    FOREIGN KEY (condition_id) REFERENCES condition_type (id), 
    FOREIGN KEY (lease_id) REFERENCES lease (id)
)**/