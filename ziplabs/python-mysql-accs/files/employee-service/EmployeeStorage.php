<?php

include("Employee.php");

class EmployeeStorage {

    private $conn;

    public function __construct() {
        $username = getenv('MYSQLCS_USER_NAME') ? getenv('MYSQLCS_USER_NAME') : '';
        $password = getenv('MYSQLCS_USER_PASSWORD') ? getenv('MYSQLCS_USER_PASSWORD') : 'Welcome#1';
        $servername = getenv('MYSQLCS_CONNECT_STRING') ? getenv('MYSQLCS_CONNECT_STRING') : 'localhost:3306/mydatabase';
        $database = substr($servername, strpos($servername, "/") + 1);
        $this->conn = new mysqli($servername, $username, $password, $database);
        if ($this->conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
            echo "connection error. Failed.....";
        }
    }

    public function getAll() {
        $data = Array();
        $query = 'SELECT * FROM EMPLOYEE';
        $result = $this->conn->query($query);
        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $employee = new Employee();
                $employee->id = $row['ID'];
                $employee->firstName = $row['FIRSTNAME'];
                $employee->lastName = $row['LASTNAME'];
                $employee->phone = $row['PHONE'];
                $employee->birthDate = $row['BIRTHDATE'];
                $employee->title = $row['TITLE'];
                $employee->dept = $row['DEPARTMENT'];
                $employee->email = $row['EMAIL'];
                array_push($data, $employee);
            }
        }
        return $data;
    }

    public function search($criteria, $value) {
        $data = Array();
        if ($criteria == 'department') {
            $filter = 'DEPARTMENT';
        } else if ($criteria == 'lastname') {
            $filter = 'LASTNAME';
        } else if ($criteria == 'title') {
            $filter = 'TITLE';
        } else {
            throw new Exception('Filter criteria not valid');
        }
        $stmt = $this->conn->prepare('SELECT ID, FIRSTNAME, LASTNAME, PHONE, BIRTHDATE, TITLE, DEPARTMENT, EMAIL FROM EMPLOYEE WHERE ' . $filter . '=?');
        $stmt->bind_param('s', $value);
        $stmt->execute();
        $stmt->bind_result($id, $firstName, $lastName, $phone, $birthDate, $title, $department, $email);
        while ($stmt->fetch()) {
            $employee = new Employee();
            $employee->id = $id;
            $employee->firstName = $firstName;
            $employee->lastName = $lastName;
            $employee->phone = $phone;
            $employee->birthDate = $birthDate;
            $employee->title = $title;
            $employee->dept = $department;
            $employee->email = $email;
            array_push($data, $employee);
        }

        return $data;
    }

    public function delete($id) {
        $stmt = $this->conn->prepare('DELETE FROM EMPLOYEE WHERE ID = ?');
        $stmt->bind_param('i', $id);
        $stmt->execute();
        if ($stmt->errno) {
            error_log ("The delete failed " . $stmt->error);
        } 
        $stmt->close();
    }

    public function update($employee) {
        $stmt = $this->conn->prepare('UPDATE EMPLOYEE SET FIRSTNAME=?, LASTNAME=?, PHONE=?, BIRTHDATE=?, TITLE=?, DEPARTMENT=?, EMAIL=? '
                . 'WHERE ID=?');
        $stmt->bind_param('sssssssi', $employee->firstName, $employee->lastName,$employee->phone, $employee->birthDate, $employee->title, $employee->dept, $employee->email,  $employee->id);
        $stmt->execute();
        if ($stmt->errno) {
            error_log ("The update failed " . $stmt->error);
        } else{
            error_log ( "Updated {$stmt->affected_rows} rows");
        }
        $stmt->close();
    }

    public function save($employee) {
        $stmt = $this->conn->prepare('INSERT INTO EMPLOYEE (FIRSTNAME, LASTNAME, EMAIL, PHONE, BIRTHDATE, TITLE, DEPARTMENT) '
                . 'VALUES(?,?,?,?,?,?,?)');
        $stmt->bind_param('sssssss', $employee->firstName, $employee->lastName, $employee->email, $employee->phone, $employee->birthDate, $employee->title, $employee->dept);
        $stmt->execute();
        if ($stmt->errno) {
            error_log ("The insert failed " . $stmt->error);
        } 
        $stmt->close();
    }

    public function get($id) {
        $stmt = $this->conn->prepare('SELECT ID, FIRSTNAME, LASTNAME, PHONE, BIRTHDATE, TITLE, DEPARTMENT, EMAIL FROM EMPLOYEE WHERE ID=?');
        $stmt->bind_param('i', $id);
        $stmt->execute();
        $employee = new Employee();
        $stmt->bind_result($id, $firstName, $lastName, $phone, $birthDate, $title, $department, $email);
        while ($stmt->fetch()) {
            $employee->id = $id;
            $employee->firstName = $firstName;
            $employee->lastName = $lastName;
            $employee->phone = $phone;
            $employee->birthDate = $birthDate;
            $employee->title = $title;
            $employee->dept = $department;
            $employee->email = $email;
        }
        return $employee;
    }

}

?>