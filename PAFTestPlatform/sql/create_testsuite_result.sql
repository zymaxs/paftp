CREATE TABLE `TestsuiteResult`(
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`suitename` varchar(50) DEFAULT NULL,
	`setupstatus` int(11) DEFAULT NULL,
	`setupdescription` varchar(200) DEFAULT NULL,
	`testpass_id` int(11) DEFAULT NULL,
	`testsuite_id` int(11) DEFAULT NULL,
	INDEX testsuite_ind (testsuite_id),
	FOREIGN KEY (testsuite_id) REFERENCES Testsuite(id) ON DELETE NO ACTION,
	INDEX testpass_ind (testpass_id), 
	FOREIGN KEY (testpass_id) REFERENCES Testpass(id) ON DELETE cascade,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;