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

db_1row status_types_defined_p {}
db_1row criteria_defined_p {}

if {!$status_types_defined_p} {
    set status_types_msg "<br><font color=red>There are no status types defined.  You must define status types before you can add and adminster candidates.</font>"
} else {
    set status_types_msg ""
}

if {!$criteria_defined_p} {
    set criteria_msg "<br><font color=red>No interview criteria has been defined.  You should define some interview criteria before you begin assigning interviews.</font>"
} else {
    set criteria_msg ""
}

ui::table::set_title setup "Setup"
ui::table::add_unsorted_row setup [list "<a href=list-status-types.tcl>Candidate status types</a>$status_types_msg"]
ui::table::add_unsorted_row setup [list "<a href=list-criteria>Interview criteria</a>$criteria_msg"]
ui::table::add_unsorted_row setup [list "<a href=email-options>Email options</a>"]

db_1row get_num_candidates {}
db_1row get_pending_interviews {}
db_1row get_num_archived_candidates {}

ui::table::set_title summary "Summary Information"
ui::table::add_unsorted_row summary [list "Candidates: $num_candidates" "(<a href=list-candidates>candidate administration</a>)"]
ui::table::add_unsorted_row summary [list "Pending Interviews: $pending_interviews" "(<a href=\"list-interviews\">view interviews</a>)"]
ui::table::add_unsorted_row summary [list "$num_archived_candidates candidates have been archived" "(<a href=\"list-archived-candidates\">view archived candidates</a>)"] 

set context_bar [list [list "../" "Recruiting"] "Admin"]

ad_return_template

