#!/bin/bash

# Functions
ok() { echo -e '\e[32m'$1'\e[m'; } # Green

EXPECTED_ARGS=3
E_BADARGS=65
MYSQL=`which mysql`
 
Q1="CREATE DATABASE IF NOT EXISTS $1;"
Q2="GRANT ALL ON *.* TO '$2'@'%' IDENTIFIED BY '$3';"
Q3="use demo;"
Q4="CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;"
Q5="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}${Q4}${Q5}"
 
if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: $0 dbname dbuser dbpass"
  exit $E_BADARGS
fi
 
$MYSQL -uroot -p -e "$SQL"

ok "Database $1 and user $2 created with a password $3"