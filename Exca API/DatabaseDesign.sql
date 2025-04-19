USE ExcaDb

DROP TABLE IF EXISTS condition_lease
DROP TABLE IF EXISTS lease_lessee
DROP TABLE IF EXISTS lease_lessor
DROP TABLE IF EXISTS lease
DROP TABLE IF EXISTS rent_assigment
DROP TABLE IF EXISTS lease_request_approvation
DROP TABLE IF EXISTS lease_request_condition
DROP TABLE IF EXISTS lease_request
DROP TABLE IF EXISTS condition
DROP TABLE IF EXISTS condition_type
DROP TABLE IF EXISTS condition_category
DROP TABLE IF EXISTS project_event
DROP TABLE IF EXISTS project_land
DROP TABLE IF EXISTS project
DROP TABLE IF EXISTS [status]
DROP TABLE IF EXISTS stage
DROP TABLE IF EXISTS land
DROP TABLE IF EXISTS individual
DROP TABLE IF EXISTS brand
DROP TABLE IF EXISTS client
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
VALUES ('Arrendador'), ('Arrendatario')

-- Companies (arrendador, arrendatario, asignado)
CREATE TABLE client (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    business_name VARCHAR(100) NOT NULL, 
    email VARCHAR(100) NULL,
    phone_number VARCHAR(15) NULL,
    tax_id VARCHAR(20) NULL, 
    address TEXT,
    type_id INT NOT NULL, 
    FOREIGN KEY (type_id) REFERENCES client_type (id)
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
    taxt_id VARCHAR(20) NULL
)

CREATE TABLE land (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    cadastral_file VARCHAR(45) NOT NULL UNIQUE,
    area DECIMAL(10,2) NOT NULL, 
    price_per_area DECIMAL(10,2) NOT NULL, 
    address VARCHAR(200) NOT NULL, 
    residential_development VARCHAR(100) NOT NULL
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

CREATE TABLE project_land (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    project_id INT NOT NULL,
    land_id INT NOT NULL, 
    area DECIMAL(10,2) NOT NULL, 
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (project_id) REFERENCES project (id), 
    FOREIGN KEY (land_id) REFERENCES land (id)
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

CREATE TABLE condition_type (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(45) NOT NULL
)

-- conditions types // Otras
CREATE TABLE condition (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    name VARCHAR(45) NOT NULL, 
    type_id INT NOT NULL, 
    category_id INT NOT NULL, 
    options NVARCHAR(MAX),
    FOREIGN KEY (type_id) REFERENCES condition_type (id),
    FOREIGN KEY (category_id) REFERENCES condition_category (id)
)

CREATE TABLE lease_request (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    project_id INT NOT NULL, 
    created_at DATETIME NOT NULL DEFAULT GETDATE(), 
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    status_id INT NOT NULL, 
    FOREIGN KEY (project_id) REFERENCES project (id), 
    FOREIGN KEY (status_id) REFERENCES status (id)
)

CREATE TABLE lease_request_condition (
    condition_id INT NOT NULL,
    lease_request_id INT NOT NULL,
    value TEXT,
    is_active BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (condition_id) REFERENCES condition_type (id), 
    FOREIGN KEY (lease_request_id) REFERENCES lease_request (id)
)

CREATE TABLE lease_request_approvation (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    signator_id INT NOT NULL, 
    response BIT NOT NULL,
    lease_request_id INT NOT NULL, 
    FOREIGN KEY (signator_id) REFERENCES [user] (id), 
    FOREIGN KEY (lease_request_id) REFERENCES lease_request (id)
)

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