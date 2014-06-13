CREATE TABLE `testcaseresult`(
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`casename` varchar(50) DEFAULT NULL,
	`ispass` tinyint(1) DEFAULT NULL,
	`description` varchar(150) DEFAULT NULL, 
	`testsuiteresult_id` int(11) DEFAULT NULL,
	`testcase_id` int(11) DEFAULT NULL,
	INDEX testcase_ind (testcase_id),
	FOREIGN KEY (testcase_id) REFERENCES testcase(id) ON DELETE NO ACTION,
	INDEX testsuite_ind (testsuiteresult_id), 
	FOREIGN KEY (testsuiteresult_id) REFERENCES testsuiteresult(id) ON DELETE cascade,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;