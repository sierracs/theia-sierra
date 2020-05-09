<?php // start.php, welcome page where you chose which workspace to start

// Username and password
$username = $password = "";
if (isset($_POST['username'])) $username = fix_string($_POST['username']);
if (isset($_POST['password'])) $password = fix_string($_POST['password']);
$fail = validate_username($username);
$fail .= validate_password($password);

echo "<!DOCTYPE html>\n<html><head><title>Theia Sierra IDE - $username</title>";
echo "<link rel='stylesheet' type='text/css' href='style.css' media='screen' />";

if ($fail == "")
{
    $workspaces = ['hello-world', 'CS46'];
    echo "</head><body>";
    echo "<h1>Welcome $username</h1><br>";
    echo "<div class='main_content'>";
    echo make_card($workspaces);
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

// Creates the box with drop down
function make_card($workspaces)
{
    $card = <<<_END
    <table class="box" border="0" cellpadding="2" cellspacing="5" bgcolor="#eeeeee">
        <th colspan="1" align="center">Workspaces</th>
            <tr><td>Please choose a workspace below:</td></tr>
            <form method="post" action="launch.php">
                <tr><td colspan="2" align="center">
                    <select name="workspace-list">
_END;
    foreach($workspaces as $workspace) $card .= "<option value=$workspace>$workspace</option>";
    $card .= <<<_END
    </select>
                </td></tr>
                <tr><td colspan="2" align="center">
                    <input type='submit' value='Launch'> 
                </td></tr>
            </form>
    </table><br>
_END;
    return $card;
}

?>