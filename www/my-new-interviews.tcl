ad_page_contract {
    recruiting user interface
    this page shows a logged in user their to-be-completed interviews

    @author chak (chak@openforce.net)
    @creation-date 2002-08-01
    @version $Id$
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

ui::table::set_title interviews "Candidates for you to interview"
ui::table::set_column_headings interviews [list "Name" "Location"]
db_foreach my_new_interviews {} {
    ui::table::add_sortable_row interviews [list "$last_name, $first_name" \
            "$location<br>Home: [recruiting::candidate::format_phone -phone_number $home_phone]<br>Mobile: [recruiting::candidate::format_phone -phone_number $cell_phone]" \
            "(<a href=\"rate-candidate?[export_vars {interview_id candidate_id}]\">rate this candidate</a>)"]
} if_no_rows {
    ui::table::add_sortable_row interviews [list "You don't have any candidates to interview right now."]
}

set context_bar [list [list "index" "Recruiting"] "My New Interviews"]

ad_return_template





