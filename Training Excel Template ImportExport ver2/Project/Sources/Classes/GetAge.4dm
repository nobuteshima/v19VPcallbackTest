Class constructor($date : Date)
	
	$4digitDate:=Month of:C24($date)*100+Day of:C23($date)
	$4digitCurrent:=Month of:C24(Current date:C33)*100+Day of:C23(Current date:C33)
	
	If ($4digitDate<$4digitCurrent)  //誕生日が来ていれば
		This:C1470.age:=Year of:C25(Current date:C33)-Year of:C25($date)
	Else   //誕生日が来ていなければ
		This:C1470.age:=Year of:C25(Current date:C33)-Year of:C25($date)-1
	End if 
	This:C1470.original:=$date
	