CREATE DATABASE aws_and_infra DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER 'aws_and_infra'@'%' IDENTIFIED BY 'password';
GRANT ALL ON aws_and_infra.* TO 'aws_and_infra'@'%';
FLUSH PRIVILEGES;
