#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.ОбновлениеВерсииИБ

////////////////////////////////////////////////////////////////////////////////
// Сведения о библиотеке (или конфигурации).

// См. ОбновлениеИнформационнойБазыБСП.ПриДобавленииПодсистемы.
Процедура ПриДобавленииПодсистемы(Описание) Экспорт
	
	Описание.Имя = Метаданные.Имя;
	Описание.Версия = Метаданные.Версия;
	Описание.ИдентификаторИнтернетПоддержки = КонфигурацииЗарплатаКадры.Модуль().ИдентификаторИнтернетПоддержки();
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Обработчики обновления информационной базы.

// См. ОбновлениеИнформационнойБазыБСП.ПриДобавленииОбработчиковОбновления.
Процедура ПриДобавленииОбработчиковОбновления(Обработчики) Экспорт
	
	ОрганизацииСлужебный.ПриДобавленииОбработчиковОбновления(Обработчики);
	
КонецПроцедуры

// См. ОбновлениеИнформационнойБазыПереопределяемый.ПередОбновлениемИнформационнойБазы.
Процедура ПередОбновлениемИнформационнойБазы() Экспорт
	
КонецПроцедуры

// См. ОбновлениеИнформационнойБазыПереопределяемый.ПослеОбновленияИнформационнойБазы.
Процедура ПослеОбновленияИнформационнойБазы(Знач ПредыдущаяВерсия, Знач ТекущаяВерсия,
		Знач ВыполненныеОбработчики, ВыводитьОписаниеОбновлений, МонопольныйРежим) Экспорт
	
КонецПроцедуры

// См. ОбновлениеИнформационнойБазыПереопределяемый.ПриПодготовкеМакетаОписанияОбновлений.
Процедура ПриПодготовкеМакетаОписанияОбновлений(Знач Макет) Экспорт
	
КонецПроцедуры

// См. ОбновлениеИнформационнойБазыБСП.ПриОпределенииРежимаОбновленияДанных.
Процедура ПриОпределенииРежимаОбновленияДанных(РежимОбновленияДанных, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// См. ОбновлениеИнформационнойБазыБСП.ПриДобавленииОбработчиковПереходаСДругойПрограммы.
Процедура ПриДобавленииОбработчиковПереходаСДругойПрограммы(Обработчики) Экспорт
	
	Обработчик = Обработчики.Добавить();
	Обработчик.ПредыдущееИмяКонфигурации  = "ЗарплатаИУправлениеПерсоналомБазовая";
	Обработчик.Процедура                  = "ОбновлениеИнформационнойБазыКонфигурацииЗарплатаКадры.ПереходСБазовойВерсии";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.ПредыдущееИмяКонфигурации  = "ЗарплатаИКадрыГосударственногоУчрежденияБазовая";
	Обработчик.Процедура                  = "ОбновлениеИнформационнойБазыКонфигурацииЗарплатаКадры.ПереходСБазовойВерсии";
	
	ЗарплатаКадрыВнутренний.ПриДобавленииОбработчиковПереходаСДругойПрограммы(Обработчики);
	
КонецПроцедуры

// См. ОбновлениеИнформационнойБазыБСП.ПриЗавершенииПереходаСДругойПрограммы.
Процедура ПриЗавершенииПереходаСДругойПрограммы(Знач ПредыдущееИмяКонфигурации, 
	Знач ПредыдущаяВерсияКонфигурации, Параметры) Экспорт
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.ОбновлениеВерсииИБ

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ОбработчикиОбновленияИнформационнойБазы

Процедура ПереходСБазовойВерсии() Экспорт

	КонфигурацииЗарплатаКадры.УстановитьФункциональнуюОпциюРазрешитьДобавлениеОрганизацииЗарплатаКадры();
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ЗарплатаКадрыБазоваяВерсия") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("ЗарплатаКадрыБазоваяВерсия");
		Модуль.УстановитьЗначениеКонстантыНеИспользуетсяБазоваяВерсия();
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#КонецОбласти
