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

ui::table::set_title ratings "Your ratings for $candidate_info(first_name) $candidate_info(last_name)"
ui::table::set_column_headings ratings [list "Criteria" "Rating"]
ui::table::set_column_alignment ratings [list left center]
ui::table::set_export_vars ratings [export_vars interview_id]

db_foreach get_ratings {} {
    ui::table::add_sortable_row ratings [list "<b>$criteria_name</b><br>$description" "<b>$rating</b>"]
} if_no_rows {
    ui::table::add_sortable_row ratings [list "You has not made any ratings for $candidate_info(first_name) $candidate_info(last_name)"]
}

ui::table::set_title summary "Summary Info"
ui::table::add_unsorted_row summary [list "Average rating:" [db_string get_average_rating {}]]
ui::table::add_unsorted_row summary [list "Hiring suggestion:" [db_string get_should_hire_p {}]]

ui::table::set_title comments "Comments"
ui::table::add_unsorted_row comments [list $interview_info(comment)]

set context_bar [list \
        [list "index" "Recruiting"] \
        [list "my-completed-interviews" "My Completed Interviews"] \
        "Interview Ratings"]

ad_return_template







