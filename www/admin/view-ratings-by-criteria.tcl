ad_page_contract {
    recruiting admin interface
    access admin function such as: criteria specification 
                               and interviewee status types

    @author chak (chak@openforce.net)
    @creation-date 2002-08-01
    @version $Id$
} {
    candidate_id:notnull
    criteria_id:notnull
}

array set candidate_info [recruiting_candidate::get -candidate_id $candidate_id]
array set criteria_info [recruiting_criteria::get -criteria_id $criteria_id]

table::setTitle ratings "$criteria_info(criteria_name) ratings for $candidate_info(first_name) $candidate_info(last_name)"
table::setColumnHeadings ratings [list "Interviewer" "$criteria_info(criteria_name) Rating"]
table::setColumnAlignment ratings [list left center]
db_foreach get_ratings_by_criteria {} {
    table::addSortableRow ratings [list "$interviewer_name (<a href=view-ratings?[export_vars interview_id]>view all ratings</a>)" "$rating"]
} if_no_rows {
    table::addSortableRow ratings [list "$candidate_info(first_name) $candidate_info(last_name) has no $criteria_info(criteria_name) ratings."]
}

table::setTitle summary "Summary Information"
table::addUnsortedRow summary [list "Average rating:" [db_string get_average_rating_by_criteria {}]]

set context_bar [list \
        [list "../" "Recruiting"] \
        [list "index" "Admin"] \
        [list "list-candidates" "Candidates"] \
        [list "view-one-candidate?[export_vars candidate_id]" "One Candidate"] \
        "Criteria Ratings"]

ad_return_template
