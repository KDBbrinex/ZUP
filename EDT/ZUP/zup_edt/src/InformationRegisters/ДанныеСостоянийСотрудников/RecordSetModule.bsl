#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	ЗарплатаКадрыПериодическиеРегистры.КонтрольИзмененийПередЗаписью(ЭтотОбъект);
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	ЗарплатаКадрыПериодическиеРегистры.КонтрольИзмененийПриЗаписи(ЭтотОбъект);
	ИзмененияВНаборе = ТаблицаИзменившихсяДанныхНабора();
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	ЗарплатаКадры.СоздатьВТПоТаблицеЗначений(МенеджерВременныхТаблиц, ИзмененияВНаборе, "ВТКлючиИзменившихсяДанных");
	СостоянияСотрудников.ОбновитьСостоянияСотрудников(МенеджерВременныхТаблиц);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает признак сформированности таблицы изменений
//
Функция ТаблицаИзменившихсяДанныхНабораСформирована() Экспорт
	Возврат ЗарплатаКадрыПериодическиеРегистры.ТаблицаИзменившихсяДанныхНабораСформирована(ЭтотОбъект);
КонецФункции

// Возвращает таблицу изменений регистра
//
Функция ТаблицаИзменившихсяДанныхНабора() Экспорт
	Возврат ЗарплатаКадрыПериодическиеРегистры.ТаблицаИзменившихсяДанныхНабора(ЭтотОбъект);
КонецФункции

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли