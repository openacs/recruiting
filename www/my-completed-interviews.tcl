ad_page_contract {
    recruiting user interface
    this page shows a logged in user their completed interviews

    @author chak (chak@openforce.net)
    @creation-date 2002-08-01
    @version $Id$
}

set package_id [ad_conn package_id]
set user_id [ad_verify_and_get_user_id]

ui::table::set_title interviews "Candidates you have interviewed"
ui::table::set_column_headings interviews [list "Name" "Location" "Average Rating" "Hiring Recommendation"]
ui::table::set_column_alignment interviews [list left left center center]
db_foreach my_completed_interviews {} {
    ui::table::add_sortable_row interviews [list "$last_name, $first_name" \
            "$location<br>Home: [recruiting_candidate::format_phone -phone_number $home_phone]<br>Mobile: [recruiting_candidate::format_phone -phone_number $cell_phone]" \
            "$average_rating" \
            "$should_hire_p" \
            "(<a href=\"rating-sheet?[export_vars interview_id]\">view my ratings</a>) (<a href=edit-ratings?[export_vars {candidate_id interview_id}]>modify interview</a>)"]
} if_no_rows {
    ui::table::add_sortable_row interviews [list "You haven't interviewed any candidates."]
}

set context_bar [list [list "index" "Recruiting"] "My Completed Interviews"]

ad_return_template





