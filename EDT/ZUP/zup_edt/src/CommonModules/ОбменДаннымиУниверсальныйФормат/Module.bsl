////////////////////////////////////////////////////////////////////////////////
// Обмен данными через универсальный формат Enterprise Data.
// Серверные процедуры и функции.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.ОбменДанными

// См. ОбменДаннымиПереопределяемый.ПриПолученииДоступныхВерсийФормата
Процедура ПриПолученииДоступныхВерсийФормата(ВерсииФормата, ВариантНастройки = "") Экспорт
	
	Если ВариантНастройки = "ОбменЗУПБП" Тогда
		ВерсииФормата.Вставить("1.8", МенеджерОбменаЧерезУниверсальныйФормат);
	Иначе
		ВерсииФормата.Вставить("1.3", МенеджерОбменаЧерезУниверсальныйФормат13);
		ВерсииФормата.Вставить("1.8", МенеджерОбменаЧерезУниверсальныйФормат);
	КонецЕсли;
	
	

КонецПроцедуры

// Конец СтандартныеПодсистемы.ОбменДанными

#КонецОбласти

// Возвращает признак существования настроенной синхронизации с конфигурацией "1С:ERP Управление предприятием 2".
// Параметры:
//   УдаляемыйУзел - ПланОбменаСсылка - Ссылка на удаляемый узел обмена.
// Возвращаемое значение:
//   Булево - Истина, если есть хотя бы одна настроенная синхронизация с "1С:ERP Управление предприятием 2".
//
Функция ИспользуетсяОбменУправлениеПредприятием2(УдаляемыйУзел = Неопределено) Экспорт
	
	Запрос = ЗапросУзлыОбменаСУправлениеПредприятием2();

	ЕстьОбменСУправлениеПредприятием = Ложь;
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Не УдаляемыйУзел = Неопределено Тогда
		Пока Выборка.Следующий() Цикл
			Если Выборка.Ссылка = УдаляемыйУзел Тогда
				Продолжить;
			КонецЕсли;
			ЕстьОбменСУправлениеПредприятием = Истина;
			Прервать;
		КонецЦикла;
	Иначе
		Если Выборка.Следующий() Тогда
			ЕстьОбменСУправлениеПредприятием = Истина;
		КонецЕсли;
	КонецЕсли;
	
	Возврат ЕстьОбменСУправлениеПредприятием;
	
КонецФункции

// Возвращает признак существования настроенной синхронизации с конфигурацией "1С:ERP Управление предприятием 2"
// и использования версии формата обмена "1.3".
//
// Возвращаемое значение:
//   Булево - Истина, если есть хотя бы одна настроенная синхронизация с "1С:ERP Управление предприятием 2" версии "1.3".
//
Функция ИспользуетсяОбменУправлениеПредприятием2Версии13() Экспорт

	Запрос = ЗапросУзлыОбменаСУправлениеПредприятием2();

	ЕстьОбменВерсии13 = Ложь;
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		ЕстьОбменВерсии13 = ЕстьОбменВерсии13 Или (Выборка.ВерсияФорматаОбмена = "1.3");
	КонецЦикла;
	
	Возврат ЕстьОбменВерсии13;

КонецФункции

// Обработчик регистрации изменений для начальной выгрузки данных.
// 
// см. ОбменДаннымиПереопределяемый.РегистрацияИзмененийНачальнойВыгрузкиДанных()
//
Процедура ОбработкаРегистрацииНачальнойВыгрузкиДанных(Знач Получатель, СтандартнаяОбработка, Отбор) Экспорт
	
	Если ОбменДаннымиПовтИсп.ПолучитьИмяПланаОбмена(Получатель) = "СинхронизацияДанныхЧерезУниверсальныйФормат" Тогда
		РегистрацияИзмененияДляНачальнойВыгрузки(Получатель, СтандартнаяОбработка, Отбор);
	КонецЕсли;
	
КонецПроцедуры

// Определяет использование обмена данными с БП3.
// Если в параметрах указана организация, то вычисляется использование обмена по этой организации, иначе по всем или любой.
//
// Параметры:
//	Организация - СправочникСсылка.Организации, Неопределено - организация, для которой определяется использование обмена.
//
// Возвращаемое значение:
// 		Булево - Истина если обмен используется, Ложь - в противном случае.
//
Функция ИспользуетсяОбменБП3(Организация = Неопределено) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ВариантНастройки", "ОбменЗУПБП");
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	СинхронизацияДанныхЧерезУниверсальныйФормат.Ссылка КАК Ссылка,
	|	СинхронизацияДанныхЧерезУниверсальныйФормат.ИспользоватьОтборПоОрганизациям КАК ИспользоватьОтборПоОрганизациям
	|ИЗ
	|	ПланОбмена.СинхронизацияДанныхЧерезУниверсальныйФормат КАК СинхронизацияДанныхЧерезУниверсальныйФормат
	|ГДЕ
	|	НЕ СинхронизацияДанныхЧерезУниверсальныйФормат.ПометкаУдаления
	|	И НЕ СинхронизацияДанныхЧерезУниверсальныйФормат.ЭтотУзел
	|	И СинхронизацияДанныхЧерезУниверсальныйФормат.ВариантНастройки = &ВариантНастройки";
	
	УстановитьПривилегированныйРежим(Истина);
	РезультатаЗапроса = Запрос.Выполнить();
	УстановитьПривилегированныйРежим(Ложь);
	Если РезультатаЗапроса.Пустой() Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если Организация = Неопределено Тогда
		Возврат Истина;
	Иначе
		Выборка = РезультатаЗапроса.Выбрать();
		Пока Выборка.Следующий() Цикл
			Если Не Выборка.ИспользоватьОтборПоОрганизациям Тогда
				Возврат Истина;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("Узлы", РезультатаЗапроса.Выгрузить().ВыгрузитьКолонку("Ссылка"));
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	СинхронизацияДанныхЧерезУниверсальныйФорматОрганизации.НомерСтроки КАК НомерСтроки
	|ИЗ
	|	ПланОбмена.СинхронизацияДанныхЧерезУниверсальныйФормат.Организации КАК СинхронизацияДанныхЧерезУниверсальныйФорматОрганизации
	|ГДЕ
	|	СинхронизацияДанныхЧерезУниверсальныйФорматОрганизации.Ссылка В(&Узлы)
	|	И СинхронизацияДанныхЧерезУниверсальныйФорматОрганизации.Организация = &Организация";
	
	УстановитьПривилегированныйРежим(Истина);
	РезультатаЗапроса = Запрос.Выполнить();
	УстановитьПривилегированныйРежим(Ложь);
	Возврат Не РезультатаЗапроса.Пустой();
	
КонецФункции

// Возвращает настройки обмена с БП3.
//
// Возвращаемое значение:
//		Структура - настройки обмена, структура с ключами
// 			* ИспользуетсяОбменПоВсемОрганизациям - Булево
// 			* ИспользуетсяОбменПоОрганизациям - Булево
// 			* ИспользованиеОбменаПоОрганизациям - Соответствие
//
Функция НастройкиОбменаБП3() Экспорт

	Настройки = Новый Структура;
	Настройки.Вставить("ИспользуетсяОбменПоВсемОрганизациям", Ложь);
	Настройки.Вставить("ИспользуетсяОбменПоОрганизациям", Ложь);
	Настройки.Вставить("ИспользованиеОбменаПоОрганизациям", Новый Соответствие);
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ВариантНастройки", "ОбменЗУПБП");
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	СинхронизацияДанныхЧерезУниверсальныйФормат.Ссылка КАК Ссылка,
	|	СинхронизацияДанныхЧерезУниверсальныйФормат.ИспользоватьОтборПоОрганизациям КАК ИспользоватьОтборПоОрганизациям
	|ИЗ
	|	ПланОбмена.СинхронизацияДанныхЧерезУниверсальныйФормат КАК СинхронизацияДанныхЧерезУниверсальныйФормат
	|ГДЕ
	|	НЕ СинхронизацияДанныхЧерезУниверсальныйФормат.ПометкаУдаления
	|	И НЕ СинхронизацияДанныхЧерезУниверсальныйФормат.ЭтотУзел
	|	И СинхронизацияДанныхЧерезУниверсальныйФормат.ВариантНастройки = &ВариантНастройки";
	
	УстановитьПривилегированныйРежим(Истина);
	РезультатаЗапроса = Запрос.Выполнить();
	УстановитьПривилегированныйРежим(Ложь);
	Если РезультатаЗапроса.Пустой() Тогда
		Возврат Настройки;
	КонецЕсли;
	
	Выборка = РезультатаЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл
		Если Выборка.ИспользоватьОтборПоОрганизациям Тогда
			Настройки.ИспользуетсяОбменПоОрганизациям = Истина;
		КонецЕсли;
	КонецЦикла;
	Настройки.ИспользуетсяОбменПоВсемОрганизациям = Не Настройки.ИспользуетсяОбменПоОрганизациям;
	
	Если Настройки.ИспользуетсяОбменПоВсемОрганизациям Тогда
		Возврат Настройки;
	КонецЕсли;
	
	ОбменПоОрганизациям = Новый Соответствие;
	ОбменПоОрганизациям.Вставить(Справочники.Организации.ПустаяСсылка(), Ложь);
	
	Запрос.УстановитьПараметр("Узлы", РезультатаЗапроса.Выгрузить().ВыгрузитьКолонку("Ссылка"));
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Организации.Ссылка КАК Ссылка,
	|	ВЫБОР
	|		КОГДА УзлыОбмена.НомерСтроки ЕСТЬ NULL
	|			ТОГДА ЛОЖЬ
	|		ИНАЧЕ ИСТИНА
	|	КОНЕЦ КАК ОбменИспользуется
	|ИЗ
	|	Справочник.Организации КАК Организации
	|		ЛЕВОЕ СОЕДИНЕНИЕ ПланОбмена.СинхронизацияДанныхЧерезУниверсальныйФормат.Организации КАК УзлыОбмена
	|		ПО (УзлыОбмена.Организация = Организации.Ссылка)
	|ГДЕ
	|	УзлыОбмена.Ссылка В(&Узлы)";
	
	Результат = Запрос.Выполнить(); 
	Выборка = Результат.Выбрать();
	Пока Выборка.Следующий() Цикл
		ОбменПоОрганизациям.Вставить(Выборка.Ссылка, Выборка.ОбменИспользуется);
	КонецЦикла;
	Настройки.ИспользованиеОбменаПоОрганизациям = ОбменПоОрганизациям;
	
	Возврат Настройки;

КонецФункции


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Вызывается при записи настройки синхронизации данных через универсальный формат.
// Используется для обновления настроек использования обмена с определенным корреспондентом.
//
// Параметры:
//    ПланОбменаОбъект - ПланОбменаОбъект.СинхронизацияДанныхЧерезУниверсальныйФормат - записываемый узел плана обмена.
//    ЭтоУдаление - Булево - признак того, что выполняется пометка на удаление или непосредственное удаление узла.
//
Процедура ОбновитьНастройкиИспользованияОбмена(ПланОбменаОбъект, ЭтоУдаление) Экспорт
	
	Если ПланОбменаОбъект.ЭтотУзел Тогда
		Возврат;
	КонецЕсли;

	// Обмен с 1С:ERP Управление предприятием 2.
	ОбменНастроенУП2 = Ложь;
	Если ЭтоУдаление Тогда
		ОбменНастроенУП2 = ИспользуетсяОбменУправлениеПредприятием2(ПланОбменаОбъект.Ссылка);
	Иначе
		ОбменНастроенУП2 = ИспользуетсяОбменУправлениеПредприятием2();
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ОрганизационнаяСтруктура") Тогда 
		Модуль = ОбщегоНазначения.ОбщийМодуль("ОрганизационнаяСтруктура");
		Модуль.ОбновитьНастройкиСтруктурыПредприятияПриИспользованииОбменаУП2(ОбменНастроенУП2);
	КонецЕсли;
	
КонецПроцедуры

// Возвращает запрос, содержащий все узлы обмена с конфигурацией "1С:ERP Управление предприятием 2".
//
Функция ЗапросУзлыОбменаСУправлениеПредприятием2() Экспорт
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	СинхронизацияДанныхЧерезУниверсальныйФормат.Ссылка КАК Ссылка,
	|	СинхронизацияДанныхЧерезУниверсальныйФормат.ВерсияФорматаОбмена КАК ВерсияФорматаОбмена
	|ИЗ
	|	ПланОбмена.СинхронизацияДанныхЧерезУниверсальныйФормат КАК СинхронизацияДанныхЧерезУниверсальныйФормат
	|ГДЕ
	|	НЕ СинхронизацияДанныхЧерезУниверсальныйФормат.ПометкаУдаления
	|	И НЕ СинхронизацияДанныхЧерезУниверсальныйФормат.ЭтотУзел
	|	И СинхронизацияДанныхЧерезУниверсальныйФормат.ВариантНастройки В(&МассивВариантов)");

	МассивВариантов = Новый Массив;
	МассивВариантов.Добавить("ОбменУП2ЗУП3");
	Запрос.УстановитьПараметр("МассивВариантов", МассивВариантов);
	
	Возврат Запрос;
КонецФункции

// Обновляет кэш значений настроек узлов планов обмена.
Процедура ОбновитьКэшМеханизмовРегистрации() Экспорт
	
	Если Не РаботаВМоделиСервиса.РазделениеВключено() Тогда
		ОбменДаннымиВызовСервера.СброситьКэшМеханизмаРегистрацииОбъектов();
		ОбновитьПовторноИспользуемыеЗначения();
	КонецЕсли;
	
КонецПроцедуры

// Обработчик регистрации изменений для начальной выгрузки данных с отбором по организации.
//
// Параметры:
//
// Получатель - ПланОбменаСсылка - Узел плана обмена, в который требуется выгрузить данные.
//
// СтандартнаяОбработка - Булево - В данный параметр передается признак выполнения стандартной (системной) обработки
//                                 события.
//  Если в теле процедуры-обработчика установить данному параметру значение Ложь, стандартная обработка события
//  производиться не будет.
//  Отказ от стандартной обработки не отменяет действие.
//  Значение по умолчанию - Истина.
//
Процедура РегистрацияИзмененияДляНачальнойВыгрузки(Получатель, СтандартнаяОбработка, Отбор)
	
	СтандартнаяОбработка = Ложь;
	
	Если Не ЗначениеЗаполнено(Отбор) Тогда
		ОтборПоМетаданнымДляРегистрации = Неопределено;
	ИначеЕсли ТипЗнч(Отбор) = Тип("Массив") Тогда
		ОтборПоМетаданнымДляРегистрации = Отбор;
	Иначе
		ОтборПоМетаданнымДляРегистрации = Новый Массив;
		ОтборПоМетаданнымДляРегистрации.Добавить(Отбор);
	КонецЕсли;
	
	ЗначенияРеквизитов = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Получатель,
			"ИспользоватьОтборПоОрганизациям,Организации,
			|ДатаНачалаВыгрузкиДокументов,
			|ОтправлятьВедомости,ОтправлятьРегламентированныеОтчеты,
			|ВариантНастройки,
			|ПравилаОтправкиСправочников,ПравилаОтправкиДокументов");
	Организации = ?(ЗначенияРеквизитов.ИспользоватьОтборПоОрганизациям,
			ЗначенияРеквизитов.Организации.Выгрузить().ВыгрузитьКолонку("Организация"), Неопределено);
			
	ЕстьОтборПоОрганизациям = (Организации <> Неопределено);
	ДатаНачалаВыгрузкиДокументов = ЗначенияРеквизитов.ДатаНачалаВыгрузкиДокументов;
	ОтправлятьВедомости = ЗначенияРеквизитов.ОтправлятьВедомости;
	ОтправлятьРегламентированныеОтчеты = ЗначенияРеквизитов.ОтправлятьРегламентированныеОтчеты;
	ЭтоОбменБП3 = ЗначенияРеквизитов.ВариантНастройки = "ОбменЗУПБП";
	
	ОтборДляРегистрацииИзменений = Новый Массив();
	
	Если ЗначенияРеквизитов.ПравилаОтправкиСправочников <> "НеСинхронизировать"
		ИЛИ ЗначенияРеквизитов.ПравилаОтправкиДокументов = "АвтоматическаяСинхронизация" Тогда
		
		// Сразу исключим объекты, которые выгружаются при необходимости, или
		// не выгружаются при указанном варианте обмена.
		// Это ускорит начальную выгрузку.
		ОтборВыгружатьПриНеобходимости = Новый Массив;
		ОтборВыгружатьПриНеобходимости.Добавить(Метаданные.Справочники.ФизическиеЛица);
		ОтборВыгружатьПриНеобходимости.Добавить(Метаданные.Справочники.ПодразделенияОрганизаций);
		ОтборВыгружатьПриНеобходимости.Добавить(Метаданные.Справочники.СпособыОтраженияЗарплатыВБухУчете);
		ОтборВыгружатьПриНеобходимости.Добавить(Метаданные.Справочники.Пользователи);
		ОтборВыгружатьПриНеобходимости.Добавить(Метаданные.Справочники.Контрагенты);
		ОтборВыгружатьПриНеобходимости.Добавить(Метаданные.Справочники.БанковскиеСчетаКонтрагентов);
		ОтборВыгружатьПриНеобходимости.Добавить(Метаданные.Справочники.КлассификаторБанков);
		ОтборВыгружатьПриНеобходимости.Добавить(Метаданные.РегистрыСведений.ФИОФизическихЛиц);
		ОтборВыгружатьПриНеобходимости.Добавить(Метаданные.РегистрыСведений.ДокументыФизическихЛиц);
		
		Если ЭтоОбменБП3 Тогда
			ОтборВыгружатьПриНеобходимости.Добавить(Метаданные.Документы.ПлатежноеПоручение);
			ОтборВыгружатьПриНеобходимости.Добавить(Метаданные.Справочники.ЗарплатныеПроекты);
			Если Не ОтправлятьВедомости Тогда
				ОтборВыгружатьПриНеобходимости.Добавить(Метаданные.Документы.РегламентированныйОтчет);
			КонецЕсли;
			Если Не ОтправлятьРегламентированныеОтчеты Тогда
				ОтборВыгружатьПриНеобходимости.Добавить(Метаданные.Документы.РегламентированныйОтчет);
			КонецЕсли;
		Иначе
			ОтборВыгружатьПриНеобходимости.Добавить(Метаданные.Документы.РегламентированныйОтчет);
			ОтборВыгружатьПриНеобходимости.Добавить(Метаданные.РегистрыСведений.НастройкиРасчетаРезервовОтпусков);
		КонецЕсли;
		
		ИмяПланаОбмена = ОбменДаннымиПовтИсп.ПолучитьИмяПланаОбмена(Получатель);
		СоставПланаОбмена = Метаданные.ПланыОбмена[ИмяПланаОбмена].Состав;
		
		Для Каждого ЭлементСоставаПланаОбмена Из СоставПланаОбмена Цикл 
			
			Если ОтборПоМетаданнымДляРегистрации <> Неопределено
				И ОтборПоМетаданнымДляРегистрации.Найти(ЭлементСоставаПланаОбмена.Метаданные) = Неопределено
				Или ОтборВыгружатьПриНеобходимости.Найти(ЭлементСоставаПланаОбмена.Метаданные) <> Неопределено Тогда
				// Передан отбор по метаданным, и текущий элемент метаданных в него не входит.
				// Или элемент метаданных входит в выгружаемые при необходимости.
				// Нужно его пропустить.
				Продолжить;
			КонецЕсли;
			
			Если ОбщегоНазначения.ЭтоСправочник(ЭлементСоставаПланаОбмена.Метаданные) Тогда
				
				Если ЗначенияРеквизитов.ПравилаОтправкиСправочников = "АвтоматическаяСинхронизация" Тогда
					ОтборДляРегистрацииИзменений.Добавить(ЭлементСоставаПланаОбмена.Метаданные);
				Иначе
					
					Если ЭлементСоставаПланаОбмена.Метаданные.Имя = "Организации"
						И ЗначенияРеквизитов.ПравилаОтправкиСправочников = "СинхронизироватьПоНеобходимости" Тогда
						
						ОтборДляРегистрацииИзменений.Добавить(ЭлементСоставаПланаОбмена.Метаданные);
						
					КонецЕсли;
				
				КонецЕсли;
				
			ИначеЕсли ОбщегоНазначения.ЭтоДокумент(ЭлементСоставаПланаОбмена.Метаданные) Тогда
				
				Если ЗначенияРеквизитов.ПравилаОтправкиДокументов = "АвтоматическаяСинхронизация" Тогда
					ОтборДляРегистрацииИзменений.Добавить(ЭлементСоставаПланаОбмена.Метаданные);
				КонецЕсли;
				
			ИначеЕсли ОбщегоНазначения.ЭтоРегистрСведений(ЭлементСоставаПланаОбмена.Метаданные) Тогда
				
				Если ЗначенияРеквизитов.ПравилаОтправкиСправочников = "АвтоматическаяСинхронизация" Тогда
					ОтборДляРегистрацииИзменений.Добавить(ЭлементСоставаПланаОбмена.Метаданные);
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;
	
	Если ОтборДляРегистрацииИзменений.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Организации", Организации);
	Запрос.УстановитьПараметр("ПоВсемОрганизациям", Не ЕстьОтборПоОрганизациям);
	Запрос.УстановитьПараметр("ДатаНачалаВыгрузкиДокументов", ДатаНачалаВыгрузкиДокументов);
	
	Для Каждого ОбъектМетаданных Из ОтборДляРегистрацииИзменений Цикл
		
		ПолноеИмяОбъекта = ОбъектМетаданных.ПолноеИмя();
		
		Если ОбщегоНазначения.ЭтоСправочник(ОбъектМетаданных) Тогда
			
			Если ОбъектМетаданных = Метаданные.Справочники.Организации Тогда
				
				Запрос.Текст = 
				"ВЫБРАТЬ
				|	Организации.Ссылка КАК Ссылка
				|ИЗ
				|	Справочник.Организации КАК Организации
				|ГДЕ
				|	(&ПоВсемОрганизациям
				|			ИЛИ Организации.Ссылка В (&Организации))
				|	И НЕ Организации.Предопределенный";
				
				Выборка = Запрос.Выполнить().Выбрать();
				Пока Выборка.Следующий() Цикл
					ПланыОбмена.ЗарегистрироватьИзменения(Получатель, Выборка.Ссылка);
				КонецЦикла;
				
			Иначе
				
				ИмяПоляОрганизация = "";
				Если ЕстьОтборПоОрганизациям Тогда
					Если ОбъектМетаданных.Реквизиты.Найти("Организация") <> Неопределено Тогда
						ИмяПоляОрганизация = "Организация";
					ИначеЕсли ОбъектМетаданных.Реквизиты.Найти("Владелец") <> Неопределено 
						И Тип(ОбъектМетаданных.Реквизиты.Найти("Владелец").Тип) = Тип("СправочникСсылка.Организации") Тогда
						ИмяПоляОрганизация = "Владелец";
					КонецЕсли;
				КонецЕсли;
				
				Если ПустаяСтрока(ИмяПоляОрганизация) Тогда
					ПланыОбмена.ЗарегистрироватьИзменения(Получатель, ОбъектМетаданных);
				Иначе
					Выборка = ВыборкаСправочниковПоОрганизациям(ОбъектМетаданных, Организации, ИмяПоляОрганизация);
					Пока Выборка.Следующий() Цикл
						ПланыОбмена.ЗарегистрироватьИзменения(Получатель, Выборка.Ссылка);
					КонецЦикла;
				КонецЕсли;
				
			КонецЕсли;
			
		ИначеЕсли ОбщегоНазначения.ЭтоДокумент(ОбъектМетаданных) Тогда	
			
			Выборка = ВыборкаДокументовПоОрганизациям(ОбъектМетаданных, Организации, ДатаНачалаВыгрузкиДокументов);
			Пока Выборка.Следующий() Цикл
				ПланыОбмена.ЗарегистрироватьИзменения(Получатель, Выборка.Ссылка);
			КонецЦикла;
			
		ИначеЕсли ОбщегоНазначения.ЭтоРегистр(ОбъектМетаданных) Тогда
			
			// Регистры сведений (независимые).
			Если ОбщегоНазначения.ЭтоРегистрСведений(ОбъектМетаданных)
				И ОбъектМетаданных.РежимЗаписи = Метаданные.СвойстваОбъектов.РежимЗаписиРегистра.Независимый Тогда
				
				ЕстьОсновнойОтборПоОрганизации = Ложь;
				ОсновнойОтбор = Неопределено;
				Если ЕстьОтборПоОрганизациям Тогда
					ОсновнойОтбор = ОсновнойОтборРегистраСведений(ОбъектМетаданных);
					ЕстьОсновнойОтборПоОрганизации = (ОсновнойОтбор.Найти("Организация") <> Неопределено);
				КонецЕсли;
				
				Если ЕстьОсновнойОтборПоОрганизации Тогда
					Выборка = ВыборкаЗначенийОсновногоОтбораРегистраСведенийПоОрганизациям(ОсновнойОтбор, ПолноеИмяОбъекта, Организации);
					НаборЗаписей = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(ПолноеИмяОбъекта).СоздатьНаборЗаписей();
					Пока Выборка.Следующий() Цикл
						Для Каждого ИмяИзмерения Из ОсновнойОтбор Цикл
							НаборЗаписей.Отбор[ИмяИзмерения].Значение = Выборка[ИмяИзмерения];
							НаборЗаписей.Отбор[ИмяИзмерения].Использование = Истина;
						КонецЦикла;
						ПланыОбмена.ЗарегистрироватьИзменения(Получатель, НаборЗаписей);
					КонецЦикла;
				Иначе
					ПланыОбмена.ЗарегистрироватьИзменения(Получатель, ОбъектМетаданных);
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Функция ВыборкаДокументовПоОрганизациям(ОбъектМетаданных, Организации, ДатаНачалаВыгрузкиДокументов)
	
	ПолноеИмяОбъекта = ОбъектМетаданных.ПолноеИмя();
	
	ИмяОтбораПоДате = "";
	Если ЗначениеЗаполнено(ДатаНачалаВыгрузкиДокументов) Тогда
		ИмяОтбораПоДате = "Дата";
	КонецЕсли;
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	Таблица.Ссылка КАК Ссылка
	|ИЗ
	|	#ПолноеИмяОбъекта КАК Таблица
	|ГДЕ
	|	Таблица.Организация В(&Организации)
	|	И ИСТИНА
	|	И &УсловиеПроведен";
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "#ПолноеИмяОбъекта", ПолноеИмяОбъекта);
	Если Не ПустаяСтрока(ИмяОтбораПоДате) Тогда
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "И Истина", "И Таблица."+ИмяОтбораПоДате+" >= &ДатаНачалаВыгрузкиДокументов");
	КонецЕсли;
	
	Если Организации = Неопределено Тогда
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "Таблица.Организация В(&Организации)", "Истина");	
	КонецЕсли;
	
	Если ОбъектМетаданных.Проведение = Метаданные.СвойстваОбъектов.Проведение.Разрешить Тогда
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "И &УсловиеПроведен", "И Таблица.Проведен");
	Иначе
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "И &УсловиеПроведен", "И НЕ Таблица.ПометкаУдаления");
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Организации", Организации);
	Запрос.УстановитьПараметр("ДатаНачалаВыгрузкиДокументов", ДатаНачалаВыгрузкиДокументов);
	Запрос.Текст = ТекстЗапроса;
	
	Возврат Запрос.Выполнить().Выбрать();
	
КонецФункции

Функция ВыборкаСправочниковПоОрганизациям(ОбъектМетаданных, Организации, ИмяПоляОрганизация)

	ПолноеИмяОбъекта = ОбъектМетаданных.ПолноеИмя();
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Организации", Организации);
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Таблица.Ссылка КАК Ссылка
	|ИЗ
	|	#ПолноеИмяОбъекта КАК Таблица
	|ГДЕ
	|	Таблица.Организация В(&Организации)
	|	И НЕ Таблица.ПометкаУдаления";
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "#ПолноеИмяОбъекта", ПолноеИмяОбъекта);
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "Таблица.Организация", "Таблица."+ИмяПоляОрганизация);
	
	Возврат Запрос.Выполнить().Выбрать();

КонецФункции

Функция ОсновнойОтборРегистраСведений(ОбъектМетаданных)
	
	Результат = Новый Массив;
	
	Если ОбъектМетаданных.ПериодичностьРегистраСведений <> Метаданные.СвойстваОбъектов.ПериодичностьРегистраСведений.Непериодический
		И ОбъектМетаданных.ОсновнойОтборПоПериоду Тогда
		Результат.Добавить("Период");
	КонецЕсли;
	
	Для Каждого Измерение Из ОбъектМетаданных.Измерения Цикл
		Если Измерение.ОсновнойОтбор Тогда
			Результат.Добавить(Измерение.Имя);
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Функция ВыборкаЗначенийОсновногоОтбораРегистраСведенийПоОрганизациям(ОсновнойОтбор, ПолноеИмяОбъекта, Организации)
	
	ТекстЗапроса =
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	[Измерения]
	|ИЗ
	|	[ПолноеИмяОбъекта] КАК ТаблицаРегистра
	|ГДЕ
	|	ТаблицаРегистра.Организация В(&Организации)";
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "[ПолноеИмяОбъекта]", ПолноеИмяОбъекта);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "[Измерения]", СтрСоединить(ОсновнойОтбор, ","));
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Организации", Организации);
	Запрос.Текст = ТекстЗапроса;
	
	Возврат Запрос.Выполнить().Выбрать();
	
КонецФункции

#КонецОбласти

