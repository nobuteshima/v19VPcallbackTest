//%attributes = {}
$event:=FORM Event:C1606
Case of 
	: ($event.code=On Load:K2:1)
		
	: ($event.code=On End URL Loading:K2:47)
		
	: ($event.code=On VP Ready:K2:59)
		$option:=New object:C1471
		$option.formula:=Formula:C1597(FillPatientData)
		$option.patient:=This:C1470.patient
		VP IMPORT DOCUMENT(This:C1470.area; This:C1470.filepath; $option)
		
End case 