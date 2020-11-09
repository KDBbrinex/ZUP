
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
		
	Если Параметры.РежимВыбора Тогда
		Элементы.Список.РежимВыбора = Истина;
	КонецЕсли;
	
	Если Параметры.Свойство("МассивВыбранных") Тогда
		Элементы.Список.РежимВыделения = РежимВыделенияТаблицы.Одиночный;
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
				Список, "Ссылка", Параметры.МассивВыбранных, ВидСравненияКомпоновкиДанных.НеВСписке, , Истина);
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
				Список, "ПометкаУдаления", Ложь, ВидСравненияКомпоновкиДанных.Равно, , Истина);		
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	Элементы.Список.Обновить();
	Элементы.Список.ТекущаяСтрока = ВыбранноеЗначение;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыбратьИзБиблиотеки(Команда)
	
	ОткрытьФорму("Справочник.Демотиваторы.Форма.БиблиотекаДемотиваторов", , ЭтотОбъект);	
	
КонецПроцедуры

#КонецОбласти
