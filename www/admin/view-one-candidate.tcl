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

set referrer [ns_urlencode [ns_conn url]?[export_vars candidate_id]]

array set info [recruiting::candidate::get \
        -candidate_id $candidate_id]


set address "$info(address1)<br>"
if {![empty_string_p "$info(address2)"]} {
    append address "$info(address2)<br>"
}
append address "$info(city), $info(state) $info(zip)"
if {![empty_string_p "$info(zip_plus_four)"]} {
    append address "-$zip_plus_four"
}
append address " $info(country)"

ui::table::set_title candidate "Recruiting Candidate Detail"
ui::table::add_unsorted_row candidate [list "Name:" "$info(last_name), $info(first_name)"]
ui::table::add_unsorted_row candidate [list "Address:" "$address"]
ui::table::add_unsorted_row candidate [list "Home Phone:" "[recruiting::candidate::format_phone -phone_number $info(home_phone)]"]
ui::table::add_unsorted_row candidate [list "Mobile Phone:" "[recruiting::candidate::format_phone -phone_number $info(cell_phone)]"]
ui::table::add_unsorted_row candidate [list "Status:" "$info(status) (<a href=change-candidate-status?candidate_id=$info(candidate_id)>change status</a>)"]

set possible_ratings [db_string get_num_criteria {}]

ui::table::set_title interviews "Interviews for this candidate"
ui::table::set_column_headings interviews [list \
        "Interviewer" \
        "Completed?" \
        "Average Rating" \
        "Recommends Hiring"
]

ui::table::set_column_alignment interviews [list left center center center]
ui::table::set_export_vars interviews [export_vars candidate_id]
db_foreach get_interviews {} {
    ui::table::add_unsorted_row interviews [list \
            "$last_name, $first_names" \
            "$completed_p" \
            "[db_string get_average_rating {}]" \
            "[db_string get_should_hire_p {}]" \
            "(<a href=view-ratings?[export_vars interview_id]>view ratings</a>)
    (<a href=view-comments?[export_vars candidate_id]>view comments</a>)
    (<a href=delete-interview?[export_vars {interview_id candidate_id referrer}]>delete</a>)"]
} if_no_rows {
    ui::table::add_unsorted_row interviews [list "No Interviews assigned. (<a href=assign-candidate-interview?[export_vars candidate_id]>assign one</a>)"]
}
ui::table::add_unsorted_row interviews [list "" "" "" "" "(<a href=view-average-ratings?[export_vars candidate_id]>view average ratings</a>)"]

ui::table::set_title options "Options"
ui::table::add_unsorted_row options [list "<a href=edit-candidate?[export_vars candidate_id]>Edit Information</a>"]
ui::table::add_unsorted_row options [list "<a href=change-candidate-status?[export_vars candidate_id]>Change Status</a>"]
ui::table::add_unsorted_row options [list "<a href=assign-candidate-interview?[export_vars candidate_id]>Assign Interview</a>"]
ui::table::add_unsorted_row options [list "<a href=archive-candidate?[export_vars {candidate_id referrer}]>Archive this candidate</a>"]
ui::table::add_unsorted_row options [list "<a href=delete-candidate?[export_vars {candidate_id referrer}]>Delete this candidate</a>"]

set attach_url [attachments::add_attachment_url -object_id $candidate_id -return_url "[ns_conn url]?[export_vars candidate_id]"]

ui::table::set_title resume "Resume"
ui::table::add_unsorted_row resume [list "No resume uploaded.  (<a href=\"$attach_url\">upload a resume</a>)"]


set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] [list "list-candidates" "Candidates"] "One Candidate"]

ad_return_template







