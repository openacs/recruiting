ad_page_contract {
    recruiting admin interface
    access admin function such as: criteria specification 
                               and interviewee status types

    @author chak (chak@openforce.net)
    @creation-date 2002-08-01
    @version $Id$
} {
    candidate_id:notnull
}

array set candidate_info [recruiting_candidate::get -candidate_id $candidate_id]

table::setTitle ratings "Average ratings for $candidate_info(first_name) $candidate_info(last_name)"
table::setColumnHeadings ratings [list "Criteria" "Average Rating"]
table::setColumnAlignment ratings [list left center]
db_foreach get_ratings_by_candidate {} {
    table::addSortableRow ratings [list "$criteria_name (<a href=view-ratings-by-criteria?[export_vars {criteria_id candidate_id}]>view all $criteria_name ratings</a>)" "$rating"]
} if_no_rows {
    table::addSortableRow ratings [list "$candidate_info(first_name) $candidate_info(last_name) has no ratings."]
}

table::setTitle summary "Summary Information"
table::addUnsortedRow summary [list "Overall rating:" [db_string get_average_rating {}]]
table::addUnsortedRow summary [list "Votes to hire:" [db_string get_hire_votes {}]]
table::addUnsortedRow summary [list "Votes against hiring:" [db_string get_no_hire_votes {}]]
set context_bar [list \
        [list "../" "Recruiting"] \
        [list "index" "Admin"] \
        [list "list-candidates" "Candidates"] \
        [list "view-one-candidate?[export_vars candidate_id]" "One Candidate"] \
        "Average Ratings"]

ad_return_template
