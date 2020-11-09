///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОписаниеПеременных

&НаКлиенте
Перем ПараметрыПередЗаписью;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.БлокироватьВладельца Тогда
		РежимОткрытияОкна = РежимОткрытияОкнаФормы.БлокироватьОкноВладельца;
	КонецЕсли;
	
	Элементы.ИспользоватьУчетнуюЗапись.ОтображатьЗаголовок = ДоступноПолучениеПисем;
	Элементы.ДляПолучения.Видимость = ДоступноПолучениеПисем;
	
	Если Не ДоступноПолучениеПисем Тогда
		Элементы.ДляОтправки.Заголовок = НСтр("ru = 'Использовать для отправки писем'");
	КонецЕсли;
	
	Если Объект.Ссылка.Пустая() Тогда
		Объект.ИспользоватьДляОтправки = Истина;
		Объект.ИспользоватьДляПолучения = ДоступноПолучениеПисем;
		ЗаполнитьНастройки();
	КонецЕсли;
	
	Элементы.ГруппаДляКогоУчетнаяЗапись.Доступность = Пользователи.ЭтоПолноправныйПользователь();
	
	РеквизитыТребующиеВводаПароляДляИзменения = Справочники.УчетныеЗаписиЭлектроннойПочты.РеквизитыТребующиеВводаПароляДляИзменения();
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Если ПарольИзменен Тогда
		УстановитьПривилегированныйРежим(Истина);
		ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(ТекущийОбъект.Ссылка, Пароль);
		ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(ТекущийОбъект.Ссылка, Пароль, "ПарольSMTP");
		УстановитьПривилегированныйРежим(Ложь);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	Если ВидУчетнойЗаписи = "Персональная" И Не ЗначениеЗаполнено(Объект.ВладелецУчетнойЗаписи) Тогда 
		Отказ = Истина;
		ТекстСообщения = НСтр("ru = 'Не выбран владелец учетной записи.'");
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, , "Объект.ВладелецУчетнойЗаписи");
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	ТекущийОбъект.ПользовательSMTP = ?(ТребуетсяАвторизацияПриОтправкеПисем И Не Объект.ТребуетсяВходНаСерверПередОтправкой, ТекущийОбъект.Пользователь, "");
	ТекущийОбъект.ТребуетсяВходНаСерверПередОтправкой = ТекущийОбъект.ТребуетсяВходНаСерверПередОтправкой И ТребуетсяАвторизацияПриОтправкеПисем;
	ТекущийОбъект.ДополнительныеСвойства.Вставить("Пароль", ПроверкаПароля);
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	ОписаниеОповещения = Новый ОписаниеОповещения("ПередЗакрытиемПодтверждениеПолучено", ЭтотОбъект);
	ОбщегоНазначенияКлиент.ПоказатьПодтверждениеЗакрытияФормы(ОписаниеОповещения, Отказ, ЗавершениеРаботы);
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	ЗаполнитьРеквизитыОбъекта();
	
	Если Не ПроверкиПередЗаписьюВыполнены(ПараметрыЗаписи) Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("Запись_УчетнаяЗаписьЭлектроннойПочты",,Объект.Ссылка);
	
	Если ПараметрыЗаписи.Свойство("ЗаписатьИЗакрыть") Тогда
		Закрыть();
	КонецЕсли;
	
	ВладелецУчетнойЗаписи = Объект.ВладелецУчетнойЗаписи;
	
	Если ПараметрыЗаписи.Свойство("ПроверитьНастройки") Тогда
		ПодключитьОбработчикОжидания("ВыполнитьПроверкуНастроек", 0.1, Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	УстановитьВидНастройкиХраненияПисемНаСервере();
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	ЗаполнитьНастройки();
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПротоколПриИзменении(Элемент)
	
	Если ПустаяСтрока(Объект.ПротоколВходящейПочты) Тогда
		Объект.ПротоколВходящейПочты = "IMAP";
	КонецЕсли;
	
	Если Объект.ПротоколВходящейПочты = "IMAP" Тогда
		Если СтрНачинаетсяС(Объект.СерверВходящейПочты, "pop.") Тогда
			Объект.СерверВходящейПочты = "imap." + Сред(Объект.СерверВходящейПочты, 5);
		КонецЕсли
	Иначе
		Если СтрНачинаетсяС(Объект.СерверВходящейПочты, "imap.") Тогда
			Объект.СерверВходящейПочты = "pop." + Сред(Объект.СерверВходящейПочты, 6);
		КонецЕсли;
	КонецЕсли;
	
	Элементы.СерверВходящейПочты.Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = 'Сервер %1'"), Объект.ПротоколВходящейПочты);
		
	ИспользуетсяПротоколPOP = Объект.ПротоколВходящейПочты = "POP";
	Элементы.ОставлятьПисьмаНаСервере.Видимость = ИспользуетсяПротоколPOP И ДоступноПолучениеПисем;
	
	УстановитьВидГруппыТребуетсяАвторизация(ЭтотОбъект, ИспользуетсяПротоколPOP);
	
	УстановитьПортВходящейПочты();
	УстановитьВидНастройкиХраненияПисемНаСервере();
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьВидГруппыТребуетсяАвторизация(Форма, ИспользуетсяПротоколPOP)
	
	Если ИспользуетсяПротоколPOP Тогда
		Форма.Элементы.ТребуетсяАвторизацияПриОтправкеПисем.Заголовок = НСтр("ru = 'При отправке писем требуется авторизация'");
	Иначе
		Форма.Элементы.ТребуетсяАвторизацияПриОтправкеПисем.Заголовок = НСтр("ru = 'При отправке писем требуется авторизация на сервере исходящей почты (SMTP)'");
	КонецЕсли;

	Форма.Элементы.АвторизацияПриОтправкеПисем.Видимость = ИспользуетсяПротоколPOP;
	
КонецПроцедуры

&НаКлиенте
Процедура СерверВходящейПочтыПриИзменении(Элемент)
	Объект.СерверВходящейПочты = СокрЛП(НРег(Объект.СерверВходящейПочты));
КонецПроцедуры

&НаКлиенте
Процедура СерверИсходящейПочтыПриИзменении(Элемент)
	Объект.СерверИсходящейПочты = СокрЛП(НРег(Объект.СерверИсходящейПочты));
КонецПроцедуры

&НаКлиенте
Процедура АдресЭлектроннойПочтыПриИзменении(Элемент)
	Объект.АдресЭлектроннойПочты = СокрЛП(Объект.АдресЭлектроннойПочты);
КонецПроцедуры

&НаКлиенте
Процедура ОставлятьКопииПисемНаСервереПриИзменении(Элемент)
	УстановитьВидНастройкиХраненияПисемНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура УдалятьПисьмаССервераПриИзменении(Элемент)
	УстановитьВидНастройкиХраненияПисемНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПарольДляПолученияПисемПриИзменении(Элемент)
	ПарольИзменен = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ПарольДляПолученияПисемИзменениеТекстаРедактирования(Элемент, Текст, СтандартнаяОбработка)
	Элементы.ПарольДляПолученияПисем.КнопкаВыбора = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ПарольДляПолученияПисемНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	РаботаСПочтовымиСообщениямиКлиент.ПолеПароляНачалоВыбора(Элемент, Пароль, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ПарольДляОтправкиПисемПриИзменении(Элемент)
	ПарольSMTPИзменен = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ДляКогоУчетнаяЗаписьПриИзменении(Элемент)
	Элементы.ПользовательУчетнойЗаписи.Доступность = ВидУчетнойЗаписи = "Персональная";
	ОповеститьОбИзмененииВладельцаУчетнойЗаписи();
КонецПроцедуры

&НаКлиенте
Процедура ПользовательУчетнойЗаписиПриИзменении(Элемент)
	ОповеститьОбИзмененииВладельцаУчетнойЗаписи();
КонецПроцедуры

&НаКлиенте
Процедура ТребуетсяВходНаСерверПередОтправкойПриИзменении(Элемент)
	Элементы.ПолучениеПисем.Доступность = ДоступноПолучениеПисем Или Объект.ТребуетсяВходНаСерверПередОтправкой;
КонецПроцедуры

&НаКлиенте
Процедура ТребуетсяАвторизацияПриОтправкеПисемПриИзменении(Элемент)
	Элементы.АвторизацияПриОтправкеПисем.Доступность = ТребуетсяАвторизацияПриОтправкеПисем;
	Элементы.АвторизацияПриОтправкеПисем.Видимость = Объект.ПротоколВходящейПочты = "POP";
КонецПроцедуры

&НаКлиенте
Процедура ШифрованиеПриОтправкеПочтыПриИзменении(Элемент)
	Объект.ИспользоватьЗащищенноеСоединениеДляИсходящейПочты = ШифрованиеПриОтправкеПочты = "SSL";
	УстановитьПортИсходящейПочты();
КонецПроцедуры

&НаКлиенте
Процедура ШифрованиеПриПолученииПочтыПриИзменении(Элемент)
	Объект.ИспользоватьЗащищенноеСоединениеДляВходящейПочты = ШифрованиеПриПолученииПочты = "SSL";
	УстановитьПортВходящейПочты();
КонецПроцедуры

&НаКлиенте
Процедура СпособАвторизацииПриОтправкеПочтыПриИзменении(Элемент)
	Объект.ТребуетсяВходНаСерверПередОтправкой = ?(СпособАвторизацииПриОтправкеПочты = "POP", Истина, Ложь);
	УстановитьВидНастройкиХраненияПисемНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура НужнаПомощьНажатие(Элемент)
	
	РаботаСПочтовымиСообщениямиКлиент.ПерейтиКДокументацииПоВводуУчетнойЗаписиЭлектроннойПочты();
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеПриИзменении(Элемент)
	Элементы.ФормаПроверитьНастройки.Доступность = Объект.ИспользоватьДляОтправки Или Объект.ИспользоватьДляПолучения;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	Записать(Новый Структура("ЗаписатьИЗакрыть"));
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьНастройки(Команда)
	ВыполнитьПроверкуНастроек();
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьПомощникНастройки(Команда)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПриЗавершенииНастройки", ЭтотОбъект);
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("Ключ", Объект.Ссылка);
	ПараметрыОткрытия.Вставить("Перенастройка", Истина);
	ОткрытьФорму("Справочник.УчетныеЗаписиЭлектроннойПочты.Форма.ПомощникНастройкиУчетнойЗаписи", 
		ПараметрыОткрытия, , , , , ОписаниеОповещения);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура УстановитьВидНастройкиХраненияПисемНаСервере()
	
	ИспользуетсяПротоколPOP = Объект.ПротоколВходящейПочты = "POP";
	Элементы.ОставлятьПисьмаНаСервере.Видимость = ИспользуетсяПротоколPOP И ДоступноПолучениеПисем;
	Элементы.НастройкаПериодаХраненияПисем.Доступность = Объект.ОставлятьКопииСообщенийНаСервере;
	Элементы.ПериодХраненияСообщенийНаСервере.Доступность = УдалятьПисьмаССервера;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПортВходящейПочты()
	Если Объект.ПротоколВходящейПочты = "IMAP" Тогда
		Если Объект.ПортСервераВходящейПочты = 995 Тогда
			Объект.ПортСервераВходящейПочты = 993;
		КонецЕсли;
	Иначе
		Если Объект.ПортСервераВходящейПочты = 993 Тогда
			Объект.ПортСервераВходящейПочты = 995;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПортИсходящейПочты()
	Если Объект.ИспользоватьЗащищенноеСоединениеДляИсходящейПочты Тогда
		Если Объект.ПортСервераИсходящейПочты = 587 Тогда
			Объект.ПортСервераИсходящейПочты = 465;
		КонецЕсли;
	Иначе
		Если Объект.ПортСервераИсходящейПочты = 465 Тогда
			Объект.ПортСервераИсходящейПочты = 587;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытиемПодтверждениеПолучено(РезультатВопроса, ДополнительныеПараметры) Экспорт
	Записать(Новый Структура("ЗаписатьИЗакрыть"));
КонецПроцедуры

&НаКлиенте
Процедура ОповеститьОбИзмененииВладельцаУчетнойЗаписи()
	Оповестить("ПриИзмененииВидаУчетнойЗаписиЭлектроннойПочты", ВидУчетнойЗаписи = "Персональная", ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьРеквизитыОбъекта()
	
	Если Не УдалятьПисьмаССервера Тогда
		Объект.ПериодХраненияСообщенийНаСервере = 0;
	КонецЕсли;
	
	Если Объект.ПротоколВходящейПочты = "IMAP" Тогда
		Объект.ОставлятьКопииСообщенийНаСервере = Истина;
		Объект.ПериодХраненияСообщенийНаСервере = 0;
	КонецЕсли;
	
	Если ВидУчетнойЗаписи = "Общая" И ЗначениеЗаполнено(Объект.ВладелецУчетнойЗаписи) Тогда
		Объект.ВладелецУчетнойЗаписи = Неопределено;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Функция ПроверкиПередЗаписьюВыполнены(ПараметрыЗаписи)
	
	ПараметрыПередЗаписью = ПараметрыЗаписи;
	
	Если Не ПараметрыПередЗаписью.Свойство("ПроверкаЗаполненияВыполнена") Тогда
		ПодключитьОбработчикОжидания("ПроверитьЗаполнениеИЗаписать", 0.1, Истина);
		Возврат Ложь;
	КонецЕсли;
	
	Если Не ПараметрыПередЗаписью.Свойство("РазрешенияПолучены") Тогда
		ПодключитьОбработчикОжидания("ПроверитьРазрешенияИЗаписать", 0.1, Истина);
		Возврат Ложь;
	КонецЕсли;
	
	Если Не ПроверкаПароляВыполнена(ПараметрыПередЗаписью) Тогда
		ПодключитьОбработчикОжидания("ВвестиПарольУчетнойЗаписиИЗаписать", 0.1, Истина);
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

&НаКлиенте
Процедура ПроверитьЗаполнениеИЗаписать()
	
	Если ПроверитьЗаполнение() Тогда
		ПараметрыПередЗаписью.Вставить("ПроверкаЗаполненияВыполнена");
		Записать(ПараметрыПередЗаписью);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьРазрешенияИЗаписать()
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПослеПроверкиРазрешений", ЭтотОбъект, ПараметрыПередЗаписью);
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПрофилиБезопасности") Тогда
		МодульРаботаВБезопасномРежимеКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("РаботаВБезопасномРежимеКлиент");
		МодульРаботаВБезопасномРежимеКлиент.ПрименитьЗапросыНаИспользованиеВнешнихРесурсов(
			ЗапросыНаИспользованиеВнешнихРесурсов(), ЭтотОбъект, ОписаниеОповещения);
	Иначе
		ВыполнитьОбработкуОповещения(ОписаниеОповещения, КодВозвратаДиалога.ОК);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ЗапросыНаИспользованиеВнешнихРесурсов()
	
	Запрос = Неопределено;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ПрофилиБезопасности") Тогда
		МодульРаботаВБезопасномРежиме = ОбщегоНазначения.ОбщийМодуль("РаботаВБезопасномРежиме");
		Запрос = МодульРаботаВБезопасномРежиме.ЗапросНаИспользованиеВнешнихРесурсов(Разрешения(), Объект.Ссылка);
	КонецЕсли;
	
	Возврат ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Запрос);
	
КонецФункции

&НаСервере
Функция Разрешения()
	
	Результат = Новый Массив;
	
	МодульРаботаВБезопасномРежиме = ОбщегоНазначения.ОбщийМодуль("РаботаВБезопасномРежиме");
	
	Если Объект.ИспользоватьДляОтправки Тогда
		Результат.Добавить(
			МодульРаботаВБезопасномРежиме.РазрешениеНаИспользованиеИнтернетРесурса(
				"SMTP",
				Объект.СерверИсходящейПочты,
				Объект.ПортСервераИсходящейПочты,
				НСтр("ru = 'Электронная почта.'")));
	КонецЕсли;
	
	Если Объект.ИспользоватьДляПолучения Тогда
		Результат.Добавить(
			МодульРаботаВБезопасномРежиме.РазрешениеНаИспользованиеИнтернетРесурса(
				Объект.ПротоколВходящейПочты,
				Объект.СерверВходящейПочты,
				Объект.ПортСервераВходящейПочты,
				НСтр("ru = 'Электронная почта.'")));
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура ПослеПроверкиРазрешений(Результат, ПараметрыЗаписи) Экспорт
	
	Если Результат = КодВозвратаДиалога.ОК Тогда
		ПараметрыЗаписи.Вставить("РазрешенияПолучены");
		Записать(ПараметрыПередЗаписью);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция ПроверкаПароляВыполнена(ПараметрыЗаписи)
	
	Если Не ПараметрыЗаписи.Свойство("ПарольВведен") Тогда
		ЗначенияРеквизитовПередЗаписью = Новый Структура(РеквизитыТребующиеВводаПароляДляИзменения);
		ЗаполнитьЗначенияСвойств(ЗначенияРеквизитовПередЗаписью, Объект);
		Возврат Не ТребуетсяПроверкаПароля(Объект.Ссылка, ЗначенияРеквизитовПередЗаписью);
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

&НаСервереБезКонтекста
Функция ТребуетсяПроверкаПароля(Ссылка, ЗначенияРеквизитов)
	Возврат Справочники.УчетныеЗаписиЭлектроннойПочты.ТребуетсяПроверкаПароля(Ссылка, ЗначенияРеквизитов);
КонецФункции

&НаКлиенте
Процедура ВвестиПарольУчетнойЗаписиИЗаписать()
	
	ПроверкаПароля = "";
	ОписаниеОповещения = Новый ОписаниеОповещения("ПослеВводаПароля", ЭтотОбъект, ПараметрыПередЗаписью);
	ОткрытьФорму("Справочник.УчетныеЗаписиЭлектроннойПочты.Форма.ПроверкаДоступаКУчетнойЗаписи", , ЭтотОбъект, , , , ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВводаПароля(Пароль, ПараметрыЗаписи) Экспорт
	
	Если ТипЗнч(Пароль) = Тип("Строка") Тогда
		ПроверкаПароля = Пароль;
		ПараметрыЗаписи.Вставить("ПарольВведен");
		Записать(ПараметрыЗаписи);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьПроверкуНастроек()
	Если Модифицированность Тогда
		Записать(Новый Структура("ПроверитьНастройки"));
	Иначе
		РаботаСПочтовымиСообщениямиКлиент.ПроверитьНастройкиУчетнойЗаписи(Объект.Ссылка);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриЗавершенииНастройки(Результат, ДополнительныеПараметры) Экспорт
	
	Прочитать();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНастройки()
	
	Перем ИспользуетсяПротоколPOP, Пароли, ЭтоПерсональнаяУчетнаяЗапись;
	
	ДоступноПолучениеПисем = РаботаСПочтовымиСообщениямиСлужебный.НастройкиПодсистемы().ДоступноПолучениеПисем;
	Элементы.ОставлятьПисьмаНаСервере.Видимость = Объект.ПротоколВходящейПочты = "POP" И ДоступноПолучениеПисем;
	
	Элементы.СерверВходящейПочты.Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
	НСтр("ru = 'Сервер %1'"), Объект.ПротоколВходящейПочты);
	
	УдалятьПисьмаССервера = Объект.ПериодХраненияСообщенийНаСервере > 0;
	Если Не УдалятьПисьмаССервера Тогда
		Объект.ПериодХраненияСообщенийНаСервере = 10;
	КонецЕсли;
	
	Если НЕ Объект.Ссылка.Пустая() Тогда
		УстановитьПривилегированныйРежим(Истина);
		Пароли = ОбщегоНазначения.ПрочитатьДанныеИзБезопасногоХранилища(Объект.Ссылка, "Пароль, ПарольSMTP");
		УстановитьПривилегированныйРежим(Ложь);
		Пароль = ?(ЗначениеЗаполнено(Пароли.Пароль), ЭтотОбъект.УникальныйИдентификатор, "");
		ПарольSMTP = ?(ЗначениеЗаполнено(Пароли.ПарольSMTP), ЭтотОбъект.УникальныйИдентификатор, "");
		
		Если Не Справочники.УчетныеЗаписиЭлектроннойПочты.ИзменениеРазрешено(Объект.Ссылка) Тогда
			ТолькоПросмотр = Истина;
		КонецЕсли;
	КонецЕсли;
	
	Элементы.ФормаЗаписатьИЗакрыть.Доступность = Не ТолькоПросмотр;
	
	ЭтоПерсональнаяУчетнаяЗапись = ЗначениеЗаполнено(Объект.ВладелецУчетнойЗаписи);
	Элементы.ПользовательУчетнойЗаписи.Доступность = ЭтоПерсональнаяУчетнаяЗапись;
	ВидУчетнойЗаписи = ?(ЭтоПерсональнаяУчетнаяЗапись, "Персональная", "Общая");
	ВладелецУчетнойЗаписи = Объект.ВладелецУчетнойЗаписи;
	
	ИспользуетсяПротоколPOP = Объект.ПротоколВходящейПочты = "POP";
	ТребуетсяАвторизацияПриОтправкеПисем = ЗначениеЗаполнено(Объект.ПользовательSMTP) Или Объект.ТребуетсяВходНаСерверПередОтправкой;
	Элементы.АвторизацияПриОтправкеПисем.Доступность = ТребуетсяАвторизацияПриОтправкеПисем;
	УстановитьВидГруппыТребуетсяАвторизация(ЭтотОбъект, ИспользуетсяПротоколPOP);
	
	ШифрованиеПриОтправкеПочты = ?(Объект.ИспользоватьЗащищенноеСоединениеДляИсходящейПочты, "SSL", "Авто");
	ШифрованиеПриПолученииПочты = ?(Объект.ИспользоватьЗащищенноеСоединениеДляВходящейПочты, "SSL", "Авто");
	
	СпособАвторизацииПриОтправкеПочты = ?(Объект.ТребуетсяВходНаСерверПередОтправкой, "POP", "SMTP");
	Элементы.ФормаПроверитьНастройки.Доступность = Объект.ИспользоватьДляОтправки Или Объект.ИспользоватьДляПолучения;
	Элементы.ФормаОткрытьПомощникНастройки.Доступность = Не Объект.Ссылка.Пустая() И Не ТолькоПросмотр;
	
	Элементы.ПарольДляПолученияПисем.КнопкаВыбора = Ложь;
	
КонецПроцедуры

#КонецОбласти
