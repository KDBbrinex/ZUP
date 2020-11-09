
#Область СлужебныеПроцедурыИФункции

Процедура УстановитьНастройкиСистемыНалогообложения(Источник, Отказ) Экспорт
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(Источник) Тогда
		Возврат;
	КонецЕсли;
	
	ПредыдущаяГоловнаяОрганизация = Неопределено;
	ЭтоНовый = Ложь;
	Источник.ДополнительныеСвойства.Свойство("ЭтоНовый", ЭтоНовый);
	Если Не Источник.ДополнительныеСвойства.Свойство("ЭтоНовый", ЭтоНовый) Тогда
		ЭтоНовый = Ложь;
	КонецЕсли;
	Если Не ЭтоНовый И НЕ Источник.ДополнительныеСвойства.Свойство("ИзмененаГоловнаяОрганизация", ПредыдущаяГоловнаяОрганизация) Тогда
		Возврат;
	КонецЕсли;
	
	РеквизитыОрганизации = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Источник.Ссылка, "ГоловнаяОрганизация,ОбособленноеПодразделение");
	
	Если РеквизитыОрганизации.ОбособленноеПодразделение Тогда
		
		НастройкиОрганизации = РегистрыСведений.НастройкиСистемыНалогообложения.СоздатьНаборЗаписей();
		НастройкиОрганизации.Отбор.Организация.Установить(Источник.Ссылка);
		НастройкиОрганизации.Прочитать();
		
		НастройкиГоловнойОрганизации = РегистрыСведений.НастройкиСистемыНалогообложения.СоздатьНаборЗаписей();
		НастройкиГоловнойОрганизации.Отбор.Организация.Установить(РеквизитыОрганизации.ГоловнаяОрганизация);
		НастройкиГоловнойОрганизации.Прочитать();
		
		Если Не ОбщегоНазначения.КоллекцииИдентичны(НастройкиОрганизации, НастройкиГоловнойОрганизации, "Период,ПлательщикЕНВД") Тогда
			НастройкиОрганизации.Очистить();
			Для Каждого СтрокаТаблицыИсточник Из НастройкиГоловнойОрганизации Цикл
				СтрокаНастроек = НастройкиОрганизации.Добавить();
				ЗаполнитьЗначенияСвойств(СтрокаНастроек, СтрокаТаблицыИсточник);
				СтрокаНастроек.Организация = Источник.Ссылка;
			КонецЦикла;
			НастройкиОрганизации.Записать();
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
