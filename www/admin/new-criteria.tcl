ad_page_contract {
    recruiting admin interface
    new criteria page

    @author chak (chak@openforce.net)
    @creation-date 2002-07-30
    @version $Id$
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

form create new_criteria
element create new_criteria criteria_name \
        -label "Criteria Name:" \
        -datatype text \
        -widget text \
        -html {size 60}

element create new_criteria description \
        -label "Description:" \
        -datatype text \
        -widget textarea \
        -html {rows 5 cols 60 wrap soft}

if {[form is_valid new_criteria]} {
    form get_values new_criteria \
            criteria_name description
    
    recruiting::criteria::new \
            -criteria_name $criteria_name \
            -description $description \
            -package_id $package_id \
            -enabled_p "t"
    
    ad_returnredirect list-criteria
    ad_script_abort
}

set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] [list "list-criteria" "Criteria Types"] "New Criteria"]

ad_return_template

