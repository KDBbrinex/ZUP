#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	ЗарплатаКадрыОтчеты.ПриКомпоновкеРезультатаВТабличныйДокумент(
		ЭтотОбъект, ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка, Ложь);
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли