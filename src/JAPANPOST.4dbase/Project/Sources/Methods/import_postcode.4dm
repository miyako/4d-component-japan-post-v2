//%attributes = {"invisible":true,"preemptive":"incapable"}
/*

マスターはここで公開されている

OPEN URL("https://www.post.japanpost.jp/zipcode/dl/kogaki-zip.html")

*/

TRUNCATE TABLE:C1051([住所の郵便番号:1])
SET DATABASE PARAMETER:C642([住所の郵便番号:1];Table sequence number:K37:31;0)

$valuesFolder:=Folder:C1567("/DATA/")
$files:=$valuesFolder.files()
$names:=New collection:C1472("ken_all")
$files:=$files.query("name in :1 and extension === :2";$names;".zip")

If ($files.length#0)
	
	$file:=$files[0]
	$archive:=ZIP Read archive:C1637($file)
	$files:=$archive.root.files()
	
	If ($files.length#0)
		
		PAUSE INDEXES:C1293([住所の郵便番号:1])
		
		$csv:=$files[0].getText("windows-31j";Document with LF:K24:22)
		
		ARRAY LONGINT:C221($pos;0)
		ARRAY LONGINT:C221($len;0)
		
		C_LONGINT:C283($i)
		$i:=1
		
		While (Match regex:C1019("(.+)";$csv;$i;$pos;$len))
			
			$i:=$pos{1}+$len{1}
			$line:=Substring:C12($csv;$pos{1};$len{1})
			$values:=Split string:C1554($line;",")
			
			trim_double_quotes ($values)
			
			$住所の郵便番号:=ds:C1482.住所の郵便番号.new()
			
			$住所の郵便番号["項目"]:=New object:C1471
			$住所の郵便番号["項目"]["全国地方公共団体コード"]:=$values[0]
			$住所の郵便番号["項目"]["旧郵便番号"]:=$values[1]
			$住所の郵便番号["郵便番号"]:=$values[2]
			$住所の郵便番号["項目"]["都道府県名"]:=$values[3]
			$住所の郵便番号["項目"]["市区町村名"]:=$values[4]
			$住所の郵便番号["項目"]["町域名"]:=$values[5]
			$住所の郵便番号["都道府県名"]:=$values[6]
			$住所の郵便番号["市区町村名"]:=$values[7]
			$住所の郵便番号["町域名"]:=$values[8]
			$住所の郵便番号["項目"]["一町域が二以上の郵便番号で表される場合の表示"]:=$values[9]
			$住所の郵便番号["項目"]["小字毎に番地が起番されている町域の表示"]:=$values[10]
			$住所の郵便番号["項目"]["丁目を有する町域の場合の表示"]:=$values[11]
			$住所の郵便番号["項目"]["一つの郵便番号で二以上の町域を表す場合の表示"]:=$values[12]
			$住所の郵便番号["項目"]["更新の表示"]:=$values[13]
			$住所の郵便番号["項目"]["変更理由"]:=$values[14]
			
			$住所の郵便番号.save()
		End while 
		
		RESUME INDEXES:C1294([住所の郵便番号:1])
		
	End if 
End if 