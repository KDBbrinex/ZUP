
#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// ЭлектронноеВзаимодействие

// См. ЭлектронноеВзаимодействиеПереопределяемый.ПолучитьСоответствиеФункциональныхОпций.
Процедура ПолучитьСоответствиеФункциональныхОпций(СоответствиеФО) Экспорт
	// Электронные документы
	СоответствиеФО.Вставить("ИспользоватьЭлектронныеПодписи", 		  "ИспользоватьЭлектронныеПодписи");
	СоответствиеФО.Вставить("ИспользоватьОбменСБанками",              "ИспользоватьОбменСБанками");
	// Конец электронные документы
КонецПроцедуры

// См. ЭлектронноеВзаимодействиеПереопределяемый.ПолучитьСоответствиеСправочников.
Процедура ПолучитьСоответствиеСправочников(СоответствиеСправочников) Экспорт
	ЗарплатаКадрыВнутренний.ЭлектронноеВзаимодействиеПриОпределенииСоответствияСправочников(СоответствиеСправочников);
КонецПроцедуры

// См. ЭлектронноеВзаимодействиеПереопределяемый.ТекстСообщенияОНеобходимостиНастройкиСистемы.
Процедура ТекстСообщенияОНеобходимостиНастройкиСистемы(ВидОперации, ТекстСообщения) Экспорт
	
	Если ВРег(ВидОперации) = "РАБОТАСЭД" Тогда
		ТекстСообщения = НСтр("ru = 'Для работы с электронными документами необходимо
			|в настройках системы включить использование обмена электронными документами.'");
	ИначеЕсли ВРег(ВидОперации) = "ПОДПИСАНИЕЭД" Тогда
		ТекстСообщения = НСтр("ru = 'Для возможности подписания ЭД необходимо
			|в настройках системы включить опцию использования электронных цифровых подписей.'");
	ИначеЕсли ВРег(ВидОперации) = "НАСТРОЙКАКРИПТОГРАФИИ" Тогда
		ТекстСообщения = НСтр("ru = 'Для возможности настройки криптографии необходимо 
			|в настройках системы включить опцию использования электронных цифровых подписей.'");
	ИначеЕсли ВРег(ВидОперации) = "РАБОТАСБАНКАМИ" Тогда
			ТекстСообщения = НСтр("ru = 'Для возможности обмена ЭД с банками необходимо 
			|в настройках программы включить опцию использования прямого обмена с банками.'");
	Иначе
		ТекстСообщения = НСтр("ru='Операция не может быть выполнена. Не выполнены необходимые настройки программы.'");
	КонецЕсли;
	
КонецПроцедуры

// См. ЭлектронноеВзаимодействиеПереопределяемый.ИзменитьСообщениеОбОшибке.
Процедура ИзменитьСообщениеОбОшибке(КодОшибки, ТекстОшибки) Экспорт
	
	Если КодОшибки = "100" ИЛИ КодОшибки = "110" Тогда
		ТекстОшибки = НСтр("ru = 'Проверьте общие настройки криптографии.'");
	КонецЕсли;
	
КонецПроцедуры

// См. ЭлектронноеВзаимодействиеПереопределяемый.НайтиСсылкуНаОбъект.
Процедура НайтиСсылкуНаОбъект(ТипОбъекта, Результат, ИдОбъекта = "", ДополнительныеРеквизиты = Неопределено, ИДЭД = Неопределено) Экспорт
	
	Если ТипОбъекта = "Валюты" Тогда
		Результат = НайтиСсылкуНаОбъектПоРеквизиту(ТипОбъекта, "Код", ИдОбъекта);
	ИначеЕсли ТипОбъекта = "Банки" И ЗначениеЗаполнено(ДополнительныеРеквизиты) Тогда
		Результат = СсылкаНаБанкПоБИК(ДополнительныеРеквизиты.Код);
	ИначеЕсли ТипОбъекта = "Контрагенты" И ЗначениеЗаполнено(ДополнительныеРеквизиты) Тогда
		ПараметрПоиска = "";
		ИНН = "";
		КПП = "";
		Если ДополнительныеРеквизиты.Свойство("ИНН")
			И ЗначениеЗаполнено(ДополнительныеРеквизиты.ИНН) Тогда 
			ИНН = ДополнительныеРеквизиты.ИНН;
		КонецЕсли;
		Если ДополнительныеРеквизиты.Свойство("КПП")
			И ЗначениеЗаполнено(ДополнительныеРеквизиты.КПП) Тогда 
			КПП = ДополнительныеРеквизиты.КПП;
		КонецЕсли;
		Если ЗначениеЗаполнено(ИНН) Тогда
			Результат = СсылкаНаКонтрагентаПоИННКПП(ИНН, КПП);
		КонецЕсли;
		Если НЕ ЗначениеЗаполнено(Результат) И ДополнительныеРеквизиты.Свойство("Наименование", ПараметрПоиска) Тогда
			Результат = НайтиСсылкуНаОбъектПоРеквизиту(ТипОбъекта, "Наименование", ПараметрПоиска); 
		КонецЕсли;
		
	ИначеЕсли ТипОбъекта = "Организации" И ЗначениеЗаполнено(ДополнительныеРеквизиты) Тогда
		ПараметрПоиска = "";
		ИНН = "";
		КПП = "";
		Если ДополнительныеРеквизиты.Свойство("ИНН")
			И ЗначениеЗаполнено(ДополнительныеРеквизиты.ИНН) Тогда 
			ИНН = ДополнительныеРеквизиты.ИНН;
		КонецЕсли;
		Если ДополнительныеРеквизиты.Свойство("КПП")
			И ЗначениеЗаполнено(ДополнительныеРеквизиты.КПП) Тогда 
			КПП = ДополнительныеРеквизиты.КПП;
		КонецЕсли;
		Если ЗначениеЗаполнено(ИНН) Тогда
			Результат = СсылкаНаОрганизациюПоИННКПП(ИНН, КПП);
		КонецЕсли;
		Если НЕ ЗначениеЗаполнено(Результат) И ДополнительныеРеквизиты.Свойство("Наименование", ПараметрПоиска) Тогда
			Результат = НайтиСсылкуНаОбъектПоРеквизиту(ТипОбъекта, "Наименование", ПараметрПоиска); 
		КонецЕсли;
		
	ИначеЕсли ТипОбъекта = "ВидыКонтактнойИнформации" Тогда
		Попытка 
			Результат = Справочники.ВидыКонтактнойИнформации[ИдОбъекта];
		Исключение
			Результат = Неопределено;
		КонецПопытки;
	ИначеЕсли ТипОбъекта = "БанковскиеСчетаКонтрагентов" И ЗначениеЗаполнено(ДополнительныеРеквизиты)Тогда
		Владелец = "";
		Если ДополнительныеРеквизиты.Свойство("Владелец", Владелец) Тогда
			ИмяПрикладногоСправочника = ЭлектронноеВзаимодействиеСлужебныйВызовСервера.ИмяПрикладногоСправочника(ТипОбъекта);
			Результат = НайтиСсылкуНаОбъектПоРеквизиту(ИмяПрикладногоСправочника, "НомерСчета", ИдОбъекта, Владелец);
		КонецЕсли;
		
	ИначеЕсли ТипОбъекта = "СтраныМира" Тогда
		Результат = НайтиСсылкуНаОбъектПоРеквизиту("СтраныМира", "Код", ИдОбъекта);
	КонецЕсли;
	
КонецПроцедуры

// См. ЭлектронноеВзаимодействиеПереопределяемый.ПолучитьПечатныйНомерДокумента.
Процедура ПолучитьПечатныйНомерДокумента(СсылкаНаОбъект, Результат) Экспорт
	
	Результат = 
		ПрефиксацияОбъектовКлиентСервер.НомерНаПечать(
			ОбщегоНазначения.ЗначениеРеквизитаОбъекта(СсылкаНаОбъект, "Номер"), 
			Истина, 
			Ложь);
	
КонецПроцедуры

// См. ЭлектронноеВзаимодействиеПереопределяемый.ПроверитьГотовностьИсточников.
Процедура ПроверитьГотовностьИсточников(ДокументыМассив) Экспорт
	
	ОбщегоНазначенияКлиентСервер.УдалитьВсеВхожденияТипаИзМассива(ДокументыМассив, Тип("СтрокаГруппировкиДинамическогоСписка"));
	
	НеГотовые = Новый Массив;
	Для каждого Источник Из ДокументыМассив Цикл
		Если Не Источник.ПолучитьОбъект().ПроверитьЗаполнение() Тогда
			НеГотовые.Добавить(Источник);
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого НеГотов Из НеГотовые Цикл
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ДокументыМассив, НеГотов);
	КонецЦикла;
	
КонецПроцедуры

// См. ЭлектронноеВзаимодействиеПереопределяемый.ПолучитьДанныеЮрФизЛица.
Процедура ПолучитьДанныеЮрФизЛица(ЮрФизЛицо, Сведения) Экспорт
	
	СписокПоказателей = Новый Массив;
	СписокПоказателей.Добавить("ИННЮЛ");
	СписокПоказателей.Добавить("КППЮЛ");
	СписокПоказателей.Добавить("НаимЮЛПол");
	
	СведенияОбОрганизации = ЗарплатаКадры.ПолучитьСведенияОбОрганизации(ЮрФизЛицо, ТекущаяДатаСеанса(), СписокПоказателей);
	Сведения.Вставить("ИНН", СведенияОбОрганизации.ИННЮЛ);
	Сведения.Вставить("КПП", СведенияОбОрганизации.КППЮЛ);
	Сведения.Вставить("ПолноеНаименование", СведенияОбОрганизации.НаимЮЛПол);
	
КонецПроцедуры

// См. ЭлектронноеВзаимодействиеПереопределяемый.ОписаниеОрганизации.
Процедура ОписаниеОрганизации(СведенияОрганизации, Результат, Список = "", СПрефиксом = Истина) Экспорт
	Результат = "";
КонецПроцедуры

// См. ЭлектронноеВзаимодействиеПереопределяемый.ЕстьПравоОткрытияЖурналаРегистрации.
Процедура ЕстьПравоОткрытияЖурналаРегистрации(Результат) Экспорт
		
	Результат = Пользователи.ЭтоПолноправныйПользователь();

КонецПроцедуры

// См. ЭлектронноеВзаимодействиеПереопределяемый.ПередЗаписьюВладельцаЭлектронногоДокумента.
Процедура ПередЗаписьюВладельцаЭлектронногоДокумента(Объект, ИзменилисьКлючевыеРеквизиты, Знач СостояниеЭлектронногоДокумента, ПодлежитОбменуЭД, Отказ) Экспорт
	
	Если Метаданные.ОпределяемыеТипы.ВладелецОбъектОбменСБанкамиБЗК.Тип.СодержитТип(ТипЗнч(Объект)) Тогда
		ИзменилисьКлючевыеРеквизиты = ИзменилисьКлючевыеРеквизиты Или Объект.ИзменилисьКлючевыеРеквизитыЭлектронногоДокумента();
	КонецЕсли
	
КонецПроцедуры

// Конец ЭлектронноеВзаимодействие

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает признак изменения реквизитов объекта.
// Сравнивает указанные реквизиты объекта с их значениями в информационной базе.
//
// Параметры:
//	Объект - СправочникОбъект, ДокументОбъект - Проверяемый объект.
//	Реквизиты - Строка                        - Список имен реквизитов объекта, разделенный запятыми, 
//                                              изменение которых необходимо проверить.
//	ИсключаяРеквизиты - Строка                - Список имен реквизитов объекта, разделенный запятыми,
//                                              которые необходимо исключить из проверки.
//
// Возвращаемое значение:
//	Булево - Истина, если значение хотя бы одного из переданных реквизитов отличается от сохраненного в ИБ.
// 
Функция ИзменилисьРеквизитыОбъекта(Объект, Знач Реквизиты = Неопределено, Знач ИсключаяРеквизиты = Неопределено) Экспорт
	
	Если ПустаяСтрока(Реквизиты) Тогда
		СравниваемыеРеквизиты = Новый Массив;
		МетаданныеОбъекта = Объект.Метаданные();
		Для Каждого СтандартныйРеквизит Из МетаданныеОбъекта.СтандартныеРеквизиты Цикл
			СравниваемыеРеквизиты.Добавить(СтандартныйРеквизит.Имя);
		КонецЦикла;	
		Для Каждого Реквизит Из МетаданныеОбъекта.Реквизиты Цикл
			СравниваемыеРеквизиты.Добавить(Реквизит.Имя);
		КонецЦикла;	
	Иначе
		СравниваемыеРеквизиты = СтроковыеФункцииБЗККлиентСервер.РазделитьИменаСвойств(Реквизиты);
	КонецЕсли;
	
	// Вычитаем исключаемые реквизиты
	СравниваемыеРеквизиты = 
		ОбщегоНазначенияКлиентСервер.РазностьМассивов(
			СравниваемыеРеквизиты, 
			СтроковыеФункцииБЗККлиентСервер.РазделитьИменаСвойств(ИсключаяРеквизиты));
	
	ПрежниеЗначения = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Объект.Ссылка, СравниваемыеРеквизиты);
	
	ТекущиеЗначения = Новый Структура(СтрСоединить(СравниваемыеРеквизиты, ","));
	ЗаполнитьЗначенияСвойств(ТекущиеЗначения, Объект);
	
	Возврат Не ОбщегоНазначения.ДанныеСовпадают(ПрежниеЗначения, ТекущиеЗначения);
	
КонецФункции

// Возвращает признак изменения реквизитов табличной части объекта.
// Сравнивает указанные реквизиты объекта с их значениями в информационной базе.
//
// Параметры:
//	Объект - СправочникОбъект, ДокументОбъект - Проверяемый объект.
//	ИмяТабличнойЧасти - Строка                - Имя табличной части объекта.
//                                              изменение которой необходимо проверить.
//	Реквизиты - Строка                        - Список имен реквизитов табличной части объекта, разделенный запятыми, 
//                                              изменение которых необходимо проверить.
//	ИсключаяРеквизиты - Строка                - Список имен реквизитов табличной части объекта, разделенный запятыми,
//                                              которые необходимо исключить из проверки.
//
// Возвращаемое значение:
//	Булево - Истина, если значение хотя бы одного из переданных реквизитов отличается от сохраненного в ИБ.
// 
Функция ИзмениласьТабличнаяЧастьОбъекта(Объект, ИмяТабличнойЧасти, Знач Реквизиты = Неопределено, Знач ИсключаяРеквизиты = Неопределено) Экспорт
	
	МетаданныеТЧ = Объект.Метаданные().ТабличныеЧасти[ИмяТабличнойЧасти];
	
	Если ПустаяСтрока(Реквизиты) Тогда
		СравниваемыеРеквизиты = Новый Массив;
		Для Каждого СтандартныйРеквизит Из МетаданныеТЧ.СтандартныеРеквизиты Цикл
			СравниваемыеРеквизиты.Добавить(СтандартныйРеквизит.Имя);
		КонецЦикла;	
		Для Каждого Реквизит Из МетаданныеТЧ.Реквизиты Цикл
			СравниваемыеРеквизиты.Добавить(Реквизит.Имя);
		КонецЦикла;	
	Иначе
		СравниваемыеРеквизиты = СтроковыеФункцииБЗККлиентСервер.РазделитьИменаСвойств(Реквизиты);
	КонецЕсли;
	
	// Вычитаем исключаемые реквизиты
	СравниваемыеРеквизиты = 
		ОбщегоНазначенияКлиентСервер.РазностьМассивов(
			СравниваемыеРеквизиты, 
			СтроковыеФункцииБЗККлиентСервер.РазделитьИменаСвойств(ИсключаяРеквизиты));
	
	// Составляем запрос выбора сравниваемых реквизитов ТЧ
	Схема = Новый СхемаЗапроса;
	ЗапросВыбора = Схема.ПакетЗапросов.Добавить();
	ЗапросВыбора.ВыбиратьРазрешенные = Ложь;
	ОператорВыбрать = ЗапросВыбора.Операторы[0];	
	ОператорВыбрать.Источники.Добавить(Объект.Метаданные().ПолноеИмя() +"."+ ИмяТабличнойЧасти, "Таблица");
	ОператорВыбрать.ВыбираемыеПоля.Добавить("Ссылка");
	Для Каждого СравниваемыйРеквизит Из СравниваемыеРеквизиты Цикл
		ОператорВыбрать.ВыбираемыеПоля.Добавить(СравниваемыйРеквизит);
	КонецЦикла;	
	ОператорВыбрать.Отбор.Добавить("Таблица.Ссылка = &Ссылка");
	
	// получаем прежние значения табличной части из ИБ
	Запрос = Новый Запрос;
	Запрос.Текст = Схема.ПолучитьТекстЗапроса();
	Запрос.УстановитьПараметр("Ссылка", Объект.Ссылка);
	ПрежниеЗначения = Запрос.Выполнить().Выгрузить();
	
	Возврат Не ОбщегоНазначения.КоллекцииИдентичны(Объект[ИмяТабличнойЧасти], ПрежниеЗначения, СтрСоединить(СравниваемыеРеквизиты, ","))
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Находит ссылку на справочник по переданному реквизиту.
//
// Параметры:
//  ИмяСправочника - Строка, имя справочника, объект которого надо найти,
//  ИмяРеквизита - Строка, имя реквизита, по которому будет проведен поиск,
//  ЗначРеквизита - произвольное значение, значение реквизита, по которому будет проведен поиск,
//  Владелец - Ссылка на владельца для поиска в иерархическом справочнике.
//
Функция НайтиСсылкуНаОбъектПоРеквизиту(ИмяСправочника, ИмяРеквизита, ЗначРеквизита, Владелец = Неопределено) Экспорт
	
	Результат = Неопределено;
	
	ОбъектМетаданных = Метаданные.Справочники[ИмяСправочника];
	Если НЕ ОбщегоНазначения.ЭтоСтандартныйРеквизит(ОбъектМетаданных.СтандартныеРеквизиты, ИмяРеквизита)
		И НЕ ОбъектМетаданных.Реквизиты.Найти(ИмяРеквизита) <> Неопределено Тогда
		
		Возврат Результат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ИскСправочник.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник." + ИмяСправочника + " КАК ИскСправочник
	|ГДЕ
	|	ИскСправочник." + ИмяРеквизита + " = &ЗначРеквизита";
	
	Если ЗначениеЗаполнено(Владелец) Тогда
		Запрос.Текст = Запрос.Текст + " И ИскСправочник.Владелец = &Владелец";
		Запрос.УстановитьПараметр("Владелец", Владелец);
	КонецЕсли;
	Запрос.УстановитьПараметр("ЗначРеквизита", ЗначРеквизита);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Результат = Выборка.Ссылка;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция СсылкаНаКонтрагентаПоИННКПП(ИНН, КПП) Экспорт
	
	Результат = Неопределено;
	
	Запрос = Новый Запрос;
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
	|	Контрагенты.Ссылка
	|ИЗ
	|	Справочник.Контрагенты КАК Контрагенты
	|ГДЕ
	|	Контрагенты.ИНН = &ИНН";
	Если ЗначениеЗаполнено(КПП) И КПП <> "0" Тогда
		ТекстЗапроса = ТекстЗапроса
			+ " И
			|	Контрагенты.КПП = &КПП";
		Запрос.УстановитьПараметр("КПП", КПП);
	КонецЕсли;
	Запрос.Текст = ТекстЗапроса;
	Запрос.УстановитьПараметр("ИНН", ИНН);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Результат = Выборка.Ссылка;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция СсылкаНаОрганизациюПоИННКПП(ИНН, КПП) Экспорт
	
	Результат = Неопределено;
	
	Запрос = Новый Запрос;
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
	|	Организации.Ссылка
	|ИЗ
	|	Справочник.Организации КАК Организации
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.РегистрацииВНалоговомОргане КАК РегистрацииВНалоговомОргане
	|		ПО Организации.РегистрацияВНалоговомОргане = РегистрацииВНалоговомОргане.Ссылка
	|ГДЕ
	|	Организации.ИНН = &ИНН";
	Если ЗначениеЗаполнено(КПП) И КПП <> "0" Тогда
		ТекстЗапроса = ТекстЗапроса
			+ " И
			|	РегистрацииВНалоговомОргане.КПП = &КПП";
		Запрос.УстановитьПараметр("КПП", КПП);
	КонецЕсли;
	Запрос.Текст = ТекстЗапроса;
	Запрос.УстановитьПараметр("ИНН", ИНН);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Результат = Выборка.Ссылка;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция СсылкаНаБанкПоБИК(БИК)
	
	Результат = Неопределено;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("БИК", БИК);
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	КлассификаторБанков.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.КлассификаторБанков КАК КлассификаторБанков
	|ГДЕ
	|	КлассификаторБанков.Код = &БИК";
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Результат = Выборка.Ссылка;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти
