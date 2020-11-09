#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
		
	Параметры.Свойство("Организация", Организация);
	
	ЗаполнитьФизическоеЛицоПоСотруднику();
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура МесяцСтрокойПриИзменении(Элемент)
	
	ЗарплатаКадрыКлиент.ВводМесяцаПриИзменении(ЭтаФорма, "Месяц", "МесяцСтрокой", Модифицированность);
	ЗаполнитьСписокДокументовНачисления();
	
КонецПроцедуры

&НаКлиенте
Процедура МесяцСтрокойНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Оповещение = Новый ОписаниеОповещения("МесяцСтрокойНачалоВыбораЗавершение", ЭтотОбъект);
	
	ЗарплатаКадрыКлиент.ВводМесяцаНачалоВыбора(ЭтаФорма, ЭтаФорма, "Месяц", "МесяцСтрокой", , Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура МесяцСтрокойРегулирование(Элемент, Направление, СтандартнаяОбработка)
	
	ЗарплатаКадрыКлиент.ВводМесяцаРегулирование(ЭтаФорма, "Месяц", "МесяцСтрокой", Направление, Модифицированность);
	ЗаполнитьСписокДокументовНачисления();
	
КонецПроцедуры

&НаКлиенте
Процедура МесяцСтрокойАвтоПодбор(Элемент,
	Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	
	ЗарплатаКадрыКлиент.ВводМесяцаАвтоПодборТекста(Текст, ДанныеВыбора, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура МесяцСтрокойОкончаниеВводаТекста(Элемент,
	Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	
	ЗарплатаКадрыКлиент.ВводМесяцаОкончаниеВводаТекста(Текст, ДанныеВыбора, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура СотрудникПриИзменении(Элемент)
	
	СотрудникПриИзмененииНаСервере();
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	Результат = Неопределено;
	Если Модифицированность И ЗаписатьПерерасчет() Тогда
		
		Модифицированность = Ложь;
		
		Результат = Новый Структура;
		Результат.Вставить("Сотрудник", Сотрудник);
		Результат.Вставить("Период", Месяц);
		
	КонецЕсли;
	
	Закрыть(Результат);
	
КонецПроцедуры

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ЗаписатьПерерасчет()
	
	Если Не ПроверитьЗаполнение() Тогда
		Возврат Ложь;
	КонецЕсли;
	
	НаборЗаписей = РегистрыСведений.ПерерасчетЗарплаты.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Организация.Установить(Организация);
	НаборЗаписей.Отбор.Сотрудник.Установить(Сотрудник);
	НаборЗаписей.Отбор.ПериодДействия.Установить(Месяц);
	НаборЗаписей.Отбор.ДокументНачисления.Установить(ДокументНачисления);
	
	Запись = НаборЗаписей.Добавить();
	Запись.Организация = Организация;
	Запись.Сотрудник = Сотрудник;
	Запись.ФизическоеЛицо = ФизическоеЛицо;
	Запись.ПериодДействия = Месяц;
	Запись.ДокументНачисления = ДокументНачисления;
	
	НаборЗаписей.Записать();
	
	Возврат Истина;
	
КонецФункции

&НаКлиенте
Процедура МесяцСтрокойНачалоВыбораЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат <> Неопределено Тогда
		ЗаполнитьСписокДокументовНачисления();
	КонецЕсли; 
	
КонецПроцедуры

&НаСервере
Процедура СотрудникПриИзмененииНаСервере()
	
	ЗаполнитьФизическоеЛицоПоСотруднику();
	ЗаполнитьСписокДокументовНачисления();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьФизическоеЛицоПоСотруднику()
	
	Если ЗначениеЗаполнено(Сотрудник) Тогда
		ФизическоеЛицо = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Сотрудник, "ФизическоеЛицо")
	Иначе
		ФизическоеЛицо = Справочники.ФизическиеЛица.ПустаяСсылка();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокДокументовНачисления()
	
	Элементы.ДокументНачисления.СписокВыбора.Очистить();
	
	Если Не ЗначениеЗаполнено(Месяц)
		Или Не ЗначениеЗаполнено(Сотрудник) Тогда
		
		Возврат;
		
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Период", Месяц);
	Запрос.УстановитьПараметр("Сотрудник", Сотрудник);
	
	Запрос.Текст =
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
		|	ПРЕДСТАВЛЕНИЕССЫЛКИ(НачисленияУдержанияПоСотрудникам.Регистратор) КАК РегистраторПредставление,
		|	НачисленияУдержанияПоСотрудникам.Регистратор КАК Регистратор
		|ИЗ
		|	РегистрНакопления.НачисленияУдержанияПоСотрудникам КАК НачисленияУдержанияПоСотрудникам
		|ГДЕ
		|	НАЧАЛОПЕРИОДА(НачисленияУдержанияПоСотрудникам.Период, МЕСЯЦ) = &Период
		|	И НачисленияУдержанияПоСотрудникам.Сотрудник = &Сотрудник
		|	И НачисленияУдержанияПоСотрудникам.НачислениеУдержание.СпособВыполненияНачисления В (ЗНАЧЕНИЕ(Перечисление.СпособыВыполненияНачислений.ЕжемесячноПриОкончательномРасчете), ЗНАЧЕНИЕ(Перечисление.СпособыВыполненияНачислений.ВЗаданныхМесяцахПриОкончательномРасчете))
		|
		|УПОРЯДОЧИТЬ ПО
		|	Регистратор";
		
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		Элементы.ДокументНачисления.СписокВыбора.Добавить(Выборка.Регистратор, Выборка.РегистраторПредставление);
	КонецЦикла;
	
	Если Элементы.ДокументНачисления.СписокВыбора.Количество() = 1 Тогда
		ДокументНачисления = Элементы.ДокументНачисления.СписокВыбора[0].Значение;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти


