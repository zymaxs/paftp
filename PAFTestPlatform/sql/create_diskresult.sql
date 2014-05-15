
CREATE TABLE `diskresult` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `stress_result_id` int(11) DEFAULT NULL,
 INDEX stress_result_ind (stress_result_id), 
 FOREIGN KEY (stress_result_id) REFERENCES stressresult(id) ON DELETE set null,
 `timestamp` varchar(20) DEFAULT NULL,
 `diskread` varchar(8) DEFAULT NULL,
 `diskwrite` varchar(8) DEFAULT NULL,
 `diskio` varchar(8) DEFAULT NULL,
 PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;