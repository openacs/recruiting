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

db_multirow enabled_criteria_types get_enabled_criteria_types "" {
    set disable_url "disable-criteria?[export_vars criteria_id]"
}

db_multirow disabled_criteria_types get_disabled_criteria_types "" {
    set enable_url "enable-criteria?[export_vars criteria_id]"
}

