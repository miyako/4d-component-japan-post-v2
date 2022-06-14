![version](https://img.shields.io/badge/version-19%2B-5682DF)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/4d-component-japan-post-v2)](LICENSE)

# 4d-component-japan-post-v2
郵便番号データベースを収めたオブジェクト

#### 使い方

```4d
$ds:=ds郵便番号
$col:=$ds.住所の郵便番号.query("郵便番号 == :1"; "154@")
```

#### 住所の郵便番号をアップデートするには

1. [`ken_all.zip`](https://www.post.japanpost.jp/zipcode/dl/kogaki-zip.html)をダウンロードして`/DATA/`にコピーする
2. `import_postcode`を実行する
3. オブジェクトをエクスポートする

```4d
$ds:=ds郵便番号(True) //リビルド
```
* 住所の郵便番号
    * 2021年11月30日

> 大分県大分市ふじが丘山手と大分県大分市ふじが丘西の郵便番号について、2021年11月30日更新のデータに誤りがありました。  
> 大分県大分市ふじが丘山手　【誤】870-1185　【正】870-1184  
> 大分県大分市ふじが丘西　　【誤】870-1184　【正】870-1185  
