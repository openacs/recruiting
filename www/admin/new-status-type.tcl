ad_page_contract {
    recruiting admin interface
    new status type page

    @author chak (chak@openforce.net)
    @creation-date 2002-07-30
    @version $Id$
}

set package_id [ad_conn package_id]
set user_id [ad_verify_and_get_user_id]

form create new_status_type
element create new_status_type short_desc \
        -label "Status type:" \
        -datatype text \
        -widget text \
        -html {size 60}

element create new_status_type long_desc \
        -label "Description:" \
        -datatype text \
        -widget textarea \
        -html {rows 5 cols 60 wrap soft}

if {[form is_valid new_status_type]} {
    form get_values new_status_type \
            short_desc long_desc
    
    recruiting_status_type::new \
            -short_desc $short_desc \
            -long_desc $long_desc \
            -package_id $package_id \
            -enabled_p "t"
    
    ad_returnredirect list-status-types
    ad_script_abort
}

ad_return_template
