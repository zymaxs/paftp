CREATE TABLE `TestcaseResultContent`(
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`status` varchar(20) DEFAULT NULL,
	`value` varchar(65535) DEFAULT NULL,
	`result` varchar(200) DEFAULT NULL,
	`testcase_id` int(11) DEFAULT NULL,
	INDEX testcase_ind (testcase_id), 
	FOREIGN KEY (testcase_id) REFERENCES TestcaseResult(id) ON DELETE cascade,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;