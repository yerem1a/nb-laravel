DELIMITER $$
CREATE FUNCTION `sf_normal` (
    `value` DOUBLE,
    `mean` DOUBLE,
    `stddev` DOUBLE
)
RETURNS DOUBLE DETERMINISTIC
BEGIN
    RETURN
    CASE
        WHEN `value` IS NOT NULL THEN (1.0 / (`stddev` * SQRT(2 * PI()))) * EXP(-0.5 * POW((`value` - `mean`) / `stddev`, 2))
        ELSE `mean`
    END;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `sf_probability_gender` (
    `gender` VARCHAR(8),
    `stroke` TINYINT(1)
)
RETURNS DOUBLE
BEGIN
    DECLARE `probability` DOUBLE DEFAULT 0;

    SELECT (CAST(SUM(`R`.`id` IS NOT NULL) AS DOUBLE) / CAST(SUM(`L`.`id` IS NOT NULL) AS DOUBLE))
    INTO `probability`
    FROM `dataset` `L`
    LEFT JOIN `dataset` `R` ON `R`.`id` = `L`.`id` AND `R`.`gender` = `gender`
    WHERE `L`.`stroke` = `stroke`;

    RETURN `probability`;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `sf_probability_age` (
    `age` INT,
    `stroke` TINYINT(1)
)
RETURNS DOUBLE
BEGIN
    DECLARE `probability` DOUBLE DEFAULT 0;

    SELECT `sf_normal`(CAST(`age` AS DOUBLE), AVG(`D`.`age`), STD(`D`.`age`))
    INTO `probability`
    FROM `dataset` `D`
    WHERE `D`.`stroke` = `stroke`;

    RETURN `probability`;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `sf_probability_hypertension` (
    `hypertension` TINYINT(1),
    `stroke` TINYINT(1)
)
RETURNS DOUBLE
BEGIN
    DECLARE `probability` DOUBLE DEFAULT 0;

    SELECT (CAST(SUM(`R`.`id` IS NOT NULL) AS DOUBLE) / CAST(SUM(`L`.`id` IS NOT NULL) AS DOUBLE))
    INTO `probability`
    FROM `dataset` `L`
    LEFT JOIN `dataset` `R` ON `R`.`id` = `L`.`id` AND `R`.`hypertension` = `hypertension`
    WHERE `L`.`stroke` = `stroke`;

    RETURN `probability`;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `sf_probability_heart_disease` (
    `heart_disease` TINYINT(1),
    `stroke` TINYINT(1)
)
RETURNS DOUBLE
BEGIN
    DECLARE `probability` DOUBLE DEFAULT 0;

    SELECT (CAST(SUM(`R`.`id` IS NOT NULL) AS DOUBLE) / CAST(SUM(`L`.`id` IS NOT NULL) AS DOUBLE))
    INTO `probability`
    FROM `dataset` `L`
    LEFT JOIN `dataset` `R` ON `R`.`id` = `L`.`id` AND `R`.`heart_disease` = `heart_disease`
    WHERE `L`.`stroke` = `stroke`;

    RETURN `probability`;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `sf_probability_ever_married` (
    `ever_married` VARCHAR(4),
    `stroke` TINYINT(1)
)
RETURNS DOUBLE
BEGIN
    DECLARE `probability` DOUBLE DEFAULT 0;

    SELECT (CAST(SUM(`R`.`id` IS NOT NULL) AS DOUBLE) / CAST(SUM(`L`.`id` IS NOT NULL) AS DOUBLE))
    INTO `probability`
    FROM `dataset` `L`
    LEFT JOIN `dataset` `R` ON `R`.`id` = `L`.`id` AND `R`.`ever_married` = `ever_married`
    WHERE `L`.`stroke` = `stroke`;

    RETURN `probability`;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `sf_probability_work_type` (
    `work_type` VARCHAR(16),
    `stroke` TINYINT(1)
)
RETURNS DOUBLE
BEGIN
    DECLARE `probability` DOUBLE DEFAULT 0;

    SELECT (CAST(SUM(`R`.`id` IS NOT NULL) AS DOUBLE) / CAST(SUM(`L`.`id` IS NOT NULL) AS DOUBLE))
    INTO `probability`
    FROM `dataset` `L`
    LEFT JOIN `dataset` `R` ON `R`.`id` = `L`.`id` AND `R`.`work_type` = `work_type`
    WHERE `L`.`stroke` = `stroke`;

    RETURN `probability`;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `sf_probability_residence_type` (
    `residence_type` VARCHAR(8),
    `stroke` TINYINT(1)
)
RETURNS DOUBLE
BEGIN
    DECLARE `probability` DOUBLE DEFAULT 0;

    SELECT (CAST(SUM(`R`.`id` IS NOT NULL) AS DOUBLE) / CAST(SUM(`L`.`id` IS NOT NULL) AS DOUBLE))
    INTO `probability`
    FROM `dataset` `L`
    LEFT JOIN `dataset` `R` ON `R`.`id` = `L`.`id` AND `R`.`residence_type` = `residence_type`
    WHERE `L`.`stroke` = `stroke`;

    RETURN `probability`;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `sf_probability_avg_glucose_level` (
    `avg_glucose_level` DOUBLE,
    `stroke` TINYINT(1)
)
RETURNS DOUBLE
BEGIN
    DECLARE `probability` DOUBLE DEFAULT 0;

    SELECT `sf_normal`(`avg_glucose_level`, AVG(`D`.`avg_glucose_level`), STD(`D`.`avg_glucose_level`))
    INTO `probability`
    FROM `dataset` `D`
    WHERE `D`.`stroke` = `stroke`;

    RETURN `probability`;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `sf_probability_bmi` (
    `bmi` DOUBLE,
    `stroke` TINYINT(1)
)
RETURNS DOUBLE
BEGIN
    DECLARE `probability` DOUBLE DEFAULT 0;

    SELECT `sf_normal`(`bmi`, AVG(`D`.`bmi`), STD(`D`.`bmi`))
    INTO `probability`
    FROM `dataset` `D`
    WHERE `D`.`stroke` = `stroke` AND `D`.`bmi` IS NOT NULL;

    RETURN `probability`;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `sf_probability_smoking_status` (
    `smoking_status` VARCHAR(24),
    `stroke` TINYINT(1)
)
RETURNS DOUBLE
BEGIN
    DECLARE `probability` DOUBLE DEFAULT 0;

    SELECT (CAST(SUM(`R`.`id` IS NOT NULL) AS DOUBLE) / CAST(SUM(`L`.`id` IS NOT NULL) AS DOUBLE))
    INTO `probability`
    FROM `dataset` `L`
    LEFT JOIN `dataset` `R` ON `R`.`id` = `L`.`id` AND `R`.`smoking_status` = `smoking_status`
    WHERE `L`.`stroke` = `stroke`;

    RETURN `probability`;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_update_algorithm` ()
BEGIN
    DELETE FROM `classifier_discrete`;
    DELETE FROM `classifier_continuous`;

    INSERT INTO `classifier_discrete` (`attribute`, `value`, `stroke`, `probability`)
    SELECT `attribute`.`data`, `value`.`data`, `stroke`.`data`, (SUM(`D`.`stroke` = `stroke`.`data`) / COUNT(*))
    FROM (SELECT 'generic' `data`) `attribute`
    CROSS JOIN (SELECT 'generic' `data`) `value`
    CROSS JOIN (SELECT 0 `data` UNION SELECT 1) `stroke`
    CROSS JOIN `dataset` `D`
    GROUP BY `attribute`.`data`, `value`.`data`, `stroke`.`data`;

    INSERT INTO `classifier_discrete` (`attribute`, `value`, `stroke`, `probability`)
    SELECT `attribute`.`data`, `value`.`data`, `stroke`.`data`, `sf_probability_gender`(`value`.`data`, `stroke`.`data`)
    FROM (SELECT 'gender' `data`) `attribute`
    CROSS JOIN (SELECT 'Male' `data` UNION SELECT 'Female' UNION SELECT 'Other') `value`
    CROSS JOIN (SELECT 0 `data` UNION SELECT 1) `stroke`;

    INSERT INTO `classifier_continuous` (`attribute`, `stroke`, `mean`, `stddev`)
    SELECT `attribute`.`data`, `stroke`.`data`, AVG(`D`.`age`), STD(`D`.`age`)
    FROM (SELECT 'age' `data`) `attribute`
    CROSS JOIN (SELECT 0 `data` UNION SELECT 1) `stroke`
    JOIN `dataset` `D` ON `D`.`stroke` = `stroke`.`data`
    GROUP BY `attribute`.`data`, `stroke`.`data`;

    INSERT INTO `classifier_discrete` (`attribute`, `value`, `stroke`, `probability`)
    SELECT `attribute`.`data`, `value`.`data`, `stroke`.`data`, `sf_probability_hypertension`(`value`.`data`, `stroke`.`data`)
    FROM (SELECT 'hypertension' `data`) `attribute`
    CROSS JOIN (SELECT 0 `data` UNION SELECT 1) `value`
    CROSS JOIN (SELECT 0 `data` UNION SELECT 1) `stroke`;

    INSERT INTO `classifier_discrete` (`attribute`, `value`, `stroke`, `probability`)
    SELECT `attribute`.`data`, `value`.`data`, `stroke`.`data`, `sf_probability_heart_disease`(`value`.`data`, `stroke`.`data`)
    FROM (SELECT 'heart_disease' `data`) `attribute`
    CROSS JOIN (SELECT 0 `data` UNION SELECT 1) `value`
    CROSS JOIN (SELECT 0 `data` UNION SELECT 1) `stroke`;

    INSERT INTO `classifier_discrete` (`attribute`, `value`, `stroke`, `probability`)
    SELECT `attribute`.`data`, `value`.`data`, `stroke`.`data`, `sf_probability_ever_married`(`value`.`data`, `stroke`.`data`)
    FROM (SELECT 'ever_married' `data`) `attribute`
    CROSS JOIN (SELECT 'Yes' `data` UNION SELECT 'No') `value`
    CROSS JOIN (SELECT 0 `data` UNION SELECT 1) `stroke`;

    INSERT INTO `classifier_discrete` (`attribute`, `value`, `stroke`, `probability`)
    SELECT `attribute`.`data`, `value`.`data`, `stroke`.`data`, `sf_probability_work_type`(`value`.`data`, `stroke`.`data`)
    FROM (SELECT 'work_type' `data`) `attribute`
    CROSS JOIN (SELECT 'children' `data` UNION SELECT 'Govt_job' UNION SELECT 'Never_worked' UNION SELECT 'Private' UNION SELECT 'Self-employed') `value`
    CROSS JOIN (SELECT 0 `data` UNION SELECT 1) `stroke`;

    INSERT INTO `classifier_discrete` (`attribute`, `value`, `stroke`, `probability`)
    SELECT `attribute`.`data`, `value`.`data`, `stroke`.`data`, `sf_probability_residence_type`(`value`.`data`, `stroke`.`data`)
    FROM (SELECT 'residence_type' `data`) `attribute`
    CROSS JOIN (SELECT 'Urban' `data` UNION SELECT 'Rural') `value`
    CROSS JOIN (SELECT 0 `data` UNION SELECT 1) `stroke`;

    INSERT INTO `classifier_continuous` (`attribute`, `stroke`, `mean`, `stddev`)
    SELECT `attribute`.`data`, `stroke`.`data`, AVG(`D`.`avg_glucose_level`), STD(`D`.`avg_glucose_level`)
    FROM (SELECT 'avg_glucose_level' `data`) `attribute`
    CROSS JOIN (SELECT 0 `data` UNION SELECT 1) `stroke`
    JOIN `dataset` `D` ON `D`.`stroke` = `stroke`.`data`
    GROUP BY `attribute`.`data`, `stroke`.`data`;

    INSERT INTO `classifier_continuous` (`attribute`, `stroke`, `mean`, `stddev`)
    SELECT `attribute`.`data`, `stroke`.`data`, AVG(`D`.`bmi`), STD(`D`.`bmi`)
    FROM (SELECT 'bmi' `data`) `attribute`
    CROSS JOIN (SELECT 0 `data` UNION SELECT 1) `stroke`
    JOIN `dataset` `D` ON `D`.`stroke` = `stroke`.`data`
    GROUP BY `attribute`.`data`, `stroke`.`data`;

    INSERT INTO `classifier_discrete` (`attribute`, `value`, `stroke`, `probability`)
    SELECT `attribute`.`data`, `value`.`data`, `stroke`.`data`, `sf_probability_smoking_status`(`value`.`data`, `stroke`.`data`)
    FROM (SELECT 'smoking_status' `data`) `attribute`
    CROSS JOIN (SELECT 'never smoked' `data` UNION SELECT 'formerly smoked' UNION SELECT 'smokes' UNION SELECT 'Unknown') `value`
    CROSS JOIN (SELECT 0 `data` UNION SELECT 1) `stroke`;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `sf_predict_stroke` (
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
    `stroke` TINYINT(1)
)
RETURNS DOUBLE
BEGIN
    DECLARE
    `probability_gender`,
    `probability_age`,
    `probability_hypertension`,
    `probability_heart_disease`,
    `probability_ever_married`,
    `probability_work_type`,
    `probability_residence_type`,
    `probability_avg_glucose_level`,
    `probability_bmi`,
    `probability_smoking_status`,
    `probability_stroke`
    DOUBLE DEFAULT 0;

    SELECT `probability` INTO `probability_gender` FROM `classifier_discrete` `c`
    WHERE `c`.`attribute` = 'gender' AND `c`.`value` = `gender` AND `c`.`stroke` = `stroke`;

    SELECT `sf_normal`(`age`, `c`.`mean`, `c`.`stddev`) INTO `probability_age` FROM `classifier_continuous` `c`
    WHERE `c`.`attribute` = 'age' AND `c`.`stroke` = `stroke`;

    SELECT `probability` INTO `probability_hypertension` FROM `classifier_discrete` `c`
    WHERE `c`.`attribute` = 'hypertension' AND `c`.`value` = `hypertension` AND `c`.`stroke` = `stroke`;

    SELECT `probability` INTO `probability_heart_disease` FROM `classifier_discrete` `c`
    WHERE `c`.`attribute` = 'heart_disease' AND `c`.`value` = `heart_disease` AND `c`.`stroke` = `stroke`;

    SELECT `probability` INTO `probability_ever_married` FROM `classifier_discrete` `c`
    WHERE `c`.`attribute` = 'ever_married' AND `c`.`value` = `ever_married` AND `c`.`stroke` = `stroke`;

    SELECT `probability` INTO `probability_work_type` FROM `classifier_discrete` `c`
    WHERE `c`.`attribute` = 'work_type' AND `c`.`value` = `work_type` AND `c`.`stroke` = `stroke`;

    SELECT `probability` INTO `probability_residence_type` FROM `classifier_discrete` `c`
    WHERE `c`.`attribute` = 'residence_type' AND `c`.`value` = `residence_type` AND `c`.`stroke` = `stroke`;

    SELECT `sf_normal`(`avg_glucose_level`, `c`.`mean`, `c`.`stddev`) INTO `probability_avg_glucose_level` FROM `classifier_continuous` `c`
    WHERE `c`.`attribute` = 'avg_glucose_level' AND `c`.`stroke` = `stroke`;

    SELECT `sf_normal`(`bmi`, `c`.`mean`, `c`.`stddev`) INTO `probability_bmi` FROM `classifier_continuous` `c`
    WHERE `c`.`attribute` = 'bmi' AND `c`.`stroke` = `stroke`;

    SELECT `probability` INTO `probability_smoking_status` FROM `classifier_discrete` `c`
    WHERE `c`.`attribute` = 'smoking_status' AND `c`.`value` = `smoking_status` AND `c`.`stroke` = `stroke`;

    SELECT `probability` INTO `probability_stroke` FROM `classifier_discrete` `c`
    WHERE `c`.`attribute` = 'generic' AND `c`.`value` = 'generic' AND `c`.`stroke` = `stroke`;

    RETURN `probability_gender`
        * `probability_age`
        * `probability_hypertension`
        * `probability_heart_disease`
        * `probability_ever_married`
        * `probability_work_type`
        * `probability_residence_type`
        * `probability_avg_glucose_level`
        * `probability_bmi`
        * `probability_smoking_status`
        * `probability_stroke`;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_predict_get` (
    IN `gender` VARCHAR(8),
    IN `age` INT,
    IN `hypertension` TINYINT(1),
    IN `heart_disease` TINYINT(1),
    IN `ever_married` VARCHAR(4),
    IN `work_type` VARCHAR(16),
    IN `residence_type` VARCHAR(8),
    IN `avg_glucose_level` DOUBLE,
    IN `bmi` DOUBLE,
    IN `smoking_status` VARCHAR(24),
    OUT `probability_stroke_0` DOUBLE,
    OUT `probability_stroke_1` DOUBLE,
    OUT `stroke` TINYINT(1)
)
BEGIN
    DECLARE `probability_stroke_sum` DOUBLE DEFAULT 0;

    SET `probability_stroke_0` = `sf_predict_stroke`(`gender`, `age`, `hypertension`, `heart_disease`, `ever_married`, `work_type`, `residence_type`, `avg_glucose_level`, `bmi`, `smoking_status`, 0);
    SET `probability_stroke_1` = `sf_predict_stroke`(`gender`, `age`, `hypertension`, `heart_disease`, `ever_married`, `work_type`, `residence_type`, `avg_glucose_level`, `bmi`, `smoking_status`, 1);
    SET `probability_stroke_sum` = `probability_stroke_0` + `probability_stroke_1`;

    IF `probability_stroke_sum` != 0 THEN
        SET `probability_stroke_0` = `probability_stroke_0` / `probability_stroke_sum`;
        SET `probability_stroke_1` = `probability_stroke_1` / `probability_stroke_sum`;
        SET `stroke` = `probability_stroke_1` > `probability_stroke_0`;
    END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_predict` (
    IN `gender` VARCHAR(8),
    IN `age` INT,
    IN `hypertension` TINYINT(1),
    IN `heart_disease` TINYINT(1),
    IN `ever_married` VARCHAR(4),
    IN `work_type` VARCHAR(16),
    IN `residence_type` VARCHAR(8),
    IN `avg_glucose_level` DOUBLE,
    IN `bmi` DOUBLE,
    IN `smoking_status` VARCHAR(24)
)
BEGIN
    DECLARE `probability_stroke_0`, `probability_stroke_1` DOUBLE DEFAULT 0;
    DECLARE `stroke` TINYINT(1) DEFAULT FALSE;

    CALL `sp_predict_get`(`gender`, `age`, `hypertension`, `heart_disease`, `ever_married`, `work_type`, `residence_type`, `avg_glucose_level`, `bmi`, `smoking_status`, `probability_stroke_0`, `probability_stroke_1`, `stroke`);

    SELECT probability_stroke_0, probability_stroke_1, stroke;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `sf_test` (
    `id` INT
)
RETURNS TINYINT(1)
BEGIN
    DECLARE `gender` VARCHAR(8);
    DECLARE `age` INT;
    DECLARE `hypertension` TINYINT(1);
    DECLARE `heart_disease` TINYINT(1);
    DECLARE `ever_married` VARCHAR(4);
    DECLARE `work_type` VARCHAR(16);
    DECLARE `residence_type` VARCHAR(8);
    DECLARE `avg_glucose_level` DOUBLE;
    DECLARE `bmi` DOUBLE;
    DECLARE `smoking_status` VARCHAR(24);
    DECLARE `probability_stroke_0` DOUBLE;
    DECLARE `probability_stroke_1` DOUBLE;
    DECLARE `stroke` TINYINT(1);

    SELECT `D`.`gender`, `D`.`age`, `D`.`hypertension`, `D`.`heart_disease`, `D`.`ever_married`, `D`.`work_type`, `D`.`residence_type`, `D`.`avg_glucose_level`, `D`.`bmi`, `D`.`smoking_status`
    INTO `gender`, `age`, `hypertension`, `heart_disease`, `ever_married`, `work_type`, `residence_type`, `avg_glucose_level`, `bmi`, `smoking_status`
    FROM `dataset` `D`
    WHERE `D`.`id` = `id`;

    CALL `sp_predict_get`(`gender`, `age`, `hypertension`, `heart_disease`, `ever_married`, `work_type`, `residence_type`, `avg_glucose_level`, `bmi`, `smoking_status`, `probability_stroke_0`, `probability_stroke_1`, `stroke`);

    RETURN `stroke`;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_evaluate` ()
BEGIN
    SELECT
    `R`.`correct`,
    `R`.`incorrect`,
    `R`.`total`,
    (`R`.`correct` / `R`.`total` * 100) `accuracy`,
    (`R`.`incorrect` / `R`.`total` * 100) `error`
    FROM (
        SELECT
        (SUM(`D`.`prediction` = `D`.`actual`)) `correct`,
        (SUM(`D`.`prediction` != `D`.`actual`)) `incorrect`,
        (COUNT(*)) `total`
        FROM (
           SELECT `id`, `stroke` `actual`, `sf_test`(`id`) `prediction`
           FROM `dataset`
        ) `D`
    ) `R`;
END $$
DELIMITER ;

