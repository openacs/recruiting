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

array set interview_info [recruiting_interview::get -interview_id $interview_id]
array set candidate_info [recruiting_candidate::get -candidate_id $interview_info(candidate_id)]

set interviewer_id $interview_info(interviewer_id)
set candidate_id $interview_info(candidate_id)

db_1row get_interviewer_info {}

table::setTitle ratings "$interviewer_name\'s ratings for $candidate_info(first_name) $candidate_info(last_name)"
table::setColumnHeadings ratings [list "Criteria" "Rating"]
table::setColumnAlignment ratings [list left center]
table::setExportVars ratings [export_vars interview_id]

db_foreach get_ratings {} {
    table::addSortableRow ratings [list "<b>$criteria_name</b> (<a href=view-ratings-by-criteria?[export_vars {candidate_id criteria_id}]>view all $criteria_name ratings</a>)<br>$description" "<b>$rating</b>"]
} if_no_rows {
    table::addSortableRow ratings [list "$interviewer_name has not made any ratings for $candidate_info(first_name) $candidate_info(last_name)"]
}

table::setTitle summary "Summary Info"
table::addUnsortedRow summary [list "Interviewed by:" "$interviewer_name<br><a href=mailto:$interviewer_email>$interviewer_email</a>"]
table::addUnsortedRow summary [list "Average rating:" [db_string get_average_rating {}]]
table::addUnsortedRow summary [list "Hiring suggestion:" [db_string get_should_hire_p {}]]

table::setTitle comments "Comments"
table::addUnsortedRow comments [list $interview_info(comment)]

set context_bar [list \
        [list "../" "Recruiting"] \
        [list "index" "Admin"] \
        [list "list-candidates" "Candidates"] \
        [list "view-one-candidate?candidate_id=$interview_info(candidate_id)" "One Candidate"] \
        "Interview Ratings"]

ad_return_template
