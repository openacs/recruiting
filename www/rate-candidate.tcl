ad_page_contract {
    recruiting user interface
    this is a rating sheet for a candidate

    @author chak (chak@openforce.net)
    @creation-date 2002-08-01
    @version $Id$
} {
    interview_id
    candidate_id
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

array set candidate_info [recruiting::candidate::get -candidate_id $candidate_id]

form create rate_sheet

set criteria_list [list]
set criteria_ids [list]

db_foreach get_criteria {} {
    element create rate_sheet criteria_$criteria_id \
        -label "<b>$criteria_name</b><br>$description" \
        -datatype integer \
        -widget radio \
        -options [list [list "1 (low)" 1] [list 2 2] [list 3 3] [list 4 4] [list "5 (high)" 5] [list "Not Applicable / Don't Know" 0]]

    lappend criteria_ids $criteria_id
    lappend criteria_list criteria_$criteria_id
}

element create rate_sheet candidate_id \
        -widget hidden \
        -value $candidate_id

element create rate_sheet interview_id \
        -widget hidden \
        -value $interview_id

element create rate_sheet should_hire_p \
        -label "Should we hire $candidate_info(first_name) $candidate_info(last_name)?" \
        -datatype text \
        -widget radio \
        -options [list [list Yes t] [list No f]]

element create rate_sheet comment \
        -label "Comments:" \
        -datatype text \
        -widget textarea \
        -html {rows 10 cols 60 wrap soft}

if {[form is_valid rate_sheet]} {
    form get_values rate_sheet \
            should_hire_p comment
    
    foreach criteria_id $criteria_ids {
        form get_values rate_sheet \
                criteria_$criteria_id

        if {[set criteria_$criteria_id] != 0} {
            recruiting::rating::new \
                -package_id $package_id \
                -interview_id $interview_id \
                -criteria_id $criteria_id \
                -rating [set criteria_$criteria_id]
        }
    }

    db_dml set_should_hire_and_comment {}

    ad_returnredirect index
    ad_script_abort
}

set context_bar [list [list "index" "Recruiting"] [list "my-new-interviews" "My New Interviews"] "One Rate Sheet"]


