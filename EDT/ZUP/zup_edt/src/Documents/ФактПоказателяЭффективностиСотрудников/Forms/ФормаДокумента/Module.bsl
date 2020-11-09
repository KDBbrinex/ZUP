#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Ключ.Пустая() Тогда
		ЗначенияДляЗаполнения = Новый Структура("Ответственный, Месяц", "Объект.Ответственный", "Объект.Период");
		ЗарплатаКадры.ЗаполнитьПервоначальныеЗначенияВФорме(ЭтаФорма, ЗначенияДляЗаполнения);
		
		ПриПолученииДанныхНаСервере();
	КонецЕсли;
	
	// Обработчик подсистемы "ВерсионированиеОбъектов".
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтаФорма);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ПриПолученииДанныхНаСервере();
	
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
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

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	МассивСотрудников = Новый Массив;
	Для каждого СтрокаСотрудник Из Объект.Сотрудники  Цикл
		МассивСотрудников.Добавить(СтрокаСотрудник.Сотрудник);
	КонецЦикла; 
	Оповестить("Запись_ФактПоказателяЭффективностиСотрудников", МассивСотрудников);
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	ПриПолученииДанныхНаСервере();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПодразделениеПриИзменении(Элемент)
	
	Объект.Сотрудники.Очистить();
	УстановитьПараметрыВыбораСотрудников();
	
КонецПроцедуры
 
&НаКлиенте
Процедура ПоказательПриИзменении(Элемент)
	
	УстановитьПараметрыВыбораСотрудников();
	
КонецПроцедуры

&НаКлиенте
Процедура ПериодСтрокойНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	КлючевыеПоказателиЭффективностиКлиент.ВыбратьПериод(ЭтаФорма, Новый ОписаниеОповещения("ПериодПриИзмененииНаКлиенте", ЭтотОбъект));
КонецПроцедуры

&НаКлиенте
Процедура ПериодСтрокойРегулирование(Элемент, Направление, СтандартнаяОбработка)
	КлючевыеПоказателиЭффективностиКлиент.ПериодСтрокойРегулирование(ЭтаФорма, Направление);
	ПериодПриИзмененииНаКлиенте();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСотрудники

&НаКлиенте
Процедура СотрудникиСотрудникПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Сотрудники.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ДополнитьТаблицуРабочихМестСотрудниковНаСервере(ТекущиеДанные.Сотрудник);
	
	УстановитьПозициюСотрудника(ЭтаФорма, ТекущиеДанные);
	ЗаполнитьОписаниеПериодаРаботыСотрудника(ЭтаФорма, ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура СотрудникиПозицияПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Сотрудники.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЗаполнитьОписаниеПериодаРаботыСотрудника(ЭтаФорма, ТекущиеДанные);
	
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
Процедура ЗаполнитьПоОтветственному(Команда)
	ЗаполнитьСписокСотрудниковПоОтветственномуНаСервере();
КонецПроцедуры

#Область ЗагрузкаДанныхИзФайла

&НаКлиенте
Процедура ЗагрузитьИзФайла(Команда)
	
	ПараметрыЗагрузки = ЗагрузкаДанныхИзФайлаКлиент.ПараметрыЗагрузкиДанных();
	ПараметрыЗагрузки.ПолноеИмяТабличнойЧасти = "ФактПоказателяЭффективностиСотрудников.Сотрудники";
	ПараметрыЗагрузки.Заголовок = НСтр("ru = 'Загрузка фактических значений показателя сотрудников из файла'");
	
	ДополнительныеПараметры = Новый Структура();
	ДополнительныеПараметры.Вставить("Подразделение", Объект.Подразделение);
	
	ПараметрыЗагрузки.ДополнительныеПараметры = ДополнительныеПараметры;
	
	Оповещение = Новый ОписаниеОповещения("ЗагрузитьСотрудниковИзФайлаЗавершение", ЭтотОбъект);
	ЗагрузкаДанныхИзФайлаКлиент.ПоказатьФормуЗагрузки(ПараметрыЗагрузки, Оповещение);
	
КонецПроцедуры

#КонецОбласти

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

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#Область ЗагрузкаДанныхИзФайла

&НаКлиенте
Процедура ЗагрузитьСотрудниковИзФайлаЗавершение(АдресЗагруженныхДанных, ДополнительныеПараметры) Экспорт
	
	Если АдресЗагруженныхДанных = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	ЗагрузитьСотрудниковИзФайлаНаСервере(АдресЗагруженныхДанных);
			
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьСотрудниковИзФайлаНаСервере(АдресЗагруженныхДанных)
	
	ДобавленыСтроки = Ложь;
	
	ЗагруженныеДанные = ПолучитьИзВременногоХранилища(АдресЗагруженныхДанных);
	Для Каждого СтрокаДанных Из ЗагруженныеДанные Цикл 
		
		Если Не ЗначениеЗаполнено(СтрокаДанных.Сотрудник) Тогда 
			Продолжить;
		КонецЕсли;
		ЗаполнитьЗначенияСвойств(Объект.Сотрудники.Добавить(), СтрокаДанных);
		
	    ДобавленыСтроки = Истина;
	КонецЦикла;
	
	Модифицированность = Модифицированность ИЛИ ДобавленыСтроки;
		
КонецПроцедуры

#КонецОбласти

&НаСервере
Процедура ПриПолученииДанныхНаСервере()
	
	ЗаполнитьВторичныеРеквизитыФормы();
	
	УстановитьСвойстваЭлементовФормы();

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьВторичныеРеквизитыФормы()
	
	КлючевыеПоказателиЭффективностиКлиентСервер.УстановитьПредставлениеПериодаПоДате(ЭтаФорма);
	
	КлючевыеПоказателиЭффективностиФормы.ЗаполнитьТаблицуРабочихМестСотрудников(
		ТаблицаРабочихМест,
		Объект.Сотрудники.Выгрузить(),
		СтруктураРеквизитовДокумента());
	
	ЗаполнитьВторичныеРеквизитыТаблицыСотрудники();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьВторичныеРеквизитыТаблицыСотрудники()

	Для каждого СтрокаСотрудники Из Объект.Сотрудники Цикл
		ЗаполнитьОписаниеПериодаРаботыСотрудника(ЭтаФорма, СтрокаСотрудники);
	КонецЦикла; 

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ЗаполнитьОписаниеПериодаРаботыСотрудника(Форма, СтрокаСотрудника)

	МестаРаботыСотрудника = Форма.ТаблицаРабочихМест.НайтиСтроки(Новый Структура("Сотрудник", СтрокаСотрудника.Сотрудник));
	
	СтрокаСотрудника.КоличествоПериодовРаботы = МестаРаботыСотрудника.Количество();
	СтрокаСотрудника.ПозицииНетВТаблицеРабочихМест = Истина;
	
	Если МестаРаботыСотрудника.Количество() = 0 Тогда
		СтрокаПериода = НСтр("ru = '<нет периодов работы>'");
	Иначе
		МассивСтрок = Новый Массив;
		Для каждого МестоРаботы Из МестаРаботыСотрудника Цикл
		    Если МестоРаботы.Позиция = СтрокаСотрудника.Позиция Тогда
				ТекстПериода = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
								"%1 - %2",
								Формат(МестоРаботы.ДатаНачала,"ДЛФ=D"),
								Формат(МестоРаботы.ДатаОкончания,"ДЛФ=D"));
				МассивСтрок.Добавить(ТекстПериода);
				
				СтрокаСотрудника.ПозицииНетВТаблицеРабочихМест = Ложь;
			КонецЕсли;
		КонецЦикла; 
		
		Если СтрокаСотрудника.КоличествоПериодовРаботы > 1 Тогда
			СтрокаПериода = СтрСоединить(МассивСтрок, ", ");
		КонецЕсли;
		
	КонецЕсли;
	
	ОписаниеПериодаРаботы = Строка(СтрокаСотрудника.Позиция);
	Если ЗначениеЗаполнено(СтрокаПериода) Тогда
		ОписаниеПериодаРаботы = ОписаниеПериодаРаботы + " (" + СтрокаПериода + ")";
	КонецЕсли;
	
	СтрокаСотрудника.ОписаниеПериодаРаботы = ОписаниеПериодаРаботы;

КонецПроцедуры

&НаСервере
Процедура УстановитьСвойстваЭлементовФормы()
	УстановитьПараметрыВыбораСотрудников();
КонецПроцедуры

&НаКлиенте
Процедура ПериодПриИзмененииНаКлиенте(Результат = Неопределено, ДополнительныеПараметры = Неопределено) Экспорт 
	ПериодПриИзмененииНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПериодПриИзмененииНаСервере()
	УстановитьПараметрыВыбораСотрудников();
КонецПроцедуры

&НаСервере
Процедура УстановитьПараметрыВыбораСотрудников()

	КоллекцияОтборов = КоллекцияОтборов();
	МассивПозиций = КлючевыеПоказателиЭффективности.ТаблицаПозицийПоПоказателю(Объект.Период, Объект.Показатель, КоллекцияОтборов).ВыгрузитьКолонку("Позиция");
	
	ПараметрыВыбораМассив = Новый Массив;
	ПараметрыВыбораМассив.Добавить(Новый ПараметрВыбора("Отбор.ДолжностьПоШтатномуРасписанию", МассивПозиций));
	ПараметрыВыбораМассив.Добавить(Новый ПараметрВыбора("НеотключаемыеОтборы", "ДолжностьПоШтатномуРасписанию"));
	
	Элементы.СотрудникиСотрудник.ПараметрыВыбора = Новый ФиксированныйМассив(ПараметрыВыбораМассив); 

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокСотрудниковПоОтветственномуНаСервере()
	
	ЗаполнитьСотрудников();
	
	ЗаполнитьВторичныеРеквизитыТаблицыСотрудники();

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСотрудников()

	УдалитьВТ = Новый Массив;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	// Получаем список позиций, на которые назначен этот показатель.
	КоллекцияОтборов = КоллекцияОтборов();
	ЗарплатаКадрыОбщиеНаборыДанных.ДобавитьВКоллекциюОтбор(
		КоллекцияОтборов, "ОтветственныйЗаВводФакта", "=", Объект.Ответственный);
		
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	&Период КАК Период, 
		|	&Показатель КАК Показатель
		|ПОМЕСТИТЬ ВТФильтрИзмерений";
	
	Запрос.УстановитьПараметр("Период", Объект.Период);
	Запрос.УстановитьПараметр("Показатель", Объект.Показатель);
	
	Запрос.Выполнить();
	УдалитьВТ.Добавить("ВТФильтрИзмерений");
	
	КлючевыеПоказателиЭффективности.СоздатьВТПозицииВводаЗначенийПоказателей(
		Запрос.МенеджерВременныхТаблиц,
		"ВТФильтрИзмерений",
		"Показатель",
		КоллекцияОтборов);
		
	УдалитьВТ.Добавить("ВТПозицииВводаЗначенийПоказателей");
	
	// Получаем список сотрудников, когда-либо работавших на этих позициях в периоде.
	КлючевыеПоказателиЭффективности.СоздатьВТПериодыРаботыСотрудниковПоСпискуПозиций(Запрос.МенеджерВременныхТаблиц, "ВТПозицииВводаЗначенийПоказателей", СтруктураРеквизитовДокумента());
	УдалитьВТ.Добавить("ВТПериодыРаботыСотрудников");
	
	Запрос.Текст =
	    "ВЫБРАТЬ РАЗЛИЧНЫЕ
	    |	ВТПериодыРаботыСотрудников.Сотрудник КАК Сотрудник,
	    |	ВТПериодыРаботыСотрудников.Позиция КАК Позиция,
	    |	МИНИМУМ(ВТПериодыРаботыСотрудников.ДатаНачала) КАК ДатаНачала
	    |ПОМЕСТИТЬ УказателиСотрудников
	    |ИЗ
	    |	ВТПериодыРаботыСотрудников КАК ВТПериодыРаботыСотрудников
	    |
	    |СГРУППИРОВАТЬ ПО
	    |	ВТПериодыРаботыСотрудников.Сотрудник,
	    |	ВТПериодыРаботыСотрудников.Позиция
	    |;
	    |
	    |////////////////////////////////////////////////////////////////////////////////
	    |ВЫБРАТЬ
	    |	ВТПериодыРаботыСотрудников.Сотрудник КАК Сотрудник,
	    |	ВТПериодыРаботыСотрудников.Позиция КАК Позиция
	    |ИЗ
	    |	ВТПериодыРаботыСотрудников КАК ВТПериодыРаботыСотрудников
	    |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ УказателиСотрудников КАК УказателиСотрудников
	    |		ПО ВТПериодыРаботыСотрудников.Сотрудник = УказателиСотрудников.Сотрудник
	    |			И ВТПериодыРаботыСотрудников.Позиция = УказателиСотрудников.Позиция
	    |			И ВТПериодыРаботыСотрудников.ДатаНачала = УказателиСотрудников.ДатаНачала
	    |;
	    |
	    |////////////////////////////////////////////////////////////////////////////////
	    |ВЫБРАТЬ
	    |	ВТПериодыРаботыСотрудников.Сотрудник КАК Сотрудник,
	    |	ВТПериодыРаботыСотрудников.Позиция КАК Позиция,
	    |	ВТПериодыРаботыСотрудников.ДатаНачала КАК ДатаНачала,
	    |	ВТПериодыРаботыСотрудников.ДатаОкончания КАК ДатаОкончания
	    |ИЗ
	    |	ВТПериодыРаботыСотрудников КАК ВТПериодыРаботыСотрудников";
	
	УдалитьВТ.Добавить("УказателиСотрудников");
	
	РезультатыЗапроса = Запрос.ВыполнитьПакет();
	
	Объект.Сотрудники.Загрузить(РезультатыЗапроса[РезультатыЗапроса.Количество() - 2].Выгрузить());
	ТаблицаРабочихМест.Загрузить(РезультатыЗапроса[РезультатыЗапроса.Количество() - 1].Выгрузить());
	
	ЗарплатаКадры.УничтожитьВТ(Запрос.МенеджерВременныхТаблиц, УдалитьВТ);
	
КонецПроцедуры

&НаСервере
Функция КоллекцияОтборов()

	КоллекцияОтборов = Новый Массив;
	
	ПодчиненныеПодразделения = ОрганизационнаяСтруктура.ПодчиненныеПодразделения(
		ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Объект.Подразделение));
	ПозицииПодразделения = ОрганизационнаяСтруктура.ПозицииПодразделений(ПодчиненныеПодразделения).ВыгрузитьКолонку("Позиция");
	
	ЗарплатаКадрыОбщиеНаборыДанных.ДобавитьВКоллекциюОтбор(
		КоллекцияОтборов, "Позиция", "В", ПозицииПодразделения);

	Возврат КоллекцияОтборов;
		
КонецФункции

&НаСервере
Функция СтруктураРеквизитовДокумента()
	
	СтруктураРеквизитов = Новый Структура;
	
	СтруктураРеквизитов.Вставить("Период", Объект.Период);
	СтруктураРеквизитов.Вставить("Горизонт", Объект.Горизонт);
	
	Возврат СтруктураРеквизитов;
	
КонецФункции

&НаСервере
Процедура ДополнитьТаблицуРабочихМестСотрудниковНаСервере(Сотрудник)

	КлючевыеПоказателиЭффективностиФормы.ДополнитьТаблицуРабочихМестСотрудников(
		ТаблицаРабочихМест,
		Сотрудник,
		СтруктураРеквизитовДокумента());
		
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьПозициюСотрудника(Форма, ТекущиеДанные)

	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	СтрокиСотрудника = Форма.ТаблицаРабочихМест.НайтиСтроки(Новый Структура("Сотрудник", ТекущиеДанные.Сотрудник));
	Если СтрокиСотрудника.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ТекущиеДанные.Позиция = СтрокиСотрудника[0].Позиция;
	
КонецПроцедуры

#КонецОбласти
