#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
#Область ПрограммныйИнтерфейс

// СтандартныеПодсистемы.ВерсионированиеОбъектов

// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
//  Настройки - Структура - настройки подсистемы.
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт

КонецПроцедуры

// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	// Ограничения доступа в ролях:
	// Чтение / Изменение
	// #ПоЗначениямРасширенный( "Документ.<ИмяДокумента>", "", "",
	// "ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Пользователи КАК Т1 ПО Т1.ФизическоеЛицо = Т.ФизическоеЛицо",
	// "",
	// "ГруппыФизическихЛиц", "Т.ФизическоеЛицо","ИЛИ",
	// "Условие", "Т1.Ссылка = &АвторизованныйПользователь", "", "","","", "","","", "","","", "","","", "","","",
	// "","","", "","","", "","","", "","","", "","","", "","","", "","","", "","","", "","","")
	Ограничение.Текст =
	"ПрисоединитьДополнительныеТаблицы
	|ЭтотСписок КАК Т
	|
	|ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Пользователи КАК Т1
	|	ПО Т1.ФизическоеЛицо = Т.ФизическоеЛицо
	|;
	|РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Т.ФизическоеЛицо)
	|	ИЛИ ЭтоАвторизованныйПользователь(Т1.Ссылка)";
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает описание состава документа
//
// Возвращаемое значение:
//  Структура - см. ЗарплатаКадрыСоставДокументов.НовоеОписаниеСоставаОбъекта.
Функция ОписаниеСоставаОбъекта() Экспорт
	Возврат ЗарплатаКадрыСоставДокументов.ОписаниеСоставаОбъектаФизическоеЛицоВШапке("ФизическоеЛицо", "");
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Печать

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
КонецПроцедуры

#КонецОбласти

Процедура ДобавитьКомандыСозданияДокументов(КомандыСозданияДокументов, ДополнительныеПараметры) Экспорт
	
	ПредставлениеДокумента = Метаданные.Документы.ЗаявкаНаОтпуск.Представление();
	
	ОписаниеКоманды = ЗарплатаКадрыРасширенный.ОписаниеКомандыСозданияДокумента(
		"Документ.ЗаявкаНаОтпуск",
		ПредставлениеДокумента);
		
	ЗарплатаКадрыРасширенный.ДобавитьВКоллекциюКомандуСозданияДокумента(
		КомандыСозданияДокументов, ОписаниеКоманды);
		
	Если Не ДополнительныеПараметры.ЗаявкиТекущегоПользователя  
		И Пользователи.РолиДоступны("ИспользованиеГрупповоеСозданиеЗаявокСотрудников") Тогда 	
		
		ПредставлениеКоманды = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = '%1 списком'"), ПредставлениеДокумента);
		
		ОписаниеКоманды = ЗарплатаКадрыРасширенный.ОписаниеКомандыСозданияДокумента(
			"Обработка.ГрупповоеСозданиеЗаявокСотрудников",
			ПредставлениеКоманды,
			ПредставлениеДокумента + 1,
			"Форма");
		
		Параметры = Новый Структура;
		Параметры.Вставить("ВидЗаявки", "ЗаявкаНаОтпуск");
		Параметры.Вставить("Заголовок", НСтр("ru = 'Создание заявок на отпуск'"));
		
		ОписаниеКоманды.Параметры = Параметры; 
		
		ЗарплатаКадрыРасширенный.ДобавитьВКоллекциюКомандуСозданияДокумента(
			КомандыСозданияДокументов, ОписаниеКоманды);
			
	КонецЕсли; 
	
КонецПроцедуры

Функция ДоступноСогласованиеДокумента() Экспорт 
	
	Возврат Пользователи.РолиДоступны("СогласованиеЗаявокНаОтпуск", , Ложь);
	
КонецФункции

#КонецОбласти

#КонецЕсли