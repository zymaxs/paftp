CREATE TABLE 'testsuiteresult'(
	'id' int(11) NOT NULL AUTO_INCREMENT,
	'suitename' varchar(50) DEFAULT NULL,
	'description' varchar(150) DEFAULT NULL,
	'passcount' int(11) DEFAULT NULL,
	'failcount' int(11) DEFAULT NULL,
	'total' int(11) DEFAULT NULL,
	'passratio' varchar(20) DEFAULT NULL,
	'failratio' varchar(20) DEFAULT NULL,
	'testpass_id' int(11) DEFAULT NULL
	INDEX testpass_ind (testpass_id), 
	FOREIGN KEY (testpass_id) REFERENCES testpass(id) ON DELETE cascade,
	PRIMARY KEY ('id')
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;