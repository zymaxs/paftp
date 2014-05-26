CREATE TABLE `testpass`(
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`createtime` datetime DEFAULT NULL,
	`testset` varchar(20) DEFAULT NULL,
	`tag` varchar(100) DEFAULT NULL,
	`sut_id` int(11) DEFAULT NULL,
	`version_id` int(11) DEFAULT NULL,
	INDEX sut_ind (sut_id), 
	FOREIGN KEY (sut_id) REFERENCES sut(id) ON DELETE SET NULL,
	INDEX version_ind (version_id),
	FOREIGN KEY (version_id) REFERENCES version(id) ON DELETE SET NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;