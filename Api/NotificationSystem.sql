DROP TABLE IF EXISTS notification_system_recipient
DROP TABLE IF EXISTS notification_system

CREATE TABLE notification_system (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(45) NOT NULL, 
    description TEXT NULL, 
    is_active BIT NOT NULL DEFAULT 1
)

INSERT INTO notification_system (name)
VALUES ('Solicitud de contraro'), ('Carátula Legal'), ('Carátula Técnica')

CREATE TABLE notification_system_recipient (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    notification_system_id INT NOT NULL, 
    user_id INT NOT NULL, 
    is_active BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (notification_system_id) REFERENCES notification_system (id), 
    FOREIGN KEY (user_id) REFERENCES [user] (id)
)