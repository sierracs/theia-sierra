<?php // launch.php, runs a script passed from workspace-list
if (isset($_POST['workspace-list'])) $script = fix_string($_POST['workspace-list']);

// Run the script, or not
if ($script == "") echo "Something went wrong.<br>I don't know which script to run.<br>";
else
{
    // Run the script
    execute('scripts/' . $script);

    // Redirect after script has been executed
    // $url = "";
    // header('Location: ' .$url);
    // exit();
}

function execute($cmd)
{
    echo "DEBUG: command: <code>$cmd</code><br>";
    exec(escapeshellcmd($cmd), $output, $status);
    if ($status) echo "Exec command failed<br>";
    else
    {
        echo "<pre>";
        foreach($output as $line) echo htmlspecialchars("$line\n");
        echo "</pre>";
    }
}

function fix_string($string)
{
    if (get_magic_quotes_gpc()) $string = stripslashes($string);
    return htmlentities($string);
}

?>