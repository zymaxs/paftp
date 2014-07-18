CREATE TABLE `AnalyseCommentHistory` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `createtime` datetime not NULL,
 `oldstatus` varchar(20) DEFAULT NULL,
 `newstatus` varchar(20) DEFAULT NULL,
 `oldcomment` varchar(1024) DEFAULT NULL,
 `newcomment` varchar(1024) DEFAULT NULL,
 `updator_id` int(11) DEFAULT NULL,
 `testcaseresult_id` int(11) not NULL,
  INDEX testcaseresult_ind (testcaseresult_id), 
  FOREIGN KEY (testcaseresult_id) REFERENCES TestcaseResult(id) ON DELETE cascade,
  INDEX user_ind (updator_id), 
  FOREIGN KEY (updator_id) REFERENCES User(id) ON DELETE set null,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;