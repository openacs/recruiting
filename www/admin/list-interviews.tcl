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

table::setTitle interviews "Pending Interviews"
table::setColumnHeadings interviews [list "Candidate" "Interviewer" "Assigned"]
db_foreach pending_interviews {} {
    table::addSortableRow interviews [list "$candidate_name" "$interviewer_name" "$assigned_date"]
} if_no_rows {
    table::addSortableRow interviews [list "There are no pending interviews"]
}

set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] "Pending Interviews"]
