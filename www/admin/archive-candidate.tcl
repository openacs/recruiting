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
    {archive_p "notyet"}
}

set package_id [ad_conn package_id]
set user_id [ad_verify_and_get_user_id]

if {$archive_p == "notyet"} {
    
    array set candidate_info [recruiting_candidate::get -candidate_id $candidate_id]
    
    ui::table::set_title archive "Archiving $candidate_info(first_name) $candidate_info(last_name)"
    ui::table::set_form archive [ns_conn url]
    ui::table::add_unsorted_row archive [list "<center><br>Archiving a candidate will hide all their information from users of the system other than administrators such as yourself.<br>You will be able to unarchive the user at a later date if you so desire.<p>Are you sure you want to archive $candidate_info(first_name) $candidate_info(last_name)?.<p><input type=submit name=archive_p value=Yes> <input type=submit name=archive_p value=No><br>[export_form_vars referrer candidate_id]</center>"]
    
    set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] [list "list-candidates" "Candidates"] "Archive Candidate"]

    ad_return_template

} else {
    
    if {$archive_p == "Yes"} {
        recruiting_candidate::archive -candidate_id $candidate_id
        ns_returnredirect list-candidates
    } else {
        ns_returnredirect [ns_urldecode $referrer]
    }

}




