ad_page_contract {
    recruiting admin interface
    access admin function such as: criteria specification 
                               and interviewee status types

    @author chak (chak@openforce.net)
    @creation-date 2002-07-30
    @version $Id$
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

set referrer [ns_urlencode [ns_conn url]]

ui::table::set_title candidates "Recruiting Candidates"
ui::table::set_column_headings candidates [list "Name" "Location" "Status" "Interviews"]
ui::table::set_column_alignment candidates [list left left left center left]
db_foreach get_candidates {} {
    ui::table::add_sortable_row candidates [list "$first_name $last_name<br>(<a href=\"mailto:$email\">$email</a>)" \
            "$city, $state" \
            "$status" \
            "$num_completed_interviews out of $num_interviews<br>completed" \
            "(<a href=\"view-one-candidate?[export_vars candidate_id]\">details</a>) (<a href=delete-candidate?[export_vars {candidate_id referrer}]>Delete this candidate</a>)"]
} if_no_rows {
    ui::table::add_sortable_row candidates [list "No Candidates"]
}

ui::table::set_title options "Options"
ui::table::add_unsorted_row options [list "<a href=new-candidate>Add a new candidate</a>"]
ui::table::add_unsorted_row options [list "<a href=list-archived-candidates>View archived candidates</a>"]

set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] "Candidates"]

ad_return_template






