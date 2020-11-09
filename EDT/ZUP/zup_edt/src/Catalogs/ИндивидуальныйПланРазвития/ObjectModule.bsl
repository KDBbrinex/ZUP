#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;

	Наименование = Владелец.Наименование + " (" + Формат(ДатаНачала, "ДФ=MM.yyyy")+ " - " + Формат(ДатаОкончания, "ДФ=MM.yyyy") + ")";
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	МассивНепроверяемыхРеквизитов = Новый Массив();
	
	Если ЗначениеЗаполнено(ДатаНачала) И ЗначениеЗаполнено(ДатаОкончания) Тогда
		
		Для каждого Мероприятие Из Мероприятия Цикл
			
			Если НЕ ЗначениеЗаполнено(Мероприятие.ДатаНачала)
				ИЛИ Мероприятие.ДатаНачала > Мероприятие.ДатаОкончания
				ИЛИ Мероприятие.ДатаНачала < ДатаНачала
				ИЛИ Мероприятие.ДатаНачала > ДатаОкончания Тогда
				
				ОбщегоНазначения.СообщитьПользователю(
					ЭтотОбъект,
					НСтр("ru ='Неверно заполнен период.'"),
					СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку("Мероприятия[%1].ДатаНачала", Мероприятия.Индекс(Мероприятие)),,
					Отказ);
				
			ИначеЕсли НЕ ЗначениеЗаполнено(Мероприятие.ДатаОкончания)
				ИЛИ Мероприятие.ДатаОкончания < ДатаНачала
				ИЛИ Мероприятие.ДатаОкончания > ДатаОкончания Тогда
				
				ОбщегоНазначения.СообщитьПользователю(
					ЭтотОбъект,
					НСтр("ru ='Неверно заполнен период.'"),
					СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку("Мероприятия[%1].ДатаОкончания", Мероприятия.Индекс(Мероприятие)),,
					Отказ);
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли; 
		
	МассивНепроверяемыхРеквизитов.Добавить("Мероприятие.ДатаНачала");
	МассивНепроверяемыхРеквизитов.Добавить("Мероприятие.ДатаОкончания");

	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты,МассивНепроверяемыхРеквизитов);
	
КонецПроцедуры
 
#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли