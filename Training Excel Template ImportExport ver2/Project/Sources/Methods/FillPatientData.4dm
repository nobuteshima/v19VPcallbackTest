//%attributes = {}
//#DECLARE($area; $filepath : Text; $option : Object)

var $entity : cs:C1710.PatientEntity

$entity:=$3.patient

//医療機関情報を代入

$range:=VP Cell($1; 22; 5)  //医療機関名
VP SET TEXT VALUE($range; "テスト医療機関")

$range:=VP Cell($1; 18; 6)  //医療機関住所
VP SET TEXT VALUE($range; "〒150-0043 東京都 渋谷区道玄坂 1-10-2-6F")

$range:=VP Cell($1; 20; 7)  //医療機関電話番号
VP SET TEXT VALUE($range; "03-4400-1789")

$range:=VP Cell($1; 20; 8)  //主治医名、エンティティから取得
VP SET TEXT VALUE($range; $entity.myDoctor.name)


//個人情報を代入

$values:=New collection:C1472

$values.push(New collection:C1472($entity.name))
$values.push(New collection:C1472($entity.address))
$values.push(New collection:C1472($entity.phone))

VP SET VALUES(VP Cell($1; 7; 11); $values)  //氏名・住所・電話番号は縦に並んでるのでVP SET VALUESを使用

//誕生日・年齢
$japaneseEra:=cs:C1710.ConvertToImperialEra.new($entity.birthday)
VP SET NUM VALUE(VP Cell($1; 15; 14); $japaneseEra.eraYear)  //生年月日の和暦の年
VP SET NUM VALUE(VP Cell($1; 19; 14); Month of:C24($entity.birthday))  //生年月日の月
VP SET NUM VALUE(VP Cell($1; 22; 14); Day of:C23($entity.birthday))  //生年月日の日
//VP SET NUM VALUE(VP Cell($1; 26; 14); GetAgeMethod($entity.birthday).age)
VP SET NUM VALUE(VP Cell($1; 26; 14); cs:C1710.GetAge.new($entity.birthday).age)


//入院日時を代入

VP SET NUM VALUE(VP Cell($1; 7; 20); Year of:C25($entity.hospitalDate))
VP SET NUM VALUE(VP Cell($1; 13; 20); Month of:C24($entity.hospitalDate))
VP SET NUM VALUE(VP Cell($1; 16; 20); Day of:C23($entity.hospitalDate))

VP SET NUM VALUE(VP Cell($1; 7; 21); Year of:C25($entity.recoverDate))
VP SET NUM VALUE(VP Cell($1; 13; 21); Month of:C24($entity.recoverDate))
VP SET NUM VALUE(VP Cell($1; 16; 21); Day of:C23($entity.recoverDate))


//12 /25   8-27
VP SET TEXT VALUE(VP Cell($1; 12; 26); "地域一般入院基本料1")
VP SET NUM VALUE(VP Cell($1; 8; 27); $entity.recoverDate-$entity.hospitalDate+1)

VP SET NUM VALUE(VP Cell($1; 13; 27); Year of:C25($entity.hospitalDate))
VP SET NUM VALUE(VP Cell($1; 17; 27); Month of:C24($entity.hospitalDate))
VP SET NUM VALUE(VP Cell($1; 20; 27); Day of:C23($entity.hospitalDate))

VP SET NUM VALUE(VP Cell($1; 24; 27); Year of:C25($entity.recoverDate))
VP SET NUM VALUE(VP Cell($1; 28; 27); Month of:C24($entity.recoverDate))
VP SET NUM VALUE(VP Cell($1; 31; 27); Day of:C23($entity.recoverDate))

//3-31
VP SET NUM VALUE(VP Cell($1; 3; 31); $entity.recoverDate-$entity.hospitalDate+1)

VP SET NUM VALUE(VP Cell($1; 8; 31); Year of:C25(Current date:C33))
VP SET NUM VALUE(VP Cell($1; 12; 31); Month of:C24(Current date:C33))
VP SET NUM VALUE(VP Cell($1; 15; 31); Day of:C23(Current date:C33))

//7-35
VP SET TEXT VALUE(VP Cell($1; 7; 35); $entity.symptomName)

//その他
VP SET TEXT VALUE(VP Cell($1; 1; 44); Choose:C955($entity.comment=""; "特になし"; $entity.comment))



//患者の情報に応じて丸をつけていく
//「男」or「女」に丸をつける、男なら459、女なら479
Case of 
	: ($entity.sex="男")
		$left:="459"
	: ($entity.sex="女")
		$left:="479"
	Else 
		
End case 
$e:=WA Evaluate JavaScript:C1029(*; $1; "var sheet = Utils.spread.getActiveSheet();var circle1 = sheet.shapes.add('oval', GC.Spread.Sheets.Shapes.AutoShapeType.oval, "+$left+", 174, 32, 32);"; Is object:K8:27)  // 左から$left、上から174を起点として、幅32、高さ32のcircle1という円シェイプを追加
$e:=WA Evaluate JavaScript:C1029(*; $1; "var style = circle1.style();style.fill = { type: GC.Spread.Sheets.Shapes.ShapeFillType.none };circle1.style(style);"; Is object:K8:27)  // circle1の塗りカラーをなし(透明)にする
$e:=WA Evaluate JavaScript:C1029(*; $1; "var style = circle1.style();style.line.color = 'black';style.line.width = 2;circle1.style(style);"; Is object:K8:27)  // circle1の線のカラーを黒に、線の幅を2にする


////和暦に丸をつける「明」なら111、「大」なら130、「昭」なら149、「平」なら168、「令」なら187、
Case of 
	: ($japaneseEra.eraShort="明")
		$eraLeft:="110"
	: ($japaneseEra.eraShort="大")
		$eraLeft:="130"
	: ($japaneseEra.eraShort="昭")
		$eraLeft:="150"
	: ($japaneseEra.eraShort="平")
		$eraLeft:="170"
	: ($japaneseEra.eraShort="令")
		$eraLeft:="190"
	Else 
		
End case 

$e:=WA Evaluate JavaScript:C1029(*; $1; "var sheet = Utils.spread.getActiveSheet();var circle2 = sheet.shapes.add('oval', GC.Spread.Sheets.Shapes.AutoShapeType.oval, "+$eraLeft+", 233, 23, 23);"; Is object:K8:27)  // 左から$eraLeft、上から233を起点として、幅23、高さ23のcircle2という円シェイプを追加
$e:=WA Evaluate JavaScript:C1029(*; $1; "var style = circle2.style();style.fill = { type: GC.Spread.Sheets.Shapes.ShapeFillType.none };circle2.style(style);"; Is object:K8:27)  // circle2の塗りカラーをなし(透明)にする
$e:=WA Evaluate JavaScript:C1029(*; $1; "var style = circle2.style();style.line.color = 'black';style.line.width = 2;circle2.style(style);"; Is object:K8:27)  // circle2の線のカラーを黒に、線の幅を2にする

////「治癒」に丸をつける
$e:=WA Evaluate JavaScript:C1029(*; $1; "var sheet = Utils.spread.getActiveSheet();var circle3 = sheet.shapes.add('oval', GC.Spread.Sheets.Shapes.AutoShapeType.oval, 64, 679, 44, 30);"; Is object:K8:27)  // 左から69、上から684を起点として、幅50、高さ30のcircle3という円シェイプを追加
$e:=WA Evaluate JavaScript:C1029(*; $1; "var style = circle3.style();style.fill = { type: GC.Spread.Sheets.Shapes.ShapeFillType.none };circle3.style(style);"; Is object:K8:27)  // circle1の塗りカラーをなし(透明)にする
$e:=WA Evaluate JavaScript:C1029(*; $1; "var style = circle3.style();style.line.color = 'black';style.line.width = 2;circle3.style(style);"; Is object:K8:27)  // circle1の線のカラーを黒に、線の幅を2にする



var $printInfo : Object

// 印刷属性オブジェクトを宣言
$printInfo:=New object:C1471

$printInfo.showRowHeader:=vk print visibility hide:K89:94
$printInfo.showColumnHeader:=vk print visibility hide:K89:94
$printInfo.showBorder:=False:C215
$printInfo.fitPagesWide:=1
$printInfo.fitPagesTall:=1


// 印刷情報を設定します
VP SET PRINT INFO("ViewProArea"; $printInfo)

//書き出しオプションを設定
$option:=New object:C1471
$option.format:=vk pdf format:K89:21
$option.formula:=Formula:C1597(ExportDone)
$date:=Replace string:C233(String:C10(Current date:C33; Internal date short special:K1:4); "/"; "")
$filepath:=Folder:C1567(fk resources folder:K87:11).platformPath+$date+Replace string:C233(String:C10(Current time:C178; HH MM SS:K7:1); ":"; "")+$entity.name+".pdf"

VP EXPORT DOCUMENT($1; $filepath; $option)

