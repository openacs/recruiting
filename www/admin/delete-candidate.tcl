ad_page_contract {
    recruiting admin interface
    access admin function such as: criteria specification 
                               and interviewee status types

    @author chak (chak@openforce.net)
    @creation-date 2002-07-30
    @version $Id$
} {
    candidate_id:notnull
    referrer:notnull
    {delete_p "notyet"}
}

set package_id [ad_conn package_id]
set user_id [ad_verify_and_get_user_id]

if {$delete_p == "notyet"} {
    
    array set candidate_info [recruiting_candidate::get -candidate_id $candidate_id]
    
    ui::table::set_title delete "Deleting $candidate_info(first_name) $candidate_info(last_name)"
    ui::table::set_form delete [ns_conn url]
    ui::table::add_unsorted_row delete [list "<center><br>This will completely remove this candidate and all their information from the system.<br>If instead all you want to do is make this candidate invisible, <a href=\"archive-candidate?[export_vars {candidate_id referrer}]\">archive them</a> instead.<br>Are you sure you want to delete $candidate_info(first_name) $candidate_info(last_name)?.<p><input type=submit name=delete_p value=Yes> <input type=submit name=delete_p value=No><br>[export_form_vars referrer candidate_id]</center>"]
    
    set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] [list "list-candidates" "Candidates"] "Delete Candidate"]

    ad_return_template

} else {
    
    if {$delete_p == "Yes"} {
        recruiting_candidate::delete -candidate_id $candidate_id
        ns_returnredirect list-candidates
    } else {
        ns_returnredirect [ns_urldecode $referrer]
    }

}




