<!-- 
 BASIC PHP/Oracle script
 FIT Database Teaching Team
-->

<html>
<head>
 <title>Student List</title>
</head>

<body>
<h1>Sample: Student Table listing from UNIVERSITY database</h1>

<?php

// Include connection details
include("connection.php");

//Disable error reporting to HTML page, however
//DO NOT comment this out until the script has been debugged
error_reporting(0); 

?>

<?php

// Set up the Oracle connection string
// dbSID comes from the connection.php file
// of course, databaseServerName.example.com is to be replaced with the actual server name in your own projects
$dbInstance = "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)
   (HOST=databaseServerName.example.com)(PORT=1521))
   (CONNECT_DATA=(SID=$dbSID)))";

// Connect to the database - Open Oracle connection
// dbUserName and dbPassword come from the connection.php file
$conn = oci_connect($dbUserName, $dbPassword, $dbInstance);
if (!$conn) {
 $e = oci_error();
 print "Error connecting to the database:<br>" ;
 print $e['message'] ;
 exit;
}
?>

<!-- create HTML table header to display output -->
<table border =1 width=600>
<tr>
 <th width=100><b>Student ID</b></td>
 <th width=200><b>Name</b></td>
 <th width=100><b>Birth Date</b></td>
 <th width=200><b>Email</b></td>
</tr>
 
<?php
//SQL query statement
$query = "SELECT studid, 
 rtrim(studfname) || ' ' || rtrim(studlname) as sname, 
 to_char(studdob,'dd-Mon-yyyy') as sbdate,
 studemail
 FROM uni.student
 ORDER BY studid";

//Parse statement
$stmt = oci_parse($conn,$query);
if (!$stmt) {
 $e = oci_error($conn);
 print "Error on parse of statement:<br>" ;
 print $e['message'] ;
 exit;
}

// oci_define_by_name maps SQL Columns in a queryto PHP variable names
// NB - MUST be done before executing, Oracle names must be in UPPER case
oci_define_by_name($stmt,"STUDID",$studid);
oci_define_by_name($stmt,"SNAME",$stuname);
oci_define_by_name($stmt,"SBDATE",$stubdate);
oci_define_by_name($stmt,"STUDEMAIL",$stuemail);

// Execute the STATEMENT
$r = oci_execute($stmt);
if (!$r) {
 $e = oci_error($stmt);
 print "Error execute of statement:<br>" ;
 print $e['message'] ;
 exit;
}

// Fetch the results of the query
while (oci_fetch($stmt)) {
 print("
 <tr>
 <td width=100>$studid</td>
 <td width=100>$stuname</td>
 <td width=100>$stubdate</td>
 <td width=100>$stuemail</td>
 </tr>");
}

// Close table
print ("</table>");

$no_rows = oci_num_rows($stmt);
print "<p>Rows found:" . $no_rows . "</p>";

// Free resources associated with Oracle statement
oci_free_statement($stmt);
// Close the Oracle connection
oci_close($conn);

?>

</body>
</html>