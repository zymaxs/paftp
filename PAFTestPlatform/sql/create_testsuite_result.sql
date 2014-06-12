CREATE TABLE `testsuiteresult`(
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`suitename` varchar(50) DEFAULT NULL,
	`testpass_id` int(11) DEFAULT NULL,
	`testsuite_id` int(11) DEFAULT NULL,
	INDEX testsuite_ind (testsuite_id),
	FOREIGN KEY (testsuite_id) REFERENCES testsuite(id) ON DELETE NO ACTION,
	INDEX testpass_ind (testpass_id), 
	FOREIGN KEY (testpass_id) REFERENCES testpass(id) ON DELETE cascade,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;