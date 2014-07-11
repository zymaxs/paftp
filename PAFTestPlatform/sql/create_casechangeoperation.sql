
CREATE TABLE `CaseChangeOperation` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `field` varchar(20) DEFAULT NULL,
    `old_value` varchar(3072) DEFAULT NULL,
    `new_value` varchar(3072) DEFAULT NULL,
    `casechangehistory_id` int(11) DEFAULT NULL,
    INDEX casechangehistory_ind (casechangehistory_id),
    FOREIGN KEY (casechangehistory_id)
        REFERENCES CaseChangeHistory (id)
        ON DELETE cascade,
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


