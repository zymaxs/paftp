CREATE TABLE 'testcase_id'(
	'id' int(11) NOT NULL AUTO_INCREMENT,
	'stardposition' int(11) NOT NULL,
	'testsuite_id' int(11) DEFAULT NULL
	INDEX testcase_ind (testcase_id), 
	FOREIGN KEY (testcase_id) REFERENCES testcase_result(id) ON DELETE cascade,
	PRIMARY KEY ('id')
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;