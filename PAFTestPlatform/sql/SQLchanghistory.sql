2014/5/23 23:21 
ALTER TABLE `paftp`.`applysut` 
ADD UNIQUE INDEX `code_UNIQUE` (`code` ASC);

2014/5/24 16:41
ALTER TABLE `paftp`.`sut` CHANGE COLUMN `group_id` `group_id` INT(11) NULL DEFAULT NULL ;
ALTER TABLE `paftp`.`sut` ADD FOREIGN KEY (`group_id`) REFERENCES `sutgroup` (`id`) ON DELETE set null;

2014/5/25  00:34
CREATE SCHEMA `paftp` DEFAULT CHARACTER SET utf8 ;


