
CREATE TABLE `testsuite` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `name` varchar(50) DEFAULT NULL,
 `sut_id` int(11) DEFAULT NULL,
  INDEX sut_ind (sut_id), 
  FOREIGN KEY (sut_id) REFERENCES sut(id) ON DELETE cascade,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


