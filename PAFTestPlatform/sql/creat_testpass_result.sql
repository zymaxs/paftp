CREATE TABLE 'testpass_result'(
	'id' int(11) NOT NULL AUTO_INCREMENT,
	'name' varchar(50) DEFAULT NULL,
	'createtime' datetime DEFAULT NULL,
	'testset' varchar(20) DEFAULT NULL,
	'passcount' int(11) DEFAULT NULL,
	'failcount' int(11) DEFAULT NULL,
	'passratio' varchar(20) DEFAULT NULL,
	'failratio' varchar(20) DEFAULT NULL,
	'sut_id' int(11) DEFAULT NULL
	INDEX sut_ind (sut_id), 
	FOREIGN KEY (sut_id) REFERENCES sut(id) ON DELETE cascade,
	PRIMARY KEY ('id')
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;