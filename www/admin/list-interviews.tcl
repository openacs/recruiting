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

ui::table::set_title interviews "Pending Interviews"
ui::table::set_column_headings interviews [list "Candidate" "Interviewer" "Assigned"]
db_foreach pending_interviews {} {
    ui::table::add_sortable_row interviews [list "$candidate_name" "$interviewer_name" "$assigned_date"]
} if_no_rows {
    ui::table::add_sortable_row interviews [list "There are no pending interviews"]
}

set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] "Pending Interviews"]




