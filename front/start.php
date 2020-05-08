<?php // start.php fires up the theia-sierra-ubuntu container

// Username and password
$username = $password = "";
if (isset($_POST['username'])) $username = fix_string($_POST['username']);
if (isset($_POST['password'])) $password = fix_string($_POST['password']);
$fail = validate_username($username);
$fail .= validate_password($password);

echo "<!DOCTYPE html>\n<html><head><title>Theia Sierra IDE - $username</title>";
echo '<link rel="stylesheet" type="text/css" href="style.css" media="screen" />';

if ($fail == "")
{
    echo "</head><body>";
    echo "<h1>Welcome $username</h1><br>";
    echo "<div class='main_content'>";
    echo make_card("CS46 workspace", "");
    echo "</div>";
    $logout_button = "<a href='/front/login.html' class='button'>Back to login screen</a>";
    echo "<h3>" . $logout_button . "</h3><br>";
}
else
{
    echo "Something went wrong.<br><a href='login.html'>Log back in.</a>";
}

// Functions

function validate_username($field)
{
    return ($field == "") ? "No username entered.<br>" : "";
}

function validate_password($field)
{
    return "";
}

function fix_string($string)
{
    if (get_magic_quotes_gpc()) $string = stripslashes($string);
    return htmlentities($string);
}

function make_card($title, $description)
{
    $launch_link = 'http://localhost:3000/#/home/project';
    $launch_button = '<input type="submit" name="launch" value="Launch">';
    $card = <<<_END
    <table class="box" border="0" cellpadding="2" cellspacing="5" bgcolor="#eeeeee">
        <th colspan="1" align="center">$title</th>
            <tr><td>$description</td></tr>
            <form method="post" action="launch.php">
            <tr><td colspan="2" align="center">$launch_button</td></tr>
            </form>
    </table>
_END;
    return $card;
}

?>