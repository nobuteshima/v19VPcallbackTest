Class constructor($date : Date)
	
	//明治 1868/10/23 - 1912/07/29
	//大正 1912/07/30 - 1926/12/24
	//昭和 1926/12/25 - 1989/01/07
	//平成 1989/01/08 - 2019/04/30
	//令和 2019/05/01以降
	This:C1470:=New object:C1471
	
	Case of 
		: ($date<!1868-10-23!)
			This:C1470.eraText:="江戸時代以前"
			//TRACE
		: ($date<!1912-07-30!)
			This:C1470.eraText:="明治"
			This:C1470.eraShort:="明"
			This:C1470.eraAlphabet:="M"
			This:C1470.eraYear:=Year of:C25($date)-1867
			This:C1470.eraDate:="明治"+String:C10(This:C1470.eraYear)+"年"+String:C10(Month of:C24($date))+"月"+String:C10(Day of:C23($date))+"日"
		: ($date<!1926-12-25!)
			This:C1470.eraText:="大正"
			This:C1470.eraShort:="大"
			This:C1470.eraAlphabet:="T"
			This:C1470.eraYear:=Year of:C25($date)-1911
			This:C1470.eraDate:="大正"+String:C10(This:C1470.eraYear)+"年"+String:C10(Month of:C24($date))+"月"+String:C10(Day of:C23($date))+"日"
		: ($date<!1989-01-08!)
			This:C1470.eraText:="昭和"
			This:C1470.eraShort:="昭"
			This:C1470.eraAlphabet:="S"
			This:C1470.eraYear:=Year of:C25($date)-1925
			This:C1470.eraDate:="昭和"+String:C10(This:C1470.eraYear)+"年"+String:C10(Month of:C24($date))+"月"+String:C10(Day of:C23($date))+"日"
		: ($date<!2019-05-01!)
			This:C1470.eraText:="平成"
			This:C1470.eraShort:="平"
			This:C1470.eraAlphabet:="H"
			This:C1470.eraYear:=Year of:C25($date)-1988
			This:C1470.eraDate:="平成"+String:C10(This:C1470.eraYear)+"年"+String:C10(Month of:C24($date))+"月"+String:C10(Day of:C23($date))+"日"
		Else 
			This:C1470.eraText:="令和"
			This:C1470.eraShort:="令"
			This:C1470.eraAlphabet:="R"
			This:C1470.eraYear:=Year of:C25($date)-2018
			This:C1470.eraDate:="令和"+String:C10(This:C1470.eraYear)+"年"+String:C10(Month of:C24($date))+"月"+String:C10(Day of:C23($date))+"日"
	End case 
	This:C1470.originalDate:=$date
	