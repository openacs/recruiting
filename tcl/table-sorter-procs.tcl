# Dan Chak (chak@mit.edu)
# 4/26/2000
# Functions to create a sortable table
# ascending or descending by any column

# setSortableHeadings 
# expects 
# the table_name and a list of column headings

namespace eval table {

    proc initColors {} {
        upvar bordercolor bordercolor
        upvar innercolor  innercolor  
        upvar color1      color1
        upvar color2      color2
        upvar curclr      curclr
        upvar titleclr    titleclr
        set titleclr      "#dcdcdc"
        set bordercolor   "black"
        set innercolor    "#CCCC00"
        set color1        "#DDDDDD"
        set color2        "#CCCCCC"
        set curclr        $color1
    }

    proc startTable {{title ""} {width "100%"} {spacing 0}} {
        upvar bordercolor bordercolor
        upvar innercolor  innercolor
        upvar color1 color1
        upvar color2 color2
        if {$width != ""} {
            set widthstr "width=$width"
        } else {
            set widthstr ""
        }    
        set text "<table border=0 cellpadding=2 bgcolor=$bordercolor cellspacing=0 $widthstr >"
        if {$title != ""} {
            append text "<tr><td width=\"100%\"><font color=white>&nbsp $title &nbsp</font></td></tr>"
        }
        append text "<tr>
        <td>
        <table width=100% border=0 cellpadding=5 bgcolor=$innercolor cellspacing=$spacing>"
        return $text
    }

    proc newRow {{flags ""} {extra ""}} {
        upvar color1 color1
        upvar color2 color2
        upvar curclr curclr
        if {![regexp {nochange} $flags match match]} {
            if {$curclr == $color1} {
                set curclr $color2
            } else {
                set curclr $color1
            }
        }
        set text "<tr $extra bgcolor=$curclr>"
        return $text
    }

    proc endRow {} {
        set text "</tr>"
        return $text
    }

    proc endTable {} {
        set text "</table></td></tr></table>"
        return $text
    }

    proc titleRow {{extra ""}} {
        upvar titleclr titleclr
        set text "<tr $extra bgcolor=$titleclr>"
        return $text
    }

    proc titleEntry {txt {align "left"} {extra ""}} {
        return "<td align=$align $extra><font size=-1><b>$txt</b></font></td>"
    }

    proc titleSortEntry {txt url {align "left"} {extra ""}} {
        return "<td align=$align $extra><font size=-1><b><a href=$url>$txt</a></b></font></td>"
    }

    proc ui_columns {cell_list {tableoptions ""}} {
        set cell_start "<td valign=top>"
        return "<table border=0 $tableoptions><tr>$cell_start[join $cell_list "</td>$cell_start"]</td></tr></table>"
    }

    proc ui_equal_columns {cell_list {width 100%}} {
        set cell_width [expr 100 / [llength $cell_list]]
        set cell_start "<td valign=top width=$cell_width%>"
        return "<table border=0 width=$width><tr>$cell_start[join $cell_list "</td>$cell_start"]</td></tr></table>"
    }
    proc is_number {text} {
        regexp {[0-9]*\.[0-9]*} $text match
        return [info exist match]
    }

    
    ##
    ## sortable table procs
    ## 

    proc setTitle {table_name table_title} {
        upvar $table_name\_title title
        set title $table_title
    }

    proc setForm {table_name action_url {options ""}} {
        upvar $table_name\_form form_action_url
        regexp {.*-file.*} $options match
        if {[info exists match]} {
            set form_action_url "action=$action_url enctype=multipart/form-data method=post"
        } else {
            set form_action_url "action=$action_url method=post"
        }
    }

    proc setColumnHeadings {table_name heading_list} {
        upvar $table_name\_headings headings
        upvar $table_name\_max_columns max_columns
        set headings $heading_list
        if {![info exist max_columns]} {set max_columns 0}
        if {[llength $heading_list] > $max_columns} {
            set max_columns [llength $heading_list]
        }
    }

    proc setColumnAlignment {table_name align_list} {
        ns_log notice "set align list to $align_list"
        upvar $table_name\_aligns aligns
        set aligns $align_list
    }

    proc setColumnWidths {table_name width_list} {
        upvar $table_name\_widths widths
        set widths $width_list
    }

    proc setExportVars {table_name vars} {
        upvar $table_name\_export_vars table_export_vars
        set table_export_vars "$vars&"
    }

    # addSortableRow
    # table_name is the name of the table we are creating
    # row is a list of the row elements
    proc addSortableRow {table_name row} {
        upvar $table_name the_table
        upvar $table_name\_max_columns max_columns
        if {![info exists the_table]} {
            #	set the_table ""
        }
        set the_table [lappend the_table $row]

        if {![info exist max_columns]} {set max_columns 0}
        if {[llength $row] > $max_columns} {
            set max_columns [llength $row]
        }
    }

    proc addUnsortedRow {table_name row} {
        upvar $table_name\_unsorted unsorted
        upvar $table_name\_max_columns max_columns
        set unsorted [lappend unsorted $row]

        if {![info exist max_columns]} {set max_columns 0}
        if {[llength $row] > $max_columns} {
            set max_columns [llength $row]
        }
    }

    proc outputTable {table_name {table_title ""} {width "100%"}} {
        # _sort_column and _sort_order should exist
        # otherwise no sorting
        
        upvar $table_name\_sort_column sort_column
        upvar $table_name\_sort_order  sort_order
        upvar $table_name the_table
        upvar $table_name\_unsorted unsorted
        upvar $table_name\_title the_title
        upvar $table_name\_headings headings
        upvar $table_name\_aligns aligns
        upvar $table_name\_widths widths
        upvar $table_name\_form form_action_url
        upvar $table_name\_max_columns max_columns
        upvar $table_name\_export_vars table_export_vars
        
        if {![info exists sort_column]} {
            set sort_column 0
        }
        if {![info exists sort_order]} {
            set sort_order increasing
        }
        # kludge until all tables are updated for titling...
        if {[info exists the_title]} {
            set table_title $the_title
        }
        if {![info exists table_export_vars]} {
            set table_export_vars ""
        }
        initColors

        if {![info exists the_table] && ![info exists unsorted]} {
            return "
            [startTable $table_title "$width"]
            [newRow]
            <td><i>No data.</i></td>
            [endRow]\n
            [endTable]"
        }

        # sort
        ad_page_variables "\"$table_name\_sort_column 0\" \"$table_name\_sort_order increasing\""
        if {[info exists the_table]} {
            set the_table [lsort -dictionary -[set $table_name\_sort_order] -index [set $table_name\_sort_column] $the_table]
        }
        
        if {[info exists form_action_url]} {
            append txt "<form $form_action_url>"
        }

        append txt "
        [startTable $table_title "$width"]"
        set i 0

        if {[info exists headings]} {
            append txt "[titleRow]"
            foreach heading $headings { 
                if {"$i" == "[set $table_name\_sort_column]"} {
                    if {"[set $table_name\_sort_order]" == "increasing"} {
                        set order_txt "decreasing"
                    } else {
                        set order_txt "increasing"
                    }
                } else {
                    set order_txt "increasing"
                }
                if {[info exist aligns]} {
                    set this_align [lindex $aligns $i]
                } else {
                    set this_align left
                }
                if {[info exist widths]} {
                    set this_width "width=[lindex $widths $i]"
                } else {
                    set this_width ""
                }
                append txt "
                [titleEntry "<a href=[ns_conn url]?$table_export_vars$table_name\_sort_order=$order_txt&$table_name\_sort_column=$i>$heading</a>" $this_align $this_width]"
                incr i
            }
            for {set j $i} {$j < $max_columns} {incr j} {
                append txt "[titleEntry "&nbsp;"]"
            }
            append txt "[endRow]\n"
        }
            

        if {[info exists the_table]} {
            ns_log notice "table $table_name contains sortable rows"
            foreach row $the_table {
                append txt "[newRow]"
                set i 0
                foreach element $row {
                    if {[info exist aligns]} {
                        set this_align [lindex $aligns $i]
                    } else {
                        set this_align left
                    }
                    if {[string compare "$element" ""] == 0} {
                        set element "&nbsp"
                    }
                    if {[info exist widths]} {
                        set this_width "width=[lindex $widths $i]"
                    } else {
                        set this_width ""
                    }
                    append txt "<td align=$this_align $this_width>$element</td>"
                    incr i
                }
                for {set j $i} {$j < $max_columns} {incr j} {
                    append txt "[titleEntry "&nbsp;"]"
                }
                append txt "[endRow]\n"
            }
        }

        # and the unsorted part
        if {[info exists unsorted]} {
            foreach row $unsorted {
                append txt "[newRow]"
                set i 0
                foreach element $row {
                    if {[info exist aligns]} {
                        set this_align [lindex $aligns $i]
                    } else {
                        set this_align left
                    }
                    if {[string compare "$element" ""] == 0} {
                        set element "&nbsp"
                    }
                    if {[info exist widths]} {
                        set this_width "width=[lindex $widths $i]"
                    } else {
                        set this_width ""
                    }
                    append txt "<td align=$this_align $this_width>$element</td>"
                    incr i
                }
                for {set j $i} {$j < $max_columns} {incr j} {
                    append txt "[titleEntry "&nbsp;"]"
                }
                append txt "[endRow]\n"
            }
        }

        append txt "[endTable]"
        if {[info exist form_action_url]} {
            append txt "</form>"
        }
        return $txt
    }

}
