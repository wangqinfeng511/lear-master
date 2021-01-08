<?php
// Zabbix GUI configuration file.
global $DB;

$DB['TYPE']     = 'MYSQL';
$DB['SERVER']   = '192.168.99.143';
$DB['PORT']     = '3306';
$DB['DATABASE'] = 'zabbix';
$DB['USER']     = 'zabbix';
$DB['PASSWORD'] = 'fengzi';

// Schema name. Used for IBM DB2 and PostgreSQL.
$DB['SCHEMA'] = '';

$ZBX_SERVER      = '192.168.99.143';
$ZBX_SERVER_PORT = '10051';
$ZBX_SERVER_NAME = 'centos';

$IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;
?>
