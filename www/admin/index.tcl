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

table::setTitle options "Recruiting Administration Options"
table::addUnsortedRow options [list "<a href=list-candidates>Candidate Administration</a>"]
table::addUnsortedRow options [list "<a href=list-status-types.tcl>Candidate status types</a>"]
table::addUnsortedRow options [list "<a href=list-criteria>Interview criteria Administration</a>"]

table::setTitle summary "Summary Information"
table::addUnsortedRow summary [list "Summary Info will go here"]

set context_bar [list [list "../" "Recruiting"] "Admin"]
