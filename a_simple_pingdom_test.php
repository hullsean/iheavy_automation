
<!--This is test page used by pingdom.com to check the server status-->
<html>
<title>Iheavy.com</title>
<body>

<?php
// *******************************
// MySQL server configuration
// *******************************

// these are placeholders for host, user & pass
// ansible will later fill them in with the correct
// db hostname, user & pass based on environment
// variables and/or prompting
//
$DB_HOST         = 'localhost'; // Database host
$DB_USERNAME = 'xxxx';  // Database username
$DB_PASSWORD = 'yyyy';  // Database password

// Get start time for the execution timer
// Execution time code from http://www.developerfusion.com
$mtime = microtime();
$mtime = explode(" ",$mtime);
$mtime = $mtime[1] + $mtime[0];
$starttime = $mtime;

// Check MySQL using the provided connection information
if ($db = mysql_connect($DB_HOST, $DB_USERNAME, $DB_PASSWORD))
        $mysqlStatus = 'OK';
else
        {$mysqlStatus = 'MySQL DOWN';
        echo "<b> MySQL DOWN;</b> "; }

// Get end time and calculate execution time
$mtime = microtime();
$mtime = explode(" ",$mtime);
$mtime = $mtime[1] + $mtime[0];
$endtime = $mtime;
$totaltime = round(($endtime - $starttime) * 1000, 3); // Time in milliseconds


mysql_select_db("test",$db)
or die('Could not select a database.');
// display mysql date/time
$result=mysql_query("SELECT now()");
$row=mysql_fetch_row($result);
echo "<b> MySQL says the time is $row[0]  Status: </b>";

// *******************************
// Return XML response for Pingdom
// *******************************
// If this script responds then obviously HTTP services is working ... we can just return the status of MySQL.
// I'll just print the XML directly instead of going through the hassle of learning PHP's XML functions

// Print the XML response
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>

<pingdom_http_custom_check>
        <status>$mysqlStatus</status>
        <response_time>$totaltime</response_time>
</pingdom_http_custom_check>"
?>
<h1>

This page is under construction!!  <br>

</h1>
</body>
</html>
