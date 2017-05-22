#!/usr/bin/ruby

require 'date'
require 'etc'

use_icloud = ENV['POPCLIP_OPTION_ICLOUD'].to_s == "1"
use_mas = ENV['POPCLIP_OPTION_MAS'].to_s == "1"
user = Etc.getpwuid.name
todo_file_loc = ""
if use_icloud
    todo_file_loc = "/Users/#{user}/Library/Mobile Documents/iCloud~co~noteplan~NotePlan/Documents/Calendar/" + Date.today.strftime('%Y%m%d') + ".txt"
    noteplanData = "/Users/#{user}/Library/Mobile Documents/iCloud~co~noteplan~NotePlan/Documents/Notes/"
else
    if use_mas
        todo_file_loc = "/Users/#{user}/Library/Containers/co.noteplan.NotePlan/Data/Library/Application Support/co.noteplan.NotePlan/Calendar/" + Date.today.strftime('%Y%m%d') + ".txt"
        noteplanData = "/Users/#{user}/Library/Containers/co.noteplan.NotePlan/Data/Library/Application Support/co.noteplan.NotePlan/Notes/"
    else
        todo_file_loc = "/Users/#{user}/Library/Application Support/co.noteplan/Calendar/" + Date.today.strftime('%Y%m%d') + ".txt"
        noteplanData = "/Users/#{user}/Library/Application Support/co.noteplan/Notes/"
    end
end

input = ENV['POPCLIP_TEXT'].to_s.strip()
journal = ENV['POPCLIP_OPTION_JOURNAL'].to_s.strip()
modifier = ENV['POPCLIP_MODIFIER_FLAGS'].to_s
use_star = ENV['POPCLIP_OPTION_STARDASH'].to_s == "1"
use_bracket = ENV['POPCLIP_OPTION_BRACKET'].to_s == "1"

header = ""
if use_star
    header = "* "
else
    header = "- "
end

if use_bracket
    header = "#{header}[ ] "
end

if modifier == "0"
    #
    # No key was pressed. Save in the journal or today file
    # as the user specified.
    #
    if journal == "Today"
        #
        # Save to the current day file.
        #
        todo_file = File.open("#{todo_file_loc}")
        linesInFile = IO.readlines(todo_file)
        lines = []
        lines.push("#{header}#{input}\n")
        lines.push(linesInFile)
        IO.write(todo_file,lines.join)
        todo_file.close
        exit(0)
    else
        #
        # Save to the named journal in the Notes Directory.
        #
        note_file = File.open("#{noteplanData}#{journal}.txt")
        linesInFile = IO.readlines(note_file)
        lines = []
        lines.push(linesInFile)
        lines.push("#{header}#{input}\n")
        IO.write(note_file,lines.join)
        note_file.close
        exit(0)
    end
else
    #
    # The modifier was set. Therefore, use the predescribed
    # locations for storing the text.
    #
    if modifier == "1048576"
        #
        # Command Modifier: Force save to inbox journal.
        #
        note_file = File.open("#{noteplanData}Inbox.txt")
        linesInFile = IO.readlines(note_file)
        lines = []
        lines.push(linesInFile)
        lines.push("#{header}#{input}\n")
        IO.write(note_file,lines.join)
        note_file.close
        exit(0)
    else
        if modifier == "262144"
            #
            # Control Modifier: Force save to the current day file.
            #
            todo_file = File.open("#{todo_file_loc}")
            linesInFile = IO.readlines(todo_file)
            lines = []
            lines.push("#{header}#{input}\n")
            lines.push(linesInFile)
            IO.write(todo_file,lines.join)
            todo_file.close
            exit(0)
        end
    end
end