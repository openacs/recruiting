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

db_multirow enabled_status_types get_enabled_status_types {} {
    set disable_url "disable-status-type?[export_vars status_type_id]"
}

db_multirow disabled_status_types get_disabled_status_types {} {
    set enable_url "enable-status-type?[export_vars status_type_id]"
}

set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] "Status Types"]

ad_return_template
