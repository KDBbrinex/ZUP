#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Элементы.Список.РежимВыбора = Параметры.РежимВыбора;
	
	ЗаполнитьРеквизитИспользоватьОтпускаУчебные();
	
	УстановитьОтборыСписка(ЭтаФорма, Параметры);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПараметрыРазмещения = ПодключаемыеКоманды.ПараметрыРазмещения();
	ПараметрыРазмещения.КоманднаяПанель = Элементы.КоманднаяПанельФормы;
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект, ПараметрыРазмещения);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	ЗарплатаКадры.ПриСозданииНаСервереФормыСДинамическимСписком(ЭтотОбъект, "Список");
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ЗаписанДокументОтпуск" 
		ИЛИ ИмяСобытия = "ЗаписанДокументОтпускаСотрудников"
		ИЛИ ИмяСобытия = "ЗаписьДокументаКомандировка"
		ИЛИ ИмяСобытия = "ЗаписьДокументаКомандировкиСотрудников" Тогда
		
		Элементы.Список.Обновить();
		УстановитьДоступностьКоманд();
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти 

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	УстановитьДоступностьКоманд();
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура СписокПередЗагрузкойПользовательскихНастроекНаСервере(Элемент, Настройки)
	 ЗарплатаКадры.ПроверитьПользовательскиеНастройкиДинамическогоСписка(ЭтотОбъект, Настройки);
КонецПроцедуры

&НаСервере
Процедура СписокПриОбновленииСоставаПользовательскихНастроекНаСервере(СтандартнаяОбработка)
	
	ЗарплатаКадры.ПроверитьПользовательскиеНастройкиДинамическогоСписка(ЭтотОбъект, , СтандартнаяОбработка);
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура СписокПриПолученииДанныхНаСервере(ИмяЭлемента, Настройки, Строки)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ДокументОснованиеКомандировка.Обучение КАК Обучение
		|ИЗ
		|	РегистрСведений.КомандировкаОснования КАК ДокументОснованиеКомандировка
		|ГДЕ
		|	ДокументОснованиеКомандировка.Обучение В(&СписокДокументов)
		|
		|ОБЪЕДИНИТЬ
		|
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ДокументОснованиеКомандировкиСотрудников.Обучение
		|ИЗ
		|	РегистрСведений.КомандировкиСотрудниковОснования КАК ДокументОснованиеКомандировкиСотрудников
		|ГДЕ
		|	ДокументОснованиеКомандировкиСотрудников.Обучение В(&СписокДокументов)
		|
		|ОБЪЕДИНИТЬ
		|
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ДокументОснованиеОтпуск.Обучение
		|ИЗ
		|	РегистрСведений.ОтпускОснования КАК ДокументОснованиеОтпуск
		|ГДЕ
		|	ДокументОснованиеОтпуск.Обучение В(&СписокДокументов)
		|
		|ОБЪЕДИНИТЬ
		|
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ДокументОснованиеОтпускаСотрудников.Обучение
		|ИЗ
		|	РегистрСведений.ОтпускаСотрудниковОснования КАК ДокументОснованиеОтпускаСотрудников
		|ГДЕ
		|	ДокументОснованиеОтпускаСотрудников.Обучение В(&СписокДокументов)";
	
	Запрос.УстановитьПараметр("СписокДокументов", Строки.ПолучитьКлючи());
	
	РезультатЗапроса = Запрос.Выполнить();
	
	// Уже введенные документы.
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл
		Строки[Выборка.Обучение].Данные.УжеВведенДокумент = Истина;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти 

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СоздатьКомандировку(Команда)
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ВДокументеНесколькоСотрудников(ТекущиеДанные.Ссылка) Тогда
		ИмяТаблицы = "КомандировкиСотрудников";
	Иначе
		ИмяТаблицы = "Командировка";
	КонецЕсли;
	
	ВвестиДокументНаОснованииОбучения(ТекущиеДанные, ИмяТаблицы);
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьОтпуск(Команда)
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ВДокументеНесколькоСотрудников(ТекущиеДанные.Ссылка) Тогда
		ИмяТаблицы = "ОтпускаСотрудников";
	Иначе
		ИмяТаблицы = "Отпуск";
	КонецЕсли;
	
	ВвестиДокументНаОснованииОбучения(ТекущиеДанные, ИмяТаблицы);
	
КонецПроцедуры

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Элементы.Список);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Элементы.Список, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Элементы.Список);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти 

#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьОтборыСписка(Форма, Параметры)

	Если Параметры.Свойство("ЭтапыОбучения") Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
			Форма.Список,
			"ПервичныйЭтапОбучения",
			Параметры.ЭтапыОбучения,
			ВидСравненияКомпоновкиДанных.Равно,,Истина);
	КонецЕсли;
	
	Если Параметры.Свойство("ТолькоПервичныеЭтапыОбучения") И Параметры.ТолькоПервичныеЭтапыОбучения Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
			Форма.Список,
			"ЭтоПервичныйЭтап",
			Истина,,,Истина);
	КонецЕсли;
	
	Если Параметры.Свойство("СкрыватьСсылку") И ЗначениеЗаполнено(Параметры.СкрыватьСсылку) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
			Форма.Список,
			"Ссылка",
			Параметры.СкрыватьСсылку,
			ВидСравненияКомпоновкиДанных.НеРавно,,Истина);
	КонецЕсли;
	
	Если Параметры.Свойство("Подразделение") И ЗначениеЗаполнено(Параметры.Подразделение) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
			Форма.Список,
			"Подразделение",
			Параметры.Подразделение,
			ВидСравненияКомпоновкиДанных.Равно,,Истина);
	КонецЕсли;
		
	Если Параметры.Свойство("Мероприятие") И ЗначениеЗаполнено(Параметры.Мероприятие) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
			Форма.Список,
			"Мероприятие",
			Параметры.Мероприятие,
			ВидСравненияКомпоновкиДанных.Равно,,Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьРеквизитИспользоватьОтпускаУчебные()
	ИспользоватьОтпускаУчебные = РасчетЗарплатыРасширенный.НастройкиРасчетаЗарплаты().ИспользоватьОтпускаУчебные;
КонецПроцедуры

// Возвращает структуру с данными документа обучения.
// 
&НаСервере
Функция ДанныеДокументаОбучения(Данные)
	
	ДанныеДокументаОбучения = Новый Структура;
	ДанныеДокументаОбучения.Вставить("Подразделение", Данные.Подразделение);
	ДанныеДокументаОбучения.Вставить("ДатаНачала", Данные.ДатаНачала);
	ДанныеДокументаОбучения.Вставить("ДатаОкончания", Данные.ДатаОкончания);
	ДанныеДокументаОбучения.Вставить("МестоПроведения", Данные.МестоПроведения);
	ДанныеДокументаОбучения.Вставить("ВидОтпуска", ОбщегоНазначения.ПредопределенныйЭлемент("Справочник.ВидыОтпусков.ОтпускУчебный"));
	ДанныеДокументаОбучения.Вставить("УчебноеЗаведение", ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Данные.Мероприятие,"УчебноеЗаведение"));
	ДанныеДокументаОбучения.Вставить("Сотрудник", СотрудникВДокумент(Данные.Ссылка));
	
	Возврат ДанныеДокументаОбучения;
	
КонецФункции

// Возвращает сотрудников (одного или массив) по ссылке на документ Обучение или его табличной части.
//
&НаСервере
Функция СотрудникВДокумент(Ссылка)

	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ОбучениеРазвитиеСотрудниковСотрудники.Сотрудник
		|ИЗ
		|	Документ.ОбучениеРазвитиеСотрудников.Сотрудники КАК ОбучениеРазвитиеСотрудниковСотрудники
		|ГДЕ
		|	ОбучениеРазвитиеСотрудниковСотрудники.Ссылка = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	МассивСотрудников = Новый Массив;
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		МассивСотрудников.Добавить(ВыборкаДетальныеЗаписи.Сотрудник);
	КонецЦикла;
	
	Возврат МассивСотрудников;
	
КонецФункции

&НаКлиенте
Процедура УстановитьДоступностьКоманд()
	 
 	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено ИЛИ (ТекущиеДанные.Свойство("ГруппировкаСтроки") И ТекущиеДанные.ГруппировкаСтроки = Неопределено) Тогда
		УстанавливаемаяДоступность = Ложь;
	Иначе
		УстанавливаемаяДоступность =
			НЕ ТекущиеДанные.УжеВведенДокумент 
			И ТекущиеДанные.ОбучениеСОтрывомОтПроизводства;
	КонецЕсли;
	
 	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ФормаСоздатьОтпуск",
		"Доступность",
		УстанавливаемаяДоступность И ИспользоватьОтпускаУчебные);
		
 	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ФормаСоздатьКомандировку",
		"Доступность",
		УстанавливаемаяДоступность);
		
КонецПроцедуры
 
&НаКлиенте
Процедура ВвестиДокументНаОснованииОбучения(ТекущиеДанные, ИмяТаблицы)
 
	Основание = Новый Структура;
	Основание.Вставить("Ссылка", ТекущиеДанные.Ссылка);
	Основание.Вставить("Действие", "ЗаполнитьИзОбучения");
	Основание.Вставить("ДанныеДокументаОбучения", ДанныеДокументаОбучения(ТекущиеДанные));
	
	ПараметрыФормы = Новый Структура("Основание", Основание);
	ОткрытьФорму("Документ." + ИмяТаблицы + ".ФормаОбъекта", ПараметрыФормы, ЭтаФорма);
 
КонецПроцедуры

&НаСервереБезКонтекста
Функция ВДокументеНесколькоСотрудников(ДокументСсылка)

	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ОбучениеРазвитиеСотрудниковСотрудники.Сотрудник) КАК КоличествоСотрудников
		|ИЗ
		|	Документ.ОбучениеРазвитиеСотрудников.Сотрудники КАК ОбучениеРазвитиеСотрудниковСотрудники
		|ГДЕ
		|	ОбучениеРазвитиеСотрудниковСотрудники.Ссылка = &Ссылка";
	Запрос.УстановитьПараметр("Ссылка", ДокументСсылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Выборка = РезультатЗапроса.Выбрать();
	Если Выборка.Следующий() Тогда
		Возврат Выборка.КоличествоСотрудников > 1;
	КонецЕсли;

КонецФункции

#КонецОбласти