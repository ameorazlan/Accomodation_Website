<html>
    <head>
        <title>Coursework Website</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="Template.css" type="text/css">
    </head>
<body>
    <?php
    $conn = new mysqli("localhost", "root", "", "courseworkfinal");
    if ($conn->connect_error) {
     die("Connection to MySQL has failed: " . $conn->connect_error);
    }
    ?>
    <h1>
        Book your room
    </h1>
    <img src="coursework_photo.jpg" alt= "picture">
    <h3>
        Get started now!
    </h3>
    <p>
    <a href="roomquery.php">Click here to go back to main page</a>
    </p>
    <form name = "new_registration" action = "" method="post" onsubmit="return formValidation()">Please input <b>your</b> details in the corresponding fields below
        <br><br>Student URN (7 Digit University Registration Number)<input type="text" name="user_urn" required>
        <br><br>First Name<input type="text" name="user_first_name" required>Last Name<input type="text" name="user_last_name" required>
        <br><br>Gender<label for="Gender"></label>
        <select name="user_gender">
            <option value ="Male">Male</option>
            <option value="females">Female</option>
        </select>
        Date of Birth<input type="date" name="user_date_of_birth" required>
        <br><br>Email(please provide your @surrey.ac.uk email if you have been given one)<input type="text" name="user_email" required> 
        <br><br>Faculty<input type="text" name="user_faculty" required><br><br>
        Please input your <b>emergency contact's</b> details in the corresponding fields below
        <br><br>Emergency Contact's First Name<input type="text" name="user_ec_f_name" required>Emergency Contact's Last Name<input type="text" name="user_ec_l_name" required>
        <br><br>Emergency Contact's Phone Number<input type="text" name="user_ec_phone" required>Relationship with Emergency Contact<input type="text" name="user_ec_relationship" required>
        <br><br>Chosen Room Number<input type="text" name="user_room_number" required>
        <br><br><br>I have read and agreed to the terms and conditions<input type="checkbox" id="accept"><br>
        <br><input type="submit" class = "submit" value="Submit" name="search_room_location"><br>
    </form>
    <script type="text/javascript">
    // This function is responsible for validating the user input
    function formValidation() {
        // Checks if the terms and conditions box has been checked or not
        // If it has not been checked it will send the user an alert box and it will not submit the form 
        if (!document.getElementById('accept').checked) {
            window.alert("Please confirm that you have agreed to the terms and conditions");
            return false;
        }
        // Checks if the URN is 7 digits or not
        // If it is not, then it will send the user an alert box and it will not submit the form
        let x = document.forms["new_registration"]["user_urn"].value;
        if (x < 1000000 || x > 9999999) {
            window.alert("Please input a valid URN");
            return false;
        }
    }
    </script>
    <p id="php_results">
    <?php
    //The if statement checks if all input fields are not empty and is responsible for storing the user input into the database
    if (!empty($_POST["user_urn"]) && !empty($_POST["user_first_name"]) && !empty($_POST["user_last_name"]) && !empty($_POST["user_gender"])
     && !empty($_POST["user_date_of_birth"]) && !empty($_POST["user_email"]) && !empty($_POST["user_faculty"])  && !empty($_POST["user_ec_f_name"])  && !empty($_POST["user_ec_l_name"])  && !empty($_POST["user_ec_phone"])
     && !empty($_POST["user_ec_relationship"])  && !empty($_POST["user_room_number"])) {
        //Stores all the user inputs into their corresponding variable
        $user_urn= $_POST["user_urn"];
        $user_first_name= $_POST["user_first_name"];
        $user_last_name= $_POST["user_last_name"];
        $user_gender= $_POST["user_gender"];
        // Since the database stores gender as either M or F we will convert user input into their corresponding short form
        if ($user_gender == "Male") {
            $user_gender = "M";
        } else {
            $user_gender = "F";
        }
        $user_date_of_birth= $_POST["user_date_of_birth"];
        $user_email = $_POST["user_email"];
        $user_faculty= $_POST["user_faculty"];

        $ec_first_name= $_POST["user_ec_f_name"];
        $ec_last_name = $_POST["user_ec_l_name"];
        $ec_phone= $_POST["user_ec_phone"];
        $ec_relationship = $_POST["user_ec_relationship"];
        $user_room= $_POST["user_room_number"];
        
        //Instead of requiring the user to input the room's location we will instead query the database and select the location name with respect to the user's chosen room number
        $result = mysqli_query($conn, "select loc_name from room where room_number = '$user_room'");
        // We will thens tore the location name into a variable as well
        $user_loc_name = $result->fetch_assoc()["loc_name"];

        // We have 2 sql statements which are responsible for inserting the user input data into the student and emergency_contact tables
        $sql = "insert into student values ('$user_urn', '$user_first_name', '$user_last_name', '$user_date_of_birth', '$user_email', '$user_gender', '$user_faculty', '$user_loc_name', '15', null)";
        $sql2 = "insert into emergency_contact values ('$user_urn', '$ec_first_name', '$ec_last_name', '$ec_phone', '$ec_relationship')";
        // If the first query is successful, the second query will execute
        // If the first query is unsuccessful we will print an error message
        if (mysqli_query($conn, $sql)) {
            // If the second query is successful we will print a success message
            // If the second query is unsuccessful we will print an error message
            if (mysqli_query($conn, $sql2)) {
                echo "Booking Successful";
            } else {
                echo "Booking Failed Please Review the Fields Again";
            }
        } else {
            echo "Booking Failed Please Review the Fields Again";
        }
        // Frees the result
        mysqli_free_result($result);
    }
    $conn->close();
    ?>
    </p>
</body>
</html>
