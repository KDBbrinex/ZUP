
#Область ОбработчикиСобытийФормы

// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ШиринаПоУмолчанию = РазработкаЭлектронныхКурсовСлужебный.ШиринаВидеоПоУмолчанию();
	
	Элементы.УстановитьШиринуПоУмолчанию.Заголовок = НСтр("ru = 'Установить ширину по умолчанию (%1px)'");	
	Элементы.УстановитьШиринуПоУмолчанию.Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Элементы.УстановитьШиринуПоУмолчанию.Заголовок, ЭлектронноеОбучениеСлужебныйКлиентСервер.ЧислоВСтроку(ШиринаПоУмолчанию));	
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиКомандФормы

// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

&НаКлиенте
Процедура Выбрать(Команда)
	Закрыть(РезультатВыбора());
КонецПроцедуры

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаКлиенте
Функция РезультатВыбора() 
	
	НастройкиВыбора = Новый Структура("УстановитьШиринуПоУмолчанию", УстановитьШиринуПоУмолчанию);
		
	Возврат Новый ФиксированнаяСтруктура(НастройкиВыбора);
	
КонецФункции


#КонецОбласти
