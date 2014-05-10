
CREATE TABLE `casechangeoperation` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `old_value` varchar(2048) DEFAULT NULL,
 `new_value` varchar(2048) DEFAULT NULL,
 `casechangehistory_id` int(11) DEFAULT NULL,
  INDEX casechangehistory_ind (casechangehistory_id), 
  FOREIGN KEY (casechangehistory_id) REFERENCES casechangehistory(id) ON DELETE cascade,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


