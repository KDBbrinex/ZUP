#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.ВариантыОтчетов

// См. ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов.
//
Процедура НастроитьВариантыОтчета(Настройки, НастройкиОтчета) Экспорт
	
	НастройкиОтчета.ОпределитьНастройкиФормы = Истина;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыКорпоративнаяПодсистемы.КадровыйУчет.ДистанционнаяРабота") Тогда
		НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "Т5КОРП");
	Иначе
		НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "Т5");
	КонецЕсли;
	
	НастройкиВарианта.Описание = НСтр("ru = 'Унифицированная форма № Т-5'");
	
	НастройкиВарианта.Включен = Ложь;
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.ВариантыОтчетов

#КонецОбласти

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода, СписокСотрудников = Неопределено) Экспорт
	
	Если СписокСотрудников <> Неопределено Тогда
		
		СписокОтборов = Новый Массив;
		
		ЗарплатаКадрыОбщиеНаборыДанных.ДобавитьВКоллекциюОтбор(
			СписокОтборов, "Работа.Сотрудник", ВидСравненияКомпоновкиДанных.ВСписке, СписокСотрудников);
		
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("Отбор", СписокОтборов);
		
	Иначе
		ДополнительныеПараметры = Неопределено;
	КонецЕсли;
	
	ЗарплатаКадрыОтчеты.ВывестиВКоллекциюПечатнуюФорму("Отчет.ПечатнаяФормаТ5",
		МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода, , ДополнительныеПараметры);
	
КонецПроцедуры

Процедура Сформировать(ДокументРезультат, РезультатКомпоновки, ОбъектыПечати = Неопределено) Экспорт
	
	Если РезультатКомпоновки.ОтчетПустой Тогда
		Возврат;
	КонецЕсли;
	
	КадровыйУчет.ВывестиНаПечатьТ5(
		ДокументРезультат,
		РезультатКомпоновки.ДанныеОтчета.Строки,
		РезультатКомпоновки.МакетПечатнойФормы,
		РезультатКомпоновки.ИдентификаторыМакета,
		ОбъектыПечати);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли