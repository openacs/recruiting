ad_page_contract {
    recruiting admin interface
    access admin function such as: criteria specification 
                               and interviewee status types

    @author chak (chak@openforce.net)
    @creation-date 2002-07-30
    @version $Id$
} {
    status_type_id:notnull
}

set package_id [ad_conn package_id]
set user_id [ad_verify_and_get_user_id]

db_dml enable_status_type {}

ns_returnredirect list-status-types
