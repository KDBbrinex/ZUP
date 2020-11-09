#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Обработчик обновления. Заполняет версию формата в настройках обмена.
//
// Параметры:
//  Параметры - Структура - структура вида:
//    * ОбработкаЗавершена - Булево - (не заполнять) признак того что обработка заполнения версии формата завершена.
//
Процедура ЗаполнитьВерсиюФормата(Параметры) Экспорт
	
	Параметры.ОбработкаЗавершена = Ложь;
	
	НачатьТранзакцию();
	Попытка
		Запрос = Новый Запрос;
		Запрос.Текст =
		"ВЫБРАТЬ
		|	НастройкиОбменСБанками.Ссылка
		|ИЗ
		|	Справочник.НастройкиОбменСБанками КАК НастройкиОбменСБанками
		|ГДЕ
		|	НастройкиОбменСБанками.ПрограммаБанка = ЗНАЧЕНИЕ(Перечисление.ПрограммыБанка.АсинхронныйОбмен)
		|	И НастройкиОбменСБанками.ВерсияФормата = """"";
		Выборка = Запрос.Выполнить().Выбрать();
		Пока Выборка.Следующий() Цикл
			СправочникОбъект = Выборка.Ссылка.ПолучитьОбъект();
			СправочникОбъект.ВерсияФормата = ОбменСБанкамиКлиентСервер.БазоваяВерсияФорматаАсинхронногоОбмена();
			ОбновлениеИнформационнойБазы.ЗаписатьОбъект(СправочникОбъект);
		КонецЦикла;
		
		ЗафиксироватьТранзакцию();
		
	Исключение
		
		ОтменитьТранзакцию();
		Операция = НСтр("ru = '1С:ДиректБанк: Заполнение версии формата.'");
		ПодробныйТекстОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЭлектронноеВзаимодействиеСлужебныйВызовСервера.ОбработатьОшибку(Операция, ПодробныйТекстОшибки, , "ОбменСБанками");
		ВызватьИсключение;
		
	КонецПопытки;
	
	Параметры.ОбработкаЗавершена = Истина;

КонецПроцедуры

// Регистрирует данные для обработчика обновления
// 
// Параметры:
//  Параметры - Структура - параметры.
//
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПустойМаршрут = Справочники.МаршрутыПодписания.ПустаяСсылка();
	ВидыДокументовСНесколькимиПодписями = ОбменСБанкамиСлужебныйПовтИсп.ВидыДокументовПодписываемыхПоМаршруту();
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	НастройкиОбменСБанками.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.НастройкиОбменСБанками КАК НастройкиОбменСБанками
	|ГДЕ
	|	НастройкиОбменСБанками.ПрограммаБанка = ЗНАЧЕНИЕ(Перечисление.ПрограммыБанка.СбербанкОнлайн)
	|	И НЕ НастройкиОбменСБанками.УдалитьВерсияВнешнейКомпоненты = """"
	|
	|СГРУППИРОВАТЬ ПО
	|	НастройкиОбменСБанками.Ссылка
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	Настройки.Ссылка
	|ИЗ
	|	Справочник.НастройкиОбменСБанками.ИсходящиеДокументы КАК Настройки
	|ГДЕ
	|	Настройки.МаршрутПодписания = &ПустойМаршрут
	|	И Настройки.ИспользоватьЭП = ИСТИНА
	|	И Настройки.Ссылка.Недействительна = ЛОЖЬ
	|	И Настройки.ИсходящийДокумент В(&ВидыДокументовСНесколькимиПодписями)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	НастройкиОбменСБанкамиСертификатыПодписейОрганизации.Ссылка
	|ИЗ
	|	Справочник.НастройкиОбменСБанками.СертификатыПодписейОрганизации КАК НастройкиОбменСБанкамиСертификатыПодписейОрганизации
	|ГДЕ
	|	НастройкиОбменСБанкамиСертификатыПодписейОрганизации.Ссылка.ПрограммаБанка = ЗНАЧЕНИЕ(Перечисление.ПрограммыБанка.СбербанкОнлайн)
	|	И НЕ НастройкиОбменСБанкамиСертификатыПодписейОрганизации.Ссылка.ИспользуетсяКриптография
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	НастройкиОбменСБанками.Ссылка
	|ИЗ
	|	Справочник.НастройкиОбменСБанками КАК НастройкиОбменСБанками
	|ГДЕ
	|	НЕ НастройкиОбменСБанками.УдалитьОбновленоПодтвердитьВБанке
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	НастройкиОбменСБанками.Ссылка
	|ИЗ
	|	Справочник.НастройкиОбменСБанками КАК НастройкиОбменСБанками
	|ГДЕ
	|	НастройкиОбменСБанками.ПрограммаБанка В (ЗНАЧЕНИЕ(Перечисление.ПрограммыБанка.СбербанкОнлайн), ЗНАЧЕНИЕ(Перечисление.ПрограммыБанка.ОбменЧерезВК), ЗНАЧЕНИЕ(Перечисление.ПрограммыБанка.ОбменЧерезДопОбработку))
	|	И НастройкиОбменСБанками.ИспользуетсяКриптография
	|
	|СГРУППИРОВАТЬ ПО
	|	НастройкиОбменСБанками.Ссылка
	|
	|ИМЕЮЩИЕ
	|	КОЛИЧЕСТВО(НастройкиОбменСБанками.СертификатыБанка.Ссылка) = 0";
	Запрос.УстановитьПараметр("ПустойМаршрут", ПустойМаршрут);
	Запрос.УстановитьПараметр("ВидыДокументовСНесколькимиПодписями", ВидыДокументовСНесколькимиПодписями);
	Запрос.УстановитьПараметр(
		"ПустаяСсылкаДополнительнаяОбработка", Справочники.ДополнительныеОтчетыИОбработки.ПустаяСсылка());
	Результат = Запрос.Выполнить().Выгрузить();
	МассивСсылок = Результат.ВыгрузитьКолонку("Ссылка");
	ОбновлениеИнформационнойБазы.ОтметитьКОбработке(Параметры, МассивСсылок);

КонецПроцедуры

// Обработчик обновления.
// 
// Параметры:
//  Параметры - Структура - параметры.
//
Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	Выборка = ОбновлениеИнформационнойБазы.ВыбратьСсылкиДляОбработки(
		Параметры.Очередь, "Справочник.НастройкиОбменСБанками");
		
	ОбработанныхОбъектов = 0; ПроблемныхОбъектов = 0;

	Пока Выборка.Следующий() Цикл
		
		НачатьТранзакцию();
		Попытка
			
			Записать = Ложь;
		
			Блокировка = Новый БлокировкаДанных;
			ЭлементБлокировки = Блокировка.Добавить("Справочник.НастройкиОбменСБанками");
			ЭлементБлокировки.УстановитьЗначение("Ссылка", Выборка.Ссылка);
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
			Блокировка.Заблокировать();

			ОбъектОбработки = Выборка.Ссылка.ПолучитьОбъект();
			
			Если ОбъектОбработки <> Неопределено Тогда
				НайденПредопределенныйМаршрут = Истина;
				ЗаполнитьМаршрутыПодписания(ОбъектОбработки, Записать, НайденПредопределенныйМаршрут);
				Если НЕ НайденПредопределенныйМаршрут Тогда
					ЗафиксироватьТранзакцию();
					Продолжить;
				КонецЕсли;
				ПеренестиВнешнююКомпонентуВСправочник(ОбъектОбработки, Записать);
				УстановитьИспользованиеКриптографииДляСбербанка(ОбъектОбработки, Записать);
				УстановитьФлагПодтвердитьВБанке(ОбъектОбработки, Записать);
				ЗаполнитьТаблицуСертификатовБанка(ОбъектОбработки, Записать);
			КонецЕсли;

			Если Записать Тогда
				ОбновлениеИнформационнойБазы.ЗаписатьОбъект(ОбъектОбработки);
			Иначе
				ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(Выборка.Ссылка);
			КонецЕсли;
			ОбработанныхОбъектов = ОбработанныхОбъектов + 1;
			
			ЗафиксироватьТранзакцию();
		Исключение
			ОтменитьТранзакцию();
			ПроблемныхОбъектов = ПроблемныхОбъектов + 1;
			ТекстСообщения = НСтр("ru = 'Не удалось обработать справочник: %Регистратор% по причине: %Причина%'");
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Регистратор%", Выборка.Ссылка);
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Причина%", ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			СобытиеЖурналаРегистрации = ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации();
			ЗаписьЖурналаРегистрации(СобытиеЖурналаРегистрации, УровеньЖурналаРегистрации.Предупреждение,
				Метаданные.Справочники.НастройкиОбменСБанками, , ТекстСообщения);
			Продолжить;
		КонецПопытки;
	КонецЦикла;

	Если ОбработанныхОбъектов = 0 И ПроблемныхОбъектов <> 0 Тогда
		ШаблонСообщения = НСтр("ru = 'Не удалось обработать некоторые настройки обмена с банками (пропущены): %1'");
		ТекстСообщения = СтрШаблон(ШаблонСообщения, ПроблемныхОбъектов);
		ВызватьИсключение ТекстСообщения;
	Иначе
		МетаданныеОбъекта = Метаданные.Справочники.НастройкиОбменСБанками;
		ШаблонСообщения = НСтр("ru = 'Обработана очередная порция настроек обмена с банками: %1'");
		ТекстСообщения = СтрШаблон(ШаблонСообщения, ОбработанныхОбъектов);
		ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(),
			УровеньЖурналаРегистрации.Информация, МетаданныеОбъекта,, ТекстСообщения);
	КонецЕсли;
	
	Параметры.ПрогрессВыполнения.ОбработаноОбъектов = Параметры.ПрогрессВыполнения.ОбработаноОбъектов
		+ ОбработанныхОбъектов;

	Параметры.ОбработкаЗавершена = ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(
		Параметры.Очередь, "Справочник.НастройкиОбменСБанками");

КонецПроцедуры

// См. ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы.
Функция ДанныеОбновленыНаНовуюВерсиюПрограммы(МетаданныеИОтбор) Экспорт
	
	Если МетаданныеИОтбор.ПолноеИмя = "Справочник.НастройкиОбменСБанками" Тогда
		МетаданныеИОтборНастройки = МетаданныеИОтбор;
	ИначеЕсли МетаданныеИОтбор.ПолноеИмя = "Документ.СообщениеОбменСБанками" Тогда
		Настройка = МетаданныеИОтбор.Отбор.НастройкаОбмена;
		МетаданныеИОтборНастройки = ОбновлениеИнформационнойБазы.МетаданныеИОтборПоДанным(Настройка);
	КонецЕсли;
	
	Возврат ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы(МетаданныеИОтборНастройки);
	
КонецФункции

// Формирует ключ, по которому будет производиться поиск настройки обмена с банком при автоматической загрузке
// настроек.
//
// Параметры:
//  НастройкаОбмена	 - СправочникСсылка.НастройкиОбменСБанками - настройка обмена с банком.
//  ВидДокумента	 - ПеречислениеСсылка.ВидыЭДОбменСБанками - вид электронного документа.
// 
// Возвращаемое значение:
//  Строка - сформированный ключ.
//
Функция КлючАвтоматическойНастройки(НастройкаОбмена, ВидДокумента) Экспорт

	Ключ = "" + НастройкаОбмена.Организация.УникальныйИдентификатор() 
			+ НастройкаОбмена.Банк.УникальныйИдентификатор() + ОбщегоНазначения.ИмяЗначенияПеречисления(ВидДокумента);
				
	Возврат Ключ;

КонецФункции 

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Организация)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#КонецЕсли

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Если ЗначениеЗаполнено(Данные.Организация) И ЗначениеЗаполнено(Данные.Банк) Тогда
		ШаблонПредставления = "%1 - %2";
		Представление = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			ШаблонПредставления, Данные.Организация, Данные.Банк);
	Иначе
		Представление = НСтр("ru = 'Не заполненная настройка'");
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПолученияПолейПредставления(Поля, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Поля.Очистить();
	Поля.Добавить("Организация");
	Поля.Добавить("Банк");
	Поля.Добавить("Код");
	
КонецПроцедуры

#КонецОбласти

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Загружает настройки обмена с сервера банка.
//
// Параметры:
//  ПараметрыПолученияНастроек - Структура - данные, необходимые для получения настроек;
//  АдресХранилища - Строка - адрес хранилища в который необходимо поместить полученные данные.
//
Процедура ПолучитьНастройкиОбменаССервераБанка(Знач ПараметрыПолученияНастроек, АдресХранилища) Экспорт

	Если НЕ ЗначениеЗаполнено(ПараметрыПолученияНастроек.НомерБанковскогоСчета) Тогда
		ПараметрыПолученияНастроек.НомерБанковскогоСчета = НомерБанковскогоСчета(
			ПараметрыПолученияНастроек.Организация, ПараметрыПолученияНастроек.Банк);
	КонецЕсли;
	
	РеквизитыОрганизации = Неопределено;
	ЭлектронноеВзаимодействиеПереопределяемый.ПолучитьДанныеЮрФизЛица(
		ПараметрыПолученияНастроек.Организация, РеквизитыОрганизации);
	ПараметрыПолученияНастроек.Вставить("ИНН", РеквизитыОрганизации.ИНН);
	НастройкиОбмена = ПолучитьНастройкиОбмена(ПараметрыПолученияНастроек);
	ПоместитьВоВременноеХранилище(НастройкиОбмена, АдресХранилища);
	
КонецПроцедуры

// Загружает настройки обмена из файла настроек
//
// Параметры:
//  ДанныеНастроек - Структура - параметры процедуры. Содержит следующие элементы:
//     * ДвоичныеДанныеФайлаНастроек - ДвоичныеДанные - данные файла настроек;
//     * ЗагружатьВК - Булево - признак необходимости загрузки внешней компоненты с сервера поставщика;
//     * Организация - ОпределяемыйТип.Организация - организация, для которой создается настройка обмена;
//  АдресХранилища - Строка - адрес хранилища в который необходимо поместить полученные данные.
//
Процедура ЗагрузитьНастройкиОбменаИзФайла(Знач ДанныеНастроек, АдресХранилища) Экспорт

	АдресФайлаНастроек = ПоместитьВоВременноеХранилище(ДанныеНастроек.ДвоичныеДанныеФайлаНастроек);
	ДанныеСертификатов = Неопределено;
	НоваяНастройкаОбмена = ОбменСБанкамиСлужебный.СоздатьНастройкуОбменаИзФайла(АдресФайлаНастроек,
		ДанныеНастроек.Организация, Истина, ДанныеНастроек.ЛокальныйФайл, ДанныеСертификатов, ДанныеНастроек.ЗагружатьВК);
	ДанныеВозврата = Новый Структура;
	ДанныеВозврата.Вставить("НастройкаОбмена", НоваяНастройкаОбмена);
	ДанныеВозврата.Вставить("ДанныеСертификатов", ДанныеСертификатов);
	ПоместитьВоВременноеХранилище(ДанныеВозврата, АдресХранилища);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Осуществляет получение настроек обмена с сервера банка.
// 
// Параметры:
//    ПараметрыПолученияНастроек - Структура - Параметры получения настроек (все обязательно к заполнению), вида:
//     * АдресСервера - Строка - адрес сервера банка, с которого будут получены настройки обмена;
//     * Банк - СправочникСсылка.КлассификаторБанков - банк, для которого будут получены настройки;
//     * НомерСчета - Строка - номер банковского счета;
//     * ДанныеМаркера - ДвоичныеДанные - временный маркер банка;
//     * ИдентификаторОрганизации - Строка - идентификатор организации на сервере банка;
//     * ИНН - Строка - ИНН организации;
//     * ПробнаяОперация - Булево - признак пробного получения настроек без вывода сообщений об ошибках.
//     * НастройкаОбмена - СправочникСсылка.НастройкиОбменСБанками - ссылка на текущую настройку обмена с банком.
//
// Возвращаемое значение:
//    ДвоичныеДанные - данные файла настроек ЭДО.
//
Функция ПолучитьНастройкиОбмена(ПараметрыПолученияНастроек)
	
	ВидОперации = НСтр("ru = 'Получение настроек с сервера банка'");
	
	Заголовки = Новый Соответствие;
	Заголовки.Вставить("Content-Type", "application/xml; charset=utf-8");
	
	ИдентификаторОрганизации = ПараметрыПолученияНастроек.ИдентификаторОрганизации;
	Если Не ЗначениеЗаполнено(ИдентификаторОрганизации) Тогда
		ИдентификаторОрганизации = "0";
	КонецЕсли;
	Заголовки.Вставить("CustomerID", ИдентификаторОрганизации);
	
	Если ЗначениеЗаполнено(ПараметрыПолученияНастроек.НомерБанковскогоСчета) Тогда
		Заголовки.Вставить("Account", ПараметрыПолученияНастроек.НомерБанковскогоСчета);
	КонецЕсли;
	
	Заголовки.Вставить("Inn", ПараметрыПолученияНастроек.ИНН);
	Заголовки.Вставить("Bic", ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ПараметрыПолученияНастроек.Банк, "Код"));
	Маркер = ЭлектронноеВзаимодействиеСлужебныйВызовСервера.СтрокаИзДвоичныхДанных(
		ПараметрыПолученияНастроек.ИдентификаторСессии);
	Заголовки.Вставить("SID", Маркер);
	Заголовки.Вставить("APIVersion", ОбменСБанкамиКлиентСервер.БазоваяВерсияФорматаАсинхронногоОбмена());
	Заголовки.Вставить("AvailableAPIVersion", ОбменСБанкамиКлиентСервер.АктуальнаяВерсияФорматаАсинхронногоОбмена());
	
	Результат = ОбменСБанкамиСлужебный.ОтправитьPOSTЗапрос(ПараметрыПолученияНастроек.АдресСервера, "GetSettings",
		Заголовки, Неопределено, , , ПараметрыПолученияНастроек.НастройкаОбмена);
	
	Если Не Результат.Статус Тогда
		Если ЗначениеЗаполнено(Результат.КодСостояния) Тогда
			Шаблон = НСтр("ru = 'Ошибка загрузки настроек с сервера банка.
								|Код ошибки: %1.
								|%2'");
			ТекстОшибки = СтрШаблон(Шаблон, Результат.КодСостояния, Результат.СообщениеОбОшибке);
		Иначе
			ТекстОшибки = Результат.СообщениеОбОшибке;
		КонецЕсли;
		ВызватьИсключение ТекстОшибки;
	КонецЕсли;
	
	ИмяФайлаРезультата = ПолучитьИмяВременногоФайла("xml");
	
	Результат.Тело.Записать(ИмяФайлаРезультата);
	
	Чтение = Новый ЧтениеXML;
	Попытка
		Чтение.ОткрытьФайл(ИмяФайлаРезультата);
		ResultBank = ФабрикаXDTO.ПрочитатьXML(Чтение);
		
		Если ResultBank.Свойства().Получить("formatVersion") = Неопределено Тогда
			ВерсияФормата = ОбменСБанкамиКлиентСервер.УстаревшаяВерсияФорматаАсинхронногоОбмена();
		Иначе
			ВерсияФормата = ResultBank.formatVersion;
		КонецЕсли;
		
		ПространствоИмен = ОбменСБанкамиСлужебный.ПространствоИменАсинхронногоОбмена(ВерсияФормата);

		Фабрика = ОбменСБанкамиСлужебныйПовтИсп.ФабрикаAsyncXDTO(ВерсияФормата);

		Чтение.ОткрытьФайл(ИмяФайлаРезультата);
		ПакетТип = ОбменСБанкамиСлужебный.ТипЗначенияCML(Фабрика, ПространствоИмен, "ResultBank");
		ResultBank = Фабрика.ПрочитатьXML(Чтение, ПакетТип);
	Исключение
		Если Не ПараметрыПолученияНастроек.ПробнаяОперация Тогда
			ТекстСообщения = НСтр("ru = 'Произошла ошибка при получении настроек из банка'");
			ПодробноеПредставлениеОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ТекстОшибки = НСтр("ru = 'Ошибка чтения ответа банка.
									|Текст ошибки: %1
									|Путь к файлу: %2'");
			ТекстОшибки = СтрШаблон(ТекстОшибки, ПодробноеПредставлениеОшибки, ИмяФайлаРезультата);
			ВидОперации = НСтр("ru = 'Получение настроек обмена из банка'");
			ЭлектронноеВзаимодействиеСлужебныйВызовСервера.ОбработатьОшибку(
				ВидОперации, ТекстОшибки, , "ОбменСБанками");
		КонецЕсли;
		Чтение.Закрыть();
		ВызватьИсключение ТекстСообщения;
	КонецПопытки;
		
	Если НЕ ResultBank.Error = Неопределено Тогда
		Чтение.Закрыть();
		ФайловаяСистема.УдалитьВременныйФайл(ИмяФайлаРезультата);
		ТекстСообщения = ОбменСБанкамиСлужебный.ТекстСообщенияОбОшибкеОтветаБанка(ResultBank.Error);
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;
	
	Чтение.Закрыть();
	ДанныеНастроек = ResultBank.Success.GetSettingsResponse.Data.__content;
	ФайловаяСистема.УдалитьВременныйФайл(ИмяФайлаРезультата);
	Возврат ДанныеНастроек;
	
КонецФункции

// Определяет один из банковских счетов организации.
//
// Параметры:
//   Организация - СправочникСсылка.Организации - организация;
//   Банк - ОпределяемыйТип.БанкОбменСБанками - банк.
//
// Возвращаемое значение:
//    Строка - номер банковского счета.
//
Функция НомерБанковскогоСчета(Знач Организация, Знач Банк)
	
	МассивБанковскихСчетов = Новый Массив;
	ОбменСБанкамиПереопределяемый.ПолучитьНомераБанковскихСчетов(Организация, Банк, МассивБанковскихСчетов);
	Если МассивБанковскихСчетов.Количество() Тогда
		Возврат МассивБанковскихСчетов[0];
	КонецЕсли;
	
КонецФункции

Процедура ПеренестиВнешнююКомпонентуВСправочник(ОбъектОбработки, Записать)
	
	Если ОбъектОбработки.ПрограммаБанка = Перечисления.ПрограммыБанка.СбербанкОнлайн
		И НЕ ОбъектОбработки.УдалитьВерсияВнешнейКомпоненты = "" Тогда
		ОбъектОбработки.ИмяВнешнегоМодуля = ОбменСБанкамиКлиентСервер.ИдентификаторВнешнейКомпонентыСбербанк();
		ОбъектОбработки.УдалитьВерсияВнешнейКомпоненты = "";
		Записать = Истина;
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗаполнитьМаршрутыПодписания(ОбъектОбработки, Записать, НайденПредопределенныйМаршрут)
	
	ПустойМаршрут = Справочники.МаршрутыПодписания.ПустаяСсылка();
	ВидыДокументовСНесколькимиПодписями = ОбменСБанкамиСлужебныйПовтИсп.ВидыДокументовПодписываемыхПоМаршруту();
	ПараметрыОтбора = Новый Структура("МаршрутПодписания", ПустойМаршрут);
	СтрокиСПустымМаршрутом = ОбъектОбработки.ИсходящиеДокументы.НайтиСтроки(ПараметрыОтбора);
	Для Каждого СтрокаНастройки Из СтрокиСПустымМаршрутом Цикл
		Если ВидыДокументовСНесколькимиПодписями.Найти(СтрокаНастройки.ИсходящийДокумент) = Неопределено Тогда
			Если ОбщегоНазначения.ПредопределенныйЭлемент("Справочник.МаршрутыПодписания.ОднойДоступнойПодписью") = Неопределено Тогда
				НайденПредопределенныйМаршрут = Ложь;
			Иначе
				СтрокаНастройки.МаршрутПодписания = Справочники.МаршрутыПодписания.ОднойДоступнойПодписью;
			КонецЕсли;
		Иначе
			МаршрутИзНесколькихПодписей = ОбменСБанкамиСлужебный.НовыйМаршрутПоСертификатамНастройки(
				ОбъектОбработки.Ссылка, СтрокаНастройки.ИсходящийДокумент);
			Если Не ЗначениеЗаполнено(МаршрутИзНесколькихПодписей) Тогда
				Если ОбщегоНазначения.ПредопределенныйЭлемент("Справочник.МаршрутыПодписания.ОднойДоступнойПодписью") = Неопределено Тогда
					НайденПредопределенныйМаршрут = Ложь;
				Иначе
					МаршрутИзНесколькихПодписей = Справочники.МаршрутыПодписания.ОднойДоступнойПодписью;
				КонецЕсли;
			КонецЕсли;
			СтрокаНастройки.МаршрутПодписания = МаршрутИзНесколькихПодписей;
		КонецЕсли;
		Записать = Истина;
	КонецЦикла;
	
КонецПроцедуры

Процедура УстановитьИспользованиеКриптографииДляСбербанка(ОбъектОбработки, Записать)
	
	Если ОбъектОбработки.ПрограммаБанка = Перечисления.ПрограммыБанка.СбербанкОнлайн
		И НЕ ОбъектОбработки.ИспользуетсяКриптография И ОбъектОбработки.СертификатыПодписейОрганизации.Количество() Тогда
		ОбъектОбработки.ИспользуетсяКриптография = Истина;
		Записать = Истина;
	КонецЕсли;

КонецПроцедуры

Процедура УстановитьФлагПодтвердитьВБанке(ОбъектОбработки, Записать)
	
	Если НЕ ОбъектОбработки.УдалитьОбновленоПодтвердитьВБанке Тогда
		Если ОбъектОбработки.ПрограммаБанка = Перечисления.ПрограммыБанка.АсинхронныйОбмен Тогда
			ВидыПлатежныхДокументов = ОбменСБанкамиСлужебный.ВидыПлатежныхДокументов();
			Для каждого ЭлементКоллекции Из ОбъектОбработки.ИсходящиеДокументы Цикл
				Если НЕ ЭлементКоллекции.ИспользоватьЭП
					И ВидыПлатежныхДокументов.Найти(ЭлементКоллекции.ИсходящийДокумент) <> Неопределено Тогда
					ЭлементКоллекции.ПодтвердитьВБанке = Истина;
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
		ОбъектОбработки.УдалитьОбновленоПодтвердитьВБанке = Истина;
		Записать = Истина;
	КонецЕсли;

КонецПроцедуры

Процедура ЗаполнитьТаблицуСертификатовБанка(ОбъектОбработки, Записать)
	
	Если ОбъектОбработки.ИспользуетсяКриптография И ОбъектОбработки.СертификатыБанка.Количество() = 0 Тогда
		Если ОбъектОбработки.ПрограммаБанка = Перечисления.ПрограммыБанка.СбербанкОнлайн Тогда
			ДвоичныеДанныеСертификата = ОбъектОбработки.УдалитьСертификатБанка.Получить();
			Если ДвоичныеДанныеСертификата <> Неопределено Тогда
				ДанныеСертификатаВФорматеDER = ОбменСБанкамиСлужебный.ДанныеСертификатаВФорматеDER(ДвоичныеДанныеСертификата);
				СертификатКриптографии = Новый СертификатКриптографии(ДанныеСертификатаВФорматеDER);
				СвойстваСертификата = ЭлектроннаяПодпись.СвойстваСертификата(СертификатКриптографии);
				СерийныйНомер = НРег(СтрЗаменить(Строка(СвойстваСертификата.СерийныйНомер), " ", ""));
				НовЗапись = ОбъектОбработки.СертификатыБанка.Добавить();
				НовЗапись.Данные = Новый ХранилищеЗначения(ДвоичныеДанныеСертификата, Новый СжатиеДанных(9));
				НовЗапись.СерийныйНомер = СерийныйНомер;
				НовЗапись.Наименование = СвойстваСертификата.Представление;
				НовЗапись.ДатаОкончания = СвойстваСертификата.ДатаОкончания;
			КонецЕсли;
			Записать = Истина;
		ИначеЕсли ОбъектОбработки.ПрограммаБанка = Перечисления.ПрограммыБанка.ОбменЧерезВК
			ИЛИ ОбъектОбработки.ПрограммаБанка = Перечисления.ПрограммыБанка.ОбменЧерезДопОбработку Тогда
			ДвоичныеДанныеСертификата = ОбъектОбработки.УдалитьСертификатБанка.Получить();
			НовЗапись = ОбъектОбработки.СертификатыБанка.Добавить();
			НовЗапись.Данные = Новый ХранилищеЗначения(ДвоичныеДанныеСертификата, Новый СжатиеДанных(9));
			Записать = Истина;
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#КонецЕсли

