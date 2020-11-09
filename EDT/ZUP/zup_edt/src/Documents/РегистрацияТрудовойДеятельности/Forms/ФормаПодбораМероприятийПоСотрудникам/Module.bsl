#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Организация = Параметры.Организация;
	ЗакрыватьПриВыборе = Ложь;
	
	РазрядКатегорияВидимость = ЭлектронныеТрудовыеКнижки.РазрядКатегорияВидимость();
	КодПоРееструДолжностейВидимость = ЭлектронныеТрудовыеКнижки.КодПоРееструДолжностейВидимость();
	
	ЭлектронныеТрудовыеКнижки.УстановитьУсловноеОформлениеТаблицыМероприятий(ЭтотОбъект, Организация, Ложь, Ложь);
	ЭлектронныеТрудовыеКнижки.УстановитьУсловноеОформлениеПредставленияДолжностиТаблицыМероприятий(ЭтотОбъект, Ложь);
	
	УстановитьУсловноеОформлениеТаблицыМероприятийДобавленныхВДокумент();
	
	ЭлектронныеТрудовыеКнижкиКлиентСервер.УстановитьОтображениеТаблицыМероприятия(ЭтотОбъект, Организация, Мероприятия);
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СотрудникПриИзменении(Элемент)
	
	Если ЗначениеЗаполнено(Сотрудник) Тогда
		СотрудникПриИзмененииНаСервере(ВладелецФормы.МероприятияФизическогоЛица(Сотрудник));
	Иначе
		Мероприятия.Очистить();
		ЭлектронныеТрудовыеКнижкиКлиентСервер.УстановитьОтображениеТаблицыМероприятия(ЭтотОбъект, Организация, Мероприятия);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ДобавитьМероприятия(Команда)
	
	Если Элементы.Мероприятия.ВыделенныеСтроки.Количество() = 0 Тогда
		
		ТекстСообщения = НСтр("ru = 'Выделите строки, которые необходимо добавить'");
		ПоказатьПредупреждение(, ТекстСообщения);
		
		Возврат;
		
	КонецЕсли;
	
	ВыбранныеМероприятия = Новый Массив;
	Для Каждого ИдентификаторСтроки Из Элементы.Мероприятия.ВыделенныеСтроки Цикл
		
		ДанныеМероприятия = Мероприятия.НайтиПоИдентификатору(ИдентификаторСтроки);
		Если ДанныеМероприятия <> Неопределено И Не ДанныеМероприятия.Добавлено Тогда
			ВыбранныеМероприятия.Добавить(ДанныеМероприятия);
		КонецЕсли;
		
	КонецЦикла;
	
	Если ВыбранныеМероприятия.Количество() > 0 Тогда
		
		ОповеститьОВыборе(ВыбранныеМероприятия);
		Для Каждого ДанныеМероприятия Из ВыбранныеМероприятия Цикл
			ДанныеМероприятия.Добавлено = Истина;
		КонецЦикла;
		
	Иначе
		
		ТекстСообщения = НСтр("ru = 'Все выбранные строки добавлены в документ ранее'");
		ПоказатьПредупреждение(, ТекстСообщения);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура СотрудникПриИзмененииНаСервере(ДанныеМероприятий)
	
	Мероприятия.Очистить();
	
	Если ЗначениеЗаполнено(Сотрудник) Тогда
		
		ДанныеСотрудника = ЭлектронныеТрудовыеКнижкиВнутренний.МероприятияСотрудникаДо2020Года(Сотрудник, Организация);
		
		Для Каждого ДанныеМероприятияСотрудника Из ДанныеСотрудника Цикл
			ЗаполнитьЗначенияСвойств(Мероприятия.Добавить(), ДанныеМероприятияСотрудника);
		КонецЦикла;
		
		Если ДанныеМероприятий <> Неопределено Тогда
			
			Для Каждого ДанныеМероприятия Из ДанныеМероприятий Цикл
				
				СтрокиМероприятий = Мероприятия.НайтиСтроки(ДанныеМероприятия);
				Если СтрокиМероприятий.Количество() > 0 Тогда
					СтрокиМероприятий[0].Добавлено = Истина;
				КонецЕсли;
				
			КонецЦикла;
			
		КонецЕсли;
		
	КонецЕсли;
	
	ЭлектронныеТрудовыеКнижкиКлиентСервер.УстановитьОтображениеТаблицыМероприятия(ЭтотОбъект, Организация, Мероприятия);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформлениеТаблицыМероприятийДобавленныхВДокумент()
	
	ЭлементОформления = УсловноеОформление.Элементы.Добавить();
	ЭлементОформления.Использование = Истина;
	
	ЭлементОтбора = ЭлементОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбора.Использование		= Истина;
	ЭлементОтбора.ЛевоеЗначение		= Новый ПолеКомпоновкиДанных("Мероприятия.Добавлено");
	ЭлементОтбора.ВидСравнения		= ВидСравненияКомпоновкиДанных.Равно;
	ЭлементОтбора.ПравоеЗначение	= Истина;
	
	ЭлементОформления.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ТекстЗапрещеннойЯчейкиЦвет);
	ЭлементОформления.Оформление.УстановитьЗначениеПараметра("ТолькоПросмотр", Истина);
	
	ОформляемоеПоле = ЭлементОформления.Поля.Элементы.Добавить();
	ОформляемоеПоле.Поле = Новый ПолеКомпоновкиДанных("Мероприятия");
	ОформляемоеПоле.Использование = Истина;
	
КонецПроцедуры

#КонецОбласти

