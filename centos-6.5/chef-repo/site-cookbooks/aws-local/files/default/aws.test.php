<?php

include "./aws.phar";

use Aws\DynamoDb\DynamoDbClient;

$c = DynamoDbClient::factory(array(
	'key'    => 'KIAJMWSCNKVAVGPWCTA',
	'secret' => 'ip4HB92jWgGPq6/SO7VH6IlR5WLihDKcaNLsaj1w',
	'region' => 'ap-northeast-1'
));


?>
