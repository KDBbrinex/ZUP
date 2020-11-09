#Если Сервер ИЛИ ТолстыйКлиентОбычноеПриложение ИЛИ ВнешнееСоединение Тогда
	
#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если НЕ ЭтоГруппа И НЕ ЗначениеЗаполнено(Родитель) Тогда
		
		Текст = НСтр("ru = 'Элемент фасета должен принадлежать группе.'");
		Поле = "Родитель";
		ОбщегоНазначения.СообщитьПользователю(Текст, ЭтотОбъект, Поле,, Отказ);			
		
	КонецЕсли;
	
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	Если ОбменДанными.Загрузка Тогда 
		Возврат; 
	КонецЕсли;		
	РазработкаЭлектронныхКурсовСлужебный.ПроверитьВозможностьЗаписиЭлементаПередЗаписью(ЭтотОбъект, Отказ);
	РазработкаЭлектронныхКурсовСлужебный.УстановитьДатуИзмененияПередЗаписью(ЭтотОбъект, Отказ);
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли