ad_page_contract {
    recruiting admin interface
    new criteria page

    @author chak (chak@openforce.net)
    @creation-date 2002-07-30
    @version $Id$
} {
    {criteria_id:notnull}
}
 
set package_id [ad_conn package_id]
set user_id [ad_verify_and_get_user_id]

array set info [recruiting_criteria::get -criteria_id $criteria_id]

form create edit_criteria
element create edit_criteria criteria_name \
        -label "Criteria Name:" \
        -datatype text \
        -widget text \
        -html {size 60} \
        -value $info(criteria_name)

element create edit_criteria description \
        -label "Description:" \
        -datatype text \
        -widget textarea \
        -html {rows 5 cols 60 wrap soft} \
        -value $info(description)

element create edit_criteria criteria_id \
        -widget hidden \
        -value $criteria_id

if {[form is_valid edit_criteria]} {
    form get_values edit_criteria \
            criteria_name description
    
    recruiting_criteria::update_criteria_type \
            -criteria_id $criteria_id \
            -criteria_name $criteria_name \
            -description $description \
            -package_id $package_id \
            -enabled_p "t"
    
    ad_returnredirect list-criteria
    ad_script_abort
}

set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] [list "list-criteria" "Criteria Types"] "Edit Criteria"]

ad_return_template
