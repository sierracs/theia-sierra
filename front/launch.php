<?php
execute('./launch.sh');

function execute($cmd)
{
    echo "DEBUG: Running command: <code>$cmd</code><br>";
    exec(escapeshellcmd($cmd), $output, $status);
    if ($status) echo "Exec command failed";
    else
    {
        echo "<pre>";
        foreach($output as $line) echo htmlspecialchars("$line\n");
        echo "</pre>";
    }
}

?>