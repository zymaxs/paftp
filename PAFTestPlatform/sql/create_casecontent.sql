
CREATE TABLE `casecontent` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `content` varchar(2048) DEFAULT NULL,
 `type` varchar(20) DEFAULT NULL,
 `testcase_id` int(11) DEFAULT NULL,
  INDEX testcase_ind (testcase_id), 
  FOREIGN KEY (testcase_id) REFERENCES testcase(id) ON DELETE cascade,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


