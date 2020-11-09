///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Ключ.Пустая()
		И Не ЗначениеЗаполнено(Параметры.ЗначениеКопирования)
		И Не ЗначениеЗаполнено(Параметры.Основание) Тогда
		Параметры.Свойство("Организация", Объект.Организация);
		Параметры.Свойство("Сотрудник", Объект.Сотрудник);
		ЗначенияДляЗаполнения = Новый Структура;
		ЗначенияДляЗаполнения.Вставить("Организация", "Объект.Организация");
		ЗначенияДляЗаполнения.Вставить("Ответственный", "Объект.Ответственный");
		ЗарплатаКадры.ЗаполнитьПервоначальныеЗначенияВФорме(ЭтотОбъект, ЗначенияДляЗаполнения);
		Если Не ЗначениеЗаполнено(Объект.ОтветственныйЗаОбработкуПерсональныхДанных)
			И ЗначениеЗаполнено(Объект.Ответственный) Тогда
			Объект.ОтветственныйЗаОбработкуПерсональныхДанных = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(
				Объект.Ответственный, "ФизическоеЛицо");
		КонецЕсли;
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ИсторияИзменений",
		"Видимость",
		СЭДОФСС.ЕстьПравоПросмотраЖурнала());
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
	Если Параметры.Ключ.Пустая() Тогда
		ПриПолученииДанныхНаСервере("Объект");
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения
	
	ПриПолученииДанныхНаСервере(ТекущийОбъект);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Запись_СогласиеНаУведомлениеОбЭЛН"
		И (Источник = Объект.Ссылка Или Источник = Неопределено) Тогда
		ОтключитьОбработчикОжидания("ПрочитатьНаКлиенте");
		ПодключитьОбработчикОжидания("ПрочитатьНаКлиенте", 0.1, Истина);
	КонецЕсли;
	
	// СтандартныеПодсистемы.Свойства
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	ФиксацияЗаполнитьИдентификаторыФиксТЧ(ЭтотОбъект);
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Ошибки = ТекущийОбъект.КритичныеОшибкиЗаполнения();
	Для Каждого Ошибка Из Ошибки Цикл
		Отказ = Истина;
		Ошибка.Сообщить();
	КонецЦикла;
	
	ФиксацияВторичныхДанныхВДокументахКлиентСервер.СохранитьРеквизитыФормыФикс(ЭтотОбъект, ТекущийОбъект);
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	ФиксацияЗаполнитьРеквизитыФормыФикс(ТекущийОбъект);
	ФиксацияВторичныхДанныхВДокументахФормы.УстановитьОбъектЗафиксирован(ЭтотОбъект);
	ФиксацияОбновитьФиксациюВФорме();
	
	ОбновитьВидимостьДоступность();
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("Запись_СогласиеНаУведомлениеОбЭЛН", ПараметрыЗаписи, Объект.Ссылка);
	ОтключитьОбработчикОжидания("ПрочитатьНаКлиенте");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	
	ОрганизацияПриИзмененииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтветственныйЗаОбработкуПерсональныхДанныхПриИзменении(Элемент)
	
	ОтветственныйЗаОбработкуПерсональныхДанныхПриИзмененииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура СотрудникПриИзменении(Элемент)
	
	СотрудникПриИзмененииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаПриИзменении(Элемент)
	
	ДатаПриИзмененииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура КомментарийНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ОбщегоНазначенияКлиент.ПоказатьФормуРедактированияКомментария(Элемент.ТекстРедактирования, ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаОтзываСогласияНажатие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ПоказатьЗначение(, ОснованиеОтзываСогласия);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.Свойства
&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.Свойства") Тогда
		МодульУправлениеСвойствамиКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеСвойствамиКлиент");
		МодульУправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
	КонецЕсли;
	
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

&НаКлиенте
Процедура ОбновитьВторичныеДанные(Команда)
	ОбновитьВторичныеДанныеНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ОтменитьИсправления(Команда)
	ОтменитьВсеИсправленияНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПометитьНаУдаление(Команда)
	ИзменитьПометкуУдаления(Истина);
КонецПроцедуры

&НаКлиенте
Процедура СнятьПометкуУдаления(Команда)
	ИзменитьПометкуУдаления(Ложь);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Обслуживание_формы

&НаСервере
Процедура ПриПолученииДанныхНаСервере(ТекущийОбъект)
	Если ПараметрыПодключаемыхКоманд = Неопределено Тогда
		// СтандартныеПодсистемы.ПодключаемыеКоманды
		ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
		// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	КонецЕсли;
	
	ФиксацияВторичныхДанныхВДокументахФормы.ИнициализироватьМеханизмФиксацииРеквизитов(ЭтотОбъект, ТекущийОбъект);
	ФиксацияВторичныхДанныхВДокументахФормы.ПодключитьОбработчикиФиксацииИзмененийРеквизитов(ЭтотОбъект, ФиксацияБыстрыйПоискРеквизитов());
	ОбновитьВторичныеДанныеНаСервере();
	ФиксацияОбновитьФиксациюВФорме();
КонецПроцедуры

&НаСервере
Процедура ОбновитьВидимостьДоступность()
	ОбновитьГруппуОтзываСогласия();
	
	Элементы.Дата.ТолькоПросмотр              = Объект.Проведен;
	Элементы.ОрганизацияГруппа.ТолькоПросмотр = Объект.Проведен;
	Элементы.СотрудникГруппа.ТолькоПросмотр   = Объект.Проведен;
	Элементы.ГруппаОтветственныйЗаОбработкуПерсональныхДанных.ТолькоПросмотр = Объект.Проведен;
	Элементы.ФормаПометитьНаУдаление.Видимость = Не Объект.ПометкаУдаления;
	Элементы.ФормаСнятьПометкуУдаления.Видимость   = Объект.ПометкаУдаления;
	
	Если Объект.ПометкаУдаления Тогда
		ТекущаяСтраница = Элементы.СтраницаДокументПомеченНаУдаление;
		Элементы.ФормаЗаписать.КнопкаПоУмолчанию = Истина;
	ИначеЕсли Не Объект.Проведен Тогда
		ТекущаяСтраница = Элементы.СтраницаДокументНеПроведен;
		ТаблицаКоманд = ПолучитьИзВременногоХранилища(ПараметрыПодключаемыхКоманд.АдресТаблицыКоманд);
		Команда = ТаблицаКоманд.Найти("СогласиеНаУведомлениеОбЭЛН", "Идентификатор");
		Если Команда <> Неопределено Тогда
			Элементы[Команда.ИмяВФорме].КнопкаПоУмолчанию = Истина;
		КонецЕсли;
	ИначеЕсли Объект.СотрудникПодписалСогласие Тогда
		ТекущаяСтраница = Элементы.СтраницаДокументПроведенИПодписан;
		Элементы.ФормаПровестиИЗакрыть.КнопкаПоУмолчанию = Истина;
	Иначе
		ТекущаяСтраница = Элементы.СтраницаДокументПроведенИНеПодписан;
		Элементы.ФормаПровестиИЗакрыть.КнопкаПоУмолчанию = Истина;
	КонецЕсли;
	
	Элементы.СтраницыРезультатыПодписания.ТекущаяСтраница = ТекущаяСтраница;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьГруппуОтзываСогласия()
	
	Отбор = Новый Структура("Сотрудник, Организация", Объект.Сотрудник, Объект.Организация);
	ДействующееСогласие = РегистрыСведений.СогласияНаУведомленияОбЭЛН.Получить(Отбор);
	Если ДействующееСогласие = Неопределено Тогда
		// Не обнаружено действующего согласия.
		Элементы.ГруппаСогласиеОтозвано.Видимость = Ложь;
		Возврат;
	КонецЕсли;
	
	ОснованиеОтзываСогласия = ДействующееСогласие.ОснованиеОтзываСогласия;
	ДатаОтзываСогласия = ДействующееСогласие.ДатаОтзываСогласия;
	
	Если ДействующееСогласие.Состояние = Перечисления.СостоянияСогласийНаУведомленияОбЭЛН.Отозвано
		И НачалоДня(ДатаОтзываСогласия) < НачалоДня(ЗарплатаКадрыПериодическиеРегистры.МаксимальнаяДата())
		И НачалоДня(ДатаОтзываСогласия) > НачалоДня(Объект.Дата) Тогда
		
		// Действие этого документа было отменено указанным отзывом согласия.
		Элементы.ГруппаСогласиеОтозвано.Видимость = Истина;
		Элементы.Скопировать.Видимость = ТипЗнч(ОснованиеОтзываСогласия) = Тип("ДокументСсылка.ОтзывСогласияНаУведомлениеОбЭЛН");
		
	Иначе
		
		// Отзыв согласия не отменяет действие данного документа.
		Элементы.ГруппаСогласиеОтозвано.Видимость = Ложь;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПрочитатьНаКлиенте()
	Если Не Модифицированность Тогда
		Прочитать();
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область Обслуживание_элементов_шапки

&НаСервере
Процедура ОрганизацияПриИзмененииНаСервере()
	ФиксацияВторичныхДанныхВДокументахКлиентСервер.СброситьФиксациюИзмененийРеквизитовПоОснованиюЗаполнения(ЭтотОбъект, "Организация");
	СотрудникПриИзмененииНаСервере();
КонецПроцедуры

&НаСервере
Процедура ОтветственныйЗаОбработкуПерсональныхДанныхПриИзмененииНаСервере()
	ФиксацияВторичныхДанныхВДокументахКлиентСервер.СброситьФиксациюИзмененийРеквизитовПоОснованиюЗаполнения(ЭтотОбъект, "ОтветственныйЗаОбработкуПерсональныхДанных");
	ОбновитьВторичныеДанныеНаСервере();
	ФиксацияОбновитьФиксациюВФорме();
КонецПроцедуры

&НаСервере
Процедура СотрудникПриИзмененииНаСервере()
	ФиксацияВторичныхДанныхВДокументахКлиентСервер.СброситьФиксациюИзмененийРеквизитовПоОснованиюЗаполнения(ЭтотОбъект, "Сотрудник");
	ОбновитьВторичныеДанныеНаСервере();
	ФиксацияОбновитьФиксациюВФорме();
КонецПроцедуры

&НаСервере
Процедура ДатаПриИзмененииНаСервере()
	ОбновитьВидимостьДоступность();
КонецПроцедуры

#КонецОбласти

#Область Обслуживание_команд

&НаКлиенте
Процедура ИзменитьПометкуУдаления(ПометкаУдаления)
	Если Модифицированность Тогда
		Если Не Записать() Тогда
			Возврат;
		КонецЕсли;
	Иначе
		Прочитать();
	КонецЕсли;
	
	Массив = Новый Массив;
	Массив.Добавить(Объект);
	СЭДОФССКлиент.ИзменитьПометкуУдаленияСогласий(Массив, ПометкаУдаления);
КонецПроцедуры

#КонецОбласти

#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#Область Свойства

// СтандартныеПодсистемы.Свойства
&НаСервере
Процедура ОбновитьЭлементыДополнительныхРеквизитов()
	УправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

#КонецОбласти

#Область ФиксацияВторичныхДанныхВДокументах

&НаСервере
Функция ОбъектЗафиксирован() Экспорт
	Возврат РеквизитФормыВЗначение("Объект").ОбъектЗафиксирован();
КонецФункции

&НаСервере
Процедура ОбновитьВторичныеДанныеНаСервере(ФиксироватьОтличия = Ложь)
	Если ФиксацияВторичныхДанныхВДокументахКлиентСервер.ОбъектФормыЗафиксирован(ЭтотОбъект) Тогда
		ОбновитьВидимостьДоступность();
		Возврат;
	КонецЕсли;
	
	ФиксацияЗаполнитьИдентификаторыФиксТЧ(ЭтотОбъект);
	ДокументОбъект = РеквизитФормыВЗначение("Объект");
	ФиксацияВторичныхДанныхВДокументахКлиентСервер.СохранитьРеквизитыФормыФикс(ЭтотОбъект, ДокументОбъект);
	
	ПараметрыФиксации = ЭтотОбъект["ПараметрыФиксацииВторичныхДанных"];
	ПараметрыФиксации.ФиксироватьОтличия = ФиксироватьОтличия;
	ДокументИзменен = ДокументОбъект.ОбновитьВторичныеДанные(ПараметрыФиксации);
	ПараметрыФиксации.ФиксироватьОтличия = Ложь;
	
	Если ДокументИзменен Тогда
		Если Не ДокументОбъект.ЭтоНовый() Тогда
			ФиксацияВторичныхДанныхВДокументахФормы.УстановитьМодифицированность(ЭтотОбъект, Истина);
		КонецЕсли;
		ЗначениеВРеквизитФормы(ДокументОбъект, "Объект");
	КонецЕсли;
	
	ОбновитьВидимостьДоступность();
	
	ФиксацияЗаполнитьРеквизитыФормыФикс(Объект);
КонецПроцедуры

&НаСервере
Функция ФиксацияОписаниеФормы(ПараметрыФиксацииВторичныхДанных) Экспорт
	ОписаниеФормы = ФиксацияВторичныхДанныхВДокументахФормы.ОписаниеФормы();
	
	ОписаниеЭлементовФормы = Новый Соответствие();
	ОписаниеЭлементаФормы = ФиксацияВторичныхДанныхВДокументахФормы.ОписаниеЭлементаФормы();
	ОписаниеЭлементаФормы.ПрефиксПути = "Объект";
	Для Каждого ОписаниеФиксацииРеквизита Из ПараметрыФиксацииВторичныхДанных.ОписаниеФиксацииРеквизитов Цикл
		ОписаниеЭлементовФормы.Вставить(ОписаниеФиксацииРеквизита.Ключ, ОписаниеЭлементаФормы);
	КонецЦикла;
	ОписаниеФормы.Вставить("ОписаниеЭлементовФормы", ОписаниеЭлементовФормы);
	
	ОписаниеФормы.Вставить("ФормаРедактируетсяПослеФиксации", Ложь);
	Возврат ОписаниеФормы;
КонецФункции

&НаСервере
Функция ФиксацияБыстрыйПоискРеквизитов()
	БыстрыйПоискРеквизитов = Новый Соответствие; // Ключ - имя элемента, значение - имя реквизита.
	
	ПараметрыФиксации = ЭтотОбъект["ПараметрыФиксацииВторичныхДанных"];
	Для Каждого КлючИЗначение Из ПараметрыФиксации.ОписаниеФиксацииРеквизитов Цикл
		ИмяРеквизита = КлючИЗначение.Значение.ИмяРеквизита;
		Если Элементы.Найти(ИмяРеквизита) <> Неопределено Тогда
			БыстрыйПоискРеквизитов.Вставить(ИмяРеквизита, ИмяРеквизита);
		ИначеЕсли Элементы.Найти(КлючИЗначение.Ключ) <> Неопределено Тогда
			БыстрыйПоискРеквизитов.Вставить(КлючИЗначение.Ключ, ИмяРеквизита);
		КонецЕсли;
	КонецЦикла;
	
	Возврат БыстрыйПоискРеквизитов;
КонецФункции

&НаСервере
Процедура ФиксацияОбновитьФиксациюВФорме()
	ФиксацияВторичныхДанныхВДокументахКлиентСервер.ОбновитьФорму(ЭтотОбъект);
КонецПроцедуры

&НаСервере
Процедура ФиксацияЗаполнитьРеквизитыФормыФикс(ТекущийОбъект)
	ФиксацияВторичныхДанныхВДокументахФормы.ЗаполнитьРеквизитыФормыФикс(ЭтотОбъект, ТекущийОбъект);
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ФиксацияЗаполнитьИдентификаторыФиксТЧ(Форма)
	ОписанияТЧ = Форма["ПараметрыФиксацииВторичныхДанных"]["ОписанияТЧ"];
	Если ОписанияТЧ = Неопределено Тогда
		Возврат;
	КонецЕсли;
	Для каждого ОписаниеТЧ Из ОписанияТЧ Цикл
		ФиксацияВторичныхДанныхВДокументахКлиентСервер.ЗаполнитьИдентификаторыФиксТЧ(Форма.Объект[ОписаниеТЧ.Ключ]);
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ОтменитьВсеИсправленияНаСервере()
	ФиксацияВторичныхДанныхВДокументахКлиентСервер.ОчиститьФиксациюИзменений(ЭтотОбъект, Объект);
	ФиксацияЗаполнитьРеквизитыФормыФикс(Объект);
	ОбновитьВторичныеДанныеНаСервере();
	ФиксацияОбновитьФиксациюВФорме();
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ЗафиксироватьИзменениеРеквизитаВФорме(Элемент, СтандартнаяОбработка = Ложь) Экспорт
	ОписаниеЭлементов = ФиксацияБыстрыйПоискРеквизитов();
	ФиксацияВторичныхДанныхВДокументахКлиентСервер.Подключаемый_ЗафиксироватьИзменениеРеквизитаВФорме(ЭтотОбъект, Элемент, ОписаниеЭлементов);
КонецПроцедуры

#КонецОбласти

#КонецОбласти
