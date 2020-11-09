
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// ЗарплатаКадрыПодсистемы.ПодписиДокументов
	ПодписиДокументов.ПриСозданииНаСервере(ЭтаФорма);
	// Конец ЗарплатаКадрыПодсистемы.ПодписиДокументов
	
	Если Параметры.Ключ.Пустая() Тогда
		// Создается новый документ.
		ЗначенияДляЗаполнения = Новый Структура("Организация, Ответственный", "Объект.Организация", "Объект.Ответственный");
		ЗарплатаКадры.ЗаполнитьПервоначальныеЗначенияВФорме(ЭтаФорма, ЗначенияДляЗаполнения);
		ЗаполнитьДанныеФормыПоОрганизации();
		ЗаполнитьПериодСуммированногоУчетаПоПрошлымДокументам();
	КонецЕсли;
	
	ПриПолученииДанныхНаСервере();
	
	// Обработчик подсистемы "ВерсионированиеОбъектов".
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтаФорма);
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ГосударственнаяСлужба") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("ГосударственнаяСлужбаФормы");
		Модуль.УстановитьПараметрыВыбораСотрудников(ЭтаФорма, "СотрудникиСотрудник");
	КонецЕсли; 
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
	// ПроцессыОбработкиДокументов
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ПроцессыОбработкиДокументовЗарплата") Тогда
		МодульПроцессыОбработкиДокументовЗарплата = ОбщегоНазначения.ОбщийМодуль("ПроцессыОбработкиДокументовЗарплата");
		МодульПроцессыОбработкиДокументовЗарплата.ПриСозданииНаСервере(ЭтотОбъект, Объект);
	КонецЕсли;	
	// Конец ПроцессыОбработкиДокументов
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.КонтрольВеденияУчета
	КонтрольВеденияУчетаБЗК.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.КонтрольВеденияУчета
	
	// ПроцессыОбработкиДокументов
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ПроцессыОбработкиДокументовЗарплата") Тогда
		МодульПроцессыОбработкиДокументовЗарплата = ОбщегоНазначения.ОбщийМодуль("ПроцессыОбработкиДокументовЗарплата");
		МодульПроцессыОбработкиДокументовЗарплата.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;	
	// Конец ПроцессыОбработкиДокументов
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	ДанныеФормыВОбъект();
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	// ЗарплатаКадрыПодсистемы.ПодписиДокументов
	ПодписиДокументов.ПослеЗаписиНаСервере(ЭтаФорма);
	// Конец ЗарплатаКадрыПодсистемы.ПодписиДокументов
	
	// СтандартныеПодсистемы.КонтрольВеденияУчета
	КонтрольВеденияУчетаБЗК.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.КонтрольВеденияУчета
	
	ЗаполнитьВторичныеДанныеФормы();
	ПерерасчетЗарплаты.РегистрацияПерерасчетовПоПредварительнымДаннымВФоне(ТекущийОбъект.Ссылка);
	
	// ПроцессыОбработкиДокументов
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ПроцессыОбработкиДокументовЗарплата") Тогда
		МодульПроцессыОбработкиДокументовЗарплата = ОбщегоНазначения.ОбщийМодуль("ПроцессыОбработкиДокументовЗарплата");
		МодульПроцессыОбработкиДокументовЗарплата.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	КонецЕсли;	
	// Конец ПроцессыОбработкиДокументов
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	// ПроцессыОбработкиДокументов
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ПроцессыОбработкиДокументовЗарплата") Тогда
		МодульПроцессыОбработкиДокументовЗарплата = ОбщегоНазначенияКлиент.ОбщийМодуль("ПроцессыОбработкиДокументовЗарплатаКлиент");
		МодульПроцессыОбработкиДокументовЗарплата.ПередЗакрытием(ЭтотОбъект, Объект, Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	КонецЕсли;	
	// Конец ПроцессыОбработкиДокументов
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	Оповестить("Запись_РегистрацияПереработок", ПараметрыЗаписи, Объект.Ссылка);
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
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	// ПроцессыОбработкиДокументов
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ПроцессыОбработкиДокументовЗарплата") Тогда
		МодульПроцессыОбработкиДокументовЗарплата = ОбщегоНазначения.ОбщийМодуль("ПроцессыОбработкиДокументовЗарплата");
		МодульПроцессыОбработкиДокументовЗарплата.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи, Отказ);
	КонецЕсли;		
	// Конец ПроцессыОбработкиДокументов
	
КонецПроцедуры
	
&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры
	
#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

#Область ПериодСуммированногоУчетаНачало

&НаКлиенте
Процедура ПериодСуммированногоУчетаНачалоПриИзменении(Элемент)
	ЗарплатаКадрыКлиент.ВводМесяцаПриИзменении(ЭтаФорма, "Объект.ПериодСуммированногоУчетаНачало", "МесяцНачалаСтрокой", Модифицированность);
КонецПроцедуры

&НаКлиенте
Процедура ПериодСуммированногоУчетаНачалоНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаНачалоВыбора(ЭтаФорма, ЭтаФорма, "Объект.ПериодСуммированногоУчетаНачало", "МесяцНачалаСтрокой");
КонецПроцедуры

&НаКлиенте
Процедура ПериодСуммированногоУчетаНачалоРегулирование(Элемент, Направление, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаРегулирование(ЭтаФорма, "Объект.ПериодСуммированногоУчетаНачало", "МесяцНачалаСтрокой", Направление, Модифицированность);
КонецПроцедуры

&НаКлиенте
Процедура ПериодСуммированногоУчетаНачалоАвтоПодбор(Элемент, Текст, ДанныеВыбора, Параметры, Ожидание, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаАвтоПодборТекста(Текст, ДанныеВыбора, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ПериодСуммированногоУчетаНачалоОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, Параметры, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаОкончаниеВводаТекста(Текст, ДанныеВыбора, СтандартнаяОбработка);
КонецПроцедуры

#КонецОбласти

#Область ПериодСуммированногоУчетаОкончание

&НаКлиенте
Процедура ПериодСуммированногоУчетаОкончаниеПриИзменении(Элемент)
	ЗарплатаКадрыКлиент.ВводМесяцаПриИзменении(ЭтаФорма, "Объект.ПериодСуммированногоУчетаОкончание", "МесяцОкончанияСтрокой", Модифицированность);
КонецПроцедуры

&НаКлиенте
Процедура ПериодСуммированногоУчетаОкончаниеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаНачалоВыбора(ЭтаФорма, ЭтаФорма, "Объект.ПериодСуммированногоУчетаОкончание", "МесяцОкончанияСтрокой");
КонецПроцедуры

&НаКлиенте
Процедура ПериодСуммированногоУчетаОкончаниеРегулирование(Элемент, Направление, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаРегулирование(ЭтаФорма, "Объект.ПериодСуммированногоУчетаОкончание", "МесяцОкончанияСтрокой", Направление, Модифицированность);
КонецПроцедуры

&НаКлиенте
Процедура ПериодСуммированногоУчетаОкончаниеАвтоПодбор(Элемент, Текст, ДанныеВыбора, Параметры, Ожидание, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаАвтоПодборТекста(Текст, ДанныеВыбора, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ПериодСуммированногоУчетаОкончаниеОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, Параметры, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаОкончаниеВводаТекста(Текст, ДанныеВыбора, СтандартнаяОбработка);
КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	ЗарплатаКадрыКлиент.КлючевыеРеквизитыЗаполненияФормыОчиститьТаблицы(ЭтаФорма);
	ОрганизацияПриИзмененииНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ДатаПриИзменении(Элемент)
	ЗаполнитьДанныеФормыПоОрганизации();
КонецПроцедуры

&НаКлиенте
Процедура ПодразделениеПриИзменении(Элемент)
	ЗарплатаКадрыКлиент.КлючевыеРеквизитыЗаполненияФормыОчиститьТаблицы(ЭтаФорма);
КонецПроцедуры

// Обработчик подсистемы "ПодписиДокументов".
&НаКлиенте
Процедура Подключаемый_ПодписиДокументовЭлементПриИзменении(Элемент) 
	ПодписиДокументовКлиент.ПриИзмененииПодписывающегоЛица(ЭтаФорма, Элемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПодписиДокументовЭлементНажатие(Элемент) 
	ПодписиДокументовКлиент.РасширеннаяПодсказкаНажатие(ЭтаФорма, Элемент.Имя);
КонецПроцедуры
// Конец Обработчик подсистемы "ПодписиДокументов".

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСотрудники

&НаКлиенте
Процедура СотрудникиОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	ДобавитьВыбранныхСотрудников(ВыбранноеЗначение);
КонецПроцедуры

&НаКлиенте
Процедура СотрудникиПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	Если НоваяСтрока Тогда
		Элемент.ТекущиеДанные.СпособКомпенсацииПереработки = ПредопределенноеЗначение("Перечисление.СпособыКомпенсацииПереработки.ПовышеннаяОплата");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СотрудникиНормаЧасовПриИзменении(Элемент)
	ПосчитатьКоличествоСверхурочныхЧасовНаКлиенте(Элементы.Сотрудники.ТекущиеДанные);
КонецПроцедуры

&НаКлиенте
Процедура СотрудникиОтработаноЧасовВПраздникиПриИзменении(Элемент)
	ПосчитатьКоличествоСверхурочныхЧасовНаКлиенте(Элементы.Сотрудники.ТекущиеДанные);
КонецПроцедуры

&НаКлиенте
Процедура СотрудникиОтработаноЧасовПриИзменении(Элемент)
	ПосчитатьКоличествоСверхурочныхЧасовНаКлиенте(Элементы.Сотрудники.ТекущиеДанные);
КонецПроцедуры

&НаКлиенте
Процедура СотрудникиСотрудникПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Сотрудники.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	РассчитатьСотрудников(ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ТекущиеДанные.Сотрудник));
	
КонецПроцедуры

&НаКлиенте
Процедура СотрудникиПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Если Копирование Тогда
		ОчиститьСтроку(Элемент.ТекущиеДанные);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СотрудникиСверхурочно1_5ПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Сотрудники.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	РассчитатьСверхурочные(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура СотрудникиСверхурочно2ПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Сотрудники.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	РассчитатьСверхурочные(ТекущиеДанные, Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура СотрудникиСверхурочно0ПриИзменении(Элемент)
	ПосчитатьКоличествоСверхурочныхЧасовНаКлиенте(Элементы.Сотрудники.ТекущиеДанные);
КонецПроцедуры

&НаКлиенте
Процедура СотрудникиСпособКомпенсацииПереработкиПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Сотрудники.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТекущиеДанные.Сверхурочно1_5 = 0;
	ТекущиеДанные.Сверхурочно2 = 0;
	РассчитатьВсего(ТекущиеДанные);
	
	Если ТекущиеДанные.СпособКомпенсацииПереработки = ПредопределенноеЗначение("Перечисление.СпособыКомпенсацииПереработки.ПовышеннаяОплата") Тогда
		ТекущиеДанные.Сверхурочно1_5 = ТекущиеДанные.Всего;
	Иначе
		ТекущиеДанные.Сверхурочно2 = ТекущиеДанные.Всего;
	КонецЕсли;
	РассчитатьСверхурочные(ТекущиеДанные);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.Свойства
&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

#Область ОбработчикиСобытийПроцессыОбработкиДокументов

&НаКлиенте
Процедура Подключаемый_ВыполнитьЗадачуПоОбработкеДокумента(Команда)
	// ПроцессыОбработкиДокументов
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ПроцессыОбработкиДокументовЗарплата") Тогда
		МодульПроцессыОбработкиДокументовЗарплата = ОбщегоНазначенияКлиент.ОбщийМодуль("ПроцессыОбработкиДокументовЗарплатаКлиент");
		МодульПроцессыОбработкиДокументовЗарплата.ВыполнитьЗадачу(ЭтотОбъект, Команда, Объект)
	КонецЕсли;		
	// Конец ПроцессыОбработкиДокументов
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьЗадачуПоОбработкеДокументаОповещение(Контекст, ДополнительныеПараметры) Экспорт
	ВыполнитьЗадачуПоОбработкеДокументаНаСервере(Контекст);
	ВыполнитьОбработкуОповещения(ДополнительныеПараметры, Контекст);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьЗадачуПоОбработкеДокументаНаСервере(Контекст)
	// ПроцессыОбработкиДокументов
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ПроцессыОбработкиДокументовЗарплата") Тогда	
		МодульПроцессыОбработкиДокументовЗарплата = ОбщегоНазначения.ОбщийМодуль("ПроцессыОбработкиДокументовЗарплата");
		МодульПроцессыОбработкиДокументовЗарплата.ВыполнитьЗадачу(ЭтотОбъект, Контекст, Объект);
	КонецЕсли;		
	// Конец ПроцессыОбработкиДокументов
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КомментарийНаправившегоОткрытие(Элемент, СтандартнаяОбработка)
	// ПроцессыОбработкиДокументов
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ПроцессыОбработкиДокументовЗарплата") Тогда	
		МодульПроцессыОбработкиДокументовЗарплата = ОбщегоНазначенияКлиент.ОбщийМодуль("ПроцессыОбработкиДокументовЗарплатаКлиент");
		МодульПроцессыОбработкиДокументовЗарплата.КомментарийНаправившегоОткрытие(ЭтотОбъект, Элемент, СтандартнаяОбработка);
	КонецЕсли;		
	// Конец ПроцессыОбработкиДокументов
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КомментарийСледующемуНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	// ПроцессыОбработкиДокументов
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ПроцессыОбработкиДокументовЗарплата") Тогда	
		МодульПроцессыОбработкиДокументовЗарплата = ОбщегоНазначенияКлиент.ОбщийМодуль("ПроцессыОбработкиДокументовЗарплатаКлиент");
		МодульПроцессыОбработкиДокументовЗарплата.КомментарийСледующемуНачалоВыбора(ЭтотОбъект, Элемент, ДанныеВыбора, СтандартнаяОбработка);
	КонецЕсли;		
	// Конец ПроцессыОбработкиДокументов
КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура Заполнить(Команда)
	ЗаполнитьСотрудниковНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПодобратьСотрудников(Команда)
	
	ПараметрыОткрытия = Неопределено;
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ГосударственнаяСлужба") Тогда
		Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("ГосударственнаяСлужбаКлиент");
		Модуль.УточнитьПараметрыОткрытияФормыВыбораСотрудников(ПараметрыОткрытия);
	КонецЕсли; 
		
	КадровыйУчетКлиент.ВыбратьСотрудниковРаботающихНаДатуПоПараметрамОткрытияФормыСписка(
		Элементы.Сотрудники,
		Объект.Организация,
		Объект.Подразделение,
		Объект.Дата,
		,
		АдресСпискаПодобранныхСотрудников(),
		ПараметрыОткрытия);
		
КонецПроцедуры

&НаКлиенте
Процедура ПересчитатьСотрудника(Команда)
	
	ТекущиеДанные = Элементы.Сотрудники.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	РассчитатьСотрудников(ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ТекущиеДанные.Сотрудник));
	
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

// СтандартныеПодсистемы.КонтрольВеденияУчета

&НаКлиенте
Процедура Подключаемый_ОткрытьОтчетПоПроблемам(ЭлементИлиКоманда, НавигационнаяСсылка, СтандартнаяОбработка)
	
	КонтрольВеденияУчетаКлиентБЗК.ОткрытьОтчетПоПроблемамОбъекта(ЭтотОбъект, Объект.Ссылка, СтандартнаяОбработка);
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.КонтрольВеденияУчета

&НаСервере
Процедура ПриПолученииДанныхНаСервере()
	
	ЗарплатаКадрыКлиентСервер.ЗаполнитьМесяцПоДате(ЭтаФорма, "Объект.ПериодСуммированногоУчетаНачало", "МесяцНачалаСтрокой");
	ЗарплатаКадрыКлиентСервер.ЗаполнитьМесяцПоДате(ЭтаФорма, "Объект.ПериодСуммированногоУчетаОкончание", "МесяцОкончанияСтрокой");
	
	// заполним предупреждения 
	ЗарплатаКадры.КлючевыеРеквизитыЗаполненияФормыЗаполнитьПредупреждения(ЭтаФорма);
	ЗарплатаКадрыКлиентСервер.КлючевыеРеквизитыЗаполненияФормыУстановитьОтображениеПредупреждения(ЭтаФорма);
	
	ЗаполнитьВторичныеДанныеФормы();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьВторичныеДанныеФормы()
	ЗаполнитьСотрудниковФормы();
КонецПроцедуры

&НаСервере
Процедура ДанныеФормыВОбъект()

	Для каждого Сотрудник Из Объект.Сотрудники Цикл
		Если Сотрудник.СпособКомпенсацииПереработки = ПредопределенноеЗначение("Перечисление.СпособыКомпенсацииПереработки.Отгул") Тогда
			Сотрудник.Сверхурочно1_5 = 0;
			Сотрудник.Сверхурочно2 = Сотрудник.Всего;
		КонецЕсли;
	КонецЦикла; 

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСотрудниковФормы()

	Для каждого Сотрудник Из Объект.Сотрудники Цикл
		Если Сотрудник.СпособКомпенсацииПереработки = ПредопределенноеЗначение("Перечисление.СпособыКомпенсацииПереработки.Отгул") Тогда
			Сотрудник.Всего = Сотрудник.Сверхурочно2;
		Иначе
			РассчитатьВсего(Сотрудник);
		КонецЕсли;
	КонецЦикла; 

КонецПроцедуры

&НаСервере
Функция АдресСпискаПодобранныхСотрудников()
	Возврат ПоместитьВоВременноеХранилище(Объект.Сотрудники.Выгрузить(,"Сотрудник").ВыгрузитьКолонку("Сотрудник"), УникальныйИдентификатор);
КонецФункции

&НаСервере
Процедура ДобавитьВыбранныхСотрудников(ВыбранныеСотрудники)

	Для каждого ВыбранныйСотрудник Из ВыбранныеСотрудники Цикл
		НайденныеСотрудники = Объект.Сотрудники.НайтиСтроки(Новый Структура("Сотрудник", ВыбранныйСотрудник));
		Если НайденныеСотрудники.Количество()=0 Тогда
			НовыйСотрудник = Объект.Сотрудники.Добавить();
			НовыйСотрудник.Сотрудник = ВыбранныйСотрудник;
			НовыйСотрудник.СпособКомпенсацииПереработки = ПредопределенноеЗначение("Перечисление.СпособыКомпенсацииПереработки.ПовышеннаяОплата");
			
			РассчитатьСотрудников(ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ВыбранныйСотрудник));
			
		КонецЕсли; 
	КонецЦикла; 

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПериодСуммированногоУчетаПоПрошлымДокументам()
	ПериодСуммированногоУчета = УчетРабочегоВремениРасширенный.ПериодСуммированногоУчетаПоПрошлымДокументам(Объект.Организация, Объект.Дата);
	Если ПериодСуммированногоУчета <> Неопределено Тогда
		ЗаполнитьЗначенияСвойств(Объект, ПериодСуммированногоУчета);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСотрудниковНаСервере()
	
	// Получаем список сотрудников, работавших на суммированном учете в этот период.
	МассивСотрудников = ЗаполнитьСотрудников();
	РассчитатьСотрудников(МассивСотрудников, Истина);
	
КонецПроцедуры

&НаСервере
Процедура РассчитатьСотрудников(МассивСотрудников, Очищать = Ложь)

	ТаблицаСотрудников = РасчетЗарплатыРасширенный.ПоказателиСуммированногоУчетаСотрудниковЗаПериод(
		МассивСотрудников,
		НачалоМесяца(Объект.ПериодСуммированногоУчетаНачало),
		КонецМесяца(Объект.ПериодСуммированногоУчетаОкончание));
		
	Если Очищать Тогда
		Объект.Сотрудники.Очистить();
		Для каждого Сотрудник Из ТаблицаСотрудников Цикл
			Если (Сотрудник.ОтработаноЧасов - Сотрудник.НормаЧасов) <= 0 Тогда
				Продолжить;
			КонецЕсли;
			НоваяСтрока = Объект.Сотрудники.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, Сотрудник);
			НоваяСтрока.Сверхурочно0 = Сотрудник.ОтработаноЧасовВПраздники;
			НоваяСтрока.СпособКомпенсацииПереработки = ПредопределенноеЗначение("Перечисление.СпособыКомпенсацииПереработки.ПовышеннаяОплата");
			ПосчитатьПоказателиСтроки(НоваяСтрока);
		КонецЦикла; 
	Иначе
		Для каждого Сотрудник Из МассивСотрудников Цикл
			РассчитанныйСотрудник = ТаблицаСотрудников.НайтиСтроки(Новый Структура("Сотрудник", Сотрудник))[0];
			СтрокаСотрудник = Объект.Сотрудники.НайтиСтроки(Новый Структура("Сотрудник", Сотрудник));
			Если СтрокаСотрудник.Количество() > 0 Тогда
				ТекущиеДанные = СтрокаСотрудник[0];
				ЗаполнитьЗначенияСвойств(ТекущиеДанные, РассчитанныйСотрудник);
				ТекущиеДанные.СпособКомпенсацииПереработки = ПредопределенноеЗначение("Перечисление.СпособыКомпенсацииПереработки.ПовышеннаяОплата");
				ТекущиеДанные.Сверхурочно0 = РассчитанныйСотрудник.ОтработаноЧасовВПраздники;
				ПосчитатьПоказателиСтроки(ТекущиеДанные);
			КонецЕсли;
		КонецЦикла; 
	КонецЕсли;

КонецПроцедуры

&НаСервере
Функция ЗаполнитьСотрудников()
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	ПараметрыПолученияРабочихМест = КадровыйУчет.ПараметрыДляЗапросВТРабочиеМестаСотрудниковПоСпискуСотрудников();
	ПараметрыПолученияРабочихМест.Организация  		= Объект.Организация;
	ПараметрыПолученияРабочихМест.Подразделение 	= Объект.Подразделение;
	ПараметрыПолученияРабочихМест.НачалоПериода		= НачалоМесяца(Объект.ПериодСуммированногоУчетаНачало);
	ПараметрыПолученияРабочихМест.ОкончаниеПериода  = КонецМесяца(Объект.ПериодСуммированногоУчетаОкончание);

	// Получаем рабочие места сотрудников
	КадровыйУчет.СоздатьВТРабочиеМестаСотрудников(Запрос.МенеджерВременныхТаблиц, Истина, ПараметрыПолученияРабочихМест);
	
	// Убираем неактуальных
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	МАКСИМУМ(ВТРабочиеМестаСотрудников.Период) КАК Период,
		|	ВТРабочиеМестаСотрудников.Сотрудник
		|ПОМЕСТИТЬ ВТПоследниеРабочиеМеста
		|ИЗ
		|	ВТРабочиеМестаСотрудников КАК ВТРабочиеМестаСотрудников
		|
		|СГРУППИРОВАТЬ ПО
		|	ВТРабочиеМестаСотрудников.Сотрудник
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТРабочиеМестаСотрудников.Сотрудник
		|ПОМЕСТИТЬ ВТУволенные
		|ИЗ
		|	ВТРабочиеМестаСотрудников КАК ВТРабочиеМестаСотрудников
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТПоследниеРабочиеМеста КАК ВТПоследниеРабочиеМеста
		|		ПО ВТРабочиеМестаСотрудников.Сотрудник = ВТПоследниеРабочиеМеста.Сотрудник
		|			И ВТРабочиеМестаСотрудников.Период = ВТПоследниеРабочиеМеста.Период
		|ГДЕ
		|	ВТРабочиеМестаСотрудников.ВидСобытия = &ВидСобытияУволен
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТРабочиеМестаСотрудников.Сотрудник КАК Сотрудник,
		|	ВТРабочиеМестаСотрудников.Период КАК ДатаНачала,
		|	&ОкончаниеПериода КАК ДатаОкончания
		|ПОМЕСТИТЬ ВТСотрудникиПериоды
		|ИЗ
		|	ВТРабочиеМестаСотрудников КАК ВТРабочиеМестаСотрудников
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТУволенные КАК ВТУволенные
		|		ПО ВТРабочиеМестаСотрудников.Сотрудник = ВТУволенные.Сотрудник
		|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.РегистрацияПереработок.Сотрудники КАК РегистрацияПереработокСотрудники
		|		ПО ВТРабочиеМестаСотрудников.Сотрудник = РегистрацияПереработокСотрудники.Сотрудник
		|			И (РегистрацияПереработокСотрудники.Ссылка.Проведен)
		|			И (РегистрацияПереработокСотрудники.Ссылка.ПериодСуммированногоУчетаОкончание = &ПериодСуммированногоУчетаОкончание)
		|			И (РегистрацияПереработокСотрудники.Ссылка <> &Ссылка)
		|ГДЕ
		|	РегистрацияПереработокСотрудники.Ссылка ЕСТЬ NULL
		|	И ВТУволенные.Сотрудник ЕСТЬ NULL";
	Запрос.УстановитьПараметр("ОкончаниеПериода", КонецМесяца(Объект.ПериодСуммированногоУчетаОкончание));
	Запрос.УстановитьПараметр("ПериодСуммированногоУчетаОкончание", Объект.ПериодСуммированногоУчетаОкончание);
	Запрос.УстановитьПараметр("Ссылка", Объект.Ссылка);
	Запрос.УстановитьПараметр("ВидСобытияУволен", ПредопределенноеЗначение("Перечисление.ВидыКадровыхСобытий.Увольнение"));
	Запрос.Выполнить();
	
	РасчетЗарплатыРасширенный.СоздатьВТПериодыРаботыСотрудниковНаСуммированномУчете(Запрос.МенеджерВременныхТаблиц);
	
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
		|	ВТКадровыеДанныеСотрудников.Сотрудник
		|ИЗ
		|	ВТПериодыРаботыСотрудниковНаСуммированномУчете КАК ВТКадровыеДанныеСотрудников
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|УНИЧТОЖИТЬ ВТПоследниеРабочиеМеста
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|УНИЧТОЖИТЬ ВТУволенные
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|УНИЧТОЖИТЬ ВТСотрудникиПериоды";
		
	РезультатЗапроса = Запрос.Выполнить();
	
	Возврат РезультатЗапроса.Выгрузить().ВыгрузитьКолонку("Сотрудник");

КонецФункции

&НаКлиенте
Процедура ПосчитатьКоличествоСверхурочныхЧасовНаКлиенте(ТекущиеДанные)

	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПосчитатьПоказателиСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьСтроку(ТекущиеДанные)

	ТекущиеДанные.НормаЧасов = 0;
	ТекущиеДанные.ОтработаноЧасов = 0;
	ТекущиеДанные.ОтработаноЧасовВПраздники = 0;
	ТекущиеДанные.Сверхурочно0 = 0;
	ТекущиеДанные.Сверхурочно1_5 = 0;
	ТекущиеДанные.Сверхурочно2 = 0;
	ТекущиеДанные.СпособКомпенсацииПереработки = ПредопределенноеЗначение("Перечисление.СпособыКомпенсацииПереработки.ПовышеннаяОплата");
	РассчитатьВсего(ТекущиеДанные);

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ПосчитатьПоказателиСтроки(ТекущиеДанные)

	РассчитатьВсего(ТекущиеДанные);
	
	Если ТекущиеДанные.СпособКомпенсацииПереработки = ПредопределенноеЗначение("Перечисление.СпособыКомпенсацииПереработки.ПовышеннаяОплата") Тогда
		ДополнитьСверхурочные(ТекущиеДанные);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ДополнитьСверхурочные(ТекущиеДанные)
	
	СверхурочныеВсего = Макс(ТекущиеДанные.Всего, 0);
	ТекущиеСверхурочные = ТекущиеДанные.Сверхурочно1_5 + ТекущиеДанные.Сверхурочно2;
	Разница = СверхурочныеВсего - ТекущиеСверхурочные;
	
	Если Разница > 0 Тогда
		ТекущиеДанные.Сверхурочно1_5 = ТекущиеДанные.Сверхурочно1_5 + Разница;
	Иначе
		ТекущиеДанные.Сверхурочно2 = Макс(ТекущиеДанные.Сверхурочно2 + Разница, 0);
		РассчитатьСверхурочные(ТекущиеДанные);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура РассчитатьСверхурочные(ТекущиеДанные, НачатьС1_5 = Истина)
	Сверхурочные = Макс(ТекущиеДанные.Всего, 0);
	Если НачатьС1_5 Тогда
		ТекущиеДанные.Сверхурочно1_5 = Мин(Сверхурочные, ТекущиеДанные.Сверхурочно1_5);
		ТекущиеДанные.Сверхурочно2 = Сверхурочные - ТекущиеДанные.Сверхурочно1_5;
	Иначе
		ТекущиеДанные.Сверхурочно2 = Мин(Сверхурочные, ТекущиеДанные.Сверхурочно2);
		ТекущиеДанные.Сверхурочно1_5 = Сверхурочные - ТекущиеДанные.Сверхурочно2;
	КонецЕсли;
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура РассчитатьВсего(ТекущиеДанные)
	ТекущиеДанные.Всего = ТекущиеДанные.ОтработаноЧасов - ТекущиеДанные.НормаЧасов - ТекущиеДанные.Сверхурочно0;
КонецПроцедуры

#Область КлючевыеРеквизитыЗаполненияФормы

&НаСервере
// Функция возвращает описание таблиц формы подключенных к механизму ключевых реквизитов формы.
Функция КлючевыеРеквизитыЗаполненияФормыТаблицыОчищаемыеПриИзменении() Экспорт
	
	Массив = Новый Массив;
	Массив.Добавить("Объект.Сотрудники");
	
	Возврат Массив;
	
КонецФункции

&НаСервере
// Функция возвращает массив реквизитов формы подключенных к механизму ключевых реквизитов формы.
Функция КлючевыеРеквизитыЗаполненияФормыОписаниеКлючевыхРеквизитов() Экспорт
	
	Массив = Новый Массив;
	Массив.Добавить(Новый Структура("ЭлементФормы, Представление", "Организация",				НСтр("ru = 'организации'")));
	Массив.Добавить(Новый Структура("ЭлементФормы, Представление", "Подразделение",				НСтр("ru = 'подразделения'")));
	
	Возврат Массив;
	
КонецФункции

#КонецОбласти

&НаСервере
Процедура ОрганизацияПриИзмененииНаСервере()
	
	ЗаполнитьДанныеФормыПоОрганизации();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДанныеФормыПоОрганизации()
	
	Если НЕ ЗначениеЗаполнено(Объект.Организация) Тогда
		Возврат;
	КонецЕсли; 
	
	// ЗарплатаКадрыПодсистемы.ПодписиДокументов
	ПодписиДокументов.ЗаполнитьПодписиПоОрганизации(ЭтаФорма);
	// Конец ЗарплатаКадрыПодсистемы.ПодписиДокументов
	
КонецПроцедуры

#КонецОбласти