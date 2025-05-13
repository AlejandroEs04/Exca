USE [GPViviendaDb]
GO

-- Eliminar tablas existentes en orden inverso de dependencias
DROP TABLE IF EXISTS project_activity
DROP TABLE IF EXISTS project_activity_status
DROP TABLE IF EXISTS legal_case_conditions
DROP TABLE IF EXISTS legal_case
DROP TABLE IF EXISTS case_condition
DROP TABLE IF EXISTS [case]
DROP TABLE IF EXISTS case_type
DROP TABLE IF EXISTS technical_case_conditions
DROP TABLE IF EXISTS technical_case
DROP TABLE IF EXISTS lease_request_condition
DROP TABLE IF EXISTS lease_request
DROP TABLE IF EXISTS approval_request
DROP TABLE IF EXISTS approval_step
DROP TABLE IF EXISTS approval_flow_step
DROP TABLE IF EXISTS approval_flow
DROP TABLE IF EXISTS condition_option
DROP TABLE IF EXISTS condition
DROP TABLE IF EXISTS condition_type
DROP TABLE IF EXISTS condition_category
DROP TABLE IF EXISTS project_event
DROP TABLE IF EXISTS project_land
DROP TABLE IF EXISTS project_land_type
DROP TABLE IF EXISTS client_address
DROP TABLE IF EXISTS document_usage
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
DROP TABLE IF EXISTS document
DROP TABLE IF EXISTS business_turn
DROP TABLE IF EXISTS client_type
DROP TABLE IF EXISTS owner
DROP TABLE IF EXISTS guarantee_type
DROP TABLE IF EXISTS [user]
DROP TABLE IF EXISTS area
DROP TABLE IF EXISTS user_rol
GO

-- 1. Tablas básicas de configuración
CREATE TABLE user_rol (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(45) NOT NULL
)
GO

INSERT INTO user_rol (name)
VALUES ('Gerente'), ('Subdirector'), ('Director'), ('Analista'), ('User')
GO

CREATE TABLE area (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(45) NOT NULL
)
GO

INSERT INTO area (name)
VALUES ('Comercial'), ('Legal'), ('Gestión'), ('Desarrollo')
GO

-- 2. Tablas de usuarios
CREATE TABLE [user] (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    full_name VARCHAR(100) NOT NULL, 
    email VARCHAR(150) NOT NULL UNIQUE, 
    rol_id INT NOT NULL,
    area_id INT NOT NULL, 
    hashed_password VARCHAR(100) NOT NULL,
    FOREIGN KEY (rol_id) REFERENCES user_rol (id), 
    FOREIGN KEY (area_id) REFERENCES area (id)
)
GO

-- 3. Tablas de clientes y documentos
CREATE TABLE client_type (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(45) NOT NULL
)
GO

INSERT INTO client_type (name)
VALUES ('Persona Moral'), ('Persona Física')
GO

CREATE TABLE business_turn (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(45) NOT NULL
)
GO

CREATE TABLE document (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(45) NOT NULL
)
GO

CREATE TABLE document_usage (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    document_id INT NOT NULL,
    usage_type VARCHAR(20) NOT NULL CHECK (usage_type IN ('legal_entity', 'physical_person', 'individual')),
    FOREIGN KEY (document_id) REFERENCES document(id)
)
GO

INSERT INTO document (name) 
VALUES ('Acta Constitutiva c/Inscriptción RPP'),
('Poder Representante Legal C/Inscripción RPP'),
('Identificación Oficial Vigente'),
('Comprobante de Domicilio No Mayor a 3 Meses'),
('RFC'),
('Estado de Cuenta Bancario'),
('Escritura de la Propiedad en Garantia'),
('Otro')
GO

-- Insertar usos de documentos basados en los datos originales
INSERT INTO document_usage (document_id, usage_type)
VALUES 
(1, 'legal_entity'),
(2, 'legal_entity'),
(3, 'legal_entity'), (3, 'physical_person'), (3, 'individual'),
(4, 'legal_entity'), (4, 'physical_person'), (4, 'individual'),
(5, 'legal_entity'), (5, 'physical_person'),
(6, 'legal_entity'), (6, 'physical_person'),
(7, 'individual'),
(8, 'legal_entity'), (8, 'physical_person')
GO

CREATE TABLE client (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    business_name VARCHAR(100) NOT NULL, 
    email VARCHAR(100) NULL UNIQUE,
    phone_number VARCHAR(15) NULL,
    tax_id VARCHAR(20) NULL UNIQUE, 
    type_id INT NOT NULL, 
    turn_id INT NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (type_id) REFERENCES client_type (id), 
    FOREIGN KEY (turn_id) REFERENCES business_turn (id)
)
GO

CREATE TABLE client_address (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    client_id INT NOT NULL,
    street VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(50) NOT NULL DEFAULT 'México',
    is_primary BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (client_id) REFERENCES client(id)
)
GO

CREATE TABLE client_document (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    client_id INT NOT NULL, 
    document_id INT NOT NULL, 
    file_path VARCHAR(255) NOT NULL,
    uploaded_at DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (client_id) REFERENCES client (id),
    FOREIGN KEY (document_id) REFERENCES document (id)
)
GO

CREATE TABLE brand (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(100) NOT NULL,
    client_id INT NOT NULL, 
    FOREIGN KEY (client_id) REFERENCES client (id)
)
GO

CREATE TABLE individual (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    full_name VARCHAR(100) NOT NULL, 
    tax_id VARCHAR(20) NULL UNIQUE,
    address_id INT NOT NULL, 
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(), 
    FOREIGN KEY (address_id) REFERENCES client_address (id)
)
GO

CREATE TABLE individual_document (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    individual_id INT NOT NULL, 
    document_id INT NOT NULL, 
    file_path VARCHAR(255) NOT NULL,
    uploaded_at DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (individual_id) REFERENCES individual (id),
    FOREIGN KEY (document_id) REFERENCES document (id)
)
GO

-- 4. Tablas de propiedades y desarrollos
CREATE TABLE residential_development (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(60) NOT NULL,
    city VARCHAR(45) NOT NULL,
    state VARCHAR(45) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE()
)
GO

CREATE TABLE land (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    cadastral_file VARCHAR(45) NOT NULL UNIQUE,
    area DECIMAL(10,2) NOT NULL CHECK (area > 0),
    build_area DECIMAL(10,2) NOT NULL CHECK (build_area >= 0),
    price_per_area DECIMAL(10,2) NOT NULL CHECK (price_per_area >= 0),
    address VARCHAR(200) NOT NULL,
    residential_development_id INT NOT NULL,
    municipio VARCHAR(100) NULL,
    valor_catastral DECIMAL(15,2) NULL,
    predial_payment DECIMAL(15,2) NULL,
    global_status INT NULL,
    name_last_update VARCHAR(50) NULL,
    path_predial_file VARCHAR(255) NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (residential_development_id) REFERENCES residential_development (id)
)
GO

-- 5. Tablas de proyectos
CREATE TABLE stage (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(45) NOT NULL,
    description VARCHAR(255) NULL
)
GO

INSERT INTO stage (name, description)
VALUES 
('Negociación', 'Etapa inicial de negociación con el cliente'),
('Solicitud', 'Solicitud formal recibida'),
('En Proceso', 'Proyecto en proceso de ejecución'),
('Ratificación', 'Esperando ratificación de términos'),
('Cerrado', 'Proyecto finalizado')
GO

CREATE TABLE [status] (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(45) NOT NULL,
    description VARCHAR(255) NULL
)
GO

INSERT INTO status (name, description)
VALUES 
('Nuevo', 'Elemento recién creado'),
('En firmas', 'En proceso de firma'),
('Aceptado', 'Aceptado y aprobado'),
('Cancelado', 'Cancelado o rechazado')
GO

CREATE TABLE project (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(45) NULL, 
    brand_id INT NOT NULL,
    stage_id INT NOT NULL,
    status_id INT NOT NULL DEFAULT 1,
    originator_id INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (brand_id) REFERENCES brand (id),
    FOREIGN KEY (stage_id) REFERENCES stage (id), 
    FOREIGN KEY (status_id) REFERENCES [status] (id),
    FOREIGN KEY (originator_id) REFERENCES [user] (id)
)
GO

CREATE TABLE project_land_type (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(45) NOT NULL,
    description VARCHAR(255) NULL
)
GO

INSERT INTO project_land_type (name, description)
VALUES 
('Local Construido', 'Local comercial ya construido'),
('Terreno en breña', 'Terreno sin construcciones'),
('Terreno con mejoras', 'Terreno con algunas mejoras básicas')
GO

CREATE TABLE project_land (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    project_id INT NOT NULL,
    land_id INT NOT NULL, 
    area DECIMAL(10,2) NOT NULL CHECK (area > 0),
    type_id INT NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (project_id) REFERENCES project (id), 
    FOREIGN KEY (land_id) REFERENCES land (id),
    FOREIGN KEY (type_id) REFERENCES project_land_type (id),
    CONSTRAINT UK_project_land UNIQUE (project_id, land_id)
)
GO

CREATE TABLE project_event (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    description TEXT NOT NULL, 
    tentative_date DATE NOT NULL, 
    actual_date DATE NULL,
    project_id INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(), 
    updated_at DATETIME NOT NULL DEFAULT GETDATE(), 
    FOREIGN KEY (project_id) REFERENCES project (id)
)
GO

-- 6. Tablas de condiciones y garantías
CREATE TABLE condition_category (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(45) NOT NULL,
    description VARCHAR(255) NULL
)
GO

INSERT INTO condition_category (name, description)
VALUES 
('Condiciones Comerciales', 'Condiciones relacionadas con aspectos comerciales'), 
('Condiciones Generales', 'Condiciones generales del contrato'), 
('Contención de riesgos económicos', 'Condiciones para mitigar riesgos económicos'), 
('Contención de riesgos', 'Condiciones generales de contención de riesgos'), 
('Mitigación de riesgos', 'Condiciones para mitigar riesgos específicos'), 
('Construcción por GP', 'Condiciones sobre construcción por parte de GP'),
('Electricidad', 'Condiciones relacionadas con servicio eléctrico'),
('Agua y Drenaje', 'Condiciones relacionadas con agua y drenaje'),
('Gestiones requeridas', 'Gestiones administrativas requeridas'),
('Técnicas', 'Condiciones técnicas especiales')
GO

CREATE TABLE condition_type (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(45) NOT NULL,
    description VARCHAR(255) NULL
)
GO

INSERT INTO condition_type (name, description)
VALUES 
('text', 'Campo de texto libre'),
('number', 'Campo numérico'),
('date', 'Campo de fecha'),
('boolean', 'Campo verdadero/falso'),
('options', 'Selección de opciones predefinidas')
GO

CREATE TABLE condition (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(150) NOT NULL, 
    description TEXT NULL,
    type_id INT NOT NULL, 
    category_id INT NOT NULL, 
    is_active BIT NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (type_id) REFERENCES condition_type (id),
    FOREIGN KEY (category_id) REFERENCES condition_category (id)
)
GO

CREATE TABLE condition_option (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    condition_id INT NOT NULL,
    option_value NVARCHAR(255) NOT NULL,
    display_order INT NOT NULL DEFAULT 0,
    is_active BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (condition_id) REFERENCES condition(id)
)
GO

-- Insertar condiciones con sus opciones (ejemplo)
INSERT INTO condition (name, type_id, category_id)
VALUES 
('Tipo de contrato', 5, 1),
('Renta Mensual', 2, 1),
('Municipio', 1, 2),
('Estado', 1, 2)
GO

INSERT INTO condition_option (condition_id, option_value, display_order)
VALUES 
(1, 'Primer Contrato', 1),
(1, 'Renovación', 2)
GO

CREATE TABLE guarantee_type (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(45) NOT NULL,
    description VARCHAR(255) NULL
)
GO

INSERT INTO guarantee_type (name, description) 
VALUES 
('Propiedad libre de gravamen', 'Garantía con propiedad sin gravámenes'),
('Estados financieros / contables', 'Garantía mediante estados financieros'),
('Obligado Solidario', 'Garantía con obligado solidario'),
('Rentas Anticipadas', 'Garantía mediante rentas anticipadas'),
('Sin garantia', 'Sin garantía requerida')
GO

CREATE TABLE owner (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(45) NOT NULL,
    description VARCHAR(255) NULL
)
GO

INSERT INTO [owner] (name, description)
VALUES 
('FIMSA', 'FIMSA como propietario'),
('FEISA', 'FEISA como propietario'),
('FIMSA / FEISA', 'Ambas entidades como propietarias'),
('Otro', 'Otro propietario no listado')
GO

-- 7. Tablas de solicitudes de arrendamiento
CREATE TABLE lease_request (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    project_id INT NOT NULL, 
    guarantee_id INT NULL, -- Puede ser NULL si es 'Sin garantia'
    guarantee_type_id INT NOT NULL, 
    owner_id INT NOT NULL,
    commission_agreement BIT NOT NULL DEFAULT 0,
    assignment_income BIT NOT NULL DEFAULT 0,
    property_file VARCHAR(20) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(), 
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    status_id INT NOT NULL DEFAULT 1, 
    created_by INT NOT NULL,
    FOREIGN KEY (project_id) REFERENCES project (id), 
    FOREIGN KEY (status_id) REFERENCES status (id),
    FOREIGN KEY (guarantee_id) REFERENCES individual (id), 
    FOREIGN KEY (guarantee_type_id) REFERENCES guarantee_type (id),
    FOREIGN KEY (owner_id) REFERENCES owner (id),
    FOREIGN KEY (created_by) REFERENCES [user](id)
)
GO

CREATE TABLE lease_request_condition (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    lease_request_id INT NOT NULL,
    condition_id INT NOT NULL,
    text_value TEXT NULL,
    number_value DECIMAL(18,2) NULL,
    date_value DATE NULL,
    boolean_value BIT NULL,
    option_id INT NULL,
    is_active BIT NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (lease_request_id) REFERENCES lease_request (id),
    FOREIGN KEY (condition_id) REFERENCES condition (id),
    FOREIGN KEY (option_id) REFERENCES condition_option (id)
)
GO

-- 8. Tablas de flujos de aprobación
CREATE TABLE approval_flow (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(45) NOT NULL,
    description VARCHAR(255) NULL,
    is_active BIT NOT NULL DEFAULT 1
)
GO

INSERT INTO approval_flow (name, description)
VALUES 
('Solicitud de contrato', 'Flujo para aprobación de contratos'),
('Caratula legal', 'Flujo para aprobación de carátulas legales')
GO

CREATE TABLE approval_flow_step (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    flow_id INT NOT NULL,
    step_order INT NOT NULL,
    signator_role_id INT NOT NULL,
    signator_area_id INT NULL,
    is_required BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (flow_id) REFERENCES approval_flow (id),
    FOREIGN KEY (signator_role_id) REFERENCES user_rol (id),
    FOREIGN KEY (signator_area_id) REFERENCES area (id),
    CONSTRAINT UQ_flow_step_order UNIQUE (flow_id, step_order)
)
GO

---------------------------------------------------

CREATE TABLE approval_request (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    flow_step_id INT NOT NULL,
    item_id VARCHAR(20) NOT NULL, -- ID del documento/solicitud
    requested_by INT NOT NULL,
    requested_at DATETIME NOT NULL DEFAULT GETDATE(),
    responded_at DATETIME NULL,
    response BIT NULL,
    comments TEXT NULL,
    FOREIGN KEY (flow_step_id) REFERENCES approval_flow_step (id),
    FOREIGN KEY (requested_by) REFERENCES [user] (id)
)
GO

-- 9. Tablas de casos (técnicos y legales)
CREATE TABLE case_type (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(30) NOT NULL,
    description VARCHAR(255) NULL
)
GO

INSERT INTO case_type (name, description) VALUES 
('Technical', 'Casos técnicos relacionados con el proyecto'),
('Legal', 'Casos legales relacionados con el proyecto')
GO

CREATE TABLE [case] (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    project_id INT NOT NULL, 
    case_type_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    description TEXT NULL,
    originator_id INT NOT NULL, 
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    sended_at DATETIME NULL,
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    status_id INT NOT NULL DEFAULT 1,
    FOREIGN KEY (project_id) REFERENCES project (id), 
    FOREIGN KEY (originator_id) REFERENCES [user] (id),
    FOREIGN KEY (case_type_id) REFERENCES case_type (id),
    FOREIGN KEY (status_id) REFERENCES [status] (id)
)
GO

CREATE TABLE case_condition (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    case_id INT NOT NULL, 
    condition_id INT NOT NULL,
    text_value TEXT NULL,
    number_value DECIMAL(18,2) NULL,
    date_value DATE NULL,
    boolean_value BIT NULL,
    option_id INT NULL,
    is_active BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (condition_id) REFERENCES condition (id), 
    FOREIGN KEY (case_id) REFERENCES [case] (id),
    FOREIGN KEY (option_id) REFERENCES condition_option (id)
)
GO

-------------------------------------------------

-- 10. Tablas de actividades
CREATE TABLE project_activity_status (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(45) NOT NULL,
    description VARCHAR(255) NULL,
    color_code VARCHAR(20) NULL
)
GO

INSERT INTO project_activity_status (name, description, color_code)
VALUES 
('No visto', 'Actividad no revisada', '#FF0000'),
('Visto', 'Actividad revisada pero no iniciada', '#FFFF00'),
('En proceso', 'Actividad en progreso', '#0000FF'),
('Finalizado', 'Actividad completada', '#00FF00'),
('Cancelado', 'Actividad cancelada', '#888888'),
('Retrasado', 'Actividad retrasada', '#FFA500')
GO

CREATE TABLE project_activity (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    project_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    description TEXT NULL, 
    responsible_area_id INT NOT NULL, 
    responsible_id INT NULL,
    due_date DATE NOT NULL, 
    completed_date DATE NULL,
    status_id INT NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    created_by INT NOT NULL,
    FOREIGN KEY (project_id) REFERENCES project (id),
    FOREIGN KEY (responsible_area_id) REFERENCES area (id), 
    FOREIGN KEY (responsible_id) REFERENCES [user] (id), 
    FOREIGN KEY (status_id) REFERENCES project_activity_status (id),
    FOREIGN KEY (created_by) REFERENCES [user](id)
)
GO

-- Insertar usuario inicial
INSERT INTO [user] (full_name, email, rol_id, area_id, hashed_password)
VALUES ('Administrador', 'admin@excadb.com', 1, 1, '$2b$12$5r1.bjr72xbAL0X3jZtvkuqtObxMZG8waRP1h43RK3GPBBzaogWVq')
GO