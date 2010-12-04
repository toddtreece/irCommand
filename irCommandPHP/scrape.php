<?php
//  _       _____                                          _ 
// (_)     / ____|                                        | |
//  _ _ __| |     ___  _ __ ___  _ __ ___   __ _ _ __   __| |
// | | '__| |    / _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` |
// | | |  | |___| (_) | | | | | | | | | | | (_| | | | | (_| |
// |_|_|   \_____\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|
// 
// irCommandPHP
// Copyright 2010 Todd Treece
// http://unionbridge.org/design/ircommand
// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

require_once 'simple_html_dom.php';

class scrape {
	private $favorites;
	private $bedfavorites;
	
	public function __construct(){
		$favorites[] = '27';
		$favorites[] = '28';
		$favorites[] = '50';
		$favorites[] = '52';
		$favorites[] = '57';
		$favorites[] = '42';
		$favorites[] = '71';
		$favorites[] = '766';
		$favorites[] = '768';
		$favorites[] = '769';
		$favorites[] = '770';
		$favorites[] = '771';
		$favorites[] = '774';
		$favorites[] = '775';
		$favorites[] = '780';
		$favorites[] = '781';
		$favorites[] = '782';
		$favorites[] = '786';
		$favorites[] = '792';
		$favorites[] = '793';
		$favorites[] = '794';
		$favorites[] = '795';
		$favorites[] = '796';
		$favorites[] = '797';
		$favorites[] = '798';
		$this->favorites = $favorites;
		$bedfavorites[] = '27';
		$bedfavorites[] = '28';
		$bedfavorites[] = '40';
		$bedfavorites[] = '45';
		$bedfavorites[] = '50';
		$bedfavorites[] = '52';
		$bedfavorites[] = '56';
		$bedfavorites[] = '57';
		$bedfavorites[] = '42';
		$bedfavorites[] = '71';
		$this-> bedfavorites = $bedfavorites;

	}
	
	public function aoltv($url) {
	    $html = file_get_html($url);
		$returnval = null;
		$timei=0;
	    foreach($html->find('ul[class="grid-head-row"]') as $time) {
			if($timei == 1){
		        foreach($time->find('div[class="grid-rest-col-data"]') as $timedata) {
					$returnval['times'][] = trim($timedata->plaintext);
		        }
			}
			$timei++;
	    }
		unset($timei);		    
		foreach($html->find('ul[class="grid-body-row"]') as $channel){
			$channelinfo = array();
			//$channelinfo['image'] = $channel->first_child()->find('img', 0)->src;
			$channelarray = explode(" ", trim($channel->first_child()->find('a', 0)->plaintext));
			if(strlen(trim($channelarray[0])) == 1){
				$channelinfo['number'] = "00" . trim($channelarray[0]);
			} else if(strlen(trim($channelarray[0])) == 2){
				$channelinfo['number'] = "0" . trim($channelarray[0]);
			} else if(strlen(trim($channelarray[0])) == 3){
				$channelinfo['number'] = trim($channelarray[0]);
			}
			$channelinfo['name'] = trim($channelarray[1]);
			unset($channelarray);		    
			$channelinfo['image'] = $channelinfo['number'] . '.gif';
			foreach($channel->children() as $show){
				if($show->class != 'grid-first-col'){
					$percent = preg_replace('#\D*?(\d+(\.\d+)?)\D*#', '$1', $show->style);
					$whole = round($percent);
					$length = $whole / 15;
					$showinfo = array();
					$showinfo['length'] = round($length);
					$showinfo['title'] = trim($show->find('a', 0)->plaintext);
					if(round($length) > 0 ){
						$channelinfo['shows'][] = $showinfo;
					}
				}
				unset($showinfo);		    
			}
			if($channelinfo['number'] > 1 && $channelinfo['number'] < 100){
				//self::downloadImages($channelinfo['image'],$channelinfo['number']);
				$returnval['channels'][] = $channelinfo;
			} else if($channelinfo['number'] > 755 && $channelinfo['number'] < 776){
				//self::downloadImages($channelinfo['image'],$channelinfo['number']);				
				$returnval['channels'][] = $channelinfo;
			} else if($channelinfo['number'] > 779 && $channelinfo['number'] < 800){
				//self::downloadImages($channelinfo['image'],$channelinfo['number']);				
				$returnval['channels'][] = $channelinfo;
			}
			if(in_array($channelinfo['number'],$this->favorites)){
				$returnval['favorites'][] = $channelinfo;
			}
			if(in_array($channelinfo['number'],$this->bedfavorites)){
				$returnval['bedfavorites'][] = $channelinfo;
			}
			unset($channelinfo);		    
		}
	    $html->clear();
	    unset($html);
	    return $returnval;
	}
	
	public function saveToDisk($url) {
		$data = json_encode($this->aoltv($url));
		file_put_contents('data.txt', $data);
	}
	
	public function readFromDisk(){
		$json = file_get_contents('data.txt');
		echo $json;
	}
	
	public function downloadImages($image_url,$number){
		$ch = curl_init(); 
		curl_setopt ($ch, CURLOPT_URL, $image_url); 
		curl_setopt ($ch, CURLOPT_CONNECTTIMEOUT, 0); 
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
		curl_setopt($ch, CURLOPT_BINARYTRANSFER, 1); 
		$image = curl_exec($ch); 
		curl_close($ch);
		$f = fopen($number . '.gif', 'w');
		fwrite($f, $image);
		fclose($f);
	}
}
?>