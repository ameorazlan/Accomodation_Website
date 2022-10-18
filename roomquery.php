<html>
    <head>
        <title>Coursework Website 2</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="coursework.css" type="text/css">
    </head>
<body>

    <?php
    $conn = new mysqli("localhost", "root", "", "courseworkfinal");
    if ($conn->connect_error) {
     die("Connection to MySQL has failed: " . $conn->connect_error);
    }
    ?>
    <h1>
        Welcome to Surrey Accomodation
    </h1>
    <a href="roombooking.php">Click here to book your own room!</a><br><br>
    <form action = "" method="get">Check room availability
        <br><input type="text" name="room_availability">
        <input type="submit" value="Search using room number" class = "submit" name="search_room_number">
        <input type="submit" value="Search using location" class = "submit" name="search_room_location">
    </form>
    <br><br>
    <form name = "checkBookings" action = "" onsubmit="return inputValidation()" method="get">
        Check room bookings<br>
        <input type="text" name="student_urn" placeholder="Input your 7 digit URN">
        <input type="submit" class = "submit" value="Submit" name="search_by_urn">
    </form>
    <script type="text/javascript">
    // This function is responsible for validating the user input
    function inputValidation() {
        // Checks if the URN is 7 digits or not
        // If it is not, then it will send the user an alert box and it will not submit the form
        let x = document.forms["checkBookings"]["student_urn"].value;
        if (x < 1000000 || x > 9999999) {
            alert("Please input a valid URN");
            return false;
        }
    }   
    </script>
    <p id ="php_result_main">
    <?php
    // This if statement checks if the room number input field is set and is responsible for getting the room number from the user input.
    // It then puts that room number in an sql query which returns the room information from the database if the room number is in the database and it has not been assigned to any students.
    if (isset($_GET["search_room_number"])) {
        // assign a variable to user input using the get method
        $room_number = $_GET["room_availability"];
        //queries the database and stores the result in a variable
        $result = mysqli_query($conn, "Select * from room left outer join student on room.room_number = student.room_number where student.urn is null and room.room_number = '".$room_number."'");
        echo "<table><tr><th>Room Number</th><th>Room Band</th><th>Room Cost (per month)</th><th>Total Room Area(Meters Squared)</th><th>Location Name</th></tr>";
        // a while loop responsible for printing each row from the result variable 
        while ($r = $result->fetch_assoc()){
            echo "<tr><td>".$r["room_number"]."</td><td>".$r["room_band"]."</td><td>".$r["cost"]."</td><td>".$r["total_room_area"]."</td><td>".$r["loc_name"]."</td></tr>";
        }
        echo "</table>";
        // The number of rows in the result variable is stored in a count variable
        $count = mysqli_num_rows($result);
        // If there is less than 1 row that means no results has been found and an error message will be printed to the user
        if ($count<1) {
            echo "No results found";
        }
        // Frees the result
        mysqli_free_result($result);
    }
    // The if statement checks if the room location input field is set and is responsible for getting the location from the user input
    // It then queries the database using the location and returns all rooms that are in that location that have not been assigned to any students
    if (isset($_GET["search_room_location"])) {
        // assign a variable to user input using the get method
        $room_location = $_GET["room_availability"];
        //queries the database and stores the result in a variable
        $result = mysqli_query($conn, "Select * from room left outer join student on room.room_number = student.room_number where student.urn is null and room.loc_name = '".$room_location."'");
        echo "<table><tr><th>Room Number</th><th>Room Band</th><th>Room Cost (per month)</th><th>Total Room Area(Meters Squared)</th><th>Location Name</th></tr>";
        // a while loop responsible for printing each row from the result variable 
        while ($r = $result->fetch_assoc()){
            echo "<tr><td>".$r["room_number"]."</td><td>".$r["room_band"]."</td><td>".$r["cost"]."</td><td>".$r["total_room_area"]."</td><td>".$r["loc_name"]."</td></tr>";
        }
        echo "</table>";
        // The number of rows in the result variable is stored in a count variable
        $count = mysqli_num_rows($result);
        // If there is less than 1 row that means no results has been found and an error message will be printed to the user
        if ($count<1) {
            echo "No results found";
        }
        // Frees the result
        mysqli_free_result($result);
    }
    // The if statement checks if the URN input field is set is responsible for getting the URN from the user input
    // It then queries the database using the URN and returns some of the student's information and their room information if the student has been assigned to a room.
    if (isset($_GET["search_by_urn"])) {
        // assign a variable to user input using the get method
        $student_urn= $_GET["student_urn"];
        //queries the database and stores the result in a variable
        $result = mysqli_query($conn, "Select * from student inner join room on room.room_number = student.room_number where student.urn = '".$student_urn."'");
        echo "<table><tr><th>Student URN</th><th>Student First Name</th><th>Student Last Name</th><th>Room Number</th><th>Room Band</th><th>Room Cost (per month)</th><th>Total Room Area (Meters Squared)</th><th>Location Name</th></tr>";
        // a while loop responsible for printing each row from the result variable 
        while ($r = $result->fetch_assoc()){
            echo "<tr><td>".$r["URN"]."</td><td>".$r["Stu_FName"]."</td><td>".$r["Stu_LName"]."</td><td>".$r["room_number"]."</td><td>".$r["room_band"]."</td><td>".$r["cost"]."</td><td>".$r["total_room_area"]."</td><td>".$r["loc_name"]."</td></tr>";
        }
        echo "</table>";
        // The number of rows in the result variable is stored in a count variable
        $count = mysqli_num_rows($result);
        // If there is less than 1 row that means no results has been found and an error message will be printed to the user
        if ($count<1) {
            echo "No results found";
        }
        // Frees the result
        mysqli_free_result($result);
    }
    $conn->close();
    ?>
    </p>
</body>
</html>
