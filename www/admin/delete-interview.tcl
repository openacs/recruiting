ad_page_contract {
    recruiting admin interface
    access admin function such as: criteria specification 
                               and interviewee status types

    @author chak (chak@openforce.net)
    @creation-date 2002-07-30
    @version $Id$
} {
    interview_id:notnull
    candidate_id:notnull
    referrer:notnull
    {delete_p "notyet"}
}

set package_id [ad_conn package_id]
set user_id [ad_verify_and_get_user_id]

if {$delete_p == "notyet"} {
    
    array set candidate_info [recruiting_candidate::get -candidate_id $candidate_id]
    array set interview_info [recruiting::interview::get -interview_id $interview_id]
    
    ui::table::set_title delete "Deleting interview for $candidate_info(first_name) $candidate_info(last_name)"
    ui::table::set_form delete [ns_conn url]
    ui::table::add_unsorted_row delete [list "<center><br>Are you sure you want to delete $candidate_info(first_name) $candidate_info(last_name)'s interview?<br><br><input type=submit name=delete_p value=Yes> <input type=submit name=delete_p value=No><br>[export_form_vars referrer candidate_id interview_id]<br></center>"]
    
    set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] [list "list-candidates" "Candidates"] [list "view-one-candidate?[export_vars candidate_id]" "One Candidate"] "Delete Interview"]

    ad_return_template

} else {
    
    if {$delete_p == "Yes"} {
        recruiting::interview::delete -interview_id $interview_id
    }
    ns_returnredirect [ns_urldecode $referrer]

}





