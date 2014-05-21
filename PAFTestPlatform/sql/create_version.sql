
CREATE TABLE `version` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `version_num` varchar(11) DEFAULT NULL,
 `sut_id` int(11) DEFAULT NULL,
 `create_time` datetime DEFAULT NULL,
 `creator_id` integer(11) DEFAULT NULL,
 `update_time` datetime DEFAULT NULL,
 `updator_id` integer(11) DEFAULT NULL,
  INDEX sut_ind (sut_id), 
  FOREIGN KEY (sut_id) REFERENCES sut(id) ON DELETE set null,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;