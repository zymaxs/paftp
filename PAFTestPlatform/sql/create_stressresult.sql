
CREATE TABLE `sceneresult` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `scene_id` varchar(11) DEFAULT NULL,
 INDEX scene_ind (scene_id), 
 FOREIGN KEY (scene_id) REFERENCES scene(id) ON DELETE set null,
 `version_id` varchar(11) DEFAULT NULL,
 INDEX version_ind (version_id), 
 FOREIGN KEY (version_id) REFERENCES version(id) ON DELETE set null,
 `strategytype_id` varchar(11) DEFAULT NULL,
 INDEX strategytype_ind (strategytype_id), 
 FOREIGN KEY (strategytype_id) REFERENCES strategytype(id) ON DELETE set null,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;