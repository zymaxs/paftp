
CREATE TABLE `StressResult` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `scene_id` int(11) DEFAULT NULL,
 INDEX scene_ind (scene_id), 
 FOREIGN KEY (scene_id) REFERENCES Scene(id) ON DELETE set null,
 `version_id` int(11) DEFAULT NULL,
 INDEX version_ind (version_id), 
 FOREIGN KEY (version_id) REFERENCES Version(id) ON DELETE set null,
 `strategytype_id` int(11) DEFAULT NULL,
 INDEX strategytype_ind (strategytype_id), 
 FOREIGN KEY (strategytype_id) REFERENCES StrategyType(id) ON DELETE set null,
 `sut_id` int(11) DEFAULT NULL,
 INDEX sut_ind (sut_id), 
 FOREIGN KEY (sut_id) REFERENCES Sut(id) ON DELETE set null,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;