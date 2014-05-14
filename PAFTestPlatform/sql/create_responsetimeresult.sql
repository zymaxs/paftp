
CREATE TABLE `responsetimeresult` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `stress_result_id` varchar(11) DEFAULT NULL,
 INDEX stress_result_ind (stress_result_id), 
 FOREIGN KEY (stress_result_id) REFERENCES stress_result(id) ON DELETE set null,
 `timestamp` varchar(20) DEFAULT NULL,
 `responsetime_pass_ave` varchar(10) DEFAULT NULL,
 `responsetime_fail_ave` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;