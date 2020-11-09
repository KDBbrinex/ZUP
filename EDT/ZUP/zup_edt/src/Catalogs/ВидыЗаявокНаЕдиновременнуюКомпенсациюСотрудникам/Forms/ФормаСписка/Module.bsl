
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.РежимВыбора Тогда
		Элементы.Список.РежимВыбора = Истина;
	КонецЕсли;
	
	УстановитьОтборИспользуемых(Список.Отбор, ПоказыватьНеиспользуемыеВидыЗаявок);
	
	ЗарплатаКадры.ПриСозданииНаСервереФормыСДинамическимСписком(ЭтотОбъект, "Список");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПоказыватьНеиспользуемыеВидыЗаявокПриИзменении(Элемент)
	
	УстановитьОтборИспользуемых(Список.Отбор, ПоказыватьНеиспользуемыеВидыЗаявок);
	
КонецПроцедуры

&НаСервере
Процедура СписокПередЗагрузкойПользовательскихНастроекНаСервере(Элемент, Настройки)
	
	ЗарплатаКадры.ПроверитьПользовательскиеНастройкиДинамическогоСписка(ЭтотОбъект, Настройки);
	
КонецПроцедуры

&НаСервере
Процедура СписокПриОбновленииСоставаПользовательскихНастроекНаСервере(СтандартнаяОбработка)
	
	ЗарплатаКадры.ПроверитьПользовательскиеНастройкиДинамическогоСписка(ЭтотОбъект, , СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьОтборИспользуемых(ГруппаОтбора, ПоказыватьВАрхиве)
	
	ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбора(ГруппаОтбора, "ВАрхиве");
	Если Не ПоказыватьВАрхиве Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(ГруппаОтбора, "ВАрхиве", Ложь);
	КонецЕсли;
		
КонецПроцедуры

#КонецОбласти
