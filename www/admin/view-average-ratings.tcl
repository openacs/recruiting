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

ui::table::set_title ratings "Average ratings for $candidate_info(first_name) $candidate_info(last_name)"
ui::table::set_column_headings ratings [list "Criteria" "Average Rating"]
ui::table::set_column_alignment ratings [list left center]
db_foreach get_ratings_by_candidate {} {
    ui::table::add_sortable_row ratings [list "$criteria_name (<a href=view-ratings-by-criteria?[export_vars {criteria_id candidate_id}]>view all $criteria_name ratings</a>)" "$rating"]
} if_no_rows {
    ui::table::add_sortable_row ratings [list "$candidate_info(first_name) $candidate_info(last_name) has no ratings."]
}

ui::table::set_title summary "Summary Information"
ui::table::add_unsorted_row summary [list "Overall rating:" [db_string get_average_rating {}]]
ui::table::add_unsorted_row summary [list "Votes to hire:" [db_string get_hire_votes {}]]
ui::table::add_unsorted_row summary [list "Votes against hiring:" [db_string get_no_hire_votes {}]]
set context_bar [list \
        [list "../" "Recruiting"] \
        [list "index" "Admin"] \
        [list "list-candidates" "Candidates"] \
        [list "view-one-candidate?[export_vars candidate_id]" "One Candidate"] \
        "Average Ratings"]

ad_return_template






