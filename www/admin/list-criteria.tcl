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

table::setTitle enabled "Candidate Criteria"
db_foreach get_enabled_criteria_types {} {
    table::addUnsortedRow enabled [list "$criteria_name" "(<a href=\"edit-criteria?[export_vars criteria_id]\">edit</a>) (<a href=\"disable-criteria?[export_vars criteria_id]\">disable</a>)"]
}

table::setTitle disabled "Disabled Criteria"
db_foreach get_disabled_criteria_types {} {
    table::addUnsortedRow disabled [list "$criteria_name" "(<a href=\"enable-criteria?[export_vars criteria_id]\">enable</a>)"]
   
}

table::setTitle options "Options"
table::addUnsortedRow options [list "<a href=\"new-criteria\">Add New Criteria</a>"]

set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] "Criteria Types"]

ad_return_template
