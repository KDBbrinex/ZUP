
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если НЕ Параметры.Ключ.Пустая() Тогда
		ПриПолученииДанныхНаСервере();
	КонецЕсли;
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	ПриПолученииДанныхНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	ХарактеристикиПерсоналаФормы.ПеренестиХарактеристикиВТабличнуюЧасть(ТекущийОбъект.ХарактеристикиПерсонала, Характеристики, ЗначенияХарактеристики);
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
	
	ХарактеристикиПерсоналаФормы.ОбработкаПроверкиЗаполненияТабличныхЧастейХарактеристик(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	
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

#Область ОбработчикиСобытийЭлементовТаблицыФормыХарактеристики

&НаКлиенте
Процедура ХарактеристикиПриИзменении(Элемент)
	
	Модифицированность = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ХарактеристикиПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	СтруктураЗначенийПоУмолчанию = Новый Структура;
	СтруктураЗначенийПоУмолчанию.Вставить("СтруктураЗначенийПоУмолчанию", Новый Структура("Вес", 1));
	
	ХарактеристикиПерсоналаКлиент.ОткрытьФормуДобавленияХарактеристик(
		ЭтаФорма,
		Копирование,
		Отказ,
		Новый ОписаниеОповещения("ДобавитьХарактеристикиПерсоналаНаКлиенте", ЭтотОбъект),
		СтруктураЗначенийПоУмолчанию);
		
КонецПроцедуры

&НаКлиенте
Процедура ХарактеристикиПередУдалением(Элемент, Отказ)
	ХарактеристикиПерсоналаКлиент.УдалитьЗначенияХарактеристик(ЭтаФорма, Элементы.Характеристики.ВыделенныеСтроки);
КонецПроцедуры

&НаКлиенте
Процедура ХарактеристикиВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле.Имя <> "ХарактеристикиЗначенияСтрокой" Тогда
		Возврат;
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	
	ТекущиеДанные = Элементы.Характеристики.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Или Не ЗначениеЗаполнено(ТекущиеДанные.Характеристика) Тогда
		Возврат;
	КонецЕсли;
	
	ХарактеристикиПерсоналаКлиент.ОткрытьНастройкуЗначенийХарактеристик(ЭтаФорма, ТекущиеДанные.Характеристика);
	
КонецПроцедуры

&НаКлиенте
Процедура ХарактеристикиПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	Если Элементы.Характеристики.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ХарактеристикаРедактируемойСтроки = Элементы.Характеристики.ТекущиеДанные.Характеристика;
	
КонецПроцедуры

&НаКлиенте
Процедура ХарактеристикиХарактеристикаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Характеристики.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЗаполнитьВидИКартинкаХарактеристикиНаСервере(ТекущиеДанные.ПолучитьИдентификатор());
	ХарактеристикиПерсоналаКлиент.ОбработатьИзменениеХарактеристики(ЭтаФорма, ТекущиеДанные);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.Свойства
&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
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

&НаКлиенте
Процедура ОткрытьПодборХарактеристикПерсонала(Команда)
	ХарактеристикиПерсоналаКлиент.ОткрытьФормуПодбораХарактеристик(ЭтаФорма, Истина, Новый ОписаниеОповещения("ДобавитьХарактеристикиПерсоналаНаКлиенте", ЭтотОбъект));
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

&НаСервере
Процедура ПриПолученииДанныхНаСервере()

	ХарактеристикиПерсоналаФормы.ПрочитатьХарактеристикиВТаблицы(Объект.ХарактеристикиПерсонала, Характеристики, ЗначенияХарактеристики);
	УстановитьСвойстваЭлементовФормы();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьСвойстваЭлементовФормы()

	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ГруппаХарактеристикиПерсонала",
		"ТолькоПросмотр",
		Не ПравоДоступа("Изменение", Метаданные.Справочники.КомпетенцииПерсонала));
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ХарактеристикиПерсоналаОткрытьПодборХарактеристикПерсонала",
		"Доступность",
		ПравоДоступа("Изменение", Метаданные.Справочники.КомпетенцииПерсонала));
		
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьХарактеристикиПерсоналаНаКлиенте(НовыеХарактеристики, ДополнительныеПараметры = Неопределено) Экспорт
	ДобавитьХарактеристикиПерсоналаНаСервере(НовыеХарактеристики, ДополнительныеПараметры);
КонецПроцедуры

&НаСервере
Процедура ДобавитьХарактеристикиПерсоналаНаСервере(НовыеХарактеристики, ДополнительныеПараметры)
	ХарактеристикиПерсоналаФормы.ДобавитьХарактеристикиВТабличнуюЧасть(ЭтаФорма, НовыеХарактеристики, ДополнительныеПараметры);
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьВидИКартинкаХарактеристикиНаСервере(Идентификатор)

	ТекущиеДанные = Характеристики.НайтиПоИдентификатору(Идентификатор);
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СтруктураРеквизитов = ХарактеристикиПерсонала.ВидИКартинкаХарактеристики(ТекущиеДанные.Характеристика);
	ТекущиеДанные.ВидХарактеристики = СтруктураРеквизитов.ВидХарактеристики;
	ТекущиеДанные.КартинкаВида = СтруктураРеквизитов.Картинка;

КонецПроцедуры

#КонецОбласти 
