#Если Сервер ИЛИ ТолстыйКлиентОбычноеПриложение ИЛИ ВнешнееСоединение Тогда
	
#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда 
		Возврат; 
	КонецЕсли;		
		
	РазработкаЭлектронныхКурсовСлужебный.ПроверитьВозможностьЗаписиЭлементаПередЗаписью(ЭтотОбъект, Отказ);
	РазработкаЭлектронныхКурсовСлужебный.УстановитьДатуИзмененияПередЗаписью(ЭтотОбъект, Отказ);
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	ДополнительныеСвойства.Вставить("ОбъектКопирования", ОбъектКопирования);
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли