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

table::setTitle enabled "Candidate Status Types"
db_foreach get_enabled_status_types {} {
    table::addSortableRow enabled [list "$short_desc" "(<a href=\"edit-status-type?[export_vars status_type_id]\">edit</a>) (<a href=\"disable-status-type?[export_vars status_type_id]\">disable</a>)"]
} if_no_rows {
    table::addSortableRow enabled [list "There are no status types.  (<a href=new-status-type>create one</a>)"]
}

table::setTitle disabled "Disabled Candidate Status Types"
db_foreach get_disabled_status_types {} {
    table::addSortableRow disabled [list "$short_desc" "(<a href=\"enable-status-type?[export_vars status_type_id]\">enable</a>)"]
} if_no_rows {
    table::addSortableRow disabled [list "There are no disabled status types"]
}

table::setTitle options "Options"
table::addUnsortedRow options [list "<a href=\"new-status-type\">Add new status type</a>"]

set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] "Status Types"]

ad_return_template
