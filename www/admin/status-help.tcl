ad_page_contract {
    recruiting admin interface
    list status type definitions

    @author chak (chak@openforce.net)
    @creation-date 2002-07-31
    @version $Id$
}

set package_id [ad_conn package_id]
set user_id [ad_verify_and_get_user_id]

table::setColumnHeadings types [list "Choose this..." "When"]
db_foreach get_status_types {} {
    table::addSortableRow types [list "<b>$short_desc</b>" "$long_desc"]
}

ad_return_template