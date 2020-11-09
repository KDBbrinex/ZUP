////////////////////////////////////////////////////////////////////////////////
// ЭлектронноеВзаимодействиеСлужебныйКлиент: общий механизм обмена электронными документами.
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

// Выводит пользователю информацию об обработанных электронных документах.
//
// Параметры:
//  ТекстЗаголовка - Строка - текст заголовка оповещения пользователя;
//  КолСформированных - Число - количество сформированных электронных документов;
//  КолУтвержденных - Число -  количество утвержденных электронных документов;
//  КолПодписанных - Число -  количество подписанных электронных документов;
//  КолПодготовленных - Число -  количество подготовленных к отправке электронных документов;
//  КолОтправленных - Число - количество отправленных электронных документов.
//
Процедура ВывестиИнформациюОбОбработанныхЭД(ТекстЗаголовка, КолСформированных, КолУтвержденных, КолПодписанных, КолПодготовленных, КолОтправленных = 0) Экспорт
	
	Если КолПодготовленных + КолОтправленных > 0 Тогда
		ДопТекст = ?(КолОтправленных > 0, НСтр("ru = 'отправлено'"), НСтр("ru = 'подготовлено к отправке'"));
		Количество = ?(КолОтправленных > 0, КолОтправленных, КолПодготовленных);
		Если КолПодписанных > 0 Тогда
			Если КолУтвержденных > 0 Тогда
				Если КолСформированных > 0 Тогда
					Текст = НСтр("ru = 'Сформировано: (%1), утверждено: (%2), подписано: (%3), %4 пакетов: (%5)'");
					Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Текст, КолСформированных, КолУтвержденных,
						КолПодписанных, ДопТекст, Количество);
				Иначе
					Текст = НСтр("ru = 'Утверждено: (%1), подписано: (%2), %3 пакетов: (%4)'");
					Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Текст, КолУтвержденных, КолПодписанных, ДопТекст,
						Количество);
				КонецЕсли;
			Иначе
				Текст = НСтр("ru = 'Подписано: (%1), %2 пакетов: (%3)'");
				Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Текст, КолПодписанных, ДопТекст, Количество);
			КонецЕсли;
		Иначе
			Если КолУтвержденных > 0 Тогда
				Если КолСформированных > 0 Тогда
					Текст = НСтр("ru = 'Сформировано: (%1), утверждено: (%2), %3 пакетов: (%4)'");
					Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Текст, КолСформированных,
						КолУтвержденных, ДопТекст, КолПодготовленных);
				Иначе
					Текст = НСтр("ru = 'Утверждено: (%1), %2 пакетов: (%3)'");
					Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Текст, КолУтвержденных, ДопТекст, КолПодготовленных);
				КонецЕсли;
			Иначе
				Текст = НСтр("ru = '%1 пакетов: (%2)'");
				Количество = Макс(КолПодготовленных, КолОтправленных);
				Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Текст, ДопТекст, Количество);
			КонецЕсли;
		КонецЕсли;
	Иначе
		Если КолПодписанных > 0 Тогда
			Если КолУтвержденных > 0 Тогда
				Если КолСформированных > 0 Тогда
					Текст = НСтр("ru = 'Сформировано: (%1), утверждено: (%2), подписано: (%3)'");
					Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Текст, КолСформированных, КолУтвержденных,
						КолПодписанных);
				Иначе
					Текст = НСтр("ru = 'Утверждено: (%1), подписано: (%2)'");
					Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Текст, КолУтвержденных, КолПодписанных);
				КонецЕсли;
			Иначе
				Текст = НСтр("ru = 'Подписано: (%1)'");
				Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Текст, КолПодписанных);
			КонецЕсли;
		Иначе
			Если КолУтвержденных > 0 Тогда
				Если КолСформированных > 0 Тогда
					Текст = НСтр("ru = 'Сформировано: (%1), утверждено: (%2)'");
					Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Текст, КолСформированных, КолУтвержденных);
				Иначе
					Текст = НСтр("ru = 'Утверждено: (%1)'");
					Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Текст, КолУтвержденных);
				КонецЕсли;
			Иначе
				Если КолСформированных > 0 Тогда
					Текст = НСтр("ru = 'Сформировано: (%1)'");
					Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Текст, КолСформированных);
				Иначе
					Текст = НСтр("ru = 'Обработанных документов нет...'");
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	ПоказатьОповещениеПользователя(ТекстЗаголовка, ,Текст);
	
КонецПроцедуры

// Выводит сообщение пользователю о нехватке прав доступа.
Процедура СообщитьПользователюОНарушенииПравДоступа() Экспорт
	
	ОчиститьСообщения();
	ТекстСообщения = НСтр("ru = 'Нарушение прав доступа.'");
	ЭлектронноеВзаимодействиеКлиентПереопределяемый.ПодготовитьТекстСообщенияОНарушенииПравДоступа(ТекстСообщения);
	ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
	
КонецПроцедуры

// Функция получает массив ссылок на объекты.
//
// Параметры:
//  ПараметрКоманды - ссылка на объект или массив.
//
// Возвращаемое значение:
//  МассивСсылок - если передан в параметр массив, то возвращает его же
//                 если передана пустая ссылка возвращает неопределено.
//
Функция МассивПараметров(ПараметрКоманды) Экспорт
	
	#Если ТолстыйКлиентОбычноеПриложение Тогда
		Если ТипЗнч(ПараметрКоманды) = Тип("ВыделенныеСтрокиТабличногоПоля") Тогда
			МассивСсылок = Новый Массив;
			Для Каждого Элемент Из ПараметрКоманды Цикл
				МассивСсылок.Добавить(Элемент);
			КонецЦикла;
			
			Возврат МассивСсылок;
		КонецЕсли;
	#КонецЕсли
	
	Если ТипЗнч(ПараметрКоманды) = Тип("Массив") Тогда
		Если ПараметрКоманды.Количество() = 0 Тогда
			Возврат Неопределено;
		КонецЕсли;
		МассивСсылок = ПараметрКоманды;
	Иначе // пришла единичная ссылка на объект
		Если НЕ ЗначениеЗаполнено(ПараметрКоманды) Тогда
			Возврат Неопределено;
		КонецЕсли;
		МассивСсылок = Новый Массив;
		МассивСсылок.Добавить(ПараметрКоманды);
	КонецЕсли;
	
	Возврат МассивСсылок;
	
КонецФункции

// Осуществляет подсчет количество подписанных электронных документов.
// 
// Параметры:
//   РезультатВыполнения - Структура - возвращает метод ЭлектроннаяПодписьКлиент.Подписать.
//
// Возвращаемое значение:
//    Число - количество подписанных документов.
//
Функция КоличествоПодписанныхЭД(РезультатВыполнения) Экспорт
	
	КолВоПодписанных = 0;
	
	НаборДанных = Неопределено;
	РезультатВыполнения.Свойство("НаборДанных", НаборДанных);
	Если НаборДанных = Неопределено Тогда
		Возврат КолВоПодписанных;
	КонецЕсли;
	
	Успех = Неопределено;
	РезультатВыполнения.Свойство("Успех", Успех);
	Если Успех = Неопределено Тогда
		Возврат КолВоПодписанных;
	КонецЕсли;
	
	Если Успех Тогда
		КолВоПодписанных = НаборДанных.Количество();
		Возврат КолВоПодписанных;
	КонецЕсли;
	
	// Если в во входящих параметрах свойство "Успех" ложь,
	// то посчитаем кол-во подписанных ЭД
	// если из 3 переданных ЭД подписали 2.
	Для Каждого ЭлементМассива Из НаборДанных Цикл
		Если ЭлементМассива.Свойство("СтруктураПодписи") Тогда
			КолВоПодписанных = КолВоПодписанных + 1;
		КонецЕсли;
	КонецЦикла;
	
	Возврат КолВоПодписанных;
	
КонецФункции

Процедура ОткрытьВыборМаршрутаПодписания(ФормаВладелец, АдресПараметровВыбораМаршрута, Организация, 
	ОповещениеОЗакрытии = Неопределено, ТолькоПросмотр = Ложь) Экспорт
	
	ПараметрыОткрытияФормы = Новый Структура("ПараметрыМаршрута, Организация, ТолькоПросмотр", 
		АдресПараметровВыбораМаршрута, Организация, ТолькоПросмотр);
	ОткрытьФорму("Справочник.МаршрутыПодписания.Форма.ВыборМаршрута", ПараметрыОткрытияФормы, ФормаВладелец, 
		ФормаВладелец.УникальныйИдентификатор,,, ОповещениеОЗакрытии, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца); 

КонецПроцедуры

// Формирует представление ошибки подписания по переданному ключу.
//
// Параметры:
//  КлючОшибки	 - Строка - идентификатор ошибки.
// 
// Возвращаемое значение:
//  Строка - представление ошибки.
//
Функция ПредставлениеОшибкиПодписания(КлючОшибки) Экспорт
	
	Результат = "";
	Если КлючОшибки = "ОшибкиВМаршруте" Тогда
		Результат = НСтр("ru = 'Для подписания документа есть доступные сертификаты, но подписи по ним уже установлены. Проверьте настройки маршрута подписания.'");
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции 

// Создает структуру, описывающую выполняемую операцию. Используется в процедурах: ЭлектронноеВзаимодействиеОбработкаОшибок.ДобавитьОшибку,
// ЭлектронноеВзаимодействиеОбработкаОшибокКлиент.ДобавитьОшибку, ЭлектронноеВзаимодействиеОбработкаОшибокКлиент.ОбработатьОшибки.
// В структуру нельзя помещать мутабельные объекты, т.к. она может передаваться между клиентом и сервером.
// 
// Возвращаемое значение:
//  Структура - см. ЭлектронноеВзаимодействиеСлужебный.НовыйКонтекстОперации.
//
Функция НовыйКонтекстОперации() Экспорт
	
	Контекст = ЭлектронноеВзаимодействиеСлужебныйКлиентСервер.НовыйКонтекстОперации();
	Контекст.Вставить("ДатаНачалаОперации", ОбщегоНазначенияКлиент.ДатаСеанса());
	
	Возврат Контекст;
	
КонецФункции

Процедура СкопироватьВБуферОбмена(Текст, ТекстОповещения) Экспорт

#Если Не ВебКлиент И Не МобильныйКлиент Тогда
	
	Попытка
		ОбъектЗапись = Новый COMОбъект("htmlfile");
		ОбъектЗапись.ParentWindow.ClipboardData.Setdata("Text", Текст);
		ПоказатьОповещениеПользователя(НСтр("ru = 'Успешно'"),
				, ТекстОповещения);
	Исключение
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Возникла ошибка при копировании в буфер обмена.
				|Воспользуйтесь комбинацией клавиш Ctrl+C.'"));
	КонецПопытки;
	
#КонецЕсли

КонецПроцедуры

// Блокирует открытие формы на мобильном клиенте
//
// Параметры:
//  Отказ - Булево - если используется мобильный клиент, то параметр устанавливается в значение Истина.
//
Процедура ЗаблокироватьОткрытиеФормыНаМобильномКлиенте(Отказ) Экспорт
	
	#Если МобильныйКлиент Тогда
		ТекстСообщения = НСтр("ru = 'Функциональность в мобильном клиенте пока недоступна. Воспользуйтесь веб-клиентом или тонким клиентом'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения, , , , Отказ);
	#КонецЕсли
	
КонецПроцедуры

Процедура ВыполнитьПроверкуПроведенияДокументов(ДокументыМассив, ОбработкаПродолжения, ФормаИсточник = Неопределено) Экспорт
	
	СтандартнаяОбработка = Истина;
	ЭлектронноеВзаимодействиеКлиентПереопределяемый.ВыполнитьПроверкуПроведенияДокументов(
		ДокументыМассив, ОбработкаПродолжения, ФормаИсточник, СтандартнаяОбработка);
		
	Если СтандартнаяОбработка = Ложь Тогда
		Возврат;
	КонецЕсли;
	
	ДокументыТребующиеПроведение = ОбщегоНазначенияВызовСервера.ПроверитьПроведенностьДокументов(ДокументыМассив);
	КоличествоНепроведенныхДокументов = ДокументыТребующиеПроведение.Количество();
	
	Если КоличествоНепроведенныхДокументов > 0 Тогда
		
		Если КоличествоНепроведенныхДокументов = 1 Тогда
			ТекстВопроса = НСтр("ru = 'Для того чтобы сформировать электронную версию документа, его необходимо предварительно провести.
										|Выполнить проведение документа и продолжить?'");
		Иначе
			ТекстВопроса = НСтр("ru = 'Для того чтобы сформировать электронные версии документов, их необходимо предварительно провести.
										|Выполнить проведение документов и продолжить?'");
		КонецЕсли;
		
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("ОбработкаПродолжения", ОбработкаПродолжения);
		ДополнительныеПараметры.Вставить("ДокументыТребующиеПроведение", ДокументыТребующиеПроведение);
		ДополнительныеПараметры.Вставить("ФормаИсточник", ФормаИсточник);
		ДополнительныеПараметры.Вставить("ДокументыМассив", ДокументыМассив);
		Обработчик = Новый ОписаниеОповещения("ВыполнитьПроверкуПроведенияДокументовПродолжить", ЭтотОбъект, ДополнительныеПараметры);
		
		ПоказатьВопрос(Обработчик, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
	Иначе
		ВыполнитьОбработкуОповещения(ОбработкаПродолжения, ДокументыМассив);
	КонецЕсли;
	
КонецПроцедуры

#Область ДлительныеОперации

// Заполняет структуру параметров значениями по умолчанию.
// 
// Параметры:
//  ПараметрыОбработчикаОжидания - Структура - заполняется значениями по умолчанию. 
//
// 
Процедура ИнициализироватьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания) Экспорт
	
	ПараметрыОбработчикаОжидания = Новый Структура;
	ПараметрыОбработчикаОжидания.Вставить("МинимальныйИнтервал", 1);
	ПараметрыОбработчикаОжидания.Вставить("МаксимальныйИнтервал", 15);
	ПараметрыОбработчикаОжидания.Вставить("ТекущийИнтервал", 1);
	ПараметрыОбработчикаОжидания.Вставить("КоэффициентУвеличенияИнтервала", 1.4);
	
КонецПроцедуры

// Заполняет структуру параметров новыми расчетными значениями.
// 
// Параметры:
//  ПараметрыОбработчикаОжидания - Структура - заполняется расчетными значениями. 
//
// 
Процедура ОбновитьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания) Экспорт
	
	ПараметрыОбработчикаОжидания.ТекущийИнтервал = ПараметрыОбработчикаОжидания.ТекущийИнтервал
		* ПараметрыОбработчикаОжидания.КоэффициентУвеличенияИнтервала;
	Если ПараметрыОбработчикаОжидания.ТекущийИнтервал > ПараметрыОбработчикаОжидания.МаксимальныйИнтервал Тогда
		ПараметрыОбработчикаОжидания.ТекущийИнтервал = ПараметрыОбработчикаОжидания.МаксимальныйИнтервал;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область Криптография

Функция НовыеПараметрыЗаполненияСертификатаКриптографии() Экспорт
	
	Параметры = Новый Структура;
	Параметры.Вставить("Организация");
	Параметры.Вставить("Программа");
	
	Возврат Параметры;
	
КонецФункции

Процедура НачатьДобавлениеСертификатаКриптографии(Знач Сертификат, Знач ПараметрыЗаполнения, Знач ОбработкаЗавершения) Экспорт
	
	Контекст = Новый Структура;
	Контекст.Вставить("Сертификат", Сертификат);
	Контекст.Вставить("ПараметрыЗаполнения", ПараметрыЗаполнения);
	Контекст.Вставить("ОбработкаЗавершения", ОбработкаЗавершения);
	
	ОбработкаПродолжения = Новый ОписаниеОповещения("НачатьДобавлениеСертификатаКриптографии_ВыгрузкаСертификата", ЭтотОбъект, Контекст);
	Сертификат.НачатьВыгрузку(ОбработкаПродолжения);
	
КонецПроцедуры

Процедура НачатьОпределениеПрограммыСертификатаКриптографии(Знач Сертификат, Знач ОбработкаЗавершения, Знач Пароль = Неопределено) Экспорт
	
	ПроцессВыполнения = НовыйПроцессОпределенияПрограммыСертификатаКриптографии(Сертификат, ОбработкаЗавершения, Пароль);
	
	ВыполнитьОпределениеПрограммыСертификатаКриптографии(Неопределено, ПроцессВыполнения);
	
КонецПроцедуры

#КонецОбласти

#Область Диагностика

// Определяет параметры вида ошибки. Параметры используются при выводе ошибки в единую форму вывода ошибок.
//
// Параметры:
//  ВидОшибки            - Строка - см. область ВидыОшибок общего модуля ОбменСКонтрагентамиДиагностикаКлиентСервер.
//  ПараметрыВидаОшибки  - Структура - см. ЭлектронноеВзаимодействиеОбработкаОшибокКлиент.НовыеПараметрыВидаОшибки.
// Пример:
//   Вариант1
//  Если ВидОшибки = ОбменСКонтрагентамиДиагностикаКлиентСервер.ВидОшибкиКриптография() Тогда
//      ПараметрыВидаОшибки.ЗаголовокПроблемы = НСтр("ru = 'Ошибка криптографии'");
//      ПараметрыВидаОшибки.ОписаниеПроблемы = СтроковыеФункцииКлиентСервер.ФорматированнаяСтрока(
//          НСтр("ru = 'Произошла криптографическая ошибка'"));
//      ПараметрыВидаОшибки.ОписаниеРешения = СтроковыеФункцииКлиентСервер.ФорматированнаяСтрока(
//          СтрШаблон(НСтр("ru = '<a href = ""Выполните"">Выполните</a> диагностику %1 или
//          |<a href = ""обратитесь"">обратитесь</a> в тех. поддержку'"), ПредставлениеПроверки));
//      ПараметрыВидаОшибки.ОбработчикиНажатия.Вставить("Выполните",
//          "ОбменСКонтрагентамиДиагностикаКлиент.ОткрытьМастерДиагностики");
//      ПараметрыВидаОшибки.ОбработчикиНажатия.Вставить("обратитесь",
//          ЭлектронноеВзаимодействиеОбработкаОшибокКлиент.ОбработчикОткрытияФормыОбращенияВТехподдержку());
//  КонецЕсли;
//
Процедура ПриОпределенииПараметровВидаОшибки(ВидОшибки, ПараметрыВидаОшибки) Экспорт
	
	// ОбменСКонтрагентами начало 
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("ЭлектронноеВзаимодействие.ОбменСКонтрагентами") Тогда
		МодульПодсистемы = ОбщегоНазначенияКлиент.ОбщийМодуль("ОбменСКонтрагентамиДиагностикаКлиент");
		МодульПодсистемы.ПриОпределенииПараметровВидаОшибки(ВидОшибки, ПараметрыВидаОшибки);
	КонецЕсли;
	// ОбменСКонтрагентами конец
	
КонецПроцедуры

// Вызывается перед формированием файла для техподдержки.
// Предназначена для подготовки клиентских данных. В переопределяемой части после заполнения данных
// необходимо выполнить обработку оповещения, указанного в параметре ОповещениеОЗавершении.
//
// Параметры:
//  ТехническаяИнформация    - Структура - см. параметр ТехническаяИнформация
//                             общего модуля ОбменСКонтрагентамиДиагностика.ПриФормированииФайлаСИнформациейДляТехподдержки.
//  ОповещениеОЗавершении    - ОписаниеОповещения - необходимо выполнить после заполнения данных, передав
//                             в качестве результата значение параметра ТехническаяИнформация.
// Пример:
// ТехническаяИнформация.Вставить("КлиентскийПараметр", "Значение клиентского параметра");
// ВыполнитьОбработкуОповещения(ОповещениеОЗавершении, ТехническаяИнформация);
//
Процедура ПередФормированиемФайлаДляТехподдержки(ТехническаяИнформация, ОповещениеОЗавершении) Экспорт
	
	// ОбменСКонтрагентами начало
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("ЭлектронноеВзаимодействие.ОбменСКонтрагентами") Тогда
		МодульПодсистемы = ОбщегоНазначенияКлиент.ОбщийМодуль("ОбменСКонтрагентамиСлужебныйКлиент");
		МодульПодсистемы.ПередФормированиемФайлаДляТехподдержки(ТехническаяИнформация, ОповещениеОЗавершении);
	КонецЕсли;
	// ОбменСКонтрагентами конец
	
КонецПроцедуры

// Вызывается при формировании параметров обращения в техподдержку, параметры подставляются
// в форму обращения в техподдержку.
//
// Параметры:
//  ПараметрыОбращения - Структура - с ключами:
//    * ТекстОбращения - Строка - текст обращения в техподдержку.
//    * ТелефонСлужбыПоддержки - Строка - телефон службы техподдержки.
//    * АдресЭлектроннойПочтыСлужбыПоддержки - Строка - адрес электронной почты службы техподдержки.
//
// Пример:
// ТекстОбращения = НСтр("ru = 'Требуется повторное получение пакетов с идентификаторами:'");
// ТелефонСлужбыПоддержки = НСтр("ru = '123-45-67'");
//
Процедура ПриОпределенииПараметровОбращенияВТехподдержку(ПараметрыОбращения, КонтекстОперации) Экспорт
	
	// ОбменСКонтрагентами начало
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("ЭлектронноеВзаимодействие.ОбменСКонтрагентами") Тогда
		МодульПодсистемы = ОбщегоНазначенияКлиент.ОбщийМодуль("ОбменСКонтрагентамиСлужебныйКлиент");
		МодульПодсистемы.ПриОпределенииПараметровОбращенияВТехподдержку(ПараметрыОбращения, КонтекстОперации);
	КонецЕсли;
	// ОбменСКонтрагентами конец
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Получение ссылок объектов из формы
//
// Параметры:
//  Источник - ТаблицаФормы, Объект - данные формы.
//
// Возвращаемое значение:
//  Массив - ссылки на объекты.
//
Функция ОбъектыОснований(Источник)
	
	Результат = Новый Массив;
	
	Если ТипЗнч(Источник) = Тип("ТаблицаФормы") Тогда
		ВыделенныеСтроки = Источник.ВыделенныеСтроки;
		Для Каждого ВыделеннаяСтрока Из ВыделенныеСтроки Цикл
			Если ТипЗнч(ВыделеннаяСтрока) = Тип("СтрокаГруппировкиДинамическогоСписка") Тогда
				Продолжить;
			КонецЕсли;
			ТекущаяСтрока = Источник.ДанныеСтроки(ВыделеннаяСтрока);
			Если ТекущаяСтрока <> Неопределено Тогда
				Результат.Добавить(ТекущаяСтрока.Ссылка);
			КонецЕсли;
		КонецЦикла;
	Иначе
		Результат.Добавить(Источник.Ссылка);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Выполнение команды после подтверждения записи
//
// Параметры:
//  РезультатВопроса - КодВозвратаДиалога - результат вопроса.
//  ДополнительныеПараметры - Структура - параметры выполняемой команды.
//
Процедура ВыполнитьПодключаемуюКомандуЭДОПодтверждениеЗаписи(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	ОписаниеКоманды = ДополнительныеПараметры.ОписаниеКоманды;
	Форма = ДополнительныеПараметры.Форма;
	Источник = ДополнительныеПараметры.Источник;
	
	Если РезультатВопроса = КодВозвратаДиалога.ОК Тогда
		Форма.Записать();
		Если Источник.Ссылка.Пустая() Или Форма.Модифицированность Тогда
			Возврат; // Запись не удалась, сообщения о причинах выводит платформа.
		КонецЕсли;
		Если Не ПустаяСтрока(ОписаниеКоманды.Обработчик) 
			И СтрНачинаетсяС(ОписаниеКоманды.Обработчик, "ОбменСБанками") Тогда 
			
			Оповестить("ОбновитьСостояниеОбменСБанками");
		Иначе
			
			
			ДокументыУчета = Новый Массив;
			ДокументыУчета.Добавить(Источник.Ссылка);
			
			ПараметрыОповещения = Новый Структура;
			ПараметрыОповещения.Вставить("ДокументыУчета", ДокументыУчета);
			
			Оповестить("ОбновитьСостояниеЭД", ПараметрыОповещения);
			
		КонецЕсли;
		
	ИначеЕсли РезультатВопроса = КодВозвратаДиалога.Отмена Тогда
		Возврат;
	КонецЕсли;
	
	ОбъектыОснований = ДополнительныеПараметры.Источник;
	Если ТипЗнч(ОбъектыОснований) <> Тип("Массив") Тогда
		ОбъектыОснований = ОбъектыОснований(ОбъектыОснований);
	КонецЕсли;
	
	ДополнительныеПараметры.Вставить("ОбъектыОснований", ОбъектыОснований);
	
	ОписаниеКоманды = ДополнительныеПараметры.ОписаниеКоманды;
	Форма = ДополнительныеПараметры.Форма;
	ОбъектыОснований = ДополнительныеПараметры.ОбъектыОснований;
	
	ОписаниеКоманды = ОбщегоНазначенияКлиент.СкопироватьРекурсивно(ОписаниеКоманды, Ложь);
	
	Если ОписаниеКоманды.РежимИспользованияПараметра = РежимИспользованияПараметраКоманды.Множественный Тогда
		ПараметрКоманды = ОбъектыОснований;
		ОписаниеКоманды.Вставить("ПараметрКоманды", ОбъектыОснований);
	Иначе
		Если ОбъектыОснований.Количество() Тогда
			ПараметрКоманды = ОбъектыОснований[0];
		Иначе
			ПараметрКоманды = Неопределено;
		КонецЕсли;
		ОписаниеКоманды.Вставить("ПараметрКоманды", ПараметрКоманды);
	КонецЕсли;
	
	Если ПустаяСтрока(ОписаниеКоманды.Обработчик) Тогда
		Возврат;
	КонецЕсли;
	
	ОписаниеКоманды.Вставить("Источник", Форма);
	ОписаниеКоманды.Вставить("Уникальность", Ложь);
	
	МассивИмениОбработчика = СтрРазделить(ОписаниеКоманды.Обработчик, ".");
	МодульОбработки = ОбщегоНазначенияКлиент.ОбщийМодуль(МассивИмениОбработчика[0]);
	Обработчик = Новый ОписаниеОповещения(МассивИмениОбработчика[1], МодульОбработки, ОписаниеКоманды);
	ВыполнитьОбработкуОповещения(Обработчик, ПараметрКоманды);
	
КонецПроцедуры

#Область Криптография

#Область ДобавлениеСертификатаКриптографии

Процедура ЗавершитьДобавлениеСертификатаКриптографии(Знач Контекст)
	
	СсылкаНаСертификат = ЗаписатьСертификатКриптографииВСправочник(
		Контекст.ДвоичныеДанныеСертификата, Контекст.ПараметрыЗаполнения);
	
	ВыполнитьОбработкуОповещения(Контекст.ОбработкаЗавершения, СсылкаНаСертификат);
	
КонецПроцедуры

Процедура НачатьДобавлениеСертификатаКриптографии_ВыгрузкаСертификата(Знач ДвоичныеДанныеСертификата, Знач Контекст) Экспорт
	
	Контекст.Вставить("ДвоичныеДанныеСертификата", ДвоичныеДанныеСертификата);
	
	ЗавершитьДобавлениеСертификатаКриптографии(Контекст);
	
КонецПроцедуры

Функция ЗаписатьСертификатКриптографииВСправочник(Знач ДвоичныеДанныеСертификата, Знач ПараметрыЗаполнения)
	
	Возврат ЭлектронноеВзаимодействиеСлужебныйВызовСервера.НайтиСоздатьСертификатЭП(
		ДвоичныеДанныеСертификата, ПараметрыЗаполнения.Организация, ПараметрыЗаполнения.Программа);
	
КонецФункции

#КонецОбласти

#Область ОпределениеПрограммыСертификатаКриптографии

Процедура ЗавершитьОпределениеПрограммыСертификатаКриптографии(Знач ПроцессВыполнения)
	
	ВыполнитьОбработкуОповещения(ПроцессВыполнения.ОбработкаЗавершения, ПроцессВыполнения.Программа);
	
КонецПроцедуры

Функция НовыйПроцессОпределенияПрограммыСертификатаКриптографии(Знач Сертификат, Знач ОбработкаЗавершения, Знач Пароль)
	
	Процесс = Новый Структура;
	Процесс.Вставить("Сертификат", Сертификат);
	Процесс.Вставить("ОбработкаЗавершения", ОбработкаЗавершения);
	Процесс.Вставить("ТекущийЭтап");
	
	Процесс.Вставить("УстановленныеПрограммы");
	Процесс.Вставить("НаборПрограмм");
	
	Процесс.Вставить("СвойстваПароля");
	Процесс.Вставить("Пароль", Пароль);
	
	Процесс.Вставить("ПрограммаДляПроверки");
	Процесс.Вставить("РезультатПроверкиПрограммы", Ложь);
	Процесс.Вставить("ПроверенныеПрограммы", Новый Массив);
	Процесс.Вставить("Программа");
	
	Возврат Процесс;
	
КонецФункции

Процедура ВыполнитьОпределениеПрограммыСертификатаКриптографии(Знач РезультатТекущегоЭтапа, Знач ПроцессВыполнения) Экспорт
	
	Если ЗначениеЗаполнено(ПроцессВыполнения.ТекущийЭтап) Тогда
		ПроцессВыполнения.Вставить(ПроцессВыполнения.ТекущийЭтап, РезультатТекущегоЭтапа);
	КонецЕсли;
	
	Выполнено = ВыполнитьОпределениеПрограммыСертификатаКриптографии_НайтиУстановленныеПрограммы(ПроцессВыполнения);
	Если Не Выполнено Тогда
		Возврат;
	КонецЕсли;
	
	Выполнено = ВыполнитьОпределениеПрограммыСертификатаКриптографии_ВводПароля(ПроцессВыполнения);
	Если Не Выполнено Тогда
		Возврат;
	КонецЕсли;
	
	Выполнено = ВыполнитьОпределениеПрограммыСертификатаКриптографии_ПроверитьПрограммы(ПроцессВыполнения);
	Если Не Выполнено Тогда
		Возврат;
	КонецЕсли;
	
	ЗавершитьОпределениеПрограммыСертификатаКриптографии(ПроцессВыполнения);
	
КонецПроцедуры

Функция ВыполнитьОпределениеПрограммыСертификатаКриптографии_НайтиУстановленныеПрограммы(ПроцессВыполнения)
	
	Выполнено = Ложь;
	
	УстановленныеПрограммы = ПроцессВыполнения.УстановленныеПрограммы;
	НаборПрограмм = ПроцессВыполнения.НаборПрограмм;
	
	Если ЗначениеЗаполнено(УстановленныеПрограммы) Тогда
		Если Не ЗначениеЗаполнено(НаборПрограмм) Тогда
			ПроцессВыполнения.НаборПрограмм = ЭлектронноеВзаимодействиеСлужебныйВызовСервера.НайтиСсылкиНаПрограммыКриптографии(УстановленныеПрограммы);
		КонецЕсли;
		Выполнено = Истина;
	ИначеЕсли ТипЗнч(УстановленныеПрограммы) = Тип("Массив") Тогда // ничего не нашли (пустой массив)
		ЗавершитьОпределениеПрограммыСертификатаКриптографии(ПроцессВыполнения);
	Иначе
		ПроцессВыполнения.Вставить("ТекущийЭтап", "УстановленныеПрограммы");
		ОбработкаПродолжения = Новый ОписаниеОповещения("ВыполнитьОпределениеПрограммыСертификатаКриптографии", ЭтотОбъект, ПроцессВыполнения);
		ОписаниеПрограмм = ЭлектронноеВзаимодействиеСлужебныйВызовСервера.ОписаниеПрограммКриптографии();
		ЭлектроннаяПодписьКлиент.НайтиУстановленныеПрограммы(ОбработкаПродолжения, ОписаниеПрограмм, Ложь);
	КонецЕсли;
	
	Возврат Выполнено;
	
КонецФункции

Функция ВыполнитьОпределениеПрограммыСертификатаКриптографии_ВводПароля(ПроцессВыполнения)
	
	Выполнено = Ложь;
	
	СвойстваПароля = ПроцессВыполнения.СвойстваПароля;
	Если ТипЗнч(СвойстваПароля) = Тип("Структура") Тогда
		ПроцессВыполнения.Пароль = СвойстваПароля.Пароль;
	КонецЕсли;
	
	Если ПроцессВыполнения.Пароль = Неопределено Тогда
		ПроцессВыполнения.Вставить("ТекущийЭтап", "СвойстваПароля");
		ОбработкаПродолжения = Новый ОписаниеОповещения("ВыполнитьОпределениеПрограммыСертификатаКриптографии", ЭтотОбъект, ПроцессВыполнения);
		ПараметрыВвода = Новый Структура;
		ПараметрыВвода.Вставить("Заголовок", НСтр("ru = 'Проверка сертификата криптографии'"));
		ПараметрыВвода.Вставить("Подсказка", НСтр("ru = 'Введите пароль закрытого ключа сертификата:'"));
		ПоказатьВводПароля(ПараметрыВвода, ОбработкаПродолжения);
	Иначе
		Выполнено = Истина;
	КонецЕсли;
	
	Возврат Выполнено;
	
КонецФункции

Функция ВыполнитьОпределениеПрограммыСертификатаКриптографии_ПроверитьПрограммы(ПроцессВыполнения)
	
	ПрограммаДляПроверки = ПроцессВыполнения.ПрограммаДляПроверки;
	РезультатПроверки = ПроцессВыполнения.РезультатПроверкиПрограммы;
	
	Если ЗначениеЗаполнено(ПрограммаДляПроверки) Тогда
		ПроцессВыполнения.ПроверенныеПрограммы.Добавить(ПрограммаДляПроверки);
		Если РезультатПроверки Тогда
			ПроцессВыполнения.Программа = ПрограммаДляПроверки;
			Возврат Истина;
		КонецЕсли;
	КонецЕсли;
	
	НаборПрограмм = ПроцессВыполнения.НаборПрограмм;
	
	Для каждого Программа Из НаборПрограмм Цикл
		Если ПроцессВыполнения.ПроверенныеПрограммы.Найти(Программа) <> Неопределено Тогда
			Продолжить;
		КонецЕсли;
		ПроцессВыполнения.Вставить("ТекущийЭтап", "РезультатПроверкиПрограммы");
		ПроцессВыполнения.Вставить("ПрограммаДляПроверки", Программа);
		ОбработкаПродолжения = Новый ОписаниеОповещения("ВыполнитьОпределениеПрограммыСертификатаКриптографии", ЭтотОбъект, ПроцессВыполнения);
		НачатьПроверкуСертификатаКриптографииПрограммой(
			ПроцессВыполнения.Сертификат, ПроцессВыполнения.ПрограммаДляПроверки, ПроцессВыполнения.Пароль, ОбработкаПродолжения);
		Возврат Ложь;
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

Процедура НачатьПроверкуСертификатаКриптографииПрограммой(Знач Сертификат, Знач Программа, Знач Пароль, Знач ОбработкаЗавершения)
	
	Контекст = Новый Структура;
	Контекст.Вставить("Сертификат", Сертификат);
	Контекст.Вставить("Программа", Программа);
	Контекст.Вставить("Пароль", Пароль);
	Контекст.Вставить("ОбработкаЗавершения", ОбработкаЗавершения);
	
	ОбработкаПродолжения = Новый ОписаниеОповещения("НачатьПроверкуСертификатаКриптографииПрограммой_ВыгрузкаСертификата", ЭтотОбъект, Контекст);
	Сертификат.НачатьВыгрузку(ОбработкаПродолжения);
	
КонецПроцедуры

Процедура НачатьПроверкуСертификатаКриптографииПрограммой_ВыгрузкаСертификата(Знач ДвоичныеДанныеСертификата, Знач Контекст) Экспорт
	
	Контекст.Вставить("ДвоичныеДанныеСертификата", ДвоичныеДанныеСертификата);
	
	ОбработкаПродолжения = Новый ОписаниеОповещения("НачатьПроверкуСертификатаКриптографииПрограммой_СозданиеМенеджераКриптографии", ЭтотОбъект, Контекст);
	ЭлектроннаяПодписьКлиент.СоздатьМенеджерКриптографии(ОбработкаПродолжения, "Подписание", Истина, Контекст.Программа);
	
КонецПроцедуры

Процедура НачатьПроверкуСертификатаКриптографииПрограммой_СозданиеМенеджераКриптографии(Знач Менеджер, Знач Контекст) Экспорт
	
	Если ТипЗнч(Менеджер) <> Тип("МенеджерКриптографии") Тогда
		ВыполнитьОбработкуОповещения(Контекст.ОбработкаЗавершения, Ложь);
		Возврат;
	КонецЕсли;
	
	Менеджер.ПарольДоступаКЗакрытомуКлючу = Контекст.Пароль;
	
	ОбработкаПродолжения = Новый ОписаниеОповещения("НачатьПроверкуСертификатаКриптографииПрограммой_ПроверкаПодписания", ЭтотОбъект, Контекст,
		"НачатьПроверкуСертификатаКриптографииПрограммой_ПроверкаПодписанияОшибка", ЭтотОбъект);
	
	Менеджер.НачатьПодписывание(ОбработкаПродолжения, Контекст.ДвоичныеДанныеСертификата, Контекст.Сертификат);
	
КонецПроцедуры

Процедура НачатьПроверкуСертификатаКриптографииПрограммой_ПроверкаПодписания(Знач ДанныеПодписи, Знач Контекст) Экспорт
	
	Подписано = Истина;
	
	Попытка
		Подписано = ЗначениеЗаполнено(ДанныеПодписи);
	Исключение
		Подписано = Ложь;
	КонецПопытки;
	
	ВыполнитьОбработкуОповещения(Контекст.ОбработкаЗавершения, Подписано);
	
КонецПроцедуры

Процедура НачатьПроверкуСертификатаКриптографииПрограммой_ПроверкаПодписанияОшибка(ИнформацияОбОшибке, СтандартнаяОбработка, Контекст) Экспорт
	
	СтандартнаяОбработка = Ложь;
	ВыполнитьОбработкуОповещения(Контекст.ОбработкаЗавершения, Ложь);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область ВзаимодействиеСПользователем

Процедура ПоказатьВводПароля(Знач ПараметрыВвода, Знач ОбработкаПродолжения)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Заголовок", "");
	ПараметрыФормы.Вставить("Подсказка", "");
	ПараметрыФормы.Вставить("ИспользоватьЗапоминание", Ложь);
	ПараметрыФормы.Вставить("ПодсказкаЗапоминания", "");
	ЗаполнитьЗначенияСвойств(ПараметрыФормы, ПараметрыВвода);
	
	ОткрытьФорму("Обработка.ЭлектронноеВзаимодействие.Форма.ВводПароля", ПараметрыФормы,,,,, ОбработкаПродолжения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

Процедура ВыполнитьПроверкуПроведенияДокументовПродолжить(Знач Результат, Знач ДополнительныеПараметры) Экспорт
	
	ДокументыМассив = Неопределено;
	ОбработкаПродолжения = Неопределено;
	ДокументыТребующиеПроведение = Неопределено;
	Если Результат = КодВозвратаДиалога.Да
		И ТипЗнч(ДополнительныеПараметры) = Тип("Структура")
		И ДополнительныеПараметры.Свойство("ДокументыМассив", ДокументыМассив)
		И ДополнительныеПараметры.Свойство("ОбработкаПродолжения", ОбработкаПродолжения)
		И ДополнительныеПараметры.Свойство("ДокументыТребующиеПроведение", ДокументыТребующиеПроведение) Тогда
		
		ДанныеОНепроведенныхДокументах = ОбщегоНазначенияВызовСервера.ПровестиДокументы(ДокументыТребующиеПроведение);
		
		// Сообщение о документах, которые не провелись.
		ШаблонСообщения = НСтр("ru = 'Документ %1 не проведен: %2 Формирование ЭД невозможно.'");
		НепроведенныеДокументы = Новый Массив;
		Для Каждого ИнформацияОДокументе Из ДанныеОНепроведенныхДокументах Цикл
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
																	ШаблонСообщения,
																	Строка(ИнформацияОДокументе.Ссылка),
																	ИнформацияОДокументе.ОписаниеОшибки);
			ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения, ИнформацияОДокументе.Ссылка);
			НепроведенныеДокументы.Добавить(ИнформацияОДокументе.Ссылка);
		КонецЦикла;
		
		КоличествоНепроведенныхДокументов = НепроведенныеДокументы.Количество();
		
		// Оповещаем открытые формы о том, что были проведены документы.
		ПроведенныеДокументы = ОбщегоНазначенияКлиентСервер.РазностьМассивов(ДокументыТребующиеПроведение,
																			НепроведенныеДокументы);
		ТипыПроведенныхДокументов = Новый Соответствие;
		Для Каждого ПроведенныйДокумент Из ПроведенныеДокументы Цикл
			ТипыПроведенныхДокументов.Вставить(ТипЗнч(ПроведенныйДокумент));
		КонецЦикла;
		Для Каждого Тип Из ТипыПроведенныхДокументов Цикл
			ОповеститьОбИзменении(Тип.Ключ);
		КонецЦикла;
		
		Оповестить("ОбновитьДокументИБПослеЗаполнения", ПроведенныеДокументы);
		
		// Обновляем исходный массив документов.
		ДокументыМассив = ОбщегоНазначенияКлиентСервер.РазностьМассивов(ДокументыМассив, НепроведенныеДокументы);
		ЕстьДокументыГотовыеДляФормированияЭД = ДокументыМассив.Количество() > 0;
		Если КоличествоНепроведенныхДокументов > 0 Тогда
			
			// Спрашиваем пользователя о необходимости продолжения печати при наличии непроведенных документов.
			ТекстВопроса = НСтр("ru = 'Не удалось провести один или несколько документов.'");
			КнопкиДиалога = Новый СписокЗначений;
			
			Если ЕстьДокументыГотовыеДляФормированияЭД Тогда
				ТекстВопроса = ТекстВопроса + " " + НСтр("ru = 'Продолжить?'");
				КнопкиДиалога.Добавить(КодВозвратаДиалога.Пропустить, НСтр("ru = 'Продолжить'"));
				КнопкиДиалога.Добавить(КодВозвратаДиалога.Отмена);
			Иначе
				КнопкиДиалога.Добавить(КодВозвратаДиалога.ОК);
			КонецЕсли;
			ДопПараметры = Новый Структура("ОбработкаПродолжения, ДокументыМассив", ОбработкаПродолжения, ДокументыМассив);
			Обработчик = Новый ОписаниеОповещения("ВыполнитьПроверкуПроведенияДокументовЗавершить", ЭтотОбъект, ДопПараметры);
			ПоказатьВопрос(Обработчик, ТекстВопроса, КнопкиДиалога);
		Иначе
			ВыполнитьОбработкуОповещения(ОбработкаПродолжения, ДокументыМассив);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ВыполнитьПроверкуПроведенияДокументовЗавершить(Знач Результат, Знач ДополнительныеПараметры) Экспорт
	
	ДокументыМассив = Неопределено;
	
	ОбработкаПродолжения = Неопределено;
	Если Результат = КодВозвратаДиалога.Пропустить
		И ТипЗнч(ДополнительныеПараметры) = Тип("Структура")
		И ДополнительныеПараметры.Свойство("ДокументыМассив", ДокументыМассив)
		И ДополнительныеПараметры.Свойство("ОбработкаПродолжения", ОбработкаПродолжения) Тогда
		
		ВыполнитьОбработкуОповещения(ОбработкаПродолжения, ДокументыМассив);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

