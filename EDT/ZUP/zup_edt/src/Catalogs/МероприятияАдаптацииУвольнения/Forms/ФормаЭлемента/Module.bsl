
#Область ОписаниеПеременных

&НаКлиенте
Перем ОткрытаФормаВыбораИсполнителя; // Признак того, что исполнитель выбирается из формы, а не быстрым вводом.

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Ключ.Пустая() Тогда
		ПриПолученииДанныхНаСервере();
	КонецЕсли;
	
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	ПриПолученииДанныхНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	Если ЕстьОшибкиЗаполнения() Тогда
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	ЗаписатьОтборыНазначенияСобытий(ТекущийОбъект);
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ЗаписатьОтборыНазначенияМероприятия(ТекущийОбъект.Ссылка);
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	ОбновитьСпискиОтборовНазначения();
	УстановитьЗаголовкиЭлементов();
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("ЗаписьДокумента", Объект.Ссылка);
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// СтандартныеПодсистемы.Свойства
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОписаниеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Оповещение = Новый ОписаниеОповещения("ОписаниеЗавершениеВыбора", ЭтотОбъект);
	ОбщегоНазначенияКлиент.ПоказатьФормуРедактированияМногострочногоТекста(Оповещение, Элемент.ТекстРедактирования, 
		НСтр("ru = 'Описание'"));
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполняетсяПриИзменении(Элемент)
	
	Объект.ВАрхиве = Не Выполняется;
	
	УстановитьДоступностьЭлементов(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ИсполняетсяСотрудникомПриИзменении(Элемент)
	
	Если Объект.ИсполняетсяСотрудником И ЗначениеЗаполнено(Объект.Исполнитель) Тогда
		Объект.Исполнитель = ПредопределенноеЗначение("Справочник.РолиИсполнителей.ПустаяСсылка");
	КонецЕсли;
	
	УстановитьДоступностьПоляИсполнитель(ЭтотОбъект);
	
КонецПроцедуры

#Область Исполнитель

&НаКлиенте
Процедура ИсполнительНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	БизнесПроцессыИЗадачиКлиент.ВыбратьИсполнителя(Элемент, Объект.Исполнитель, Ложь, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ИсполнительПриИзменении(Элемент)
	
	Если ОткрытаФормаВыбораИсполнителя = Истина Тогда
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(Объект.Исполнитель) = Тип("СправочникСсылка.РолиИсполнителей") И ЗначениеЗаполнено(Объект.Исполнитель) Тогда 
		
		Если ИспользуетсяСОбъектамиАдресации(Объект.Исполнитель) Тогда
			
			КонтекстВыбора = "ИсполнительПриИзменении";
			
			ПараметрыФормы = Новый Структура;
			ПараметрыФормы.Вставить("РольИсполнителя", Объект.Исполнитель);
			ПараметрыФормы.Вставить("ОсновнойОбъектАдресации", Неопределено);
			ПараметрыФормы.Вставить("ДополнительныйОбъектАдресации", Неопределено);
			
			ОткрытьФорму("ОбщаяФорма.ВыборРолиИсполнителя", ПараметрыФормы, ЭтотОбъект);
			
			Возврат;
			
		КонецЕсли;
		
	КонецЕсли;
	
	Если Объект.ИсполняетсяСотрудником И ЗначениеЗаполнено(Объект.Исполнитель) Тогда
		Объект.ИсполняетсяСотрудником = Ложь;
	КонецЕсли;
	
	УстановитьДоступностьПоляИсполняетсяСотрудником(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ИсполнительОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	ВыбранаРоль = ТипЗнч(ВыбранноеЗначение) = Тип("Структура");
	
	Если ВыбранаРоль Тогда
		
		СтандартнаяОбработка = Ложь;
		Объект.Исполнитель = ВыбранноеЗначение.РольИсполнителя;
		Объект.ОсновнойОбъектАдресации = ВыбранноеЗначение.ОсновнойОбъектАдресации;
		Объект.ДополнительныйОбъектАдресации = ВыбранноеЗначение.ДополнительныйОбъектАдресации;
		
		Модифицированность = Истина;
		
	Иначе
		
		Объект.ОсновнойОбъектАдресации = Неопределено;
		Объект.ДополнительныйОбъектАдресации = Неопределено;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ИсполнительАвтоПодбор(Элемент, Текст, ДанныеВыбора, Ожидание, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(Текст) Тогда 
		СтандартнаяОбработка = Ложь;
		ДанныеВыбора = БизнесПроцессыИЗадачиВызовСервера.СформироватьДанныеВыбораИсполнителя(Текст);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ИсполнительОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(Текст) Тогда 
		СтандартнаяОбработка = Ложь;
		ДанныеВыбора = БизнесПроцессыИЗадачиВызовСервера.СформироватьДанныеВыбораИсполнителя(Текст);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура ВСрокНачалоПриИзменении(Элемент)
	
	УстановитьЗаголовокПоляДнейНачало(ЭтотОбъект);
	
	Если ДнейНачало = 0 Тогда
		Объект.СдвигСрокаНачалаИсполнения = 1;
	ИначеЕсли ВСрокНачало <> Объект.СдвигСрокаНачалаИсполнения / ДнейНачало Тогда
		Объект.СдвигСрокаНачалаИсполнения = Объект.СдвигСрокаНачалаИсполнения * -1;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДнейНачалоПриИзменении(Элемент)
	
	УстановитьЗаголовокПоляДнейНачало(ЭтотОбъект);
	
	Объект.СдвигСрокаНачалаИсполнения = ВСрокНачало * ДнейНачало;
	
КонецПроцедуры

&НаКлиенте
Процедура ВСрокОкончаниеПриИзменении(Элемент)
	
	УстановитьЗаголовокПоляДнейОкончание(ЭтотОбъект);
	
	Если ДнейОкончание = 0 Тогда
		Объект.СдвигСрокаОкончанияИсполнения = 1;
	ИначеЕсли ВСрокОкончание <> Объект.СдвигСрокаОкончанияИсполнения / ДнейОкончание Тогда
		Объект.СдвигСрокаОкончанияИсполнения = Объект.СдвигСрокаОкончанияИсполнения * -1;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДнейОкончаниеПриИзменении(Элемент)
	
	УстановитьЗаголовокПоляДнейОкончание(ЭтотОбъект);
	
	Объект.СдвигСрокаОкончанияИсполнения = ВСрокОкончание * ДнейОкончание;
	
КонецПроцедуры

&НаКлиенте
Процедура ВидМероприятияПриИзменении(Элемент)
	
	ОбновитьСписокДоступныхСобытий();
	УстановитьЗаголовокКнопкиПодбораСобытий(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ДляОпределенныхСобытийПриИзменении(Элемент)
	
	Если ДляОпределенныхСобытий = 0
		И ОбщегоНазначенияКлиентСервер.ОтмеченныеЭлементы(СписокДоступныхСобытий).Количество() <> 0 Тогда
		
		ТекстВопроса = НСтр("ru = 'Список событий будет очищен. 
								|Продолжить?'");
		
		Оповещение = Новый ОписаниеОповещения("ДляОпределенныхСобытийЗавершениеИзменения", ЭтотОбъект);
		ПоказатьВопрос(Оповещение, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
		
	Иначе
		
		ОбновитьСписокДоступныхСобытий(Ложь);
		УстановитьВидимостьКнопкиПодбораСобытий(ЭтотОбъект);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДляОпределенныхСотрудниковПриИзменении(Элемент)
	
	Если ДляОпределенныхСотрудников = 0
		И (СписокДолжностей.Количество() > 0
		ИЛИ СписокОрганизаций.Количество() > 0
		ИЛИ СписокПодразделений.Количество() > 0
		ИЛИ СписокПозиций.Количество() > 0) Тогда
		
		ТекстВопроса = НСтр("ru = 'Списки назначения будут очищены. 
								|Продолжить?'");
		
		Оповещение = Новый ОписаниеОповещения("ДляОпределенныхСотрудниковЗавершениеИзменения", ЭтотОбъект);
		ПоказатьВопрос(Оповещение, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
		
	Иначе
		
		УстановитьДоступностьГруппыПолейОтборыНазначения(ЭтотОбъект);
		Модифицированность = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ФлажокНазначенияПриИзменении(Элемент)
	
	ИмяФлажка = Элемент.Имя;
	ИмяКоманды = СоответствиеКомандФлажкам.Получить(ИмяФлажка);
	ИмяСписка = СоответствиеСписковКомандам.Получить(ИмяКоманды);
	ИмяКнопки = СоответствиеКнопокКомандам.Получить(ИмяКоманды);
	
	Если Не ЭтотОбъект[ИмяФлажка] Тогда
		ЭтотОбъект[ИмяСписка].Очистить();
		Модифицированность = Истина;
	КонецЕсли;
	
	Элементы[ИмяКнопки].Заголовок = ТекстЗаголовкаКнопкиПодбора(ЭтотОбъект[ИмяСписка]);
	Элементы[ИмяКнопки].Видимость = ЭтотОбъект[ИмяФлажка];
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.Свойства
&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

&НаКлиенте
Процедура ЗаполнитьСписокНазначения(Команда)
	
	ОткрытьФормуПодбораЗначенийНазначения(Команда);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьСобытияНазначения(Команда)
	
	Оповещение = Новый ОписаниеОповещения("ПослеОтметкиЭлементовСпискаСобытий", ЭтотОбъект);
	СписокДоступныхСобытий.ПоказатьОтметкуЭлементов(Оповещение, "События");
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

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

&НаКлиентеНаСервереБезКонтекста
Функция ТекстЗаголовкаКнопкиПодбора(Знач ПодобранныеЗначения, ТолькоДляОтмеченных = Ложь)
	
	Возврат АдаптацияУвольнениеКлиентСервер.ТекстПредставленияСпискаВидовСобытий(ПодобранныеЗначения, НСтр("ru = 'Заполнить'"), ТолькоДляОтмеченных);
	
КонецФункции

&НаСервере
Процедура ОбновитьСписокДоступныхСобытий(УстанавливатьОтметку = Истина)
	
	СписокДоступныхСобытий.Очистить();
	
	ДоступныеСобытия = Перечисления.ВидыСобытийАдаптацииУвольнения.ДоступныеВидыСобытий(Объект.ВидМероприятия);
	
	ВидыСобытий = Объект.События.Выгрузить(,"ВидСобытия").ВыгрузитьКолонку("ВидСобытия");
	
	Для Каждого Событие Из ДоступныеСобытия Цикл
		СписокДоступныхСобытий.Добавить(Событие, , ?(УстанавливатьОтметку, ВидыСобытий.Найти(Событие) <> НеОпределено, Ложь));
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция ОтборыНазначения()
	
	СтруктураСписков = Новый Структура("Подразделения, Должности, Позиции, Организации");
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Мероприятие", Объект.Ссылка);
	
	Запрос.Текст = "ВЫБРАТЬ
	|	ОбъектыНазначения.ОбъектНазначения КАК Объект
	|ПОМЕСТИТЬ ВТОбъектыНазначения
	|ИЗ
	|	РегистрСведений.ОтборыНазначенияМероприятийАдаптацииУвольнения КАК ОбъектыНазначения
	|ГДЕ
	|	ОбъектыНазначения.Мероприятие = &Мероприятие
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ОбъектыНазначения.Объект
	|ИЗ
	|	ВТОбъектыНазначения КАК ОбъектыНазначения
	|ГДЕ
	|	ТИПЗНАЧЕНИЯ(ОбъектыНазначения.Объект) = ТИП(Справочник.ПодразделенияОрганизаций)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ОбъектыНазначения.Объект
	|ИЗ
	|	ВТОбъектыНазначения КАК ОбъектыНазначения
	|ГДЕ
	|	ТИПЗНАЧЕНИЯ(ОбъектыНазначения.Объект) = ТИП(Справочник.Должности)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ОбъектыНазначения.Объект
	|ИЗ
	|	ВТОбъектыНазначения КАК ОбъектыНазначения
	|ГДЕ
	|	ТИПЗНАЧЕНИЯ(ОбъектыНазначения.Объект) = ТИП(Справочник.ШтатноеРасписание)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ОбъектыНазначения.Объект
	|ИЗ
	|	ВТОбъектыНазначения КАК ОбъектыНазначения
	|ГДЕ
	|	ТИПЗНАЧЕНИЯ(ОбъектыНазначения.Объект) = ТИП(Справочник.Организации)";
	
	Результаты = Запрос.ВыполнитьПакет();
	
	СтруктураСписков.Подразделения = Результаты[1].Выгрузить().ВыгрузитьКолонку("Объект");
	СтруктураСписков.Должности = Результаты[2].Выгрузить().ВыгрузитьКолонку("Объект");
	СтруктураСписков.Позиции = Результаты[3].Выгрузить().ВыгрузитьКолонку("Объект");
	СтруктураСписков.Организации = Результаты[4].Выгрузить().ВыгрузитьКолонку("Объект");
	
	Возврат СтруктураСписков;
	
КонецФункции

&НаСервере
Процедура ОбновитьПризнакиНазначения()
	
	ДляПодразделений = СписокПодразделений.Количество() > 0;
	ДляДолжностей = СписокДолжностей.Количество() > 0;
	ДляПозиций = СписокПозиций.Количество() > 0;
	ДляОрганизаций = СписокОрганизаций.Количество() > 0;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьСпискиОтборовНазначения()
	
	Отборы = ОтборыНазначения();
	
	СписокПодразделений.ЗагрузитьЗначения(Отборы.Подразделения);
	СписокДолжностей.ЗагрузитьЗначения(Отборы.Должности);
	СписокПозиций.ЗагрузитьЗначения(Отборы.Позиции);
	СписокОрганизаций.ЗагрузитьЗначения(Отборы.Организации);
	
	СписокПодразделенийПрежний = СписокПодразделений.Скопировать();
	СписокДолжностейПрежний = СписокДолжностей.Скопировать();
	СписокПозицийПрежний = СписокПозиций.Скопировать();
	СписокОрганизацийПрежний = СписокОрганизаций.Скопировать();
	
	ОбновитьСписокДоступныхСобытий();
	
	ОбновитьПризнакиНазначения();
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьЗаголовокКнопкиПодбораСобытий(Форма)
	
	Форма.Элементы.ЗаполнитьСобытия.Заголовок = ТекстЗаголовкаКнопкиПодбора(Форма.СписокДоступныхСобытий, Истина);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьЗаголовокПоляДнейНачало(Форма)
	
	Форма.Элементы.ДнейНачало.Заголовок =  ТекстЗаголовкаДней(Форма.ВСрокНачало, Форма.ДнейНачало);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьЗаголовокПоляДнейОкончание(Форма)
	
	Форма.Элементы.ДнейОкончание.Заголовок = ТекстЗаголовкаДней(Форма.ВСрокОкончание, Форма.ДнейОкончание);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ТекстЗаголовкаДней(ВСрок, Дней)
	
	ФормаСклоненияДня = ?(ВСрок = -1 , 
		?(Дней = 1, НСтр("ru = 'день'"), ?(Дней > 1 И Дней < 5, НСтр("ru = 'дня'"), НСтр("ru = 'дней'"))), 
		?(Дней = 1, НСтр("ru = 'дня'"), НСтр("ru = 'дней'")));
	
	ДопОписание = ?(ВСрок = -1, НСтр("ru = 'до'"), НСтр("ru = 'после'"));
	
	Возврат СтрШаблон(НСтр("ru = '%1 %2 события'"), ФормаСклоненияДня, ДопОписание);
	
КонецФункции

&НаСервере
Процедура УстановитьЗаголовкиЭлементов()
	
	Элементы.ЗаполнитьДляПодразделений.Заголовок = ТекстЗаголовкаКнопкиПодбора(СписокПодразделений);
	Элементы.ЗаполнитьДляДолжностей.Заголовок = ТекстЗаголовкаКнопкиПодбора(СписокДолжностей);
	Элементы.ЗаполнитьДляПозиций.Заголовок = ТекстЗаголовкаКнопкиПодбора(СписокПозиций);
	Элементы.ЗаполнитьДляОрганизаций.Заголовок = ТекстЗаголовкаКнопкиПодбора(СписокОрганизаций);
	
	УстановитьЗаголовокКнопкиПодбораСобытий(ЭтотОбъект);
	УстановитьЗаголовокПоляДнейНачало(ЭтотОбъект);
	УстановитьЗаголовокПоляДнейОкончание(ЭтотОбъект);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьВспомогательныеРеквизиты()
	
	КомандыФлажкам = Новый Соответствие;
	СпискиКомандам = Новый Соответствие;
	КнопкиКомандам = Новый Соответствие;
	ТаблицыКомандам = Новый Соответствие;
	ЗаголовкиКомандам = Новый Соответствие;
	
	КомандыФлажкам.Вставить("ДляПодразделений", "ЗаполнитьПодразделения");
	КомандыФлажкам.Вставить("ДляДолжностей", "ЗаполнитьДолжности");
	КомандыФлажкам.Вставить("ДляПозиций", "ЗаполнитьПозиции");
	КомандыФлажкам.Вставить("ДляОрганизаций", "ЗаполнитьОрганизации");
	
	СпискиКомандам.Вставить("ЗаполнитьПодразделения", "СписокПодразделений");
	СпискиКомандам.Вставить("ЗаполнитьДолжности", "СписокДолжностей");
	СпискиКомандам.Вставить("ЗаполнитьПозиции", "СписокПозиций");
	СпискиКомандам.Вставить("ЗаполнитьОрганизации", "СписокОрганизаций");
	
	КнопкиКомандам.Вставить("ЗаполнитьПодразделения", "ЗаполнитьДляПодразделений");
	КнопкиКомандам.Вставить("ЗаполнитьДолжности", "ЗаполнитьДляДолжностей");
	КнопкиКомандам.Вставить("ЗаполнитьПозиции", "ЗаполнитьДляПозиций");
	КнопкиКомандам.Вставить("ЗаполнитьОрганизации", "ЗаполнитьДляОрганизаций");
	
	ТаблицыКомандам.Вставить("ЗаполнитьПодразделения", "Справочник.ПодразделенияОрганизаций");
	ТаблицыКомандам.Вставить("ЗаполнитьДолжности", "Справочник.Должности");
	ТаблицыКомандам.Вставить("ЗаполнитьПозиции", "Справочник.ШтатноеРасписание");
	ТаблицыКомандам.Вставить("ЗаполнитьОрганизации", "Справочник.Организации");
	
	ЗаголовкиКомандам.Вставить("ЗаполнитьПодразделения", НСтр("ru = 'Выберите подразделения для отбора:'"));
	ЗаголовкиКомандам.Вставить("ЗаполнитьДолжности", НСтр("ru = 'Выберите должности для отбора:'"));
	ЗаголовкиКомандам.Вставить("ЗаполнитьПозиции", НСтр("ru = 'Выберите позиции для отбора:'"));
	ЗаголовкиКомандам.Вставить("ЗаполнитьОрганизации", НСтр("ru = 'Выберите организации для отбора:'"));
	
	СоответствиеКомандФлажкам = Новый ФиксированноеСоответствие(КомандыФлажкам);
	СоответствиеСписковКомандам = Новый ФиксированноеСоответствие(СпискиКомандам);
	СоответствиеКнопокКомандам = Новый ФиксированноеСоответствие(КнопкиКомандам);
	СоответствиеТаблицКомандам = Новый ФиксированноеСоответствие(ТаблицыКомандам);
	СоответствиеЗаголовковКомандам = Новый ФиксированноеСоответствие(ЗаголовкиКомандам);
	
КонецПроцедуры

&НаСервере
Процедура ДанныеВРеквизиты()
	
	Выполняется = Не Объект.ВАрхиве;
	
	ВСрокОкончание = ?(Объект.СдвигСрокаОкончанияИсполнения < 0, -1, 1);
	ДнейОкончание = Объект.СдвигСрокаОкончанияИсполнения * ВСрокОкончание;
	
	ВСрокНачало = ?(Объект.СдвигСрокаНачалаИсполнения < 0, -1, 1);
	ДнейНачало = Объект.СдвигСрокаНачалаИсполнения * ВСрокНачало;
	
	ОбновитьСпискиОтборовНазначения();
	УстановитьЗаголовкиЭлементов();
	
	ДляОпределенныхСобытий 		= ?(Объект.События.Количество() > 0, 1, 0);
	ДляОпределенныхСотрудников 	= ?(ДляОрганизаций Или ДляДолжностей Или ДляПодразделений Или ДляПозиций, 1, 0);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьВидимостьКнопкиПодбораСобытий(Форма)
	
	Форма.Элементы.ЗаполнитьСобытия.Видимость = (Форма.ДляОпределенныхСобытий = 1);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьВидимостьЭлементов(Форма)
	
	Элементы = Форма.Элементы;
	
	Элементы.ЗаполнитьДляПодразделений.Видимость = Форма.ДляПодразделений;
	Элементы.ЗаполнитьДляДолжностей.Видимость = Форма.ДляДолжностей;
	Элементы.ЗаполнитьДляПозиций.Видимость = Форма.ДляПозиций;
	Элементы.ЗаполнитьДляОрганизаций.Видимость = Форма.ДляОрганизаций;
	
	УстановитьВидимостьКнопкиПодбораСобытий(Форма);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьДоступностьПоляИсполнитель(Форма)
	
	Форма.Элементы.Исполнитель.Доступность = Не Форма.Объект.ИсполняетсяСотрудником;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьДоступностьПоляИсполняетсяСотрудником(Форма)
	
	Форма.Элементы.ИсполняетсяСотрудником.Доступность = Не ЗначениеЗаполнено(Форма.Объект.Исполнитель);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьДоступностьГруппыПолейОтборыНазначения(Форма)
	
	Форма.Элементы.ОтборыНазначенияГруппа.Доступность = Форма.ДляОпределенныхСотрудников;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьДоступностьЭлементов(Форма)
	
	Объект = Форма.Объект;
	Элементы = Форма.Элементы;
	Выполняется = Форма.Выполняется;
	
	Элементы.ВыполнениеГруппа.Доступность = Выполняется;
	Элементы.НазначениеЗаданияГруппа.Доступность = Выполняется;
	
	Если Выполняется Тогда
		
		УстановитьДоступностьПоляИсполнитель(Форма);
		УстановитьДоступностьПоляИсполняетсяСотрудником(Форма);
		УстановитьДоступностьГруппыПолейОтборыНазначения(Форма);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриПолученииДанныхНаСервере()
	
	ЗаполнитьВспомогательныеРеквизиты();
	
	ДанныеВРеквизиты();
	
	УстановитьВидимостьЭлементов(ЭтотОбъект);
	УстановитьДоступностьЭлементов(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Функция ЕстьОшибкиЗаполнения()
	
	Отказ = Ложь;
	
	Если Выполняется Тогда
		
		Если ДляОпределенныхСобытий = 1 И ОбщегоНазначенияКлиентСервер.ОтмеченныеЭлементы(СписокДоступныхСобытий).Количество() = 0 Тогда
			ТекстСообщения = НСтр("ru = 'Не выбрано ни одного события.'");
			ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения, , "ДляОпределенныхСобытий", , Отказ);
		КонецЕсли;
		
		Если ДляОпределенныхСотрудников = 1 И (Не ДляОрганизаций И Не ДляДолжностей И Не ДляПодразделений И Не ДляПозиций) Тогда
			
			ТекстСообщения = НСтр("ru = 'Не заданы отборы назначения для сотрудников.'");
			ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения, , "ДляОпределенныхСотрудников", , Отказ);
			
		Иначе
			
			Если ДляОрганизаций И СписокОрганизаций.Количество() = 0 Тогда
				
				ТекстСообщения = НСтр("ru = 'Не выбрано ни одной организации.'");
				ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения, , "ДляОрганизаций", , Отказ);
				
			КонецЕсли;
			
			Если ДляДолжностей И СписокДолжностей.Количество() = 0 Тогда
				
				ТекстСообщения = НСтр("ru = 'Не выбрано ни одной должности.'");
				ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения, , "ДляДолжностей", , Отказ);
				
			КонецЕсли;
			
			Если ДляПодразделений И СписокПодразделений.Количество() = 0 Тогда
				
				ТекстСообщения = НСтр("ru = 'Не выбрано ни одного подразделения.'");
				ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения, , "ДляПодразделений", , Отказ);
				
			КонецЕсли;
			
			Если ДляПозиций И СписокПозиций.Количество() = 0 Тогда
				
				ТекстСообщения = НСтр("ru = 'Не выбрано ни одной позиции.'");
				ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения, , "ДляПозиций", , Отказ);
				
			КонецЕсли;
			
		КонецЕсли;
		
		Если Не Объект.ИсполняетсяСотрудником 
			И Не ЗначениеЗаполнено(Объект.Исполнитель) Тогда
			ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Не выбран исполнитель.'"), , "Объект.Исполнитель", , Отказ);
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Отказ;
	
КонецФункции

&НаСервереБезКонтекста
Функция ИспользуетсяСОбъектамиАдресации(ПроверяемыйОбъект)
	
	Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ПроверяемыйОбъект, "ИспользуетсяСОбъектамиАдресации");
	
КонецФункции

&НаКлиенте
Процедура ОписаниеЗавершениеВыбора(РезультатВыбора, ДополнительныеПараметры) Экспорт
	
	Если РезультатВыбора = НеОпределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Объект.Описание <> РезультатВыбора Тогда
		
		Объект.Описание = РезультатВыбора;
		Модифицированность = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДляОпределенныхСотрудниковЗавершениеИзменения(Ответ, ДополнительныеПараметры) Экспорт 
	
	Если Ответ = КодВозвратаДиалога.Нет Тогда
		
		ДляОпределенныхСотрудников = 1;
		
	Иначе
		
		СписокДолжностей.Очистить();
		СписокОрганизаций.Очистить();
		СписокПодразделений.Очистить();
		СписокПозиций.Очистить();
		
		ОбновитьПризнакиНазначения();
		УстановитьЗаголовкиЭлементов();
		
		УстановитьВидимостьЭлементов(ЭтотОбъект);
		УстановитьДоступностьГруппыПолейОтборыНазначения(ЭтотОбъект);
		
		Модифицированность = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДляОпределенныхСобытийЗавершениеИзменения(Ответ, ДополнительныеПараметры) Экспорт 
	
	Если Ответ = КодВозвратаДиалога.Нет Тогда
		
		ДляОпределенныхСобытий = 1;
		
	Иначе
		
		СписокДоступныхСобытий.Очистить();
		
		УстановитьЗаголовокКнопкиПодбораСобытий(ЭтотОбъект);
		УстановитьВидимостьКнопкиПодбораСобытий(ЭтотОбъект);
		
		Модифицированность = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуПодбораЗначенийНазначения(Команда)
	
	ИмяСписка = СоответствиеСписковКомандам.Получить(Команда.Имя);
	ИмяКнопки = СоответствиеКнопокКомандам.Получить(Команда.Имя);
	ИмяТаблицы = СоответствиеТаблицКомандам.Получить(Команда.Имя);
	ЗаголовокФормы = СоответствиеЗаголовковКомандам.Получить(Команда.Имя);
	
	ПараметрыОповещения = Новый Структура;
	ПараметрыОповещения.Вставить("ИмяСписка", ИмяСписка);
	ПараметрыОповещения.Вставить("ИмяКнопки", ИмяКнопки);
	
	Если СписокОрганизаций.Количество() = 1 И (ИмяТаблицы = "Справочник.ПодразделенияОрганизаций" 
		Или ИмяТаблицы = "Справочник.ШтатноеРасписание") Тогда
		Организация = СписокОрганизаций[0].Значение;
	Иначе
		Организация = ПредопределенноеЗначение("Справочник.Организации.ПустаяСсылка");
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Организация", Организация);
	ПараметрыФормы.Вставить("Заголовок", ЗаголовокФормы);
	ПараметрыФормы.Вставить("ИмяТаблицы", ИмяТаблицы);
	ПараметрыФормы.Вставить("ТекущиеЗначения", ЭтотОбъект[ИмяСписка]);
	ПараметрыФормы.Вставить("ТолькоПросмотр", Ложь);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ОбработкаВыбораЗначенийНазначения", ЭтотОбъект, ПараметрыОповещения);
	
	ОткрытьФорму("Справочник.МероприятияАдаптацииУвольнения.Форма.ФормаЗначенийНазначения", ПараметрыФормы, ЭтотОбъект,,,, ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбораЗначенийНазначения(РезультатВыбора, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(РезультатВыбора) = Тип("СписокЗначений") Тогда
		
		ИмяСписка = ДополнительныеПараметры.ИмяСписка;
		ИмяКнопки = ДополнительныеПараметры.ИмяКнопки;
		
		ЭтотОбъект[ИмяСписка] = РезультатВыбора;
		Элементы[ИмяКнопки].Заголовок = ТекстЗаголовкаКнопкиПодбора(ЭтотОбъект[ИмяСписка]);
		
		Модифицированность = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеОтметкиЭлементовСпискаСобытий(Список, Параметры) Экспорт
	
	Если ЗначениеЗаполнено(Список) Тогда
		
		СписокДоступныхСобытий = Список;
		
		УстановитьЗаголовокКнопкиПодбораСобытий(ЭтотОбъект);
		Модифицированность = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьОтборыНазначенияМероприятия(Мероприятие)
	
	ЗаписатьОтборыНазначенияСотрудниковПоСпискам(Мероприятие, СписокДолжностей, СписокДолжностейПрежний);
	ЗаписатьОтборыНазначенияСотрудниковПоСпискам(Мероприятие, СписокОрганизаций, СписокОрганизацийПрежний);
	ЗаписатьОтборыНазначенияСотрудниковПоСпискам(Мероприятие, СписокПодразделений, СписокПодразделенийПрежний);
	ЗаписатьОтборыНазначенияСотрудниковПоСпискам(Мероприятие, СписокПозиций, СписокПозицийПрежний);
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьОтборыНазначенияСобытий(Мероприятие)
	
	Если ДляОпределенныхСобытий = 1 Тогда
		
		Мероприятие.События.Очистить();
		
		ОтмеченныеСобытия = ОбщегоНазначенияКлиентСервер.ОтмеченныеЭлементы(СписокДоступныхСобытий);
		ОбщегоНазначенияКлиентСервер.ДополнитьТаблицуИзМассива(Мероприятие.События, ОтмеченныеСобытия, "ВидСобытия");
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЗаписатьОтборыНазначенияСотрудниковПоСпискам(Мероприятие, СписокТекущий, СписокПрежний)
	
	МенеджерЗаписи = РегистрыСведений.ОтборыНазначенияМероприятийАдаптацииУвольнения.СоздатьМенеджерЗаписи();
	
	Если Не ОбщегоНазначенияКлиентСервер.СпискиЗначенийИдентичны(СписокТекущий, СписокПрежний) Тогда
		
		ЗначенияПосле 	= СписокТекущий.ВыгрузитьЗначения();
		ЗначенияДо 		= СписокПрежний.ВыгрузитьЗначения();
		
		НовыеЗначения = ОбщегоНазначенияКлиентСервер.РазностьМассивов(ЗначенияПосле, ЗначенияДо);
		СнятыеЗначения = ОбщегоНазначенияКлиентСервер.РазностьМассивов(ЗначенияДо, ЗначенияПосле);
		
		Если НовыеЗначения.Количество() > 0 Тогда
			
			ЗначенияРеквизита = Новый Соответствие;
			ОрганизацияПоУмолчанию = Справочники.Организации.ПустаяСсылка();
			
			Если ТипЗнч(НовыеЗначения[0]) = Тип("СправочникСсылка.Организации") Тогда
				Для Каждого Значение Из НовыеЗначения Цикл
					ЗначенияРеквизита.Вставить(Значение, Значение);
				КонецЦикла;
			ИначеЕсли ТипЗнч(НовыеЗначения[0]) = Тип("СправочникСсылка.ПодразделенияОрганизаций")
				Или ТипЗнч(НовыеЗначения[0]) = Тип("СправочникСсылка.ШтатноеРасписание") Тогда
				ЗначенияРеквизита = ОбщегоНазначения.ЗначениеРеквизитаОбъектов(НовыеЗначения, "Владелец");
			КонецЕсли;
			
			Для Каждого Значение Из НовыеЗначения Цикл
				
				МенеджерЗаписи.ОбъектНазначения = Значение;
				МенеджерЗаписи.Мероприятие = Мероприятие;
				МенеджерЗаписи.Прочитать();
				
				Если Не МенеджерЗаписи.Выбран() Тогда
					
					МенеджерЗаписи.ОбъектНазначения = Значение;
					МенеджерЗаписи.Мероприятие = Мероприятие;
					МенеджерЗаписи.Организация = ?(ЗначениеЗаполнено(ЗначенияРеквизита), ЗначенияРеквизита.Получить(Значение), ОрганизацияПоУмолчанию);
					МенеджерЗаписи.Записать();
					
				КонецЕсли;
				
			КонецЦикла;
			
		КонецЕсли;
			
		Для Каждого Значение Из СнятыеЗначения Цикл
			
			МенеджерЗаписи.ОбъектНазначения = Значение;
			МенеджерЗаписи.Мероприятие = Мероприятие;
			МенеджерЗаписи.Прочитать();
			
			Если МенеджерЗаписи.Выбран() Тогда
				МенеджерЗаписи.Удалить();
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

