#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Свойство("ВедущийОбъект", ОбъектВладелец);
	Если Не ЗначениеЗаполнено(ОбъектВладелец) Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	Если ТолькоПросмотр Тогда
		
		Элементы.НаборЗаписей.ТолькоПросмотр = Истина;
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, 
			"ФормаКомандаОК",
			"Доступность",
			Ложь);
			
		Элементы.ФормаКомандаОтмена.КнопкаПоУмолчанию = Истина;
		
	КонецЕсли;
		
	Для Каждого ЗаписьНабора Из Параметры.МассивЗаписей Цикл
		ЗаполнитьЗначенияСвойств(НаборЗаписей.Добавить(), ЗаписьНабора);
	КонецЦикла;
	
	НаборЗаписей.Сортировать("Период");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура НаборЗаписейПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	Если Не НоваяСтрока Тогда
		Возврат;
	КонецЕсли;
	
	Если Элемент.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Элемент.ТекущиеДанные.ВидРабот = ОбъектВладелец;
	НовыйПериод = НачалоДня(ОбщегоНазначенияКлиент.ДатаСеанса());
	Если НаборЗаписей.Количество() > 1 Тогда
		ПоследнийПериод = НаборЗаписей.Получить(НаборЗаписей.Количество() - 2).Период;
	Иначе
		ПоследнийПериод = '00010101000000';
	КонецЕсли; 
	Если НовыйПериод <= ПоследнийПериод Тогда
		НовыйПериод = КонецДня(ПоследнийПериод) + 1;
	КонецЕсли; 
	Элемент.ТекущиеДанные.Период = НовыйПериод;
	
КонецПроцедуры

&НаКлиенте
Процедура НаборЗаписейПередОкончаниемРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования, Отказ)
	
	Если ОтменаРедактирования Тогда
		Возврат;
	КонецЕсли;
	
	Если Элемент.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Элемент.ТекущиеДанные.Период) Тогда
		СообщениеОбОшибке = НСтр("ru = 'Необходимо указать дату сведений'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(СообщениеОбОшибке, , "НаборЗаписей.Период", , Отказ);
	Иначе
		НайденныеСтроки = НаборЗаписей.НайтиСтроки(Новый Структура("Период", Элемент.ТекущиеДанные.Период));
		Для Каждого НайденнаяСтрока Из НайденныеСтроки Цикл
			Если НайденнаяСтрока <> Элемент.ТекущиеДанные Тогда
				СообщениеОбОшибке = НСтр("ru = 'Уже есть запись с указанной датой сведений'");
				ОбщегоНазначенияКлиент.СообщитьПользователю(СообщениеОбОшибке, , "НаборЗаписей.Период", , Отказ);
				Прервать;
			КонецЕсли; 
		КонецЦикла;
	КонецЕсли; 

КонецПроцедуры

&НаКлиенте
Процедура НаборЗаписейПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	Если ОтменаРедактирования Тогда
		Возврат;
	КонецЕсли;
	
	РедактированиеПериодическихСведенийКлиент.УпорядочитьНаборЗаписейВФорме(ЭтаФорма);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаОК(Команда)
	РедактированиеПериодическихСведенийКлиент.ОповеститьОЗавершении(ЭтаФорма, "РасценкиРаботСотрудников", ОбъектВладелец);
КонецПроцедуры

&НаКлиенте
Процедура КомандаОтмена(Команда)
	Закрыть();
КонецПроцедуры

#КонецОбласти
