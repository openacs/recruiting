ad_page_contract {
    recruiting admin interface
    access admin function such as: criteria specification 
                               and interviewee status types

    @author chak (chak@openforce.net)
    @creation-date 2002-07-30
    @version $Id$
} {
    status_type_id:notnull
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

array set info [recruiting::status_type::get -status_type_id $status_type_id]

form create edit_status_type
element create edit_status_type short_desc \
        -label "Status type:" \
        -datatype text \
        -widget text \
        -html {size 60} \
        -value $info(short_desc)

element create edit_status_type long_desc \
        -label "Description:" \
        -datatype text \
        -widget textarea \
        -html {rows 5 cols 60 wrap soft} \
        -value $info(long_desc)

element create edit_status_type status_type_id \
        -widget hidden \
        -value $info(status_type_id)

if {[form is_valid edit_status_type]} {
    form get_values edit_status_type \
            short_desc long_desc
    
    recruiting::status_type::update_status_type \
            -status_type_id $status_type_id \
            -short_desc $short_desc \
            -long_desc $long_desc \
            -package_id $package_id \
            -enabled_p "t"
    
    ad_returnredirect list-status-types
    ad_script_abort
}

set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] [list "list-status-types" "Status Types"] "Edit Status Type"]

ad_return_template

