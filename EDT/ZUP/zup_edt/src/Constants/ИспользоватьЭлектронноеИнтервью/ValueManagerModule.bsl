#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриЗаписи(Отказ)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ ПолучитьФункциональнуюОпцию("ИспользоватьАнкетирование") Тогда
		Константы.ИспользоватьАнкетирование.Установить(Истина);
	КонецЕсли;
	Если НЕ ПолучитьФункциональнуюОпцию("ИспользоватьШаблоныСообщений") Тогда
		Константы.ИспользоватьШаблоныСообщений.Установить(Истина);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли