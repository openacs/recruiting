ad_page_contract {
    recruiting admin interface
    access admin function such as: criteria specification 
                               and interviewee status types

    @author chak (chak@openforce.net)
    @creation-date 2002-08-01
    @version $Id$
} {
    interview_id:notnull
}

array set interview_info [recruiting::interview::get -interview_id $interview_id]
array set candidate_info [recruiting::candidate::get -candidate_id $interview_info(candidate_id)]

set interviewer_id $interview_info(interviewer_id)
set candidate_id $interview_info(candidate_id)

db_1row get_interviewer_info {}

ui::table::set_title ratings "$interviewer_name\'s ratings for $candidate_info(first_name) $candidate_info(last_name)"
ui::table::set_column_headings ratings [list "Criteria" "Rating"]
ui::table::set_column_alignment ratings [list left center]
ui::table::set_export_vars ratings [export_vars interview_id]

db_foreach get_ratings {} {
    ui::table::add_sortable_row ratings [list "<b>$criteria_name</b> (<a href=view-ratings-by-criteria?[export_vars {candidate_id criteria_id}]>view all $criteria_name ratings</a>)<br>$description" "<b>$rating</b>"]
} if_no_rows {
    ui::table::add_sortable_row ratings [list "$interviewer_name has not made any ratings for $candidate_info(first_name) $candidate_info(last_name)"]
}

ui::table::set_title summary "Summary Info"
ui::table::add_unsorted_row summary [list "Interviewed by:" "$interviewer_name<br><a href=mailto:$interviewer_email>$interviewer_email</a>"]
ui::table::add_unsorted_row summary [list "Average rating:" [db_string get_average_rating {}]]
ui::table::add_unsorted_row summary [list "Hiring suggestion:" [db_string get_should_hire_p {}]]

ui::table::set_title comments "Comments"
ui::table::add_unsorted_row comments [list $interview_info(comment)]

set context_bar [list \
        [list "../" "Recruiting"] \
        [list "index" "Admin"] \
        [list "list-candidates" "Candidates"] \
        [list "view-one-candidate?candidate_id=$interview_info(candidate_id)" "One Candidate"] \
        "Interview Ratings"]

ad_return_template









