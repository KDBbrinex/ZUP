#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(
		ЭтотОбъект.Список,
		"ПодтвержденияПолучены",
		НСтр("ru = 'Подтверждения получены'"),
		Истина);
	
	СтруктураПараметровОтбора = Новый Структура();
	ЗарплатаКадры.ДобавитьПараметрОтбора(СтруктураПараметровОтбора, "ФизическоеЛицо",
		Новый ОписаниеТипов("СправочникСсылка.ФизическиеЛица"), НСтр("ru = 'Сотрудник'"));
	
	ОбменСБанкамиПоЗарплатнымПроектам.ПриСозданииНаСервереФормыВедомостейСДинамическимСписком(ЭтотОбъект);
	ЗарплатаКадры.ПриСозданииНаСервереФормыСДинамическимСписком(ЭтотОбъект, "Список",,
		СтруктураПараметровОтбора, "СписокКритерииОтбора");
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПараметрыРазмещения = ПодключаемыеКоманды.ПараметрыРазмещения();
	ПараметрыРазмещения.КоманднаяПанель = Элементы.КоманднаяПанельФормы;
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект, ПараметрыРазмещения);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "Запись_ПрисоединенныйФайл" И Параметр.ЭтоНовый Тогда
		ТипыОбъектовДляОповещенияОбИзменении = ТипыОбъектовДляОповещенияОЗаписиФайла(Источник);
		Для каждого ТипОбъектаДляОповещенияОбИзменении Из ТипыОбъектовДляОповещенияОбИзменении Цикл
			ОповеститьОбИзменении(ТипОбъектаДляОповещенияОбИзменении);
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура Подключаемый_ПараметрОтбораПриИзменении(Элемент)
	ЗарплатаКадрыКлиент.ПараметрОтбораНаФормеСДинамическимСпискомПриИзменении(ЭтотОбъект, Элемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	ОбменСБанкамиПоЗарплатнымПроектамКлиент.СписокВедомостейПриАктивизацииСтроки(ЭтотОбъект, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПриИзменении(Элемент)
	ОповеститьОбИзменении(Тип("РегистрСведенийКлючЗаписи.СостоянияДокументовЗачисленияЗарплаты"));
КонецПроцедуры

&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Если Параметр = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыОткрытия = Новый Структура;
	
	ЗарплатаКадрыКлиент.ДинамическийСписокПередНачаломДобавления(ЭтотОбъект, ПараметрыОткрытия, Параметр);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ЗначенияЗаполнения", ПараметрыОткрытия.ЗначенияЗаполнения);
	
	Отказ = Истина;
	ОткрытьФорму(ПараметрыОткрытия.ОписаниеФормы, ПараметрыФормы);
	
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

#Область ОбработчикиКомандФормы

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

&НаКлиенте
Процедура ОтправитьВБанк(Команда)
	
	МассивДокументов = Новый Массив;
	Для каждого СсылкаНаДокумент Из Элементы.Список.ВыделенныеСтроки Цикл
		МассивДокументов.Добавить(СсылкаНаДокумент);
	КонецЦикла;
	ОбменСБанкамиКлиент.СформироватьПодписатьОтправитьЭД(МассивДокументов);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьСинхронизациюСБанком(Команда)
	
	ВыделенныеДокументы = Новый ФиксированныйМассив(Элементы.Список.ВыделенныеСтроки);
	НастройкиСинхронизации = НастройкиСинхронизацииСБанками(ВыделенныеДокументы);
	Для каждого НастройкаСинхронизации Из НастройкиСинхронизации Цикл
		ОбменСБанкамиКлиент.СинхронизироватьСБанком(НастройкаСинхронизации.Организация, НастройкаСинхронизации.Банк);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьОтправленныйДокумент(Команда)
	
	МассивДокументов = Новый Массив;
	Для каждого СсылкаНаДокумент Из Элементы.Список.ВыделенныеСтроки Цикл
		МассивДокументов.Добавить(СсылкаНаДокумент);
	КонецЦикла;
	
	ОбменСБанкамиКлиент.ОткрытьАктуальныйЭД(МассивДокументов, ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция НастройкиСинхронизацииСБанками(ДокументыОбменаСБанками)
	
	НастройкиСинхронизации = Новый Массив;
	
	// В журнале или документа обмена с банками БЗК, или платежные документы
	МетаданныеПлатежногоДокумента = ОбменСБанкамиПоЗарплатнымПроектам.МетаданныеПлатежногоДокументаПеречисленияЗарплаты();
	ДокументыПлатежей = Новый Массив;
	ДокументыЗарплаты = Новый Массив;
	Для Каждого Документ Из ДокументыОбменаСБанками Цикл
		Если МетаданныеПлатежногоДокумента <> Неопределено 
			И МетаданныеПлатежногоДокумента.ПолноеИмя() = Документ.Метаданные().ПолноеИмя() Тогда
 			ДокументыПлатежей.Добавить(Документ);
		Иначе
			ДокументыЗарплаты.Добавить(Документ);
		КонецЕсли	
	КонецЦикла;	
	
	// Зарплатные документы хранят зарплатный проект в реквизите
	ЗарплатныеПроекты = ОбщегоНазначения.ЗначениеРеквизитаОбъектов(ДокументыЗарплаты, "ЗарплатныйПроект");
	ЗарплатныеПроекты = ОбщегоНазначения.ВыгрузитьКолонку(ЗарплатныеПроекты, "Значение");

	// Зарплатные проекты платежных документов определяем по их ведомостям
	Для Каждого Документ Из ДокументыПлатежей Цикл
		ВедомостиПлатежногоДокумента = ОбменСБанкамиПоЗарплатнымПроектам.ВедомостиПлатежногоДокументаПеречисленияЗарплаты(Документ);
		Если ВедомостиПлатежногоДокумента.Количество() > 0 Тогда
			ЗарплатныеПроекты.Добавить(ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ВедомостиПлатежногоДокумента[0], "ЗарплатныйПроект"))
		КонецЕсли
	КонецЦикла;
	
	// Выяснив используемые документами зарплатные проекты, получаем их организации и банки
	РеквизитыЗарплатныхПроектов = ОбщегоНазначения.ЗначенияРеквизитовОбъектов(ЗарплатныеПроекты, "Организация, Банк");
	Для Каждого РеквизитыЗарплатногоПроекта Из РеквизитыЗарплатныхПроектов Цикл
		НастройкиСинхронизации.Добавить(РеквизитыЗарплатногоПроекта.Значение);
	КонецЦикла;
	
	Возврат НастройкиСинхронизации;
	
КонецФункции

&НаСервере
Функция ТипыОбъектовДляОповещенияОЗаписиФайла(Источник)
	
	МассивТипов = Новый Массив;
	ТипОбъекта = ТипЗнч(ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(ЭтотОбъект.ИмяФормы));
	МетаданныеОбъекта = Метаданные.НайтиПоТипу(ТипОбъекта);
	
	Если ТипЗнч(Источник) = Тип("Массив") Тогда
		Для каждого ПрисоединенныйФайл Из Источник Цикл
			Если МетаданныеОбъекта.РегистрируемыеДокументы.Содержит(ПрисоединенныйФайл.ВладелецФайла.Метаданные()) Тогда
				ТипДокумента = ТипЗнч(ПрисоединенныйФайл.ВладелецФайла);
				Если МассивТипов.Найти(ТипДокумента) = Неопределено Тогда
					МассивТипов.Добавить(ТипДокумента);
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
	Иначе
		Если МетаданныеОбъекта.РегистрируемыеДокументы.Содержит(Источник.ВладелецФайла.Метаданные()) Тогда
			ТипДокумента = ТипЗнч(Источник.ВладелецФайла);
			Если МассивТипов.Найти(ТипДокумента) = Неопределено Тогда
				МассивТипов.Добавить(ТипДокумента);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	Возврат МассивТипов;
	
КонецФункции

#КонецОбласти
