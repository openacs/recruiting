ad_page_contract {
    recruiting admin interface
    access admin function such as: criteria specification 
                               and interviewee status types

    @author chak (chak@openforce.net)
    @creation-date 2002-07-30
    @version $Id$
} {
    candidate_id:notnull
}

set package_id [ad_conn package_id]
set user_id [ad_verify_and_get_user_id]

array set candidate_info [recruiting::candidate::get -candidate_id $candidate_id]

ui::table::set_title comments "Comments for $candidate_info(first_name) $candidate_info(last_name)"

db_foreach get_comments {} {
    ui::table::add_unsorted_row comments [list "<b>$interviewer_name</b>: $comment<br>(<a href=view-ratings.tcl?[export_vars interview_id]>view $interviewer_name's ratings</a>)"]
}

set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] [list "list-candidates" "Candidates"] [list "view-one-candidate?[export_vars candidate_id]" "One Candidate"] "Comments"]

ad_return_template




