<?php

$username = getenv('MYSQLCS_USER_NAME') ? getenv('MYSQLCS_USER_NAME') : '';
$password = getenv('MYSQLCS_USER_PASSWORD') ? getenv('MYSQLCS_USER_PASSWORD') : '';
$servername = getenv('MYSQLCS_CONNECT_STRING') ? getenv('MYSQLCS_CONNECT_STRING') : 'localhost:3306/mydatabase';
$database = substr($servername,strpos($servername,"/")+1);
$conn = new mysqli($servername, $username, $password, $database);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
    echo "connection error. Failed.....";
} else {
	 $sql = "DROP TABLE employees";
	$conn->query($sql);
	
    $sql = "CREATE TABLE employees ("
            . "ID INTEGER NOT NULL AUTO_INCREMENT,"
            . "FIRSTNAME VARCHAR(255),"
            . "LASTNAME VARCHAR(255),"
            . "EMAIL VARCHAR(255),"
            . "PHONE VARCHAR(255),"
            . "BIRTHDATE VARCHAR(10),"
            . "TITLE VARCHAR(255),"
            . "DEPARTMENT VARCHAR(255),"
            . "PRIMARY KEY (id)"
            . "); ";
    if ($conn->query($sql) === TRUE) {
        echo "Table EMPLOYEE created successfully". "<br>";
        $sql = "INSERT INTO EMPLOYEE (FIRSTNAME, LASTNAME, EMAIL, PHONE, BIRTHDATE, TITLE, DEPARTMENT) VALUES "
                . "('Hugh', 'Jast', 'Hugh.Jast@example.com', '730-715-4446', '1970-11-28' , 'National Data Strategist', 'Mobility'), "
                . "('Toy', 'Herzog', 'Toy.Herzog@example.com', '769-569-1789','1961-08-08', 'Dynamic Operations Manager', 'Paradigm'), "
                . "('Reed', 'Hahn', 'Reed.Hahn@example.com', '429-071-2018', '1977-02-05', 'Future Directives Facilitator', 'Quality'), "
                . "('Novella', 'Bahringer', 'Novella.Bahringer@example.com', '293-596-3547', '1961-07-25' , 'Principal Factors Architect', 'Division'), "
                . "('Zora', 'Sawayn', 'Zora.Sawayn@example.com', '923-814-0502', '1978-03-18' , 'Dynamic Marketing Designer', 'Security'); ";
        if ($conn->query($sql) === TRUE) {
            echo "New records created successfully";
        } else {
            echo "Error: " . $sql . "<br>" . $conn->error;
        }
    } else {
        echo "Error creating table: " . $conn->error;
    }
    $conn->close();
}
?>    