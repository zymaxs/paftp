CREATE TABLE `analysecommenthistory` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `updator_id` int(11) DEFAULT NULL,
 `testcaseresult_id` int(11) not NULL,
  INDEX testcaseresult_ind (testcaseresult_id), 
  FOREIGN KEY (testcaseresult_id) REFERENCES testcaseresult(id) ON DELETE cascade,
  INDEX user_ind (updator_id), 
  FOREIGN KEY (updator_id) REFERENCES user(id) ON DELETE set null,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;