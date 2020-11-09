#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура РезультатОбработкаРасшифровки(Элемент, Расшифровка, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	СтруктураРасшифровки = РасшифровкаНаСервере(Расшифровка);
	Если СтруктураРасшифровки = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Отбор = Новый Структура;
	Отбор.Вставить("Вакансия", СтруктураРасшифровки.Вакансия);
	Отбор.Вставить("Кандидат", СтруктураРасшифровки.Кандидат);
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("Отбор", Отбор);
	ПараметрыОткрытия.Вставить("СформироватьПриОткрытии", Истина);
	
	ОткрытьФорму("Отчет.МотиваторыКандидата.Форма", ПараметрыОткрытия, , Истина);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция РасшифровкаНаСервере(Расшифровка)
	
	ДанныеРасшифровкиОбъект = ПолучитьИзВременногоХранилища(ДанныеРасшифровки);
	Если ДанныеРасшифровкиОбъект.Элементы[Расшифровка].ПолучитьПоля()[0].Поле = "Количество" Тогда
		ИДКандидата = ДанныеРасшифровкиОбъект.Элементы[Расшифровка].ПолучитьРодителей()[1].Идентификатор;
		Кандидат = ДанныеРасшифровкиОбъект.Элементы[ИДКандидата].ПолучитьПоля()[0].Значение;
		Вакансия = ДанныеРасшифровкиОбъект.Настройки.ПараметрыДанных.Элементы.Найти("Вакансия").Значение;
		Если ЗначениеЗаполнено(Кандидат) Тогда
			СтруктураРасшифровки = Новый Структура;
			СтруктураРасшифровки.Вставить("Кандидат", Кандидат);
			СтруктураРасшифровки.Вставить("Вакансия", Вакансия);
			Возврат СтруктураРасшифровки;
		КонецЕсли;
	ИначеЕсли ДанныеРасшифровкиОбъект.Элементы[Расшифровка].ПолучитьПоля()[0].Поле = "Кандидат" Тогда
		Кандидат = ДанныеРасшифровкиОбъект.Элементы[Расшифровка].ПолучитьПоля()[0].Значение;
		Вакансия = ДанныеРасшифровкиОбъект.Настройки.ПараметрыДанных.Элементы.Найти("Вакансия").Значение;
		Если ЗначениеЗаполнено(Кандидат) Тогда
			СтруктураРасшифровки = Новый Структура;
			СтруктураРасшифровки.Вставить("Кандидат", Кандидат);
			СтруктураРасшифровки.Вставить("Вакансия", Вакансия);
			Возврат СтруктураРасшифровки;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

#КонецОбласти
