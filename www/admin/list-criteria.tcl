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

ui::table::set_title enabled "Candidate Criteria"
db_foreach get_enabled_criteria_types {} {
    ui::table::add_unsorted_row enabled [list "$criteria_name" "(<a href=\"edit-criteria?[export_vars criteria_id]\">edit</a>) (<a href=\"disable-criteria?[export_vars criteria_id]\">disable</a>)"]
}  if_no_rows {
    ui::table::add_unsorted_row enabled [list "There is no criteria defined yet.  (<a href=new-criteria>Add Criteria</a>)"]
}


ui::table::set_title disabled "Disabled Criteria"
db_foreach get_disabled_criteria_types {} {
    ui::table::add_unsorted_row disabled [list "$criteria_name" "(<a href=\"enable-criteria?[export_vars criteria_id]\">enable</a>)"]
} if_no_rows {
    ui::table::add_unsorted_row disabled [list "There are no disabled criteria"]
}

ui::table::set_title options "Options"
ui::table::add_unsorted_row options [list "<a href=\"new-criteria\">Add New Criteria</a>"]

set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] "Criteria Types"]

ad_return_template



