CREATE TABLE 'testcase_result'(
	'id' int(11) NOT NULL AUTO_INCREMENT,
	'casename' varchar(50) DEFAULT NULL,
	'ispass' tinyint(1) DEFAULT NULL,
	'casetype' varchar(10) DEFAULT NULL,
	'description' varchar(150) DEFAULT NULL, 
	'testsuite_id' int(11) DEFAULT NULL
	INDEX testsuite_ind (testsuite_id), 
	FOREIGN KEY (testsuite_id) REFERENCES testsuite_result(id) ON DELETE cascade,
	PRIMARY KEY ('id')
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;