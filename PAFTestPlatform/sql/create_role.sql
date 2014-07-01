
CREATE TABLE `Role` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(20) not NULL UNIQUE,
    `description` varchar(30) DEFAULT NULL,
    `sut_id` integer(11) DEFAULT NULL,
      INDEX sut_ind (sut_id), 
  FOREIGN KEY (sut_id) REFERENCES Sut(id) ON DELETE cascade,
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


