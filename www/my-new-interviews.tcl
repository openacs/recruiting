ad_page_contract {
    recruiting user interface
    this page shows a logged in user their to-be-completed interviews

    @author chak (chak@openforce.net)
    @creation-date 2002-08-01
    @version $Id$
}

set package_id [ad_conn package_id]
set user_id [ad_verify_and_get_user_id]

table::setTitle interviews "Candidates for you to interview"
table::setColumnHeadings interviews [list "Name" "Location"]
db_foreach my_new_interviews {} {
    table::addSortableRow interviews [list "$last_name, $first_name" "$location" "(<a href=\"rate-candidate?[export_vars {interview_id candidate_id}]\">rate this candidate</a>)"]
} if_no_rows {
    table::addSortableRow interviews [list "You don't have any candidates to interview right now."]
}

set context_bar [list [list "index" "Recruiting"] "My New Interviews"]

ad_return_template
