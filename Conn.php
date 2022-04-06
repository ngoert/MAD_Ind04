// php script
// Create connection
    $conn = mysqli_connect("cs.okstate.edu", "ngoerte", "*******************",>

    // get data from database
    $result = mysqli_query($conn, "SELECT * FROM states");

    // adding in array
    $data = array();
    while ($row = mysqli_fetch_object($result))
    {
        array_push($data, $row);
    }

    // send as response
