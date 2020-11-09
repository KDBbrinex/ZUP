#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Сайт = ИнтеграцияРекрутинговыхСайтовКлиентСервер.HeadHunter();
	СсылкаНаСайт = ИнтеграцияРекрутинговыхСайтов.СтрокаАвторизацииHeadHunter();
	
	Если ОбщегоНазначения.ЭтоВебКлиент() Тогда
		
		ТекстСообщения = СтрШаблон(НСтр("ru = 'Авторизация на %1 не доступна в веб-клиенте.'"), Сайт);
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, , , , Отказ);
		
	КонецЕсли;
	
	АвторизацияУжеПроведена = Ложь;
	СтруктураМаркеровПолучена = Ложь;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СсылкаНаСайтДокументСформирован(Элемент)
	
	Документ = Элемент.Документ;
	
	Если Документ.url = "about:blank" Тогда
		Возврат;
	КонецЕсли; 
	
	ТекстШапки = "";
	Для Каждого Шапка Из Документ.getElementsByTagName("head") Цикл
		СписокЭлементов = Шапка.getElementsByTagName("script");
		Для Каждого УзелДляУдаления Из СписокЭлементов Цикл
			УзелДляУдаления.parentNode.removeChild(УзелДляУдаления);
		КонецЦикла;
		ТекстШапки = Шапка.outerHTML;
		Прервать;
	КонецЦикла;

	Если Найти(Документ.url, "account/login") > 0 Тогда
		
		Если Найти(Документ.url, "mismatch") > 0 Тогда
			Закрыть(Ложь);
			ВызватьИсключение НСтр("ru = 'Указаны неверные параметры доступа на сайт.'");
		КонецЕсли;
		
	КонецЕсли;
	
	Если Не СтруктураМаркеровПолучена Тогда
		АвторизацияHeadHunter(Документ, Шапка);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаЗакрыть(Команда)
	Закрыть(Ложь);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура АвторизацияHeadHunter(Документ, Шапка)
	
	Попытка
		ЗаголовокОкна	= Шапка.document.URLUnencoded;
	Исключение
		Возврат;
	КонецПопытки;
	
	Если Не ЗначениеЗаполнено(ЗаголовокОкна) Тогда
		Попытка
			ЗаголовокОкна = РаскодироватьURL(Шапка.document.URL);
		Исключение
			Возврат;
		КонецПопытки;
	КонецЕсли;
	
	// Анализируем заголовок выделяем из строки КодАвторизации.
	НомерСимвола = Найти(ЗаголовокОкна, "?code=");
	Если НомерСимвола <> 0 Тогда
		КодАвторизации = Сред(ЗаголовокОкна, НомерСимвола + 6);
	Иначе
		Возврат;
	КонецЕсли;
	
	СтруктураМаркеров = СтруктураМаркеров(КодАвторизации);
	СтруктураМаркеровПолучена = СтруктураМаркеров <> Неопределено;
	
	Если СтруктураМаркеровПолучена И ЗначениеЗаполнено(СтруктураМаркеров.access_token) Тогда
		Закрыть(СтруктураМаркеровПолучена);
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция РаскодироватьURL(URL)
	
	Возврат РаскодироватьСтроку(URL, СпособКодированияСтроки.КодировкаURL);
	
КонецФункции

&НаСервере
Функция СтруктураМаркеров(КодАвторизации)
	Возврат ИнтеграцияРекрутинговыхСайтов.СтруктураМаркеров(Сайт, КодАвторизации);
КонецФункции

&НаКлиенте
Процедура ПредупреждениеЗавершение(ДополнительныеПараметры) Экспорт
	ФайловаяСистемаКлиент.ОткрытьНавигационнуюСсылку(ДополнительныеПараметры.URL);
КонецПроцедуры

#КонецОбласти
