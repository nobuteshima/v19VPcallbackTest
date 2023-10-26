//%attributes = {}

var $selection : cs:C1710.PatientSelection
var $entity : cs:C1710.PatientEntity

$selection:=ds:C1482.Patient.all().slice(0; 1)  //ここの末尾の1の数字を増やすと書き出される患者の数が増える

For each ($entity; $selection)
	
	$offscreenTest:=New object:C1471
	
	$offscreenTest.area:="ViewProArea"
	$offscreenTest.filepath:=Get 4D folder:C485(Current resources folder:K5:16)+"Excel templates:e1.xlsx"
	$offscreenTest.onEvent:=Formula:C1597(ImportTemplate)
	$offscreenTest.autoQuit:=False:C215
	$offscreenTest.patient:=$entity
	
	$result:=VP Run offscreen area($offscreenTest)
	//DISPLAY NOTIFICATION("4D View Pro export"; $entity.name+"の書き出しが完了しました")
End for each 

DISPLAY NOTIFICATION:C910("4D View Pro export"; "全ての書き出しが完了しました")
