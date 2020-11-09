#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.ВариантыОтчетов

// См. ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов.
//
Процедура НастроитьВариантыОтчета(Настройки, НастройкиОтчета) Экспорт

	НастройкиОтчета.ОпределитьНастройкиФормы = Истина;
	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "ЖурналУчетаИсполнительныхДокументов");
	НастройкиВарианта.Описание =
		НСтр("ru = 'Список исполнительных листов, действующих в заданном периоде.'");
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.ВариантыОтчетов

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область Печать

// Сформировать печатные формы объектов.
//
// ВХОДЯЩИЕ:
//   МассивОбъектов  - Массив    - Массив ссылок на объекты которые нужно распечатать.
//
// ИСХОДЯЩИЕ:
//   ПараметрыПечати       - Структура  - Дополнительные параметры для печати.
//   КоллекцияПечатныхФорм - Таблица значений - Сформированные табличные документы.
//   ОбъектыПечати         - Список значений  - Объекты печати (значение - ссылка на объект, представление - имя
//                           области в которой был выведен объект).
//   ПараметрыВывода       - Структура        - Параметры сформированных табличных документов.
//
Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "КарточкаУчетаИсполнительныхДокументов") Тогда
		
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(
				КоллекцияПечатныхФорм,
				"КарточкаУчетаИсполнительныхДокументов",
				НСтр("ru = 'Карточка учета исполнительных документов'"),
				ПечатьКарточкиУчетаИсполнительныхДокументов(МассивОбъектов, ОбъектыПечати));
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПечатьКарточкиУчетаИсполнительныхДокументов(СписокДокументов, ОбъектыПечати) 
	
	ОтчетОбъект = Отчеты.ЖурналУчетаИсполнительныхДокументов.Создать();
	
	ВариантОтчета = ОтчетОбъект.СхемаКомпоновкиДанных.ВариантыНастроек.Найти("КарточкаУчетаИсполнительныхДокументов");
	Если ВариантОтчета= Неопределено Тогда
		Возврат Новый ТабличныйДокумент;
	КонецЕсли;
	
	НастройкиОтчета = ВариантОтчета.Настройки;
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("Период", 				Новый СтандартныйПериод(Дата(1, 1, 1), Дата(1, 1, 1)));
	СтруктураПараметров.Вставить("НачалоПериода",		Дата(1, 1, 1));
	СтруктураПараметров.Вставить("КонецПериода",		Дата(1, 1, 1));
	СтруктураПараметров.Вставить("ТолькоПроведенные",	Ложь);
	
	Для каждого ПараметрЗаполнения Из СтруктураПараметров Цикл
		
		ПараметрКомпоновкиДанных = Новый ПараметрКомпоновкиДанных(ПараметрЗаполнения.Ключ);
		ЗначениеПараметра = НастройкиОтчета.ПараметрыДанных.НайтиЗначениеПараметра(ПараметрКомпоновкиДанных);
		Если ЗначениеПараметра <> Неопределено Тогда
			ЗначениеПараметра.Значение = ПараметрЗаполнения.Значение;
			ЗначениеПараметра.Использование = Истина;
		Иначе
			НовыйПараметр = НастройкиОтчета.ПараметрыДанных.Элементы.Добавить();
			НовыйПараметр.Параметр = ПараметрКомпоновкиДанных;
			НовыйПараметр.Значение = ПараметрЗаполнения.Значение;
			НовыйПараметр.Использование = Истина;
		КонецЕсли;
		
	КонецЦикла;
	
	НастройкиОтчета.Отбор.Элементы.Очистить();
	ЭлементОтбора = НастройкиОтчета.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИсполнительныйЛист");
	ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
	ЭлементОтбора.ПравоеЗначение = СписокДокументов;
	ЭлементОтбора.Использование = Истина;
	
	ОтчетОбъект.КомпоновщикНастроек.ЗагрузитьНастройки(НастройкиОтчета);
	
	ДокументРезультат = Новый ТабличныйДокумент;
	
	ОтчетОбъект.СкомпоноватьРезультат(ДокументРезультат);
	
	Возврат ДокументРезультат;
	
КонецФункции

#КонецОбласти

#КонецЕсли