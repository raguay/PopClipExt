<?php
//
// Array for converting English Bible book names to thai. Not elloquent, but works.
//
$book = array();
$book['Genesis']='ปฐมกาล';
$book['Exodus']='อพยพ';
$book['Leviticus']='เลวีนิติ';
$book['Numbers']='กันดารวิถี';
$book['Deuteronomy']='เฉลยธรรมบัญญัติ';
$book['Joshua']='โยชูวา';
$book['Judges']='ผู้วินิจฉัย';
$book['Ruth']='นางรูธ';
$book['1Samuel']='1ซามูเอล';
$book['2Samuel']='2ซามูเอล';
$book['1Kings']='1พงศ์กษัตริย์';
$book['2Kings']='2พงศ์กษัตริย์';
$book['1Chronicles']='1พงศาวดาร';
$book['2Chronicles']='2พงศาวดาร';
$book['Ezra']='เอสรา';
$book['Nehemiah']='เนหะมีย์';
$book['Esther']='เอสเธอร์';
$book['Job']='โยบ';
$book['Psalms']='สดุดี';
$book['Proverbs']='สุภาษิต';
$book['Ecclesiastes']='ปัญญาจารย์';
$book['SongofSongs']='เพลงซาโลมอน';
$book['Isaiah']='อิสยาห์';
$book['Jeremiah']='เยเรมีย์';
$book['Lamentations']='เพลงคร่ำครวญ';
$book['Ezekiel']='เอเสเคียล';
$book['Daniel']='ดาเนียล';
$book['Hosea']='โฮเชยา';
$book['Joel']='โยเอล';
$book['Amos']='อาโมส';
$book['Obadiah']='โอบาดีย์';
$book['Jonah']='โยนาห์';
$book['Micah']='มีคาห์';
$book['Nahum']='นาฮูม';
$book['Habakkuk']='ฮาบากุก';
$book['Zephaniah']='เศฟันยาห์';
$book['Haggai']='ฮักกัย';
$book['Zechariah']='เศคาริยาห์';
$book['Malachi']='มาลาคี';
$book['Matthew']='มัทธิว';
$book['Mark']='มาระโก';
$book['Luke']='ลูกา';
$book['John']='ยอห์น';
$book['Acts']='กิจการของอัครทูต';
$book['Romans']='โรม';
$book['1Corinthians']='1โครินธ์';
$book['2Corinthians']='2โครินธ์';
$book['Galatians']='กาลาเทีย';
$book['Ephesians']='เอเฟซัส';
$book['Philippians']='ฟีลิปปี';
$book['Colossians']='โคโลสี';
$book['1Thessalonians']='1เธสะโลนิกา';
$book['2Thessalonians']='2เธสะโลนิกา';
$book['1Timothy']='1ทิโมธี';
$book['2Timothy']='2ทิโมธี';
$book['Titus']='ทิตัส';
$book['Philemon']='ฟีเลโมน';
$book['Hebrews']='ฮีบรู';
$book['James']='ยากอบ';
$book['1Peter']='1เปโตร';
$book['2Peter']='2เปโตร';
$book['1John']='1ยอห์น';
$book['2John']='2ยอห์น';
$book['3John']='3ยอห์น';
$book['Jude']='ยูดา';
$book['Revelation']='วิวรณ์';

//
// Get the PopClip Environment variables for our
// extension.
//
$BibleName = trim(getenv('POPCLIP_TEXT'));

echo $book[$BibleName];

?>