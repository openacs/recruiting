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
set user_id [ad_verify_and_get_user_id]

array set info [recruiting_candidate::get \
        -candidate_id $candidate_id]


set address "$info(address1)<br>"
if {![empty_string_p "$info(address2)"]} {
    append address "$info(address2)"
}
append address "$info(city), $info(state) $info(zip)"
if {![empty_string_p "$info(zip_plus_four)"]} {
    append address "-$zip_plus_four"
}
append address " $info(country)"

table::setTitle candidate "Recruiting Candidate Detail"
table::addUnsortedRow candidate [list "Name:" "$info(last_name), $info(first_name)"]
table::addUnsortedRow candidate [list "Address:" "$address"]
table::addUnsortedRow candidate [list "Status:" "$info(status) (<a href=change-candidate-status?candidate_id=$info(candidate_id)>change status</a>)"]

set possible_ratings [db_string get_num_criteria {}]

table::setTitle interviews "Interviews for this candidate"
table::setColumnHeadings interviews [list "Interviewer" "Ratings"]
table::setExportVars interviews [export_vars candidate_id]

db_foreach get_interviews {} {
    table::addUnsortedRow interviews [list "$last_name, $first_names" "$num_ratings out of $possible_ratings"]
} if_no_rows {
    table::addUnsortedRow interviews [list "No Interviews assigned. (<a href=assign-candidate-interview?[export_vars candidate_id]>assign one</a>)"]
}

table::setTitle options "Options"
table::addUnsortedRow options [list "<a href=edit-candidate?[export_vars candidate_id]>Edit Information</a>"]
table::addUnsortedRow options [list "<a href=change-candidate-status?[export_vars candidate_id]>Change Status</a>"]
table::addUnsortedRow options [list "<a href=assign-candidate-interview?[export_vars candidate_id]>Assign Interview</a>"]

set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] [list "list-candidates" "Candidates"] "One Candidate"]

ad_return_template
