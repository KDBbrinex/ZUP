#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	Если ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.МероприятияОбученияРазвития") Тогда
		// Заполнение шапки
		Ответственный = ДанныеЗаполнения.Ответственный;
		Мероприятие = ДанныеЗаполнения.Ссылка;
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		Если ДанныеЗаполнения.Свойство("ДатаНачала") Тогда
			ДатаНачалаСобытия = ДанныеЗаполнения.ДатаНачала;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры
 
Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	ЗарплатаКадры.ПроверитьКорректностьДаты(Ссылка, ДатаОкончания, "Объект.ДатаОкончания", Отказ, НСтр("ru='Дата окончания публикации'"), , , Ложь);
	ЗарплатаКадры.ПроверитьКорректностьДаты(Ссылка, ДатаНачалаСобытия, "Объект.ДатаНачалаСобытия", Отказ, НСтр("ru='Дата начала мероприятия'"), , , Ложь);
	
	Если ЗначениеЗаполнено(ДатаНачалаСобытия) И ЗначениеЗаполнено(ДатаОкончания )
		И ДатаОкончания > ДатаНачалаСобытия Тогда
		
		ОбщегоНазначения.СообщитьПользователю(
			ЭтотОбъект,
			НСтр("ru ='Дата начала события должна быть больше даты окончания публикации мероприятия.'"),
			"ДатаНачала",,
			Отказ);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли