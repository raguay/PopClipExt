#!/usr/bin/env ruby
# encoding: utf-8

require "./findBiblicalInfo.rb"

$bookNames = Hash.new
$bookNames['Genesis']='ปฐมกาล'
$bookNames['Exodus']='อพยพ'
$bookNames['Leviticus']='เลวีนิติ'
$bookNames['Numbers']='กันดารวิถี'
$bookNames['Deuteronomy']='เฉลยธรรมบัญญัติ'
$bookNames['Joshua']='โยชูวา'
$bookNames['Judges']='ผู้วินิจฉัย'
$bookNames['Ruth']='นางรูธ'
$bookNames['1 Samuel']='1ซามูเอล'
$bookNames['2 Samuel']='2ซามูเอล'
$bookNames['1 Kings']='1พงศ์กษัตริย์'
$bookNames['2 Kings']='2พงศ์กษัตริย์'
$bookNames['1 Chronicles']='1พงศาวดาร'
$bookNames['2 Chronicles']='2พงศาวดาร'
$bookNames['Ezra']='เอสรา'
$bookNames['Nehemiah']='เนหะมีย์'
$bookNames['Esther']='เอสเธอร์'
$bookNames['Job']='โยบ'
$bookNames['Psalms']='สดุดี'
$bookNames['Proverbs']='สุภาษิต'
$bookNames['Ecclesiastes']='ปัญญาจารย์'
$bookNames['SongofSongs']='เพลงซาโลมอน'
$bookNames['Isaiah']='อิสยาห์'
$bookNames['Jeremiah']='เยเรมีย์'
$bookNames['Lamentations']='เพลงคร่ำครวญ'
$bookNames['Ezekiel']='เอเสเคียล'
$bookNames['Daniel']='ดาเนียล'
$bookNames['Hosea']='โฮเชยา'
$bookNames['Joel']='โยเอล'
$bookNames['Amos']='อาโมส'
$bookNames['Obadiah']='โอบาดีย์'
$bookNames['Jonah']='โยนาห์'
$bookNames['Micah']='มีคาห์'
$bookNames['Nahum']='นาฮูม'
$bookNames['Habakkuk']='ฮาบากุก'
$bookNames['Zephaniah']='เศฟันยาห์'
$bookNames['Haggai']='ฮักกัย'
$bookNames['Zechariah']='เศคาริยาห์'
$bookNames['Malachi']='มาลาคี'
$bookNames['Matthew']='มัทธิว'
$bookNames['Mark']='มาระโก'
$bookNames['Luke']='ลูกา'
$bookNames['John']='ยอห์น'
$bookNames['Acts']='กิจการของอัครทูต'
$bookNames['Romans']='โรม'
$bookNames['1 Corinthians']='1โครินธ์'
$bookNames['2 Corinthians']='2โครินธ์'
$bookNames['Galatians']='กาลาเทีย'
$bookNames['Ephesians']='เอเฟซัส'
$bookNames['Philippians']='ฟีลิปปี'
$bookNames['Colossians']='โคโลสี'
$bookNames['1 Thessalonians']='1เธสะโลนิกา'
$bookNames['2 Thessalonians']='2เธสะโลนิกา'
$bookNames['1 Timothy']='1ทิโมธี'
$bookNames['2 Timothy']='2ทิโมธี'
$bookNames['Titus']='ทิตัส'
$bookNames['Philemon']='ฟีเลโมน'
$bookNames['Hebrews']='ฮีบรู'
$bookNames['James']='ยากอบ'
$bookNames['1 Peter']='1เปโตร'
$bookNames['2 Peter']='2เปโตร'
$bookNames['1 John']='1ยอห์น'
$bookNames['2 John']='2ยอห์น'
$bookNames['3 John']='3ยอห์น'
$bookNames['Jude']='ยูดา'
$bookNames['Revelation']='วิวรณ์'

def CleanVerse(verse)
    #
    # Fix any encoding issues.
    #
    nverse = verse.chars.select(&:valid_encoding?).join

    #
    # Remove Ref tags.
    #
    nverse = nverse.gsub(/\<RF\>[^\<]*\<Rf\>/,'')

    #
    # Remove any inline word hinting.
    #
    nverse = nverse.gsub(/\<[^\>]*\>/,'')
    
    #
    # Return the results.
    #
    return nverse
end

#
# Get the PopClip Environment variables for our
# extension.
#
$verse = ENV['POPCLIP_TEXT']
$qKJV = ENV['POPCLIP_OPTION_BIBLEKJV']
$qThaiKJV = ENV["POPCLIP_OPTION_BIBLETHAIKJV"]
$keycode = ENV['POPCLIP_MODIFIER_FLAGS']
$verseNumber = addrToVerse($verse)
$bookName = ""
$chapter = ""
$rverse = ""
$result = ""
m = /(\d*\s*(\w+)*)\s+(\d+):(\d+)/.match($verse)
if m != nil
    $bookName = m[1]
    $chapter = m[3].strip.to_i
    $rverse = m[4].strip.to_i
end

#
# Get the English verses.
#
if $keycode == "1048576" || $keycode == "1310720" || $qKJV == '1'
    $verse = CleanVerse(IO.readlines("kjv.ont")[$verseNumber].chomp!)
    $result += "#{$bookName} #{$chapter}:#{$rverse} \"#{$verse}\"\n"
end

#
# Get the Thai verses.
#
if $keycode == "262144" || $keycode == "1310720" || $qThaiKJV == '1'
    $bookName = $bookNames[$bookName]
    $rawVerse = IO.readlines("thaikjv.ont")[$verseNumber].chomp!
    $verse = CleanVerse($rawVerse)
    if $verse == ''
        $verse = $rawVerse
    end
    $result += "#{$bookName} #{$chapter}:#{$rverse} \"#{$verse}\"\n"
end

#
# Give the result to PopClip
#
print $result
