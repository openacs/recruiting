ad_page_contract {
    recruiting admin interface
    access admin function such as: criteria specification 
                               and interviewee status types

    @author chak (chak@openforce.net)
    @creation-date 2002-07-30
    @version $Id$
} {
    candidate_id:notnull
    search_user_id:notnull
}

set package_id [ad_conn package_id]

set node_id [ad_conn node_id]
set package_url [site_node::get_url -node_id $node_id]

set user_id [ad_conn user_id]

array set candidate_info [recruiting::candidate::get -candidate_id $candidate_id]

set candidate_name [person::name -person_id $candidate_id]
set url "[ad_parameter -package_id [ad_acs_kernel_id] SystemURL ""]$package_url"
set interviewer_name [person::name -person_id $search_user_id]
set sender_name [person::name -person_id $user_id]

form create msg
element create msg subject \
        -label "Subject:" \
        -datatype text \
        -widget text \
        -html {size 50} \
        -value "New recruiting interview assignment for you"

element create msg body \
        -label "Email:" \
        -datatype text \
        -widget textarea \
        -html {rows 10 cols 60 wrap soft} \
        -value [recruiting::email::get_body -package_id $package_id]

element create msg candidate_id \
        -widget hidden \
        -value $candidate_id

element create msg search_user_id\
        -widget  hidden \
        -value $search_user_id

if {[form is_valid msg]} {
    form get_values msg \
            subject body

    set sender_email [db_string get_sender_email {}]
    set interviewer_email [db_string get_interviewer_email {}]

    catch {ns_sendmail $interviewer_email $sender_email "$subject" "$body"} message_send_errors
    
    recruiting::interview::new \
        -interviewer_id $search_user_id \
        -candidate_id $candidate_id \
        -package_id $package_id

    ns_returnredirect view-one-candidate?[export_vars candidate_id]
    ad_script_abort
}

set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] [list "list-candidates" "Candidates"] [list "view-one-candidate?[export_vars candidate_id]" "One Candidate"] "Assign Interview"]

ad_return_template





