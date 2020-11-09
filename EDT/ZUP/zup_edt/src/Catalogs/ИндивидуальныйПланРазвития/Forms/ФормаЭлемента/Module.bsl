
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Ключ.Пустая() Тогда
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
	ДополнительныеПараметры.Вставить("ОтложеннаяИнициализация", Истина);
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ПриПолученииДанныхНаСервере();
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
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

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ХарактеристикиПерсоналаФормы.ПеренестиХарактеристикиВТабличнуюЧасть(ТекущийОбъект.РазвиваемыеХарактеристики, Характеристики, ЗначенияХарактеристик);
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
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

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	ЗаполнитьВторичныеРеквизитыФормы();
КонецПроцедуры

#КонецОбласти 

#Область ОбработчикиСобытийЭлементовЭлементовФормы

&НаКлиенте
Процедура ВладелецПриИзменении(Элемент)
	ЗаполнитьХарактеристикиСотрудника();
КонецПроцедуры

&НаКлиенте
Процедура ОснованиеПриИзменении(Элемент)
	
	ЕстьЗаполненныеДанные = (Объект.Мероприятия.Количество() > 0) 
							ИЛИ (Объект.ДействияСотрудников.Количество() > 0)
							ИЛИ (Объект.РазвиваемыеХарактеристики.Количество() > 0);
	
	Если ЕстьЗаполненныеДанные Тогда
	
		ТекстВопроса = НСтр("ru = 'Заполнить ИПР по данным основания?'");
		ОбработчикОповещенияОЗакрытии = Новый ОписаниеОповещения("ЗаполнитьПоДаннымОснованияЗавершение", ЭтотОбъект);
		
		ПоказатьВопрос(
			ОбработчикОповещенияОЗакрытии,
			ТекстВопроса,
			РежимДиалогаВопрос.ДаНет,,
			КодВозвратаДиалога.Да,
			НСтр("ru = 'Продолжить?'"));
	Иначе
		ЗаполнитьПоДаннымОснованияЗавершение(КодВозвратаДиалога.Да);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КомментарийНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОбщегоНазначенияКлиент.ПоказатьФормуРедактированияКомментария(
		Элемент.ТекстРедактирования,
		ЭтотОбъект,
		"Объект.Комментарий");
		
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыМероприятия

&НаКлиенте
Процедура МероприятияВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле.Имя = "МероприятияСтрокаХарактеристик" Тогда
		ТекущиеДанные = Элементы.Мероприятия.ТекущиеДанные;
		Если ТекущиеДанные = Неопределено Или Не ЗначениеЗаполнено(ТекущиеДанные.Мероприятие) Тогда
			Возврат;
		КонецЕсли;
		
		СтруктураПараметров = Новый Структура;
		СтруктураПараметров.Вставить("Ключ", ТекущиеДанные.Мероприятие);
		СтруктураПараметров.Вставить("ОткрытьСписокХарактеристик", Истина);
		
	    ОткрытьФорму("Справочник.МероприятияОбученияРазвития.ФормаОбъекта", СтруктураПараметров, ЭтаФорма, УникальныйИдентификатор);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура МероприятияПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	Если НоваяСтрока Тогда
		Элемент.ТекущиеДанные.ДатаНачала = Объект.ДатаНачала;
		Элемент.ТекущиеДанные.ДатаОкончания = Объект.ДатаОкончания;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура МероприятияМероприятиеПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Мероприятия.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЗаполнитьВторичныеДанныеОбученияНаСервере(ТекущиеДанные.ПолучитьИдентификатор());
	
КонецПроцедуры

&НаКлиенте
Процедура ТаблицыСтраницаПриСменеСтраницы(Элемент, ТекущаяСтраница)
	
	// СтандартныеПодсистемы.Свойства
	Если ЭтотОбъект.ПараметрыСвойств.Свойство(ТекущаяСтраница.Имя)
		И Не ЭтотОбъект.ПараметрыСвойств.ВыполненаОтложеннаяИнициализация Тогда
		
		СвойстваВыполнитьОтложеннуюИнициализацию();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

#КонецОбласти 

#Область ОбработчикиСобытийЭлементовТаблицыФормыХарактеристики

&НаКлиенте
Процедура ХарактеристикиТребуетсяОбучениеПриИзменении(Элемент)
	ХарактеристикиТребуетсяОбучениеПриИзмененииНаКлиенте();
КонецПроцедуры

#КонецОбласти 

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОткрытьПодборПрограммыОбученияПоХарактеристикам(Команда)
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("АдресХарактеристикПерсонала", АдресХарактеристикПерсонала());
	СтруктураПараметров.Вставить("АдресПрограммыОбучения", АдресПрограммыОбучения());
	
	ОбучениеРазвитиеКлиент.ОткрытьФормуПодбораПрограммыОбучения(
		ЭтаФорма,
		Новый Структура("ПараметрыФормыПодбора", СтруктураПараметров),
		Новый ОписаниеОповещения("ЗагрузитьПрограммуОбученияНаКлиенте", ЭтотОбъект));
	
КонецПроцедуры

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

// СтандартныеПодсистемы.Свойства
&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

#КонецОбласти 

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПриПолученииДанныхНаСервере()
	
	ОбучениеРазвитиеФормы.ЗаполнитьКэшХарактеристикиМероприятияПоХарактеристикам(КэшХарактеристикиМероприятия, Объект.РазвиваемыеХарактеристики.Выгрузить(, "Характеристика").ВыгрузитьКолонку("Характеристика"));
	ЗаполнитьВторичныеРеквизитыФормы();

КонецПроцедуры	
	
&НаСервере
Процедура ЗаполнитьВторичныеРеквизитыФормы()
	
	ЗаполнитьВторичнуюТаблицуХарактеристики();
	ЗаполнитьВторичнуюИнформациюПланаОбучения();

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьВторичнуюТаблицуХарактеристики()
	
	ХарактеристикиПерсоналаФормы.ПрочитатьХарактеристикиВТаблицы(Объект.РазвиваемыеХарактеристики, Характеристики, ЗначенияХарактеристик);
	ДополнитьХарактеристикиДаннымиХарактеристикСотрудника();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьВторичнуюИнформациюПланаОбучения()
	
	ОбучениеРазвитиеФормы.ЗаполнитьСтрокиХарактеристикВТаблицеПрограммаОбучения(Объект.Мероприятия, Объект.РазвиваемыеХарактеристики, КэшХарактеристикиМероприятия);
	ОбучениеРазвитиеФормы.ЗаполнитьУчебныеЧасыПланаОбучения(ЭтаФорма,, "Объект.Мероприятия");
	
КонецПроцедуры

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

&НаСервере
Процедура СвойстваВыполнитьОтложеннуюИнициализацию()
	УправлениеСвойствами.ЗаполнитьДополнительныеРеквизитыВФорме(ЭтотОбъект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

&НаКлиенте
Процедура ЗаполнитьПоДаннымОснованияЗавершение(Результат = Неопределено, ДополнительныеПараметры = Неопределено) Экспорт

	Если Результат <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;

	ЗаполнитьПоДаннымОснования();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьХарактеристикиСотрудника()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ХарактеристикиФизическихЛиц.ХарактеристикаПерсонала КАК Характеристика,
		|	ХарактеристикиФизическихЛиц.ЗначениеХарактеристики КАК ЗначениеХарактеристикиСотрудника,
		|	ХарактеристикиФизическихЛиц.Балл КАК БаллХарактеристикиСотрудника
		|ПОМЕСТИТЬ ВТХарактеристикиСотрудника
		|ИЗ
		|	РегистрСведений.ХарактеристикиФизическихЛиц КАК ХарактеристикиФизическихЛиц
		|ГДЕ
		|	ХарактеристикиФизическихЛиц.ФизическоеЛицо = &ФизическоеЛицо
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТХарактеристикиСотрудника.Характеристика КАК Характеристика,
		|	МАКСИМУМ(ВТХарактеристикиСотрудника.БаллХарактеристикиСотрудника) КАК БаллХарактеристикиСотрудника
		|ПОМЕСТИТЬ ВТУказателиМаксимальныхБаллов
		|ИЗ
		|	ВТХарактеристикиСотрудника КАК ВТХарактеристикиСотрудника
		|
		|СГРУППИРОВАТЬ ПО
		|	ВТХарактеристикиСотрудника.Характеристика
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТХарактеристикиСотрудника.Характеристика КАК Характеристика,
		|	МАКСИМУМ(ВТХарактеристикиСотрудника.ЗначениеХарактеристикиСотрудника) КАК Значение,
		|	ВТХарактеристикиСотрудника.БаллХарактеристикиСотрудника КАК БаллХарактеристики
		|ИЗ
		|	ВТХарактеристикиСотрудника КАК ВТХарактеристикиСотрудника
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТУказателиМаксимальныхБаллов КАК ВТУказателиМаксимальныхБаллов
		|		ПО ВТХарактеристикиСотрудника.Характеристика = ВТУказателиМаксимальныхБаллов.Характеристика
		|			И ВТХарактеристикиСотрудника.БаллХарактеристикиСотрудника = ВТУказателиМаксимальныхБаллов.БаллХарактеристикиСотрудника
		|
		|СГРУППИРОВАТЬ ПО
		|	ВТХарактеристикиСотрудника.Характеристика,
		|	ВТХарактеристикиСотрудника.БаллХарактеристикиСотрудника";
	
	Запрос.УстановитьПараметр("ФизическоеЛицо", Объект.Владелец);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Объект.ХарактеристикиСотрудника.Загрузить(РезультатЗапроса.Выгрузить());
	
	ДополнитьХарактеристикиДаннымиХарактеристикСотрудника();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПоДаннымОснования()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	КадровыйРезервДействияСотрудников.ДействиеСотрудника КАК ДействиеСотрудника
		|ИЗ
		|	Справочник.КадровыйРезерв.ДействияСотрудников КАК КадровыйРезервДействияСотрудников
		|ГДЕ
		|	КадровыйРезервДействияСотрудников.Ссылка = &Основание
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	КадровыйРезервХарактеристикиПерсонала.Характеристика КАК Характеристика,
		|	КадровыйРезервХарактеристикиПерсонала.Значение КАК Значение,
		|	ИСТИНА КАК ТребуетсяОбучение
		|ИЗ
		|	Справочник.КадровыйРезерв.ХарактеристикиПерсонала КАК КадровыйРезервХарактеристикиПерсонала
		|ГДЕ
		|	КадровыйРезервХарактеристикиПерсонала.Ссылка = &Основание
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	КадровыйРезерв.РазмерностьПродолжительностиПланаОбучения КАК РазмерностьПродолжительностиПланаОбучения
		|ИЗ
		|	Справочник.КадровыйРезерв КАК КадровыйРезерв
		|ГДЕ
		|	КадровыйРезерв.Ссылка = &Основание
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	КадровыйРезервПрограммаОбучения.Мероприятие.ВидМероприятия КАК ВидМероприятия,
		|	КадровыйРезервПрограммаОбучения.Мероприятие КАК Мероприятие,
		|	КадровыйРезервПрограммаОбучения.Ответственный КАК Ответственный,
		|	КадровыйРезервПрограммаОбучения.Начало КАК Начало,
		|	КадровыйРезервПрограммаОбучения.Окончание КАК Окончание
		|ИЗ
		|	Справочник.КадровыйРезерв.ПрограммаОбучения КАК КадровыйРезервПрограммаОбучения
		|ГДЕ
		|	КадровыйРезервПрограммаОбучения.Ссылка = &Основание";
	
	Запрос.УстановитьПараметр("Основание", Объект.Основание);
	
	РезультатыЗапроса = Запрос.ВыполнитьПакет();
	
	РезультатыДействия = РезультатыЗапроса[РезультатыЗапроса.Количество() - 4];
	РезультатыХарактеристики = РезультатыЗапроса[РезультатыЗапроса.Количество() - 3];
	РезультатыПараметрыПрограммы = РезультатыЗапроса[РезультатыЗапроса.Количество() - 2];
	РезультатыПрограмма = РезультатыЗапроса[РезультатыЗапроса.Количество() - 1];
	
	// Действия.
	Объект.ДействияСотрудников.Загрузить(РезультатыДействия.Выгрузить());
	
	// Характеристики.
	Объект.РазвиваемыеХарактеристики.Загрузить(РезультатыХарактеристики.Выгрузить());
	ЗаполнитьВторичнуюТаблицуХарактеристики();
	
	// План обучения.
	ПланОбучения = РезультатыПрограмма.Выгрузить();
	Объект.Мероприятия.Загрузить(ПланОбучения);
	
	ВыборкаПараметры = РезультатыПараметрыПрограммы.Выбрать();
	ВыборкаПараметры.Следующий();
	ПланОбученияСДатами = ОбучениеРазвитие.ПрограммаОбученияПоДатам(Объект.ДатаНачала, ПланОбучения, ВыборкаПараметры.РазмерностьПродолжительностиПланаОбучения);
	
	Для каждого СтрокаМероприятия Из Объект.Мероприятия Цикл
		НайденныеСтроки = ПланОбученияСДатами.НайтиСтроки(Новый Структура("Мероприятие", СтрокаМероприятия.Мероприятие));
		Если НайденныеСтроки.Количество() = 0 Тогда
			Продолжить;
		КонецЕсли;
		ЗаполнитьЗначенияСвойств(СтрокаМероприятия, НайденныеСтроки[0],"ДатаНачала, ДатаОкончания");
	КонецЦикла; 
	
	ОбучениеРазвитиеФормы.ЗаполнитьКэшХарактеристикиМероприятияПоХарактеристикам(КэшХарактеристикиМероприятия, Объект.ХарактеристикиСотрудника.Выгрузить(, "Характеристика").ВыгрузитьКолонку("Характеристика"));
	
	ЗаполнитьВторичнуюИнформациюПланаОбучения();
			
КонецПроцедуры

&НаСервере
Процедура ДополнитьХарактеристикиДаннымиХарактеристикСотрудника()

	Для каждого СтрокаХарактеристик Из Характеристики Цикл
		НайденныеСтроки = Объект.ХарактеристикиСотрудника.НайтиСтроки(Новый Структура("Характеристика", СтрокаХарактеристик.Характеристика));
		Если НайденныеСтроки.Количество() = 0 Тогда
			Продолжить;
		КонецЕсли;
		СтрокаХарактеристик.ЗначениеХарактеристикиСотрудника = НайденныеСтроки[0].Значение;
		СтрокаХарактеристик.БаллХарактеристикиСотрудника = НайденныеСтроки[0].БаллХарактеристики;
	КонецЦикла; 

КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьПрограммуОбученияНаКлиенте(Результат, ДополнительныеПараметры = Неопределено) Экспорт
	ЗагрузитьПрограммуОбученияНаСервере(Результат, ДополнительныеПараметры);
КонецПроцедуры
	
&НаСервере
Процедура ЗагрузитьПрограммуОбученияНаСервере(Результат, ДополнительныеПараметры)
	
	ОбучениеРазвитиеФормы.ЗагрузитьПрограммуОбучения(ЭтаФорма, Результат, "Объект.Мероприятия");
	ОбучениеРазвитиеФормы.ЗаполнитьСтрокиХарактеристикВТаблицеПрограммаОбучения(Объект.Мероприятия, Объект.РазвиваемыеХарактеристики, КэшХарактеристикиМероприятия);
	
КонецПроцедуры

&НаСервере
Функция АдресХарактеристикПерсонала()
	Возврат ПоместитьВоВременноеХранилище(Характеристики.Выгрузить(, "Характеристика,КартинкаВида,ТребуетсяОбучение"), УникальныйИдентификатор);
КонецФункции

&НаСервере
Функция АдресПрограммыОбучения()
	Возврат ПоместитьВоВременноеХранилище(Объект.Мероприятия.Выгрузить(, "Мероприятие,Ответственный"), УникальныйИдентификатор);
КонецФункции

&НаКлиенте
Процедура ХарактеристикиТребуетсяОбучениеПриИзмененииНаКлиенте()

	ХарактеристикиТребуетсяОбучениеПриИзмененииНаСервере();
	
	СтрокиСУдаленнымиМероприятиями = Новый Массив;
	Для каждого СтрокаМероприятия Из Объект.Мероприятия Цикл
		Если СтрокаМероприятия.СтрокаХарактеристикОчистилась Тогда
			СтрокиСУдаленнымиМероприятиями.Добавить(СтрокаМероприятия);
		КонецЕсли;
	КонецЦикла; 
	
	Если СтрокиСУдаленнымиМероприятиями.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ОповещениеОЗакрытии = Новый ОписаниеОповещения("УдалитьВыбранноеМероприятиеЗавершение", ЭтотОбъект, Новый Структура("СтрокиСУдаленнымиМероприятиями", СтрокиСУдаленнымиМероприятиями));
	
	ТекстВопроса = ТекстВопросаУдаления(СтрокиСУдаленнымиМероприятиями);
	СписокКнопок = Новый СписокЗначений;
	СписокКнопок.Добавить(КодВозвратаДиалога.Да, НСтр("ru = 'Да, исключить'"));
	СписокКнопок.Добавить(КодВозвратаДиалога.Нет, НСтр("ru = 'Нет, оставить'"));
	
	ПоказатьВопрос(ОповещениеОЗакрытии, ТекстВопроса, СписокКнопок,, КодВозвратаДиалога.Да);
		
КонецПроцедуры

&НаКлиенте
Функция ТекстВопросаУдаления(СтрокиСУдаленнымиМероприятиями)

	Если СтрокиСУдаленнымиМероприятиями.Количество() = 1 Тогда
		
		Возврат СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Не осталось характеристик, которое развивает мероприятие ""%1"".
								|Исключить его из программы обучения?'"),
			СтрокиСУдаленнымиМероприятиями[0].Мероприятие);
		
	Иначе
		
		ТекстМероприятий = "";
		Для каждого СтрокаУдаляемогоМероприятия Из СтрокиСУдаленнымиМероприятиями Цикл
			ТекстМероприятий = ТекстМероприятий + ?(ТекстМероприятий = "", "", ", ") + """" + СтрокаУдаляемогоМероприятия.Мероприятие + """";
		КонецЦикла; 
		
		Возврат СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Не осталось характеристик, которые развивают мероприятия ""%1"".
								|Исключить их из программы обучения?'"),
			ТекстМероприятий);
			
	КонецЕсли;
	
КонецФункции

&НаСервере
Процедура ХарактеристикиТребуетсяОбучениеПриИзмененииНаСервере()
	ОбучениеРазвитиеФормы.ЗаполнитьСтрокиХарактеристикВТаблицеПрограммаОбучения(Объект.Мероприятия, Характеристики, КэшХарактеристикиМероприятия, Истина);
КонецПроцедуры

&НаКлиенте
Процедура УдалитьВыбранноеМероприятиеЗавершение(Результат = Неопределено, ДополнительныеПараметры = Неопределено) Экспорт

	Если Результат <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;

	Если ДополнительныеПараметры = Неопределено ИЛИ НЕ ДополнительныеПараметры.Свойство("СтрокиСУдаленнымиМероприятиями") Тогда
		Возврат;
	КонецЕсли;
	
	Для каждого УдаляемаяСтрока Из ДополнительныеПараметры.СтрокиСУдаленнымиМероприятиями Цикл
		Объект.Мероприятия.Удалить(УдаляемаяСтрока);
	КонецЦикла; 
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьВторичныеДанныеОбученияНаСервере(ИдентификаторТекущейСтроки)
	ОбучениеРазвитиеФормы.ЗаполнитьУчебныеЧасыПланаОбучения(ЭтаФорма, ИдентификаторТекущейСтроки, "Объект.Мероприятия");
	ОбучениеРазвитиеФормы.ЗаполнитьОтветственногоВСтрокеПрограммыОбучения(ЭтаФорма, ИдентификаторТекущейСтроки, "Объект.Мероприятия");
КонецПроцедуры

#КонецОбласти 

