
CREATE TABLE `sut` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `code` varchar(20) not NULL,
    `name` varchar(100) not NULL UNIQUE,
    `description` varchar(200) DEFAULT NULL,
    `group_id` int(11) DEFAULT NULL,
    INDEX group_ind (group_id), 
	FOREIGN KEY (group_id) REFERENCES sutgroup(id) ON DELETE SET NULL,
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


