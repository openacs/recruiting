ad_page_contract {
    recruiting admin interface
    access admin function such as: criteria specification 
                               and interviewee status types

    @author chak (chak@openforce.net)
    @creation-date 2002-07-30
    @version $Id$
}

set package_id [ad_conn package_id]
set user_id [ad_verify_and_get_user_id]

table::setTitle candidates "Recruiting Candidates"
table::setColumnHeadings candidates [list "Name" "Location" "Status"]
db_foreach get_candidates {} {
    table::addSortableRow candidates [list "$first_name $last_name" "$city, $state" "$status" "(<a href=\"mailto:$email\">email</a>) (<a href=\"view-one-candidate?[export_vars candidate_id]\">details</a>)"]
} if_no_rows {
    table::addSortableRow candidates [list "No Candidates"]
}

table::setTitle options "Options"
table::addUnsortedRow options [list "<a href=new-candidate>Add a new candidate</a>"]

set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] "Candidates"]

ad_return_template
