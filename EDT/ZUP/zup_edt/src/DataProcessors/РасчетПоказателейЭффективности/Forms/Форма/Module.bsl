#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЗначенияДляЗаполнения = Новый Структура("Месяц",  "Период");
	ЗарплатаКадры.ЗаполнитьПервоначальныеЗначенияВФорме(ЭтаФорма, ЗначенияДляЗаполнения);
	
	ПриПолученииДанныхНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	ПриПолученииДанныхНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Запись_НазначениеПоказателейЭффективности" Тогда
	 	ПриПолученииДанныхНаСервере();
	ИначеЕсли ИмяСобытия = "Запись_ПланПоказателейЭффективностиПодразделения" Тогда
		ПриПолученииДанныхНаСервере();
	ИначеЕсли ИмяСобытия = "Запись_ПланПоказателейЭффективностиПозиции" Тогда
		ПриПолученииДанныхНаСервере();
	ИначеЕсли ИмяСобытия = "Запись_ПланПоказателейЭффективностиСотрудника" Тогда
		ОбновитьПоказателиСотрудника(Параметр);
	ИначеЕсли ИмяСобытия = "Запись_ПланПоказателяЭффективностиПодразделений" Тогда
		ПриПолученииДанныхНаСервере();
	ИначеЕсли ИмяСобытия = "Запись_ПланПоказателяЭффективностиПозиций" Тогда
		ПриПолученииДанныхНаСервере();
	ИначеЕсли ИмяСобытия = "Запись_ФактПоказателейЭффективностиПодразделения" Тогда
		ПриПолученииДанныхНаСервере();
	ИначеЕсли ИмяСобытия = "Запись_ФактПоказателейЭффективностиСотрудника" Тогда
		ОбновитьПоказателиСотрудника(Параметр);
	ИначеЕсли ИмяСобытия = "Запись_ФактПоказателяЭффективностиПодразделений" Тогда
		ПриПолученииДанныхНаСервере();
	ИначеЕсли ИмяСобытия = "Запись_ФактПоказателяЭффективностиСотрудников" Тогда
		ОбновитьПоказателиСотрудника(Параметр);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПодразделениеОтборПриИзменении(Элемент)
	ПриПолученииДанныхНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПериодСтрокойРегулирование(Элемент, Направление, СтандартнаяОбработка)
	
	КлючевыеПоказателиЭффективностиКлиент.ПериодСтрокойРегулирование(ЭтаФорма, Направление, "Горизонт", "Период", "ПериодСтрокой");
	ПриИзмененииДатыНаКлиенте();
	
КонецПроцедуры

&НаКлиенте
Процедура ПериодСтрокойНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ОповещениеОЗакрытии = Новый ОписаниеОповещения("ПриИзмененииДатыНаКлиенте", ЭтотОбъект);
	СтруктураИменРеквизитов = Новый Структура;
	СтруктураИменРеквизитов.Вставить("ИмяРеквизитаПериод", "Период");
	СтруктураИменРеквизитов.Вставить("ИмяРеквизитаПредставленияПериода", "ПериодСтрокой");
	СтруктураИменРеквизитов.Вставить("ИмяРеквизитаГоризонт", "Горизонт");
	
	КлючевыеПоказателиЭффективностиКлиент.ВыбратьПериод(ЭтаФорма, ОповещениеОЗакрытии, СтруктураИменРеквизитов);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДеревоСотрудников

&НаКлиенте
Процедура ДеревоСотрудниковПриАктивизацииСтроки(Элемент)
	
	УстановитьОтборОценкамПоказателей(ЭтаФорма, Элементы.ДеревоСотрудников.ТекущиеДанные);
	СформироватьСтрокуВладельцаПоказателя(ЭтаФорма, Элементы.ДеревоСотрудников.ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоСотрудниковВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле.Имя <> "ДеревоСотрудниковЗначениеСтроки" Тогда
		Возврат;
	КонецЕсли;
	
	ПоказатьЗначение(, Элемент.ТекущиеДанные.ЗначениеСтроки);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТаблицаОценокПоказателейСотрудников

&НаКлиенте
Процедура ТаблицаОценокПоказателейСотрудниковВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле.Имя = "ТаблицаОценокПоказателейСотрудниковПланПоказателя"
		ИЛИ Поле.Имя = "ТаблицаОценокПоказателейСотрудниковФактПоказателя" Тогда
		ОткрытьРегистраторПланаФакта(Элемент, Поле);
	ИначеЕсли Поле.Имя = "ТаблицаОценокПоказателейСотрудниковПоказатель" Тогда
		ОткрытьРегистраторНазначения(Элемент);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаОценокПоказателейСотрудниковПриАктивизацииСтроки(Элемент)
	СформироватьСтрокуРасшифровкиОценкиПоказателя(ЭтаФорма);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВвестиПланПоказателей(Команда)
	ОткрытьНовыйПланСотрудникаНаКлиенте();
КонецПроцедуры

&НаКлиенте
Процедура ВвестиФактПоказателей(Команда)
	ОткрытьНовыйФактСотрудникаНаКлиенте();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПриПолученииДанныхНаСервере()

	Если Не ЗначениеЗаполнено(Горизонт) Тогда
		Горизонт = ПредопределенноеЗначение("Перечисление.Периодичность.Месяц");
	КонецЕсли;
	
	ЦветаСтиляПоясняющийТекст = ЦветаСтиля.ПоясняющийТекст;
	
	ЗаполнитьДанныеОбОкончательномРасчете();
	
	УстановитьСвойстваЭлементовФормы();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьСвойстваЭлементовФормы()
	КлючевыеПоказателиЭффективностиКлиентСервер.УстановитьПредставлениеПериодаПоДате(ЭтаФорма, "Горизонт", "Период");
КонецПроцедуры

#Область ОценкиПоказателей

&НаСервере
Процедура ЗаполнитьДанныеОбОкончательномРасчете()

	Если Не ЗначениеЗаполнено(ПодразделениеОтбор)
		ИЛИ Не ЗначениеЗаполнено(Период) Тогда
		
		Возврат;
	КонецЕсли;
	
	УдалитьВТ = Новый Массив;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	// Определяем список позиций.
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	СтруктураПредприятия.Ссылка КАК Подразделение
		|ПОМЕСТИТЬ ВТПодразделенияОтбор
		|ИЗ
		|	Справочник.СтруктураПредприятия КАК СтруктураПредприятия
		|ГДЕ
		|	СтруктураПредприятия.Ссылка В ИЕРАРХИИ(&Подразделение)";
	Запрос.УстановитьПараметр("Подразделение", ПодразделениеОтбор);
	
	Запрос.Выполнить();
	УдалитьВТ.Добавить("ВТПодразделенияОтбор");
	
	ОрганизационнаяСтруктура.СоздатьВТПозицииПодразделений(Запрос.МенеджерВременныхТаблиц, "ВТПодразделенияОтбор");
	УдалитьВТ.Добавить("ВТПозицииПодразделений");
	
	// Получаем сотрудников, работавших в периоде на этих местах
	КлючевыеПоказателиЭффективности.СоздатьВТПериодыРаботыСотрудниковПоСпискуПозиций(Запрос.МенеджерВременныхТаблиц, "ВТПозицииПодразделений", СтруктураРеквизитовФормы());
	УдалитьВТ.Добавить("ВТПериодыРаботыСотрудников");
	
	Запрос.Текст =
	    "ВЫБРАТЬ РАЗЛИЧНЫЕ
	    |	ВТПериодыРаботыСотрудников.Сотрудник КАК Сотрудник,
	    |	ВТПериодыРаботыСотрудников.Позиция КАК Позиция,
	    |	МИНИМУМ(ВТПериодыРаботыСотрудников.ДатаНачала) КАК Период
	    |ПОМЕСТИТЬ ВТСгруппированныеПериоды
	    |ИЗ
	    |	ВТПериодыРаботыСотрудников КАК ВТПериодыРаботыСотрудников
	    |ГДЕ
	    |	ВТПериодыРаботыСотрудников.Сотрудник <> ЗНАЧЕНИЕ(Справочник.Сотрудники.ПустаяСсылка)
	    |
	    |СГРУППИРОВАТЬ ПО
	    |	ВТПериодыРаботыСотрудников.Сотрудник,
	    |	ВТПериодыРаботыСотрудников.Позиция
	    |;
	    |
	    |////////////////////////////////////////////////////////////////////////////////
	    |ВЫБРАТЬ РАЗЛИЧНЫЕ
	    |	&Горизонт КАК Горизонт,
	    |	ПериодыРаботыСотрудников.Сотрудник КАК Сотрудник,
	    |	ПериодыРаботыСотрудников.Период КАК Период,
	    |	&ДатаНачала КАК ДатаНачала,
	    |	&ДатаОкончания КАК ДатаОкончания
	    |ПОМЕСТИТЬ ВТСотрудникиОтбор
	    |ИЗ
	    |	ВТСгруппированныеПериоды КАК ПериодыРаботыСотрудников
	    |;
	    |
	    |////////////////////////////////////////////////////////////////////////////////
	    |ВЫБРАТЬ РАЗЛИЧНЫЕ
	    |	ВТПериодыРаботыСотрудников.Сотрудник КАК Сотрудник,
	    |	ВТПериодыРаботыСотрудников.Позиция КАК Позиция,
	    |	ВТПериодыРаботыСотрудников.ДатаНачала КАК ДатаНачала,
	    |	ВТПериодыРаботыСотрудников.ДатаОкончания КАК ДатаОкончания
	    |ИЗ
	    |	ВТПериодыРаботыСотрудников КАК ВТПериодыРаботыСотрудников
	    |ГДЕ
	    |	ВТПериодыРаботыСотрудников.Сотрудник <> ЗНАЧЕНИЕ(Справочник.Сотрудники.ПустаяСсылка)
	    |;
	    |
	    |////////////////////////////////////////////////////////////////////////////////
	    |ВЫБРАТЬ РАЗЛИЧНЫЕ
	    |	ВТПериодыРаботыСотрудников.Сотрудник КАК ЗначениеСтроки,
	    |	ВТПериодыРаботыСотрудников.Сотрудник КАК Сотрудник,
	    |	ВТПериодыРаботыСотрудников.Позиция КАК Позиция,
	    |	ВТПериодыРаботыСотрудников.Подразделение КАК Подразделение
	    |ИЗ
	    |	ВТПериодыРаботыСотрудников КАК ВТПериодыРаботыСотрудников
	    |ИТОГИ ПО
	    |	Подразделение ИЕРАРХИЯ";
	
	Запрос.УстановитьПараметр("Горизонт", Горизонт);
	
	СтруктураДат = КлючевыеПоказателиЭффективностиКлиентСервер.ДатыПериодаГоризонта(Период, Горизонт);
	Запрос.УстановитьПараметр("ДатаНачала", СтруктураДат.ДатаНачала);
	Запрос.УстановитьПараметр("ДатаОкончания", СтруктураДат.ДатаОкончания);
	
	РезультатыЗапроса = Запрос.ВыполнитьПакет();
	
	УдалитьВТ.Добавить("ВТСгруппированныеПериоды");
	УдалитьВТ.Добавить("ВТСотрудникиОтбор");
	
	РезультатТаблицаПериодов = РезультатыЗапроса[РезультатыЗапроса.Количество() - 2];
	РезультатДерево = РезультатыЗапроса[РезультатыЗапроса.Количество() - 1];
	
	ПерезаполнитьТаблицуОценокПоказателейСотрудников(Запрос.МенеджерВременныхТаблиц, "ВТСотрудникиОтбор");
	ПериодыРаботыСотрудников.Загрузить(РезультатТаблицаПериодов.Выгрузить());
	ЗаполнитьДеревоСотрудников(РезультатДерево);
	
	ЗарплатаКадры.УничтожитьВТ(Запрос.МенеджерВременныхТаблиц, УдалитьВТ);

КонецПроцедуры

&НаСервере
Процедура ПерезаполнитьТаблицуОценокПоказателейСотрудников(МенеджерВременныхТаблиц, ИмяОтбора)
	
	ТаблицаОценокПоказателейСотрудников.Очистить();
	ЗаполнитьТаблицаОценокПоказателейСотрудников(МенеджерВременныхТаблиц, ИмяОтбора);

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДеревоСотрудников(РезультатДерево)

	ДеревоСотрудников.ПолучитьЭлементы().Очистить();
	
	ДеревоРезультат = РезультатДерево.Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкамСИерархией);
	
	ДополнитьДеревоСотрудников(ДеревоРезультат, ДеревоСотрудников);
	
КонецПроцедуры

&НаСервере
Процедура ДополнитьДеревоСотрудников(ДеревоИсточник, ДеревоПриемник)
	
	СтрокиПриемника = ДеревоПриемник.ПолучитьЭлементы();
	
	Для Каждого СтрокаИсточника Из ДеревоИсточник.Строки Цикл
		ЗначениеСтроки = ?(ЗначениеЗаполнено(СтрокаИсточника.Сотрудник), СтрокаИсточника.Сотрудник, СтрокаИсточника.Подразделение);
			
		Если ТипЗнч(ДеревоПриемник) = Тип("ДанныеФормыЭлементДерева") И ДеревоПриемник.ЗначениеСтроки = ЗначениеСтроки Тогда 
			ДополнитьДеревоСотрудников(СтрокаИсточника, ДеревоПриемник);
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого СтрокаИсточника Из ДеревоИсточник.Строки Цикл
		
		ЗначениеСтроки = ?(ЗначениеЗаполнено(СтрокаИсточника.Сотрудник), СтрокаИсточника.Сотрудник, СтрокаИсточника.Подразделение);
		КартинкаСтроки = ?(ЗначениеЗаполнено(СтрокаИсточника.Сотрудник), 2, 1);
			
		Если ТипЗнч(ДеревоПриемник) = Тип("ДанныеФормыЭлементДерева") И ДеревоПриемник.ЗначениеСтроки = ЗначениеСтроки Тогда 
			Продолжить;
		КонецЕсли;
		
		СтрокаПриемника = СтрокиПриемника.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаПриемника, СтрокаИсточника);
		СтрокаПриемника.ЗначениеСтроки = ЗначениеСтроки;
		СтрокаПриемника.КартинкаСтроки = КартинкаСтроки;
		ЗаполнитьИтоговуюОценкуПоказателяСотрудника(СтрокаПриемника);
		
		ДополнитьДеревоСотрудников(СтрокаИсточника, СтрокаПриемника);
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьОтборОценкамПоказателей(Форма, ТекущиеДанные = Неопределено)
	
	Если ТекущиеДанные = Неопределено
		Или Не ЗначениеЗаполнено(ТекущиеДанные.Сотрудник)
		Или Не ЗначениеЗаполнено(ТекущиеДанные.Позиция) Тогда
		
		Форма.Элементы.ТаблицаОценокПоказателейСотрудников.ОтборСтрок =
			Новый ФиксированнаяСтруктура("Сотрудник, Позиция", ПредопределенноеЗначение("Справочник.Сотрудники.ПустаяСсылка"), ПредопределенноеЗначение("Справочник.ШтатноеРасписание.ПустаяСсылка"));
	Иначе
		Форма.Элементы.ТаблицаОценокПоказателейСотрудников.ОтборСтрок =
			Новый ФиксированнаяСтруктура("Сотрудник, Позиция", ТекущиеДанные.Сотрудник, ТекущиеДанные.Позиция);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьИтоговуюОценкуПоказателяСотрудника(ТекущиеДанные)

	Если Не ЗначениеЗаполнено(ТекущиеДанные.Сотрудник) Тогда
		Возврат;
	КонецЕсли;
	
	ИтоговаяОценкаПоказателя = 0;
	ТекущиеДанные.ПолностьюРассчитан = Истина;
	
	НайденныеСтроки = ТаблицаОценокПоказателейСотрудников.НайтиСтроки(Новый Структура("Сотрудник, Позиция", ТекущиеДанные.Сотрудник, ТекущиеДанные.Позиция));
	Для каждого НайденнаяСтрока Из НайденныеСтроки Цикл
		ТекущиеДанные.ВладелецПоказателя = НайденнаяСтрока.ВладелецПоказателя;
		Если НайденнаяСтрока.Рассчитан Тогда
			ИтоговаяОценкаПоказателя = ИтоговаяОценкаПоказателя + НайденнаяСтрока.УдельнаяОценкаПоказателя;
			ТекущиеДанные.ЕстьРассчитанныеЗначения = Истина;
		Иначе
			ТекущиеДанные.ПолностьюРассчитан = Ложь;
		КонецЕсли;
	КонецЦикла; 
	
	ТекущиеДанные.ИтоговаяОценкаПоказателя = Окр(ИтоговаяОценкаПоказателя, 2);
	
КонецПроцедуры

#КонецОбласти

&НаКлиентеНаСервереБезКонтекста
Процедура СформироватьСтрокуВладельцаПоказателя(Форма, ТекущиеДанные)
	
	Если ТекущиеДанные = Неопределено Или Не ЗначениеЗаполнено(ТекущиеДанные.ВладелецПоказателя) Тогда
		Форма.Элементы.СтрокаВладельцаПоказателя.Видимость = Ложь;
		Возврат;
	КонецЕсли;
	
	Форма.Элементы.СтрокаВладельцаПоказателя.Видимость = Истина;
	
	МассивСтрок = Новый Массив;
	
	// Сотрудник
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(НСтр("ru = 'Сотрудник работает на позиции'"),, Форма.ЦветаСтиляПоясняющийТекст));
	МассивСтрок.Добавить(" ");
	// Позиция
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(Строка(ТекущиеДанные.Позиция)));
	
	// Периоды работы.
	ПериодыРаботы = Форма.ПериодыРаботыСотрудников.НайтиСтроки(Новый Структура("Сотрудник, Позиция", ТекущиеДанные.Сотрудник, ТекущиеДанные.Позиция));
	МассивСтрокПериодов = МассивСтрокПериодовРаботы(Форма, ПериодыРаботы);
	Если МассивСтрокПериодов.Количество() > 0 Тогда
		МассивСтрок.Добавить(Новый ФорматированнаяСтрока(", ",, Форма.ЦветаСтиляПоясняющийТекст));
		Если ПериодыРаботы.Количество() = 1 Тогда
			МассивСтрок.Добавить(Новый ФорматированнаяСтрока(НСтр("ru = 'в периоде'"),, Форма.ЦветаСтиляПоясняющийТекст));
		Иначе
			МассивСтрок.Добавить(Новый ФорматированнаяСтрока(НСтр("ru = 'в периодах'"),, Форма.ЦветаСтиляПоясняющийТекст));
		КонецЕсли;
		МассивСтрок.Добавить(" ");
		ОбщегоНазначенияКлиентСервер.ДополнитьМассив(МассивСтрок, МассивСтрокПериодов);
	КонецЕсли;
	
	МассивСтрок.Добавить(Символы.ПС);
	
	// Набор показателей.
	Если ТипЗнч(ТекущиеДанные.ВладелецПоказателя) = Тип("СправочникСсылка.СтруктураПредприятия") Тогда
		ТекстВладельца = НСтр("ru = 'подразделение'");
	Иначе
		ТекстВладельца = НСтр("ru = 'позицию'");
	КонецЕсли;
	
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(
		СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Набор показателей, действующих на него, назначен на %1'"), ТекстВладельца),, Форма.ЦветаСтиляПоясняющийТекст));
	МассивСтрок.Добавить(" ");
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(Строка(ТекущиеДанные.ВладелецПоказателя)));
	
	Форма.СтрокаВладельцаПоказателя = Новый ФорматированнаяСтрока(МассивСтрок);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция МассивСтрокПериодовРаботы(Форма, СтрокиПериодов)

	МассивСтрок = Новый Массив;
	
	Для каждого СтрокаПериода Из СтрокиПериодов Цикл
		Если СтрокиПериодов.Найти(СтрокаПериода) > 0 Тогда
			МассивСтрок.Добавить(Новый ФорматированнаяСтрока(", ",, Форма.ЦветаСтиляПоясняющийТекст));
		КонецЕсли;
		
		МассивСтрок.Добавить(НСтр("ru = 'с'"));
		МассивСтрок.Добавить(" ");
		МассивСтрок.Добавить(Формат(СтрокаПериода.ДатаНачала,"ДЛФ=D"));
		МассивСтрок.Добавить(" ");
		МассивСтрок.Добавить(НСтр("ru = 'по'"));
		МассивСтрок.Добавить(" ");
		МассивСтрок.Добавить(Формат(СтрокаПериода.ДатаОкончания, "ДЛФ=D"));
		
	КонецЦикла; 

	Возврат МассивСтрок;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Процедура СформироватьСтрокуРасшифровкиОценкиПоказателя(Форма)
	
	ТекущиеДанные = Форма.Элементы.ТаблицаОценокПоказателейСотрудников.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Или Не ТекущиеДанные.Рассчитан Тогда
		Форма.Элементы.СтрокаРасшифровкиОценкиПоказателя.Видимость = Ложь;
		Возврат;
	КонецЕсли;
	
	Форма.Элементы.СтрокаРасшифровкиОценкиПоказателя.Видимость = Истина;
	МассивСтрок = Новый Массив;
	
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(НСтр("ru = 'Итоговая оценка показателя:'"),, Форма.ЦветаСтиляПоясняющийТекст));
	МассивСтрок.Добавить(" ");
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(Формат(ТекущиеДанные.УдельнаяОценкаПоказателя, "ЧН=0,00")));
	МассивСтрок.Добавить(" = ");
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(Формат(ТекущиеДанные.ОценкаПоказателя, "ЧН=0,00")));
	МассивСтрок.Добавить(" ");
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(НСтр("ru = '(оценка показателя)'"),, Форма.ЦветаСтиляПоясняющийТекст));
	МассивСтрок.Добавить(" * ");
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(Формат(ТекущиеДанные.УдельныйВес, "ЧН=0,00")));
	МассивСтрок.Добавить(" ");
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(НСтр("ru = '(доля показателя в итоговой оценке).'"),, Форма.ЦветаСтиляПоясняющийТекст));
	МассивСтрок.Добавить(Символы.ПС);
	
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(НСтр("ru = 'Значение показателя'"),, Форма.ЦветаСтиляПоясняющийТекст));
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(" - ",, Форма.ЦветаСтиляПоясняющийТекст));
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(Формат(ТекущиеДанные.ЗначениеПоказателя, "ЧН=0,00")));
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(", ",, Форма.ЦветаСтиляПоясняющийТекст));
	
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(НСтр("ru = 'располагается на отрезке шкалы'"),, Форма.ЦветаСтиляПоясняющийТекст));
	МассивСтрок.Добавить(" ");
	
	ТекстШкалы = """" + КлючевыеПоказателиЭффективностиКлиентСервер.ТекстШкалыПоОтрезку(ТекущиеДанные.ЗначениеОт, ТекущиеДанные.ЗначениеДо) + """";
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(ТекстШкалы));
	МассивСтрок.Добавить(Символы.ПС);
	
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(НСтр("ru = 'Оценка показателя, рассчитанная по данному отрезку шкалы значений'"),, Форма.ЦветаСтиляПоясняющийТекст));
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(" - ",, Форма.ЦветаСтиляПоясняющийТекст));
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(Формат(ТекущиеДанные.ОценкаПоказателя, "ЧН=0,00")));
	МассивСтрок.Добавить(".");
	МассивСтрок.Добавить(Символы.ПС);
	
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(НСтр("ru = 'Вес показателя'"),, Форма.ЦветаСтиляПоясняющийТекст));
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(" - ",, Форма.ЦветаСтиляПоясняющийТекст));
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(Формат(ТекущиеДанные.Вес, "ЧН=0")));
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(". ",, Форма.ЦветаСтиляПоясняющийТекст));
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(НСтр("ru = 'Доля показателя в итоговой оценке'"),, Форма.ЦветаСтиляПоясняющийТекст));
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(" - ",, Форма.ЦветаСтиляПоясняющийТекст));
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(Формат(ТекущиеДанные.УдельныйВес, "ЧН=0,00")));
	МассивСтрок.Добавить(".");
	
	Форма.СтрокаРасшифровкиОценкиПоказателя = Новый ФорматированнаяСтрока(МассивСтрок);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьДокументНаКлиенте(ТекущиеДанныеРегистратор)

	Если Не ЗначениеЗаполнено(ТекущиеДанныеРегистратор) Тогда
		Возврат;
	КонецЕсли;

	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("Ключ", ТекущиеДанныеРегистратор);
	
	ОткрытьФорму("Документ." + ИмяДокументаНаСервере(ТекущиеДанныеРегистратор) + ".Форма.ФормаДокумента", СтруктураПараметров, ЭтотОбъект, УникальныйИдентификатор);

КонецПроцедуры

&НаСервере
Функция ИмяДокументаНаСервере(ДокументСсылка)
	Возврат ДокументСсылка.Метаданные().Имя;
КонецФункции

&НаКлиенте
Процедура ОткрытьНовыйПланСотрудникаНаКлиенте()

	ОтборСтрок = Элементы.ТаблицаОценокПоказателейСотрудников.ОтборСтрок;
	Сотрудник = ОтборСтрок.Сотрудник;
	
	Показатели = Новый Массив;
	
	СтрокиСотрудника = ТаблицаОценокПоказателейСотрудников.НайтиСтроки(Новый Структура(ОтборСтрок));
	Для каждого СтрокаСотрудника Из СтрокиСотрудника Цикл
		Если ЗначениеЗаполнено(СтрокаСотрудника.ПланПоказателя) ИЛИ Не СтрокаСотрудника.ТребуетсяВводПлана Тогда
			Продолжить;
		КонецЕсли;
		Показатели.Добавить(СтрокаСотрудника.Показатель);
	КонецЦикла; 
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("ЗначенияЗаполнения", ЗначенияЗаполнения(Сотрудник, Показатели));
	
	ОткрытьФорму("Документ.ПланПоказателейЭффективностиСотрудника.ФормаОбъекта", СтруктураПараметров, ЭтотОбъект, УникальныйИдентификатор);

КонецПроцедуры

&НаКлиенте
Процедура ОткрытьНовыйФактСотрудникаНаКлиенте()

	ОтборСтрок = Элементы.ТаблицаОценокПоказателейСотрудников.ОтборСтрок;
	Сотрудник = ОтборСтрок.Сотрудник;
	
	Показатели = Новый Массив;
	
	СтрокиСотрудника = ТаблицаОценокПоказателейСотрудников.НайтиСтроки(Новый Структура(ОтборСтрок));
	Для каждого СтрокаСотрудника Из СтрокиСотрудника Цикл
		Если ЗначениеЗаполнено(СтрокаСотрудника.ФактПоказателя) Тогда
			Продолжить;
		КонецЕсли;
		Показатели.Добавить(СтрокаСотрудника.Показатель);
	КонецЦикла; 
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("ЗначенияЗаполнения", ЗначенияЗаполнения(Сотрудник, Показатели));
	
	ОткрытьФорму("Документ.ФактПоказателейЭффективностиСотрудника.ФормаОбъекта", СтруктураПараметров, ЭтотОбъект, УникальныйИдентификатор);

КонецПроцедуры

&НаКлиенте
Функция ЗначенияЗаполнения(Сотрудник, Показатели)

	ЗначенияЗаполнения = Новый Структура;
	
	ЗначенияЗаполнения.Вставить("Период", Период);
	ЗначенияЗаполнения.Вставить("Подразделение", ПодразделениеОтбор);
	ЗначенияЗаполнения.Вставить("Сотрудник", Сотрудник);
	ЗначенияЗаполнения.Вставить("Показатели", Показатели);
	
	Возврат ЗначенияЗаполнения;

КонецФункции

&НаКлиенте
Процедура ОбновитьПоказателиСотрудника(Сотрудники)

	Если Сотрудники = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ОбновитьПоказателиСотрудникаНаСервере(Сотрудники);
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьПоказателиСотрудникаНаСервере(Сотрудники)
	
	МассивСотрудников = ОбщегоНазначенияКлиентСервер.СвернутьМассив(Сотрудники);
	
	ТаблицаОтбор = Новый ТаблицаЗначений;
	ТаблицаОтбор.Колонки.Добавить("Горизонт", Новый ОписаниеТипов("ПеречислениеСсылка.Периодичность"));
	ТаблицаОтбор.Колонки.Добавить("Период", Новый ОписаниеТипов("Дата"));
	ТаблицаОтбор.Колонки.Добавить("ДатаНачала", Новый ОписаниеТипов("Дата"));
	ТаблицаОтбор.Колонки.Добавить("ДатаОкончания", Новый ОписаниеТипов("Дата"));
	ТаблицаОтбор.Колонки.Добавить("Сотрудник", Новый ОписаниеТипов("СправочникСсылка.Сотрудники"));
	
	СтруктураДат = КлючевыеПоказателиЭффективностиКлиентСервер.ДатыПериодаГоризонта(Период, Горизонт);
	
	Для каждого Сотрудник Из МассивСотрудников Цикл
		ОтборПоСотруднику = Новый Структура("Сотрудник", Сотрудник);
		
		ПериодыРаботыСотрудника = ПериодыРаботыСотрудников.Выгрузить(ОтборПоСотруднику);
		РабочиеМестаСотрудника = РабочиеМестаПоПериодамРаботыСотрудника(ПериодыРаботыСотрудника);
		
		Для каждого РабочееМесто Из РабочиеМестаСотрудника Цикл
			НоваяСтрока = ТаблицаОтбор.Добавить();
			НоваяСтрока.Горизонт = Горизонт;
			НоваяСтрока.Сотрудник = РабочееМесто.Сотрудник;
			НоваяСтрока.Период = РабочееМесто.ДатаНачала;
			НоваяСтрока.ДатаНачала = СтруктураДат.ДатаНачала;
			НоваяСтрока.ДатаОкончания = СтруктураДат.ДатаОкончания;
		КонецЦикла; 
		
		// Очистка старых строк.
		УдаляемыеСтроки = ТаблицаОценокПоказателейСотрудников.НайтиСтроки(ОтборПоСотруднику);
		Для каждого УдаляемаяСтрока Из УдаляемыеСтроки Цикл
			ТаблицаОценокПоказателейСотрудников.Удалить(УдаляемаяСтрока);
		КонецЦикла;
	КонецЦикла; 
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ТаблицаОтбор.Сотрудник КАК Сотрудник,
		|	ТаблицаОтбор.Горизонт КАК Горизонт,
		|	ТаблицаОтбор.Период КАК Период,
		|	ТаблицаОтбор.ДатаНачала КАК ДатаНачала,
		|	ТаблицаОтбор.ДатаОкончания КАК ДатаОкончания
		|ПОМЕСТИТЬ ВТСотрудникиОтбор
		|ИЗ
		|	&ТаблицаОтбор КАК ТаблицаОтбор";
	Запрос.УстановитьПараметр("ТаблицаОтбор", ТаблицаОтбор);
	
	Запрос.Выполнить();
	
	ЗаполнитьТаблицаОценокПоказателейСотрудников(Запрос.МенеджерВременныхТаблиц, "ВТСотрудникиОтбор");
	
	ОбновитьИтоговыеОценкиПоказателейСотрудников(ТаблицаОтбор);

КонецПроцедуры

&НаСервере
Функция РабочиеМестаПоПериодамРаботыСотрудника(ПериодыРаботыСотрудника)
	
	ИтоговыеПериоды = ПериодыРаботыСотрудников.Выгрузить().СкопироватьКолонки();
	
	Для каждого ПериодРаботы Из ПериодыРаботыСотрудника Цикл
		НайденныеСтроки = ИтоговыеПериоды.НайтиСтроки(Новый Структура("Сотрудник, Позиция", ПериодРаботы.Сотрудник, ПериодРаботы.Позиция));
		Если НайденныеСтроки.Количество() = 0 Тогда
			ЗаполнитьЗначенияСвойств(ИтоговыеПериоды.Добавить(), ПериодРаботы);
		Иначе
			НайденныеСтроки[0].ДатаНачала = Мин(НайденныеСтроки[0].ДатаНачала, ПериодРаботы.ДатаНачала);
		КонецЕсли;
	КонецЦикла; 
	
	Возврат ИтоговыеПериоды;

КонецФункции

&НаСервере
Процедура ОбновитьИтоговыеОценкиПоказателейСотрудников(ТаблицаСотрудников)

	ДеревоЗначений = РеквизитФормыВЗначение("ДеревоСотрудников");
	
	Для каждого СтрокаСотрудника Из ТаблицаСотрудников Цикл
		СтруктураПоиска = Новый Структура("Сотрудник", СтрокаСотрудника.Сотрудник);
		НайденныеСтроки = ДеревоЗначений.Строки.НайтиСтроки(СтруктураПоиска, Истина);
		Для каждого НайденнаяСтрока Из НайденныеСтроки Цикл
			ЗаполнитьИтоговуюОценкуПоказателяСотрудника(НайденнаяСтрока);
		КонецЦикла; 
	КонецЦикла;
	
	ЗначениеВРеквизитФормы(ДеревоЗначений, "ДеревоСотрудников");

КонецПроцедуры

&НаКлиенте
Процедура ОткрытьРегистраторНазначения(Элемент)

	ТекущиеДанные = Элемент.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("Ключ", ТекущиеДанные.РегистраторПоказателя);
	
	ОткрытьФорму("Документ.НазначениеПоказателейЭффективности.Форма.ФормаДокумента", СтруктураПараметров, ЭтотОбъект, УникальныйИдентификатор);

КонецПроцедуры

&НаКлиенте
Процедура ОткрытьРегистраторПланаФакта(Элемент, Поле)

	ОтборСтрок = Элементы.ТаблицаОценокПоказателейСотрудников.ОтборСтрок;
	Если ОтборСтрок = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Поле.Имя = "ТаблицаОценокПоказателейСотрудниковПланПоказателя" Тогда
		ОткрытьДокументНаКлиенте(Элемент.ТекущиеДанные.РегистраторПлана);
	ИначеЕсли Поле.Имя = "ТаблицаОценокПоказателейСотрудниковФактПоказателя" Тогда
		ОткрытьДокументНаКлиенте(Элемент.ТекущиеДанные.РегистраторФакта);
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицаОценокПоказателейСотрудников(МенеджерВременныхТаблиц, ИмяОтбора)

	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	КлючевыеПоказателиЭффективности.СоздатьВТОценкиПоказателейСотрудников(Запрос.МенеджерВременныхТаблиц, ИмяОтбора);
	
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ОценкиПоказателейСотрудников.Сотрудник КАК Сотрудник,
		|	ОценкиПоказателейСотрудников.Позиция КАК Позиция,
		|	ОценкиПоказателейСотрудников.Показатель КАК Показатель,
		|	ОценкиПоказателейСотрудников.РегистраторНазначенияПоказателей КАК РегистраторПоказателя,
		|	ОценкиПоказателейСотрудников.ТребуетсяВводПлана КАК ТребуетсяВводПлана,
		|	ОценкиПоказателейСотрудников.ВладелецПоказателя КАК ВладелецПоказателя,
		|	ОценкиПоказателейСотрудников.Вес КАК Вес,
		|	ОценкиПоказателейСотрудников.УдельныйВес КАК УдельныйВес,
		|	ОценкиПоказателейСотрудников.ЗначениеПоказателя КАК ЗначениеПоказателя,
		|	ОценкиПоказателейСотрудников.ЗначениеОт КАК ЗначениеОт,
		|	ОценкиПоказателейСотрудников.ЗначениеДо КАК ЗначениеДо,
		|	ОценкиПоказателейСотрудников.ПлановоеЗначение КАК ПланПоказателя,
		|	ОценкиПоказателейСотрудников.ФактическоеЗначение КАК ФактПоказателя,
		|	ОценкиПоказателейСотрудников.ОценкаПоказателя КАК ОценкаПоказателя,
		|	ОценкиПоказателейСотрудников.УдельнаяОценкаПоказателя КАК УдельнаяОценкаПоказателя,
		|	ОценкиПоказателейСотрудников.РегистраторПлановогоЗначения КАК РегистраторПлана,
		|	ОценкиПоказателейСотрудников.РегистраторФактическогоЗначения КАК РегистраторФакта,
		|	ВЫБОР
		|		КОГДА ОценкиПоказателейСотрудников.УдельнаяОценкаПоказателя ЕСТЬ NULL
		|			ТОГДА ЛОЖЬ
		|		ИНАЧЕ ИСТИНА
		|	КОНЕЦ КАК Рассчитан
		|ИЗ
		|	ВТОценкиПоказателейСотрудников КАК ОценкиПоказателейСотрудников
		|
		|УПОРЯДОЧИТЬ ПО
		|	Сотрудник,
		|	Позиция,
		|	Показатель";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл
		ЗаполнитьЗначенияСвойств(ТаблицаОценокПоказателейСотрудников.Добавить(), Выборка);
	КонецЦикла;
	
	УстановитьОтборОценкамПоказателей(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура ПриИзмененииДатыНаКлиенте(Результат = Неопределено, ДополнительныеПараметры = Неопределено) Экспорт
	ПриПолученииДанныхНаСервере();
КонецПроцедуры

&НаСервере
Функция СтруктураРеквизитовФормы()
	
	СтруктураРеквизитов = Новый Структура;
	
	СтруктураРеквизитов.Вставить("Период", Период);
	СтруктураРеквизитов.Вставить("Горизонт", Горизонт);
	
	Возврат СтруктураРеквизитов;
	
КонецФункции

#КонецОбласти
