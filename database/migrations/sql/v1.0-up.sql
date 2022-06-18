CREATE TABLE `dataset` (
    `id` INT,
    `gender` VARCHAR(8),
    `age` INT,
    `hypertension` TINYINT(1),
    `heart_disease` TINYINT(1),
    `ever_married` VARCHAR(4),
    `work_type` VARCHAR(16),
    `residence_type` VARCHAR(8),
    `avg_glucose_level` DOUBLE,
    `bmi` DOUBLE,
    `smoking_status` VARCHAR(24),
    `stroke` TINYINT(1),
    PRIMARY KEY (`id`)
);

CREATE TABLE `classifier_discrete` (
    `attribute` VARCHAR(24),
    `value` VARCHAR(32),
    `stroke` TINYINT(1),
    `probability` DOUBLE,
    PRIMARY KEY (`attribute`, `value`, `stroke`)
);

CREATE TABLE `classifier_continuous` (
    `attribute` VARCHAR(24),
    `stroke` TINYINT(1),
    `mean` DOUBLE,
    `stddev` DOUBLE,
    PRIMARY KEY (`attribute`, `stroke`)
);

