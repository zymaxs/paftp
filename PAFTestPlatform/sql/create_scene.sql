
CREATE TABLE `Scene` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `scenename` varchar(30) DEFAULT NULL,
 `code` varchar(30) DEFAULT NULL,
 `description` varchar(100) DEFAULT NULL,
 `createtime` datetime DEFAULT NULL,
 `creator_id` integer(11) DEFAULT NULL,
 `updatetime` datetime DEFAULT NULL,
 `updator_id` integer(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;