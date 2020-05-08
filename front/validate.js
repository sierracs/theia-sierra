function validate(form)
{
    fail = validateUsername(form.username.value)
    fail += validatePassword(form.password.value)
    
    if (fail == "") return true;
    else
    {
        alert(fail)
        return false
    }
}

function validateUsername(field)
{
    return (field == "") ? "No username entered.\n" : ""
}

function validatePassword(field)
{
    // if (field == "")
    //     return "No password was entered.\n"
    // else if (field.length < 6)
    //     return "Password must be at least 6 characters long.\n"
    // else if (!/[a-z]/.test(field) || !/[A-Z]/.test(field) || !/[0-9]/.test(field))
    //     return "Passwords require at least one uppercase, one lowercase, and one number.\n"
     return ""
}