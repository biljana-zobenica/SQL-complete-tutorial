-- MySQL Workbench Synchronization
-- Generated: 2021-11-21 17:39
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Biljana

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER TABLE `school`.`courses` 
DROP FOREIGN KEY `fk_courses_instructors`;

ALTER TABLE `school`.`enrollments` 
DROP FOREIGN KEY `fk_enrollments_courses`;

ALTER TABLE `school`.`course_tabs` 
DROP FOREIGN KEY `fk_course_tabs_courses1`,
DROP FOREIGN KEY `fk_course_tabs_tags1`;

ALTER TABLE `school`.`students` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `school`.`courses` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `school`.`enrollments` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ,
ADD COLUMN `coupon` VARCHAR(50) NULL DEFAULT NULL AFTER `price`;

ALTER TABLE `school`.`tags` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `school`.`course_tabs` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `school`.`instructors` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `school`.`courses` 
ADD CONSTRAINT `fk_courses_instructors`
  FOREIGN KEY (`instructor_id`)
  REFERENCES `school`.`instructors` (`instructor_id`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;

ALTER TABLE `school`.`enrollments` 
DROP FOREIGN KEY `fk_enrollments_students`;

ALTER TABLE `school`.`enrollments` ADD CONSTRAINT `fk_enrollments_students`
  FOREIGN KEY (`student_id`)
  REFERENCES `school`.`students` (`student_id`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE,
ADD CONSTRAINT `fk_enrollments_courses`
  FOREIGN KEY (`course_id`)
  REFERENCES `school`.`courses` (`course_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `school`.`course_tabs` 
ADD CONSTRAINT `fk_course_tabs_courses1`
  FOREIGN KEY (`course_id`)
  REFERENCES `school`.`courses` (`course_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_course_tabs_tags1`
  FOREIGN KEY (`tag_id`)
  REFERENCES `school`.`tags` (`tag_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
