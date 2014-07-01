
CREATE TABLE `TestcaseStep` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `type` varchar(20) DEFAULT NULL,
 `content` varchar(100) DEFAULT NULL,
 `testcase_id` int(11) DEFAULT NULL,
  INDEX testcase_ind (testcase_id), 
  FOREIGN KEY (testcase_id) REFERENCES Testcase(id) ON DELETE set null,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


