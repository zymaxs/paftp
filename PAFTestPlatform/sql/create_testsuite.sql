
CREATE TABLE `testsuite` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `name` varchar(100) DEFAULT NULL,
 `sut_id` int(11) DEFAULT NULL,
  INDEX sut_ind (sut_id), 
  FOREIGN KEY (sut_id) REFERENCES sut(id) ON DELETE NO ACTION,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


