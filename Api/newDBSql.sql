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
    client_id INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(), 
    FOREIGN KEY (address_id) REFERENCES client_address (id),
    FOREIGN KEY (client_id) REFERENCES client (id)
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
    cadastral_value DECIMAL(15,2) NULL,
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
INSERT INTO [status] (name, [description])
VALUES ('En renta', 'Terreno en renta'), ('Disponible', 'Terreno disponible')
GO

CREATE TABLE project (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    brand_id INT NOT NULL,
    stage_id INT NOT NULL DEFAULT 1,
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
    build_area DECIMAL(10,2) NOT NULL CHECK(build_area >= 0),
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
    signator_role_id INT NULL,
    signator_area_id INT NULL,
    signator_id INT NULL,
    is_required BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (flow_id) REFERENCES approval_flow (id),
    FOREIGN KEY (signator_role_id) REFERENCES user_rol (id),
    FOREIGN KEY (signator_area_id) REFERENCES area (id),
    FOREIGN KEY (signator_id) REFERENCES [user] (id),
    CONSTRAINT UQ_flow_step_order UNIQUE (flow_id, step_order)
)
GO

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

-- Primero insertamos las condiciones sin opciones
INSERT INTO condition (name, type_id, category_id)
VALUES 
-- Condiciones comerciales (category_id = 1)
('Tipo de contrato', 5, 1),
('Renta Mensual', 2, 1), 
('Renta Anterior', 2, 1), 
('Precio por m2 (LOCA)', 2, 1),
('Porcentaje de incremento', 2, 1),
('Referencia lista precios (Breña)', 2, 1), 
('Cuota de mantenimiento', 2, 1),
('¿Cumple lo mínimo autorizado', 4, 1),
('Vigencia', 2, 1),
('Prorroga', 4, 1),
('¿Automática?', 4, 1),
('Plazo forzoso GPV', 2, 1),
('Plazo forzoso arrendatario', 2, 1),
('Incremento anual', 1, 1),
('Incremento a partir de', 5, 1),
('Incremento adicional', 1, 1),
('¿Cuándo?', 1, 1),
('Fecha de firma de contrato', 3, 1),
('Deposito de garantía (meses)', 5, 1),
('Renta anticipada (meses)', 2, 1),
('Inicio de pago de renta', 3, 1),
('Periodo de gracia (meses)', 5, 1),
('¿Cumple con la tabla autorizada de PG?', 4, 1),
('¿Cúando inicia el PG?', 1, 1),
('¿Hay que firmar acta de entrega?', 4, 1),
('¿Paga predial proporcional?', 4, 1),
('Derecho de preferencia en venta', 5, 1),

-- Condiciones de predio (category_id = 10)
('Estatus del predio', 5, 10),
('¿Está pagado el 7%?', 4, 10),
('En caso de NO, tiempos estimados para pagarlo', 1, 10),
('¿Tenemos el plano Ejecutivo de Ventas que ampare este proyecto?', 4, 10),

-- Condiciones de infraestructura (category_id = 7)
('¿Existe infraestructura frente al predio?', 4, 7),
('En caso de NO tiempos estimados para tenerlo', 1, 7),

-- Condiciones de servicios (category_id = 8)
('¿Existe infraestructura frente al predio?', 4, 8),
('Esta pagada la incorporación AyD', 4, 8),
('Esta pagada la aportación de Ay D?', 4, 8),
('¿El local / predio tiene o tuvo contrato de servicios?', 4, 8),
('¿Tenemos que tramitar factibilidad?', 4, 8),
('Tiempos para tramitarla', 1, 8),

-- Condiciones de trámites (category_id = 9)
('CLG', 1, 9),
('Alineamiento Vial', 1, 9),
('Amojonamiento', 1, 9),
('Licencias', 1, 9),
('Fusión', 1, 9),
('Subdivisión', 1, 9),
('Uso de Suelo', 1, 9),
('Estudios Ambientales', 1, 9),

-- Condiciones Generales (category_id = 2)
('Municipio', 1, 2),
('Estado', 1, 2),
('Vigencia Contrato en Años', 2, 2),
('Inicio de Vigencia', 3, 2),
('Prórroga de Vigencia en Años', 2, 2),
('Prórroga Condicionada o Automática', 5, 2),
('Plazo Para Solicitar Prórroga en Días', 2, 2),
('Incremento de Renta en Prórroga', 1, 2),
('Riesgo de no recibir pago de Rentas', 4, 2),
('Fecha de Entrega de Posesión del Inmueble', 3, 2),
('Responsabilidad de Trámite de Licencias', 5, 2),
('Fecha de Entrega de Licencias', 3, 2),
('Mantenimiento (Sin IVA)', 2, 2),
('Indexación Mantenimiento', 1, 2),
('Periodo de Gracia en Meses', 2, 2),
('Inicio de Periodo de Gracia', 5, 2),
('Fecha de Inicio de Periodo de Gracia', 3, 2),

-- Contención de riesgos económicos (category_id = 3)
('Depósito en Garantía en Meses', 2, 3),
('Cantidad Garantía en Meses', 2, 3),
('Actualización de Depósito en Garantía', 1, 3),
('Renta Anticipada en Meses', 2, 3),
('Cantidad de Renta Anticipada', 2, 3),

-- Contención de riesgos (category_id = 4)
('GPV Autoriza Layout', 4, 4),
('GP Puede Cancelar el Contrato', 4, 4),
('Supuesto en el que GP puede Cancelar el Contrato', 1, 4),
('Plazo en días para que GP Termine el Contrato', 2, 4),
('Subarrendamiento Libre', 4, 4),
('Subarrendamiento a Filiales', 4, 4),
('Derecho de Preferencia en Venta para la Arrendataria', 4, 4),
('Tiempo en Días para Respuesta para Aceptación del Derecho de Preferencia', 2, 4),
('Derecho de Preferencia para Filiales de la Arrendataria', 4, 4),
('Aviso a Filiales de Derecho de Preferencia', 4, 4),

-- Mitigación de riesgos (category_id = 5)
('Giro de Negocio de la Arrendataria', 1, 5),
('Riesgo por Distancia con Zona Habitacional', 4, 5),
('Distancia con Casa Habitación más Cercana', 1, 5),
('Riesgo de Olores', 4, 5),
('Visto Bueno de Área de Ventas', 1, 5),
('Riesgo de Generación de Tráfico', 4, 5),
('Visto Bueno de Proyectos', 1, 5),
('Riesgo de Residuos Peligrosos', 4, 5),
('Remediación por la Arrendataria en caso de Contaminación de Suelo', 4, 5),
('Riesgo de Contaminación de Suelo', 4, 5),
('Arrendataria Obligada a Contratación de Seguro por Obra y Operación', 4, 5),
('Giros Prohibidos', 4, 5),
('Listado de Giros Prohibidos', 1, 5),
('Lotes Afectados por Giros Prohibidos', 1, 5),
('Exclusividad de Giros en Contrato', 4, 5),
('Lotes Afectados por Exclusividad de Giros', 1, 5),
('Giros Exclusivos', 1, 5),
('Incumple Giros Exclusivos de Otros Contratos', 4, 5),
('Estado de Devolución del Inmueble al Termino del Contrato', 1, 5),

-- Construcción por GP (category_id = 6)
('GP Construye', 4, 6),
('Superficie a Construir', 2, 6),
('Incluye Estacionamiento', 4, 6),
('Servicio de Agua y Drenaje', 4, 6),
('GP Administra el consumo de agua', 4, 6),
('Servicio de Electricidad', 4, 6),
('Preparación Eléctrica', 4, 6),
('Fecha de Entrega del Inmueble con Construcción', 3, 6),
('Aplica posibilidad de Entrega Parcial', 4, 6),
('Permite Terminación del Contrato por la No Entrega de la Construcción', 4, 6),
('Licencias a Cargo de', 5, 6),
('Construcción de Totem', 4, 6),
('Posición de Rótulo', 1, 6),
('Entrega de Planos / Proyectos', 4, 6),
('Fecha de Entrega de Planos / Proyectos', 3, 6);

-- Ahora insertamos las opciones para cada condición que las tiene
-- Nota: Asumo que los IDs de las condiciones se asignan en orden de inserción

-- Tipo de contrato (ID: 1)
INSERT INTO condition_option (condition_id, option_value, display_order)
VALUES 
(1, 'Primer Contrato', 1),
(1, 'Renovación', 2);

-- Incremento a partir de (ID: 15)
INSERT INTO condition_option (condition_id, option_value, display_order)
VALUES 
(15, 'Fecha de firma', 1),
(15, 'Obtención de permisos', 2),
(15, 'Inicio de operaciones', 3);

-- Deposito de garantía (meses) (ID: 19)
INSERT INTO condition_option (condition_id, option_value, display_order)
VALUES 
(19, '1', 1),
(19, '2', 2),
(19, '3', 3),
(19, '4', 4),
(19, '5', 5),
(19, '6', 6),
(19, '7', 7),
(19, '8', 8),
(19, '9', 9),
(19, '10', 10),
(19, '11', 11),
(19, '12', 12),
(19, 'NO', 13);

-- Periodo de gracia (meses) (ID: 23)
INSERT INTO condition_option (condition_id, option_value, display_order)
VALUES 
(23, '1', 1),
(23, '2', 2),
(23, '3', 3),
(23, '4', 4),
(23, '5', 5),
(23, '6', 6),
(23, '7', 7),
(23, '8', 8),
(23, '9', 9),
(23, '10', 10),
(23, '11', 11),
(23, '12', 12),
(23, 'NO', 13);

-- Derecho de preferencia en venta (ID: 27)
INSERT INTO condition_option (condition_id, option_value, display_order)
VALUES 
(27, 'No tiene derecho de preferencia, no se le tiene que avisar', 1),
(27, 'No tiene derecho de preferencia, si se le tiene que avisar', 2),
(27, 'Si tiene derecho, no aplica entre filiales GP, no se le avisa', 3),
(27, 'Si tiene derecho, no aplica entre filiales GP, si se le avisa', 4);

-- Estatus del predio (ID: 28)
INSERT INTO condition_option (condition_id, option_value, display_order)
VALUES 
(28, 'Lote Comercial', 1),
(28, 'Área fuera de trámite', 2);

-- Prórroga Condicionada o Automática (ID: 44)
INSERT INTO condition_option (condition_id, option_value, display_order)
VALUES 
(44, 'Condicionada', 1),
(44, 'Automática', 2);

-- Responsabilidad de Trámite de Licencias (ID: 51)
INSERT INTO condition_option (condition_id, option_value, display_order)
VALUES 
(51, 'Arrendadora', 1),
(51, 'Arrendataria', 2);

-- Inicio de Periodo de Gracia (ID: 56)
INSERT INTO condition_option (condition_id, option_value, display_order)
VALUES 
(56, 'Entrega del Local Construido', 1),
(56, 'Firma de contrato', 2),
(56, 'Otro', 3);

-- Licencias a Cargo de (ID: 96)
INSERT INTO condition_option (condition_id, option_value, display_order)
VALUES 
(96, 'Arrendadora', 1),
(96, 'Arrendataria', 2);