ad_page_contract {
    recruiting user interface

    @author chak (chak@openforce.net)
    @creation-date 2002-08-01
    @version $Id$
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

set new_interviews [db_string num_new_interviews {}]
set old_interviews [db_string num_old_interviews {}]

ui::table::set_title summary "Your Recruiting Summary"

if {$new_interviews} {
    ui::table::add_unsorted_row summary [list "You have <a href=my-new-interviews><b>$new_interviews</b> new interviews</a> to complete."]
} else {
    ui::table::add_unsorted_row summary [list "You don't have any new interviews to complete."]
}

if {$old_interviews} {
    ui::table::add_unsorted_row summary [list "You may view your $old_interviews <a href=my-completed-interviews>completed interviews</a>."]
}

set context_bar [list "Recruiting"]



