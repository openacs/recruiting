ad_page_contract {
    recruiting user interface

    @author chak (chak@openforce.net)
    @creation-date 2002-08-01
    @version $Id$
} {
    interview_id
}

set package_id [ad_conn package_id]
set user_id [ad_verify_and_get_user_id]

array set interview_info [recruiting_interview::get -interview_id $interview_id]

if {$user_id != $interview_info(interviewer_id)} {
    
    ad_script_abort
}

array set candidate_info [recruiting_candidate::get -candidate_id $interview_info(candidate_id)]

set interviewer_id $interview_info(interviewer_id)
set candidate_id $interview_info(candidate_id)

table::setTitle ratings "Your ratings for $candidate_info(first_name) $candidate_info(last_name)"
table::setColumnHeadings ratings [list "Criteria" "Rating"]
table::setColumnAlignment ratings [list left center]
table::setExportVars ratings [export_vars interview_id]

db_foreach get_ratings {} {
    table::addSortableRow ratings [list "<b>$criteria_name</b><br>$description" "<b>$rating</b>"]
} if_no_rows {
    table::addSortableRow ratings [list "You has not made any ratings for $candidate_info(first_name) $candidate_info(last_name)"]
}

table::setTitle summary "Summary Info"
table::addUnsortedRow summary [list "Average rating:" [db_string get_average_rating {}]]
table::addUnsortedRow summary [list "Hiring suggestion:" [db_string get_should_hire_p {}]]

set context_bar [list \
        [list "index" "Recruiting"] \
        [list "my-completed-interviews" "My Completed Interviews"] \
        "Interview Ratings"]

ad_return_template
