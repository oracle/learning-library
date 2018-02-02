<?php

class Employee {

    public $id;
    public $firstName;
    public $lastName;
    public $birthDate;
    public $phone;
    public $email;
    public $dept;
    public $title;

    public function set($arrayParams) {
        if (!empty($arrayParams['id'])) {
            $this->id = $arrayParams['id'];
        }
        $this ->firstName = $arrayParams['firstName'];
        $this->lastName = $arrayParams['lastName'];
        $this->birthDate = $arrayParams['birthDate'];
        $this->phone = $arrayParams['phone'];
        $this->email = $arrayParams['email'];
        $this->dept = $arrayParams['dept'];
        $this->title = $arrayParams['title'];
    }

}

?>