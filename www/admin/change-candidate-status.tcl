ad_page_contract {
    recruiting admin interface
    change a candidate's status

    @author chak (chak@openforce.net)
    @creation-date 2002-07-30
    @version $Id$
} {
    candidate_id
}

set package_id [ad_conn package_id]
set user_id [ad_verify_and_get_user_id]

array set info [recruiting_candidate::get -candidate_id $candidate_id]

form create change_status
element create change_status status \
        -label "Change status type for $info(first_name) $info(last_name) (<a href=\"javascript:openPage('status-help',400,300)\">help</a>):" \
        -datatype integer \
        -widget select \
        -options [db_list_of_lists get_status_types "select short_desc,status_type_id from recruiting_status_types where enabled_p='t' order by short_desc"] \
        -value $info(status)

element create change_status candidate_id \
        -widget hidden \
        -value $candidate_id

if {[form is_valid change_status]} {
    form get_values change_status \
            status    
    
    recruiting_candidate::update_candidate \
            -candidate_id $info(candidate_id) \
            -first_name $info(first_name) \
            -last_name $info(last_name) \
            -address1 $info(address1) \
            -address2 $info(address2) \
            -city $info(city) \
            -state $info(state) \
            -zip $info(zip) \
            -zip_plus_four $info(zip_plus_four) \
            -country $info(country) \
            -email $info(email) \
            -status $status \
            -package_id $package_id
    
    ad_returnredirect view-one-candidate?[export_vars candidate_id]
    ad_script_abort
}

set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] [list "list-candidates" "Candidates"] [list "view-one-candidate?[export_vars candidate_id]"] "Change Status"]

ad_return_template