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

table::setTitle archived "Archived Candidates"
table::setColumnHeadings archived [list "Name" "Location" "Status"]
db_foreach get_archived_candidates {} {
    table::addSortableRow archived [list "$candidate_name<br>(<a href=\"mailto:$email\">$email</a>)" \
            "$city, $state" \
            "$status" \
            "(<a href=\"unarchive-candidate?[export_vars candidate_id]\">unarchive</a>)"]
} if_no_rows {
    table::addSortableRow archived [list "There are no archived candidates.  You may <a href=index>go back to administration</a> or <a href=list-candidates>view unarchived candidates</a>."]
}


set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] "Archived Candidates"]

ad_return_template
