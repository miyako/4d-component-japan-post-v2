//%attributes = {}
$ds:=ds郵便番号(True:C214)

$e:=$ds.code["1540014"]

$e:=$ds.住所の郵便番号.query("郵便番号 == :1"; "1540014")
