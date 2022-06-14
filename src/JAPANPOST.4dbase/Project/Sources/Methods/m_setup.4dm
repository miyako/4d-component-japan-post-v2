//%attributes = {"invisible":true,"preemptive":"capable"}
C_COLLECTION:C1488($1; $住所の郵便番号)
C_BOOLEAN:C305($2; $noHost)

C_BLOB:C604($data)
C_TEXT:C284($薬価基準コード)
C_TEXT:C284($項目)

$住所の郵便番号:=$1
$noHost:=$2

Use ($住所の郵便番号)
	If ($noHost)
		//データ再構築
		For each ($e住所の郵便番号; ds:C1482.住所の郵便番号.all())
			$o住所の郵便番号:=New shared object:C1526
			$住所の郵便番号.push($o住所の郵便番号)
			Use ($o住所の郵便番号)
				For each ($項目; $e住所の郵便番号)
					Case of 
						: (Value type:C1509($e住所の郵便番号[$項目])=Is object:K8:27)  //"項目" フィールド
							$o住所の郵便番号_項目:=New shared object:C1526
							$o住所の郵便番号[$項目]:=$o住所の郵便番号_項目
							$e住所の郵便番号_項目:=$e住所の郵便番号[$項目]
							Use ($o住所の郵便番号_項目)
								For each ($項目; $e住所の郵便番号_項目)
									$o住所の郵便番号_項目[$項目]:=$e住所の郵便番号_項目[$項目]
								End for each 
							End use 
						Else 
							$o住所の郵便番号[$項目]:=$e住所の郵便番号[$項目]
					End case 
				End for each 
			End use 
			
		End for each 
		
		C_OBJECT:C1216($sharedObject)
		
		$o:=This:C1470["code"]
		
		For each ($sharedObject; $住所の郵便番号)
			$code:=$sharedObject["郵便番号"]
			$o[$code]:=$sharedObject
		End for each 
		
		$sharedObject:=This:C1470
		
		VARIABLE TO BLOB:C532($sharedObject; $data)
		$file:=Folder:C1567("/RESOURCES/").file("住所の郵便番号.data")
		$file.setContent($data)
		
	Else 
		
		$file:=Folder:C1567("/RESOURCES/").file("住所の郵便番号.data")
		
		If ($file.exists)
			
			$data:=$file.getContent()
			
			C_OBJECT:C1216($object)
			BLOB TO VARIABLE:C533($data; $object)
			$object:=OB Copy:C1225($object; ck shared:K85:29; This:C1470)
			
			Use (This:C1470)
				This:C1470.住所の郵便番号:=$object.住所の郵便番号
				This:C1470["code"]:=$object["code"]
			End use 
			
		End if 
	End if 
End use 