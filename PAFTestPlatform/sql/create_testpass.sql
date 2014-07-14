CREATE TABLE `Testpass`(
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(100) DEFAULT NULL,
	`createtime` datetime DEFAULT NULL,
	`testset` varchar(20) DEFAULT NULL,
	`tag` varchar(100) DEFAULT NULL,
	`env` varchar(20) DEFAULT NULL,
	`sut_id` int(11) DEFAULT NULL,
	`version_id` int(11) DEFAULT NULL,
	INDEX sut_ind (sut_id), 
	FOREIGN KEY (sut_id) REFERENCES Sut(id) ON DELETE SET NULL,
	INDEX version_ind (version_id),
	FOREIGN KEY (version_id) REFERENCES Version(id) ON DELETE SET NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;