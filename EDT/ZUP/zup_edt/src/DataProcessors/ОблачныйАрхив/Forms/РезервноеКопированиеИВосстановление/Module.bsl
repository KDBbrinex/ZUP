///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОписаниеПеременных

&НаКлиенте
Перем ОбновитьИнтерфейс;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	// Значения реквизитов формы
	РежимРаботыСтруктура = Новый Структура();
	РежимРаботыСтруктура.Вставить("Локальный", ((Не ОбщегоНазначения.ЭтоАвтономноеРабочееМесто()) И (Не ОбщегоНазначения.РазделениеВключено())));
	РежимРаботыСтруктура.Вставить("Автономный", ОбщегоНазначения.ЭтоАвтономноеРабочееМесто());
	РежимРаботыСтруктура.Вставить("ЭтоАдминистраторСистемы", Пользователи.ЭтоПолноправныйПользователь(, Истина));
	РежимРаботыСтруктура.Вставить("ЭтоВебКлиент", ОбщегоНазначения.ЭтоВебКлиент());
	РежимРаботыСтруктура.Вставить("ЭтоWindowsКлиент", ОбщегоНазначения.ЭтоWindowsКлиент());
	ЭтотОбъект.РежимРаботы = Новый ФиксированнаяСтруктура(РежимРаботыСтруктура);

	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РезервноеКопированиеИБ") Тогда
		Элементы.ГруппаРезервноеКопированиеИВосстановление.Видимость = ((ЭтотОбъект.РежимРаботы.Локальный
			Или ЭтотОбъект.РежимРаботы.Автономный) И ЭтотОбъект.РежимРаботы.ЭтоАдминистраторСистемы
			И Не ЭтотОбъект.РежимРаботы.ЭтоВебКлиент И ЭтотОбъект.РежимРаботы.ЭтоWindowsКлиент);
		ОбновитьНастройкиРезервногоКопирования();
	Иначе
		Элементы.ГруппаРезервноеКопированиеИВосстановление.Видимость = Ложь;
	КонецЕсли;

	ОблачныйАрхив.ПанельАдминистрированияБСП_ПриСозданииНаСервере(ЭтотОбъект);

	// Обновление состояния элементов.
	УстановитьДоступность();

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ОблачныйАрхивКлиент.ПанельАдминистрированияБСП_ПриОткрытии(ЭтотОбъект);

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)

	Если ИмяСобытия = "ЗакрытаФормаНастройкиРезервногоКопирования"
			И ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.РезервноеКопированиеИБ") Тогда
		ОбновитьНастройкиРезервногоКопирования();
	КонецЕсли;

	ОблачныйАрхивКлиент.ПанельАдминистрированияБСП_ОбработкаОповещения(ЭтотОбъект, ИмяСобытия, Параметр, Источник);

КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)

	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;

	ОбновитьИнтерфейсПрограммы();

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

#Область ИнтернетПоддержкаПользователей_ОблачныйАрхив

&НаКлиенте
Процедура ОблачныйАрхивОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)

	СтандартнаяОбработка = Истина;

	ОблачныйАрхивКлиент.ОбработкаНавигационнойСсылки(
		ЭтотОбъект, Элемент, НавигационнаяСсылкаФорматированнойСтроки,
		СтандартнаяОбработка, Новый Структура);

КонецПроцедуры

&НаКлиенте
Процедура СпособРезервногоКопированияПриИзменении(Элемент)

	// В зависимости от состояния, вывести правильную страницу.
	ОблачныйАрхивКлиент.ПанельАдминистрированияБСП_СпособРезервногоКопированияПриИзменении(ЭтотОбъект);

КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область ОбработчикиКомандФормы

#Область ИнтернетПоддержкаПользователей_ОблачныйАрхив

&НаКлиенте
Процедура ПодключитьСервисОблачныйАрхив(Команда)

	ОблачныйАрхивКлиент.ПодключитьСервисОблачныйАрхив();

КонецПроцедуры

&НаКлиенте
Процедура ОблачныйАрхивВосстановлениеИзРезервнойКопииНажатие(Элемент)

	ОблачныйАрхивКлиент.ВосстановлениеИзРезервнойКопии();

КонецПроцедуры

&НаКлиенте
Процедура ОблачныйАрхивНастройкаРезервногоКопированияНажатие(Элемент)

	ОблачныйАрхивКлиент.НастройкаРезервногоКопирования();

КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

////////////////////////////////////////////////////////////////////////////////
// Клиент

//@skip-warning
&НаКлиенте
Процедура Подключаемый_ПриИзмененииРеквизита(Элемент, НеобходимоОбновлятьИнтерфейс = Истина)

	КонстантаИмя = ПриИзмененииРеквизитаСервер(Элемент.Имя);

	ОбновитьПовторноИспользуемыеЗначения();

	Если НеобходимоОбновлятьИнтерфейс Тогда
		ОбновитьИнтерфейс = Истина;
		ПодключитьОбработчикОжидания("ОбновитьИнтерфейсПрограммы", 2, Истина);
	КонецЕсли;

	Если КонстантаИмя <> "" Тогда
		Оповестить("Запись_НаборКонстант", Новый Структура, КонстантаИмя);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИнтерфейсПрограммы()

	Если ОбновитьИнтерфейс = Истина Тогда
		ОбновитьИнтерфейс = Ложь;
		ОбщегоНазначенияКлиент.ОбновитьИнтерфейсПрограммы();
	КонецЕсли;

КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Вызов сервера

&НаСервере
Функция ПриИзмененииРеквизитаСервер(ИмяЭлемента)

	РеквизитПутьКДанным = Элементы[ИмяЭлемента].ПутьКДанным;

	КонстантаИмя = СохранитьЗначениеРеквизита(РеквизитПутьКДанным);

	УстановитьДоступность(РеквизитПутьКДанным);

	ОбновитьПовторноИспользуемыеЗначения();

	Возврат КонстантаИмя;

КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Сервер

&НаСервере
Функция СохранитьЗначениеРеквизита(РеквизитПутьКДанным)

	// Сохранение значений реквизитов, не связанных с константами напрямую.
	Если РеквизитПутьКДанным = "" Тогда
		Возврат "";
	КонецЕсли;

	// Определение имени константы.
	КонстантаИмя = "";
	Если НРег(Лев(РеквизитПутьКДанным, 14)) = НРег("НаборКонстант.") Тогда
		// Если путь к данным реквизита указан через "НаборКонстант".
		КонстантаИмя = Сред(РеквизитПутьКДанным, 15);
	КонецЕсли;

	// Сохранения значения константы.
	Если НРег(Лев(РеквизитПутьКДанным, 14)) = НРег("НаборКонстант.") Тогда
		КонстантаМенеджер = Константы[КонстантаИмя];
		КонстантаЗначение = НаборКонстант[КонстантаИмя];
		Если КонстантаМенеджер.Получить() <> КонстантаЗначение Тогда
			КонстантаМенеджер.Установить(КонстантаЗначение);
		КонецЕсли;
	КонецЕсли;

	Возврат КонстантаИмя;

КонецФункции

&НаСервере
Процедура УстановитьДоступность(РеквизитПутьКДанным = "")

	Если Не РежимРаботы.ЭтоАдминистраторСистемы Тогда
		Возврат;
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ОбновитьНастройкиРезервногоКопирования()

	Если (РежимРаботы.Локальный Или РежимРаботы.Автономный) И РежимРаботы.ЭтоАдминистраторСистемы Тогда
		МодульРезервноеКопированиеИБСервер = ОбщегоНазначения.ОбщийМодуль("РезервноеКопированиеИБСервер");
		Элементы.НастройкаРезервногоКопированияИБ.РасширеннаяПодсказка.Заголовок =
			МодульРезервноеКопированиеИБСервер.ТекущаяНастройкаРезервногоКопирования(); // АПК:278 Обращение к родственной подсистеме.
	КонецЕсли;

КонецПроцедуры

#Область ИнтернетПоддержкаПользователей_ОблачныйАрхив

&НаКлиенте
Процедура Подключаемый_ПроверитьСостояниеОблачногоАрхива()

	#Если НЕ ВебКлиент Тогда

	ТипСтруктура = Тип("Структура");

	ЭтотОбъект.ПараметрыОблачногоАрхива.ТекущийСчетчикПроверкиФоновогоЗадания = ЭтотОбъект.ПараметрыОблачногоАрхива.ТекущийСчетчикПроверкиФоновогоЗадания + 1;
	Если ЭтотОбъект.ПараметрыОблачногоАрхива.ТекущийСчетчикПроверкиФоновогоЗадания > 12 Тогда // Прошла 2 минуты - прервать
		// Завершить фоновое задание и отключить обработчики ожидания
		ЗавершитьФоновоеЗаданиеОблачногоАрхиваНаСервере(ЭтотОбъект.ПараметрыОблачногоАрхива.ИдентификаторФоновогоЗадания);
		ОтключитьОбработчикОжидания("Подключаемый_ПроверитьСостояниеОблачногоАрхива");
		ТекстСообщения = НСтр("ru='Произошли ошибки при подключении к подсистеме Облачный архив:
			|Сбор данных превысил допустимое время.'");
		ЭтотОбъект.ПараметрыОблачногоАрхива.Вставить("ОшибкиПодключения", ТекстСообщения);
		Элементы.ДекорацияОблачныйАрхивОшибки.Заголовок = ЭтотОбъект.ПараметрыОблачногоАрхива.ОшибкиПодключения;
		Элементы.СтраницыСостоянийОблачныйАрхив.ТекущаяСтраница = Элементы.СтраницаОблачныйАрхивОшибки;
	Иначе
		Если ЭтотОбъект.ПараметрыОблачногоАрхива.ИдентификаторФоновогоЗадания <> Неопределено Тогда
			Прогресс = ПроверитьСостояниеОблачногоАрхиваНаСервере(ЭтотОбъект.ПараметрыОблачногоАрхива.ИдентификаторФоновогоЗадания);
			// Ключи переменной Прогресс:
			//  * Процент;
			//  * Текст;
			//  * ДополнительныеПараметры - Структура с ключами:
			//    ** КодСостояния       - Число (код ошибки) или Строка ("Завершено без ошибок", "Завершено с ошибками");
			//    ** ОписаниеРезультата - Неопределено (если "Завершено без ошибок") или текст ошибки;
			Если ТипЗнч(Прогресс) = ТипСтруктура Тогда
				Если Прогресс.Свойство("Процент") И Прогресс.Свойство("Текст") Тогда
					ЭтотОбъект.ПрогрессПроверкиОблачногоАрхива = Прогресс.Процент;
					Элементы.ДекорацияПрогрессПроверкиОблачногоАрхиваОписание.Заголовок = Прогресс.Текст;
				КонецЕсли;
				Если Прогресс.Свойство("ДополнительныеПараметры")
						И (ТипЗнч(Прогресс.ДополнительныеПараметры) = ТипСтруктура) Тогда
					Если Прогресс.ДополнительныеПараметры.Свойство("КодСостояния") Тогда
						Если Прогресс.ДополнительныеПараметры.КодСостояния = "Завершено без ошибок" Тогда // Идентификатор.
							ПараметрыОкруженияСервер    = ОблачныйАрхивВызовСервера.ПолучитьНастройкиОблачногоАрхива("ПараметрыОкруженияСервер");
							ИнформацияОКлиенте          = ОблачныйАрхивВызовСервера.ПолучитьНастройкиОблачногоАрхива("ИнформацияОКлиенте", ИмяКомпьютера());
							АктивацииАгентовКопирования = ОблачныйАрхивВызовСервера.ПолучитьНастройкиОблачногоАрхива("АктивацииАгентовКопирования", ИмяКомпьютера());
							ОблачныйАрхивКлиент.ПанельАдминистрированияБСП_ПереключитьНаПравильнуюСтраницу(
								ЭтотОбъект,
								Новый Структура("ПараметрыОкруженияСервер, ИнформацияОКлиенте, АктивацииАгентовКопирования",
									ПараметрыОкруженияСервер,
									ИнформацияОКлиенте,
									АктивацииАгентовКопирования));
						ИначеЕсли Прогресс.ДополнительныеПараметры.КодСостояния = "Завершено с ошибками" Тогда // Идентификатор.
							Элементы.ДекорацияОблачныйАрхивОшибки.Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
								НСтр("ru='Произошли ошибки при подключении к подсистеме Облачный архив:
									|%1'"),
								Прогресс.ДополнительныеПараметры.ОписаниеРезультата);
							Элементы.СтраницыСостоянийОблачныйАрхив.ТекущаяСтраница = Элементы.СтраницаОблачныйАрхивОшибки;
						КонецЕсли;
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
		ПодключитьОбработчикОжидания("Подключаемый_ПроверитьСостояниеОблачногоАрхива", 10, Истина);
	КонецЕсли;

	#КонецЕсли

КонецПроцедуры

&НаСервереБезКонтекста
Функция ПроверитьСостояниеОблачногоАрхиваНаСервере(ИдентификаторФоновогоЗадания)

	Возврат ДлительныеОперации.ПрочитатьПрогресс(ИдентификаторФоновогоЗадания);

КонецФункции

// Завершает фоновое задание по его идентификатору.
//
// Параметры:
//  Нет.
//
&НаСервереБезКонтекста
Процедура ЗавершитьФоновоеЗаданиеОблачногоАрхиваНаСервере(ИдентификаторФоновогоЗадания)

	ФоновоеЗадание = ФоновыеЗадания.НайтиПоУникальномуИдентификатору(ИдентификаторФоновогоЗадания);
	Если ФоновоеЗадание <> Неопределено Тогда
		ФоновоеЗадание.Отменить();
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#КонецОбласти