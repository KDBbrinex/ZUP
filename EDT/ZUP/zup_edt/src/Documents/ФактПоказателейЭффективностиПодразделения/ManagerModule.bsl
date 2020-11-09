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
	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Подразделение)";
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Функция ДобавитьКомандыСозданияДокументов(КомандыСозданияДокументов, ДополнительныеПараметры) Экспорт
	
	ОписаниеКоманды = ЗарплатаКадрыРасширенный.ОписаниеКомандыСозданияДокумента(
		"Документ.ФактПоказателейЭффективностиПодразделения",
		НСтр("ru = 'Факт показателей подразделения'"));
	
	ЗарплатаКадрыРасширенный.ДобавитьВКоллекциюКомандуСозданияДокумента(
		КомандыСозданияДокументов, ОписаниеКоманды);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПолучитьДанныеДляПроведения(Ссылка)Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ФактПоказателейЭффективностиПодразделения.Ссылка.Период КАК Период,
		|	ФактПоказателейЭффективностиПодразделения.Ссылка.Горизонт КАК Горизонт,
		|	ФактПоказателейЭффективностиПодразделения.Ссылка.Подразделение КАК Подразделение,
		|	ФактПоказателейЭффективностиПодразделения.Показатель КАК Показатель,
		|	ФактПоказателейЭффективностиПодразделения.Значение КАК Значение
		|ИЗ
		|	Документ.ФактПоказателейЭффективностиПодразделения.Показатели КАК ФактПоказателейЭффективностиПодразделения
		|ГДЕ
		|	ФактПоказателейЭффективностиПодразделения.Ссылка = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ДанныеДляПроведения = Новый Структура;
	ДанныеДляПроведения.Вставить("ФактПодразделений", РезультатЗапроса.Выгрузить());
	
	Возврат ДанныеДляПроведения;

КонецФункции	

#Область Печать

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли
