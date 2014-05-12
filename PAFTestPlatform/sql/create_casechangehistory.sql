
CREATE TABLE `casechangehistory` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `updator_id` int(11) DEFAULT NULL,
 `testcase_id` int(11) not NULL,
  INDEX testcase_ind (testcase_id), 
  FOREIGN KEY (testcase_id) REFERENCES testcase(id) ON DELETE cascade,
  INDEX user_ind (updator_id), 
  FOREIGN KEY (updator_id) REFERENCES user(id) ON DELETE set null,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;