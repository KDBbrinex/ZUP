#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("Характеристика") Тогда
		Характеристика = Параметры.Характеристика;
		ЗначениеХарактеристики = Параметры.ЗначениеХарактеристики;
	Иначе
		Характеристика = Неопределено;
		ЗначениеХарактеристики = Неопределено;
	КонецЕсли;
	
	ЗаполнитьСписки();
	
	ЭлектронноеИнтервью.УстановитьОформлениеДереваКритериевОценки(ЭтаФорма);
	ОтборСтрок = Новый Структура;
	ОтборСтрок.Вставить("ЭлементарныйВопрос", ПредопределенноеЗначение("ПланВидовХарактеристик.ВопросыДляАнкетирования.ПустаяСсылка"));
	ОтборСтрок.Вставить("Уровень", 3);
	Элементы.Ответы.ОтборСтрок = Новый ФиксированнаяСтруктура(ОтборСтрок);
	
	Если Не ПравоДоступа("Добавление", Метаданные.Справочники.ВопросыДляСобеседования) Тогда
		Элементы.ВопросыДляСобеседованияСоздатьВопрос.Доступность = Ложь;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ЗаписьВопроса" И ТипЗнч(Источник) = Тип("СправочникСсылка.ВопросыДляСобеседования") Тогда
		ДобавитьВопрос(Источник);
		ЭлектронноеИнтервьюКлиент.ЗаполнитьДеревоКритериевОценки(ЭтаФорма, Ложь, Ложь);
	КонецЕсли;	
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВопросыДляСобеседованияПриАктивизацииСтроки(Элемент)
	
	ЭлектронноеИнтервьюКлиент.ЗаполнитьДеревоКритериевОценки(ЭтаФорма, Ложь, Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура КритерииОценкиДеревоПриАктивизацииСтроки(Элемент)
	
	ПодключитьОбработчикОжидания("КритерииОценкиДеревоПриАктивизацииСтрокиОбработчикОжидания", 0.1, Истина);
	
КонецПроцедуры 

&НаКлиенте
Процедура КритерииОценкиДеревоПриАктивизацииСтрокиОбработчикОжидания()
	
	ЭлектронноеИнтервьюКлиент.УстановитьОтборТаблицыКритериев(ЭтаФорма, Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура КритерииОценкиДеревоВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.КритерииОценкиДерево.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ТекущиеДанные.Уровень = 0 Тогда
		Родитель = ТекущиеДанные;
	Иначе
		Родитель = ТекущиеДанные.ПолучитьРодителя();
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Родитель.ПояснениеКомментария) Тогда
		ПоказатьЗначение(, Родитель.ПояснениеКомментария);
	КонецЕсли; 
		
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаВыбрать(Команда)
	
	ВыбратьИЗакрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьФлажки(Команда)
	
	УстановитьВыбор(Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура СнятьФлажки(Команда)
	
	УстановитьВыбор(Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьВопрос(Команда)
	
	ОткрытьФорму("Справочник.ВопросыДляСобеседования.ФормаОбъекта",, ЭтаФорма);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьСписки()
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ВопросыДляСобеседованияКлючи.Ссылка КАК ВопросДляСобеседования
		|ПОМЕСТИТЬ ВТВопросыДляСобеседования
		|ИЗ
		|	Справочник.ВопросыДляСобеседования.Ключи КАК ВопросыДляСобеседованияКлючи
		|ГДЕ
		|	НЕ ВопросыДляСобеседованияКлючи.Ссылка.ПометкаУдаления
		|	И ВопросыДляСобеседованияКлючи.ЗначениеХарактеристики = &ЗначениеХарактеристики
		|	И ВопросыДляСобеседованияКлючи.ХарактеристикаПерсонала = &ХарактеристикаПерсонала
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВопросыДляСобеседования.ВопросДляСобеседования,
		|	ВопросыДляСобеседования.ВопросДляСобеседования.ТипВопроса КАК ТипВопроса,
		|	ВопросыДляСобеседования.ВопросДляСобеседования.Формулировка КАК Формулировка
		|ИЗ
		|	ВТВопросыДляСобеседования КАК ВопросыДляСобеседования";
	Если ЗначениеЗаполнено(Характеристика) Тогда
		Запрос.УстановитьПараметр("ХарактеристикаПерсонала", Характеристика);
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "И ВопросыДляСобеседованияКлючи.ХарактеристикаПерсонала = &ХарактеристикаПерсонала", "");
	КонецЕсли;
	Если ЗначениеЗаполнено(ЗначениеХарактеристики) Тогда
		Запрос.УстановитьПараметр("ЗначениеХарактеристики", ЗначениеХарактеристики);
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "И ВопросыДляСобеседованияКлючи.ЗначениеХарактеристики = &ЗначениеХарактеристики", "");
	КонецЕсли;
	
	ТаблицаВопросов = Запрос.Выполнить().Выгрузить();
	ВопросыДляСобеседования.Загрузить(ТаблицаВопросов);
	
	ЗаполнитьДеревоКритериев();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДеревоКритериев()
	
	Ответы.Очистить();	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Вопросы", ВопросыДляСобеседования.Выгрузить().ВыгрузитьКолонку("ВопросДляСобеседования"));
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ВопросыДляСобеседованияКлючевыеВопросы.Ссылка КАК ВопросДляСобеседования,
		|	ВопросыДляСобеседованияКлючевыеВопросы.ЭлементарныйВопрос КАК ЭлементарныйВопрос,
		|	ВариантыОтветовАнкет.Ссылка КАК ОтветНаВопрос
		|ПОМЕСТИТЬ ВТКлючевыеВопросы
		|ИЗ
		|	Справочник.ВопросыДляСобеседования.КлючевыеВопросы КАК ВопросыДляСобеседованияКлючевыеВопросы
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ВариантыОтветовАнкет КАК ВариантыОтветовАнкет
		|		ПО ВопросыДляСобеседованияКлючевыеВопросы.ЭлементарныйВопрос = ВариантыОтветовАнкет.Владелец
		|			И (НЕ ВариантыОтветовАнкет.ПометкаУдаления)
		|ГДЕ
		|	ВопросыДляСобеседованияКлючевыеВопросы.Ссылка В(&Вопросы)
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	КлючевыеВопросы.ВопросДляСобеседования КАК ВопросДляСобеседования,
		|	КлючевыеВопросы.ЭлементарныйВопрос КАК ЭлементарныйВопрос,
		|	КлючевыеВопросы.ЭлементарныйВопрос.Формулировка КАК Наименование,
		|	КлючевыеВопросы.ЭлементарныйВопрос.ТребуетсяКомментарий КАК ТребуетсяКомментарий,
		|	КлючевыеВопросы.ЭлементарныйВопрос.ПояснениеКомментария КАК ПояснениеКомментария,
		|	КлючевыеВопросы.ОтветНаВопрос КАК ОтветНаВопрос,
		|	КлючевыеВопросы.ОтветНаВопрос.Наименование КАК ОтветНаименование,
		|	ВопросыДляСобеседованияКлючи.Балл,
		|	ВопросыДляСобеседованияКлючи.ХарактеристикаПерсонала КАК Характеристика,
		|	ВопросыДляСобеседованияКлючи.ЗначениеХарактеристики КАК Значение
		|ИЗ
		|	ВТКлючевыеВопросы КАК КлючевыеВопросы
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ВопросыДляСобеседования.Ключи КАК ВопросыДляСобеседованияКлючи
		|		ПО КлючевыеВопросы.ВопросДляСобеседования = ВопросыДляСобеседованияКлючи.Ссылка
		|			И КлючевыеВопросы.ЭлементарныйВопрос = ВопросыДляСобеседованияКлючи.ЭлементарныйВопрос
		|			И КлючевыеВопросы.ОтветНаВопрос = ВопросыДляСобеседованияКлючи.ОтветНаВопрос
		|ИТОГИ ПО
		|	ВопросДляСобеседования,
		|	ЭлементарныйВопрос,
		|	ОтветНаВопрос";	
	
	ДеревоРезультат =  Запрос.Выполнить().Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкам);
	ЭлектронноеИнтервью.ЗаполнитьТаблицуДереваКритериевОценки(ДеревоРезультат.Строки, Ответы);

КонецПроцедуры
 
&НаКлиенте
Процедура ВыбратьИЗакрыть()
	
	СтруктураПоиска = Новый Структура;
	СтруктураПоиска.Вставить("Выбран", Истина);
	ВыбранныеВопросыДляСобеседования = ВопросыДляСобеседования.НайтиСтроки(СтруктураПоиска);
	ПараметрыЗакрытия = Новый Массив;
	Для Каждого СтрокаВопросДляСобеседования Из ВыбранныеВопросыДляСобеседования Цикл
		ПараметрыЗакрытия.Добавить(СтрокаВопросДляСобеседования.ВопросДляСобеседования)
	КонецЦикла;
	
	Закрыть(ПараметрыЗакрытия);

КонецПроцедуры

&НаКлиенте
Процедура УстановитьВыбор(Значение)
	
	Для Каждого ТекущаяСтрока Из ВопросыДляСобеседования Цикл
		ТекущаяСтрока.Выбран = Значение;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьВопрос(НовыйВопрос)
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ВопросыДляСобеседованияКлючи.Ссылка КАК ВопросДляСобеседования
		|ПОМЕСТИТЬ ВТВопросыДляСобеседования
		|ИЗ
		|	Справочник.ВопросыДляСобеседования.Ключи КАК ВопросыДляСобеседованияКлючи
		|ГДЕ
		|	НЕ ВопросыДляСобеседованияКлючи.Ссылка.ПометкаУдаления
		|	И ВопросыДляСобеседованияКлючи.Ссылка = &Вопрос
		|	И ВопросыДляСобеседованияКлючи.ЗначениеХарактеристики = &ЗначениеХарактеристики
		|	И ВопросыДляСобеседованияКлючи.ХарактеристикаПерсонала = &ХарактеристикаПерсонала
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВопросыДляСобеседования.ВопросДляСобеседования,
		|	ВопросыДляСобеседования.ВопросДляСобеседования.ТипВопроса КАК ТипВопроса,
		|	ВопросыДляСобеседования.ВопросДляСобеседования.Формулировка КАК Формулировка
		|ИЗ
		|	ВТВопросыДляСобеседования КАК ВопросыДляСобеседования";
	Запрос.УстановитьПараметр("Вопрос", НовыйВопрос);
	Если ЗначениеЗаполнено(Характеристика) Тогда
		Запрос.УстановитьПараметр("ХарактеристикаПерсонала", Характеристика);
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "И ВопросыДляСобеседованияКлючи.ХарактеристикаПерсонала = &ХарактеристикаПерсонала", "");
	КонецЕсли;
	Если ЗначениеЗаполнено(ЗначениеХарактеристики) Тогда
		Запрос.УстановитьПараметр("ЗначениеХарактеристики", ЗначениеХарактеристики);
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "И ВопросыДляСобеседованияКлючи.ЗначениеХарактеристики = &ЗначениеХарактеристики", "");
	КонецЕсли;
	
	СтруктураПоиска = Новый Структура;
	СтруктураПоиска.Вставить("ВопросДляСобеседования", НовыйВопрос);
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		Если ВопросыДляСобеседования.НайтиСтроки(СтруктураПоиска).Количество() = 0 Тогда
			НоваяСтрока = ВопросыДляСобеседования.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, Выборка);
		КонецЕсли;
	Иначе
		УдаляемыеВопросы = ВопросыДляСобеседования.НайтиСтроки(СтруктураПоиска);
		Для Каждого ТекущаяСтрока Из УдаляемыеВопросы Цикл
			ВопросыДляСобеседования.Удалить(ТекущаяСтрока);
		КонецЦикла;
	КонецЕсли;	
	
	ЗаполнитьДеревоКритериев();
	
КонецПроцедуры

#КонецОбласти
