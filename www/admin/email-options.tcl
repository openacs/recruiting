ad_page_contract {
    recruiting admin interface
    access admin function such as: criteria specification 
                               and interviewee status types

    @author chak (chak@openforce.net)
    @creation-date 2002-07-30
    @version $Id$
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

form create email

element create email default_email \
        -label "<center>This email gets sent to users to whom you assign recruiting candidate interviews.  You may edit the default email here.<br><br>The following variables are available to you:<br>\$interviewer_name<br>\$candidate_name<br>\$sender_name (you)<br>\$url</center>" \
        -datatype text \
        -widget textarea \
        -html {cols 60 rows 10} \
        -value [recruiting::email::get_body -package_id $package_id]

if {[form is_valid email]} {
    form get_values email \
            default_email

    recruiting::email::set_email \
            -email_body $default_email \
            -package_id $package_id
    
    ns_returnredirect index
}
    
set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] "Default Email"]

ad_return_template

