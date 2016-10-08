
create database SJWeather;

use SJWeather;

create table if not exists user (user_id int not null auto_increment primary key, name char(20) not null, pwd char(40) not null);

create table if not exists sign_in (user_id int not null primary key, token char(130) not null);


