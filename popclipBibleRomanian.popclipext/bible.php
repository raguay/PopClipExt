<?php

// Romanian version:  cornilescu
// French: Darby (darby)
// French: Louis Segond (1910) (ls1910)
// French: Martin (1744) (martin)

//
// Send a GET requst using cURL
// @param string $url to request
// @param array $get values to send
// @param array $options for cURL
// @return string
//
function curl_get($url, array $options = array())
{
    $defaults = array(
        CURLOPT_URL => $url,
        CURLOPT_HEADER => 0,
        CURLOPT_RETURNTRANSFER => TRUE,
        CURLOPT_TIMEOUT => 4
    );

    $ch = curl_init();
    curl_setopt_array($ch, ($options + $defaults));
    if( ! $result = curl_exec($ch))
    {
        trigger_error(curl_error($ch));
    }
    curl_close($ch);
    return $result;
}

//
// Function:          getBibleVerse
//
// Description:      This function is for retrieving a Bible verse from the api.preachingcentral.com web site.
//
// Inputs:
//                           $verse       The verses to be searched for.
//                           $version    The version of the bible to use.
//
function getBibleVerse($verse, $version) {
	global $book;

	$result = "";
	$raw = urlencode($verse);
	$xml = curl_get("http://api.preachingcentral.com/bible.php?passage=$raw&version=$version");
	$xml_parser = xml_parser_create();
	xml_parse_into_struct($xml_parser, $xml, $vals, $index);
	xml_parser_free($xml_parser);

	$quote = 0;
	$first = 0;

	foreach ($vals as $xml_elem) {
		//
		// Process the actual verse.
		//
		if(strcmp($xml_elem['tag'],"TEXT") === 0) {
			if($quote == 0) {
				$result .= ' "' . $xml_elem['value'];
				$quote = 1;
			} else {
				$result .=  " " . $xml_elem['value'];
			}
		} else if(strcmp($xml_elem['tag'],"RESULT") === 0) {
			//
			// This is a reference.
			//
			if(strcmp($version, "thai") === 0) {
				//
				// The site only return book names in English.
				// Translate them to Thai.
				//
				$blist = explode(" ", $xml_elem['value']);
				$bname = '';
				$bver = '';
				if(count($blist) == 3) {
					$bname = $blist[0] . $blist[1];
					$bver = $blist[2];
				} elseif (count($blist) == 4) {
					$bname = $blist[0] . $blist[1] . $blist[2];
					$bver = $blist[3];
				} else {
					$bname = $blist[0];
					$bver = $blist[1];
				}
				if($first != 0) {
					$result .= "\n";
				}
				$result .= $book[$bname] . " " . $bver;
				$first = 1;
			} else {
				//
				// English is fine here.
				//
				if($first != 0) {
					$result .= "\n";
				}
				$result .= $xml_elem['value'];
				$first = 1;
			}
			$quote = 0;
		}
	}
	return $result . '"';
}

unset($xml_elem);

//
// Get the PopClip Environment variables for our
// extension.
//
$verse = trim(getenv('POPCLIP_TEXT'));
$qKJV = getenv('POPCLIP_OPTION_BIBLEKJV');
$qFre = getenv("POPCLIP_OPTION_BIBLEFRE");
$qRom = getenv("POPCLIP_OPTION_BIBLEROM");
$keycode = intval(getenv('POPCLIP_MODIFIER_FLAGS'));
$results = "";

//
// If the preference is set to KJV or the command key
// is pressed, then get the verse from the English KJV
// and add it to the result. If both the command key
// and the control key is pressed, then get the KJV also.
//
if(($qKJV[0] == '1')||($keycode == 1048576)||($keycode == 1310720)) {
	$results .= getBibleVerse($verse, "kjv") . "\n" ;
}

//
// If the preference is set to the Romanian or the
// control key is press then get the verse from the
// Romanian and add it to the result. If both the
// command key and the control key is pressed,
// then get the Thai version also.
//
if(($qRom[0] == '1')||($keycode == 262144)||($keycode == 1310720)) {
	$results .= getBibleVerse($verse, "cornilescu") . "\n";
}

//
// If the preference is set to the Romanian or the
// alt key is press then get the verse from the
// Romanian and add it to the result. 
//
if(($qFre[0] == '1')||($keycode == 524288)||($keycode == 1835008)) {
	$results .= getBibleVerse($verse, "ls1910") . "\n";
}

//
// Anything echoed from the script will be pasted in
// to the top most application by PopClip. If the results
// is nothing, then return the verse.
//
if(strcmp($results,"")===0) {
	echo $verse;
} else {
	echo $results;
}

?>