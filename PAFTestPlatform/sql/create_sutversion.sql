CREATE TABLE `sut_version` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `sut_id` int(11) not NULL,
    `version_id` int(11) not NULL,
    INDEX sut_ind (sut_id),
    FOREIGN KEY (sut_id)
        REFERENCES sut (id)
        ON DELETE cascade,
    INDEX version_ind (version_id),
    FOREIGN KEY (version_id)
        REFERENCES version (id)
        ON DELETE cascade,
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
