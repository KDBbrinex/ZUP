#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

// ОБРАБОТЧИКИ СОБЫТИЙ

Процедура ПередЗаписью(Отказ)
	Если ОбменДанными.Загрузка Тогда 
		Возврат; 
	КонецЕсли;	
	РазработкаЭлектронныхКурсовСлужебный.УстановитьДатуИзмененияПередЗаписью(ЭтотОбъект, Отказ);
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли