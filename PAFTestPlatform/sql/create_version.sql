
CREATE TABLE `Version` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `version_num` varchar(50) DEFAULT NULL UNIQUE,
 `create_time` datetime DEFAULT NULL,
 `creator_id` integer(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;