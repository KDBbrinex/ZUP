
#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьДанныеПоискаФизическихЛицПриЗаписи(Источник, Отказ) Экспорт
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(Источник) Тогда
		Возврат;
	КонецЕсли;
	
	ПоискФизическихЛиц.ЗаполнитьДанныеПоискаФизическогоЛица(Источник);
	
КонецПроцедуры

#КонецОбласти
