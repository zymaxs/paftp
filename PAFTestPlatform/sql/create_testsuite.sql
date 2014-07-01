
CREATE TABLE `Testsuite` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(50) DEFAULT NULL,
    `code` varchar(50) DEFAULT NULL,
    `status` varchar(20) DEFAULT NULL,
    `version_id` int(11) DEFAULT NULL,
    `description` varchar(150) DEFAULT NULL,
    `sut_id` int(11) DEFAULT NULL,
    INDEX sut_ind (sut_id),
    FOREIGN KEY (sut_id)
        REFERENCES Sut (id)
        ON DELETE cascade,
    INDEX version_ind (version_id),
    FOREIGN KEY (version_id)
    	REFERENCES Version (id)
    	ON DELETE cascade,
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


