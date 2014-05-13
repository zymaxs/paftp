CREATE TABLE 'testsuite_result'(
	'id' int(11) NOT NULL AUTO_INCREMENT,
	'suitename' varchar(50) DEFAULT NULL,
	'createtime' datetime DEFAULT NULL,
	'passcount' int(11) DEFAULT NULL,
	'failcount' int(11) DEFAULT NULL,
	'passratio' varchar(20) DEFAULT NULL,
	'failratio' varchar(20) DEFAULT NULL,
	'testpass_id' int(11) DEFAULT NULL
	INDEX testpass_ind (testpass_id), 
	FOREIGN KEY (testpass_id) REFERENCES testpass_result(id) ON DELETE cascade,
	PRIMARY KEY ('id')
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;