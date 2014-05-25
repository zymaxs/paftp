2014/5/23 23:21 
ALTER TABLE `paftp`.`applysut` 
ADD UNIQUE INDEX `code_UNIQUE` (`code` ASC);

2014/5/24 16:41
ALTER TABLE `paftp`.`sut` CHANGE COLUMN `group_id` `group_id` INT(11) NULL DEFAULT NULL ;
ALTER TABLE `paftp`.`sut` ADD FOREIGN KEY (`group_id`) REFERENCES `sutgroup` (`id`) ON DELETE set null;

2014/5/25  00:34
CREATE SCHEMA `paftp` DEFAULT CHARACTER SET utf8 ;

2014/5/25  14:39
ALTER TABLE `paftp`.`userinfo` 
CHANGE COLUMN `department` `department_id` INT(11) NOT NULL ,
CHANGE COLUMN `position` `position_id` INT(11) NOT NULL ;

ALTER TABLE `paftp`.`userinfo` 
ADD INDEX `departmentid_idx` (`department_id` ASC);
ALTER TABLE `paftp`.`userinfo` 
ADD CONSTRAINT `departmentid`
  FOREIGN KEY (`department_id`)
  REFERENCES `paftp`.`userinfodepartment` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  ALTER TABLE `paftp`.`userinfo` 
ADD INDEX `positionid_idx` (`position_id` ASC);
ALTER TABLE `paftp`.`userinfo` 
ADD CONSTRAINT `positionid`
  FOREIGN KEY (`position_id`)
  REFERENCES `paftp`.`userinfoposition` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;