CREATE TABLE process_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    vin VARCHAR(17) NOT NULL,
    trigger_timestamp TIMESTAMP NOT NULL,
    car_type VARCHAR(255) NOT NULL,
    use_type VARCHAR(255) NOT NULL,
    trigger_id VARCHAR(255) NOT NULL,
    process_status VARCHAR(50) NOT NULL,
    process_log VARCHAR(2000) NOT NULL,
    
    INDEX idx_vin (vin),
    INDEX idx_vin_trigger (vin, trigger_timestamp),
    INDEX idx_process_status (process_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE data_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    vin VARCHAR(17) NOT NULL,
    trigger_timestamp TIMESTAMP NOT NULL,
    car_type VARCHAR(255) NOT NULL,
    use_type VARCHAR(255) NOT NULL,
    trigger_id VARCHAR(255) NOT NULL,
    is_crash INT NOT NULL,
    crash_reason VARCHAR(2000) NOT NULL,
    criterion_judgment VARCHAR(2000) NOT NULL,

    INDEX idx_vin (vin),
    INDEX idx_vin_trigger (vin, trigger_timestamp),
    INDEX idx_is_crash (is_crash)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



CREATE TABLE car_user_info (
	`id` INT AUTO_INCREMENT,
	`updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`create_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`vin` VARCHAR(17) NOT NULL,
	`car_type` VARCHAR(255) NOT NULL,
	`use_type` VARCHAR(255) NOT NULL,
	`nower_name` VARCHAR(255) DEFAULT 'none',
	`priority` INTEGER,
	`project_name` VARCHAR(255),
	PRIMARY KEY(`id`),
	INDEX idx_vin (vin),
	INDEX idx_project (project_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

