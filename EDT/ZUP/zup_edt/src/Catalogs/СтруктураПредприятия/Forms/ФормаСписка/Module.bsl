#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.РежимВыбора Тогда
		Элементы.Список.РежимВыбора = Истина;
	КонецЕсли;
	
	Соответствие = Новый Соответствие;
	Соответствие.Вставить(Тип("СправочникСсылка.Организации"), "Справочник.Организации");
	Соответствие.Вставить(Тип("СправочникСсылка.ПодразделенияОрганизаций"), "Справочник.ПодразделенияОрганизаций");
	
	ТаблицыИсточника = Новый ФиксированноеСоответствие(Соответствие);
	
	ТаблицаИсточникаПоУмолчанию = Неопределено;
	Если Не ПолучитьФункциональнуюОпцию("СтруктураПредприятияНеСоответствуетСтруктуреЮридическихЛиц") Тогда
		ТаблицаИсточникаПоУмолчанию = "Справочник.ПодразделенияОрганизаций";
	КонецЕсли;
	
	ЗарплатаКадры.ПриСозданииНаСервереФормыСДинамическимСписком(ЭтотОбъект, "Список");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	
	Если ПустаяСтрока(ТаблицаИсточникаПоУмолчанию) Тогда
		Возврат;
	КонецЕсли;
	
	Отказ = Истина;
	
	ТаблицаИсточника = ТаблицаИсточникаПоУмолчанию;
	
	ПараметрыФормы = Новый Структура;
	Если Копирование Тогда
		ПараметрыФормы.Вставить("ЗначениеКопирования", Элемент.ТекущиеДанные.Источник);
		ТаблицаИсточника = ТаблицыИсточника.Получить(ТипЗнч(Элемент.ТекущиеДанные.Источник));
	КонецЕсли;
	
	ОткрытьФорму(ТаблицаИсточника + ".ФормаОбъекта", ПараметрыФормы, ЭтаФорма);
	
КонецПроцедуры

&НаСервере
Процедура СписокПередЗагрузкойПользовательскихНастроекНаСервере(Элемент, Настройки)
	ЗарплатаКадры.ПроверитьПользовательскиеНастройкиДинамическогоСписка(ЭтотОбъект, Настройки);
КонецПроцедуры

&НаСервере
Процедура СписокПриОбновленииСоставаПользовательскихНастроекНаСервере(СтандартнаяОбработка)
	
	ЗарплатаКадры.ПроверитьПользовательскиеНастройкиДинамическогоСписка(ЭтотОбъект, , СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти
