ad_page_contract {
    recruiting admin interface
    access admin function such as: criteria specification 
                               and interviewee status types

    @author chak (chak@openforce.net)
    @creation-date 2002-07-30
    @version $Id$
} {
    candidate_id:notnull
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

set searching_p 1

form create assign_interview 
element create assign_interview search_user_id \
        -label "Assign interview to" \
        -datatype integer \
        -widget select \
        -options [db_list_of_lists get_all_recruiting_users {select last_name||', '||first_names,user_id from registered_users order by last_name}] 

element create assign_interview search_text \
        -label "or search:" \
        -datatype text \
        -widget text \
        -html {size 40} \
        -optional

element create assign_interview candidate_id \
        -widget hidden \
        -value $candidate_id

if {[form is_valid assign_interview]} {
    set searching_p 0
    form get_values assign_interview \
            search_text search_user_id

    if {![empty_string_p $search_text]} {

        ui::table::set_title search_results "Choose an interviewer"

        db_foreach select_users {} {
            ui::table::add_sortable_row search_results [list "<a href=assign-candidate-interview-2?[export_vars "candidate_id search_user_id"]>$last_name, $first_names ($email)</a>"]
        } if_no_rows {
            ui::table::add_sortable_row search_results [list "There were no users matching your criteria"]
        }

    } else {
        
        ns_returnredirect assign-candidate-interview-2?[export_vars {candidate_id search_user_id}]
    }
}

set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] [list "list-candidates" "Candidates"] [list "view-one-candidate?[export_vars candidate_id]" "One Candidate"] "Assign Interview"]
    
ad_return_template



