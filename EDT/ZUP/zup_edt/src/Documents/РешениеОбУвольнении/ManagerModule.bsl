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
	|	ЗначениеРазрешено(Организация)
	|	И ЗначениеРазрешено(ФизическоеЛицо)";
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
	
	МетаданныеДокумента = Метаданные.Документы.РешениеОбУвольнении;
	Возврат ЗарплатаКадрыСоставДокументов.ОписаниеСоставаОбъектаФизическоеЛицоВШапке();
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПараметрыЗаполненияМероприятий(Объект) Экспорт
	
	ПараметрыЗаполнения = АдаптацияУвольнение.ПараметрыЗаполненияМероприятий();
	
	ПараметрыЗаполнения.Организация = Объект.Организация;
	ПараметрыЗаполнения.Сотрудник = Объект.Сотрудник;
	ПараметрыЗаполнения.ФизическоеЛицо = Объект.ФизическоеЛицо;
	ПараметрыЗаполнения.ВидСобытия = ВидСобытияАдаптацииУвольнения();
	ПараметрыЗаполнения.ДатаСобытия = Объект.ДатаУвольнения;
	
	УстановитьПривилегированныйРежим(Истина);
	
	Поля = "ДолжностьПоШтатномуРасписанию,Подразделение,Должность";
	ДанныеСотрудников = КадровыйУчет.КадровыеДанныеСотрудников(Ложь, ПараметрыЗаполнения.Сотрудник, Поля, ПараметрыЗаполнения.ДатаСобытия, , Ложь);
	
	УстановитьПривилегированныйРежим(Ложь);
	
	Если ДанныеСотрудников.Количество() > 0 Тогда
		
		ТекущиеКадровыеДанныеСотрудника = ДанныеСотрудников[0];
		
		ПараметрыЗаполнения.ПредыдущаяПозиция = ТекущиеКадровыеДанныеСотрудника.ДолжностьПоШтатномуРасписанию;
		ПараметрыЗаполнения.ПредыдущееПодразделение = ТекущиеКадровыеДанныеСотрудника.Подразделение;
		ПараметрыЗаполнения.ПредыдущаяДолжность = ТекущиеКадровыеДанныеСотрудника.Должность;
		
	КонецЕсли;
	
	Возврат ПараметрыЗаполнения;
	
КонецФункции

Функция ВидСобытияАдаптацииУвольнения() Экспорт
	
	Возврат АдаптацияУвольнение.СобытиеУвольнение();
	
КонецФункции

Функция ПоляПроверкиУникальности() Экспорт
	
	ПоляПроверки = Новый Массив();
	
	ПоляПроверки.Добавить("Организация");
	ПоляПроверки.Добавить("Сотрудник");
	
	Возврат ПоляПроверки;
	
КонецФункции

Функция СоответствиеРеквизитовОтбораРеквизитамПриказа() Экспорт
	
	СоответствиеРеквизитов = Новый Соответствие;
	СоответствиеРеквизитов.Вставить("Сотрудник", "Сотрудник");
	
	Возврат СоответствиеРеквизитов;
	
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
