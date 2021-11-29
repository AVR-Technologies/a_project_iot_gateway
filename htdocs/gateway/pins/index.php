<?php
    header('Access-Control-Allow-Origin: *');  
    header("Access-Control-Allow-Headers: *");
    header('Access-Control-Allow-Credentials: true');
    header('Access-Control-Allow-Methods: *');
    $connection = mysqli_connect("localhost", "root", "", "gateway");

    $query = "SELECT * FROM controller";
    $query_run = mysqli_query($connection, $query);
    $r = array();
    if($query_run){
        if(mysqli_num_rows($query_run) > 0){
            while($row = mysqli_fetch_assoc($query_run)){
                $r[] = $row;
            }
            $response['success'] = true;
            $response['message'] = "success";
            $response['data'] = $r;
        }else{
            $response['success'] = false;
            $response['message'] = "no data found";
        }
    }else{
        $response['success'] = false;
        $response['message'] = "unknown error";
    }
    echo json_encode($response);
    mysqli_close($connection);
?>