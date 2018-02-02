<?php

include("EmployeeStorage.php");

set_exception_handler(function ($e) {
    $code = $e->getCode() ? : 400;
    header("Content-Type: application/json", NULL, $code);
    echo json_encode(["error" => $e->getMessage()]);
    exit;
});

// assume JSON, handle requests by verb and path
$verb = $_SERVER['REQUEST_METHOD'];
$url_pieces = explode('/', $_SERVER['PATH_INFO']);

if ($url_pieces[1] != 'employees') {
    throw new Exception('Unknown endpoint', 404);
}

$employeeStorage = new EmployeeStorage ();
$data;
error_log(print_r($verb, TRUE));
switch ($verb) {
    case 'GET':       
        if (!empty($url_pieces[2]) && !empty($url_pieces[3])) {
            $filter = $url_pieces[2];
            $value = $url_pieces[3];
            $data = $employeeStorage->search($filter, $value);
        }elseif (!empty($url_pieces[2])) {
            $id = $url_pieces[2];
            $data = $employeeStorage->get($id);
        }else {
            $data = $employeeStorage->getAll();
        }
        break;
    case 'POST':
        $params = json_decode(file_get_contents("php://input"), true);
        if (!$params) {
            throw new Exception("Data missing or invalid");
        }
        $employee = new Employee();
        $employee->set($params);
        $employeeStorage->save($employee);
        $data = '{"status":"OK"}';
        http_response_code(201);
        break;
    case 'PUT':
        $params = json_decode(file_get_contents("php://input"), true);
        if (!$params) {
            throw new Exception("Data missing or invalid");
        }
        $id;
        if (!empty($url_pieces[2])) {
            $id = $url_pieces[2];
        }
        $employee = new Employee();
        $employee->id = $id;
        $employee->set($params);
        $employeeStorage->update($employee);
        $data = '{"status":"OK"}';
        http_response_code(200);
        break;
    case 'DELETE':
        $id;
        if (!empty($url_pieces[2])) {
            $id = $url_pieces[2];
            $employeeStorage->delete($id);
        }
        $data = '{"status":"OK"}';
        http_response_code(200);
        break;
    case 'OPTIONS':
        http_response_code(200);
        $data = '{"status":"OK"}';
        break;
    default:
        throw new Exception('Method Not Supported', 405);
}

header("Content-Type: application/json");
header('Access-Control-Allow-Origin:*');
header('Access-Control-Allow-Methods:GET, POST, OPTIONS, PUT, PATCH, DELETE');
header('Access-Control-Allow-Headers:X-Requested-With,content-type');
header('Access-Control-Allow-Credentials:true');
echo json_encode($data);
?>