
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("ПредставлениеГруппы") Тогда
		ПредставлениеГруппы = Параметры.ПредставлениеГруппы;
	КонецЕсли;
	
	Если Параметры.Свойство("ОсновноеРабочееМесто") Тогда
		ОсновноеРабочееМесто = Параметры.ОсновноеРабочееМесто;
	КонецЕсли;
	
	Если Параметры.Свойство("ТолькоПросмотр") И Параметры.ТолькоПросмотр <> Неопределено Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ФормаКомандаОК", "Видимость", Не Параметры.ТолькоПросмотр);
	КонецЕсли;
	
	АналогичныеРабочиеМеста.Очистить();
	Для Каждого АналогичноеМесто Из Параметры.АналогичныеМеста Цикл
		Если ПустаяСтрока(ПредставлениеГруппы) И Не ПустаяСтрока(АналогичноеМесто.Представление) Тогда
			ПредставлениеГруппы = АналогичноеМесто.Представление;
		КонецЕсли;
		АналогичныеРабочиеМеста.Добавить(АналогичноеМесто.РабочееМесто, ?(ПустаяСтрока(АналогичноеМесто.Представление), "", АналогичноеМесто.Представление));
	КонецЦикла;
	
	РабочиеМеста.Очистить();
	Для Каждого РабочееМесто Из Параметры.РабочиеМеста Цикл
		Если АналогичныеРабочиеМеста.НайтиПоЗначению(РабочееМесто.РабочееМесто) = Неопределено Тогда
			РабочиеМеста.Добавить(РабочееМесто.РабочееМесто, ?(ПустаяСтрока(РабочееМесто.Представление), "", РабочееМесто.Представление));
		КонецЕсли;
	КонецЦикла;
	
	АналогичныеРабочиеМеста.СортироватьПоПредставлению();
	РабочиеМеста.СортироватьПоПредставлению();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыРабочиеМеста

&НаКлиенте
Процедура РабочиеМестаВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	ПеренестиВправо();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыАналогичныеРабочиеМеста

&НаКлиенте
Процедура АналогичныеРабочиеМестаВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	ПеренестиВлево();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаОК(Команда)
	
	Если Не ЗначениеЗаполнено(ПредставлениеГруппы) И АналогичныеРабочиеМеста.Количество() > 0 Тогда
		ПредставлениеГруппы = ?(ЗначениеЗаполнено(ОсновноеРабочееМесто), Строка(ОсновноеРабочееМесто), Строка(АналогичныеРабочиеМеста[0].Значение));
	КонецЕсли;
	
	ПараметрЗакрытия = Новый Структура;
	ПараметрЗакрытия.Вставить("АналогичныеМеста", АналогичныеРабочиеМеста.ВыгрузитьЗначения());
	ПараметрЗакрытия.Вставить("РабочиеМеста", РабочиеМеста.ВыгрузитьЗначения());
	ПараметрЗакрытия.Вставить("ПредставлениеГруппы", ПредставлениеГруппы);
	ПараметрЗакрытия.Вставить("ОсновноеРабочееМесто", ОсновноеРабочееМесто);
	
	Закрыть(ПараметрЗакрытия);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаВправо(Команда)
	ПеренестиВправо();
КонецПроцедуры

&НаКлиенте
Процедура КомандаВлево(Команда)
	ПеренестиВлево();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПеренестиВправо()
	
	Для каждого ВыделеннаяСтрока Из Элементы.РабочиеМеста.ВыделенныеСтроки Цикл
		СтрокаТаблицы = РабочиеМеста.НайтиПоИдентификатору(ВыделеннаяСтрока);
		Если СтрокаТаблицы <> Неопределено Тогда 
			АналогичныеРабочиеМеста.Добавить(СтрокаТаблицы.Значение, СтрокаТаблицы.Представление);
			РабочиеМеста.Удалить(СтрокаТаблицы);
		КонецЕсли;
	КонецЦикла;
	
	АналогичныеРабочиеМеста.СортироватьПоПредставлению();
	РабочиеМеста.СортироватьПоПредставлению();
	
КонецПроцедуры

&НаКлиенте
Процедура ПеренестиВлево()
	
	Для каждого ВыделеннаяСтрока Из Элементы.АналогичныеРабочиеМеста.ВыделенныеСтроки Цикл
		СтрокаТаблицы = АналогичныеРабочиеМеста.НайтиПоИдентификатору(ВыделеннаяСтрока);
		Если СтрокаТаблицы <> Неопределено Тогда 
			РабочиеМеста.Добавить(СтрокаТаблицы.Значение, СтрокаТаблицы.Представление);
			АналогичныеРабочиеМеста.Удалить(СтрокаТаблицы);
		КонецЕсли;
	КонецЦикла;
	
	АналогичныеРабочиеМеста.СортироватьПоПредставлению();
	РабочиеМеста.СортироватьПоПредставлению();
	
КонецПроцедуры

#КонецОбласти

