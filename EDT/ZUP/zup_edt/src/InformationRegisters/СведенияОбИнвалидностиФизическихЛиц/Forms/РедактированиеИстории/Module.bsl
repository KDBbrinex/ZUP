
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Свойство("ВедущийОбъект", ОбъектВладелец);
	Если Не ЗначениеЗаполнено(ОбъектВладелец) Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	// Если объект еще не заблокирован для изменений и есть права на изменение набора
	// попытаемся установить блокировку.
	Если НЕ Пользователи.РолиДоступны("ДобавлениеИзменениеДанныхФизическихЛицЗарплатаКадры") Тогда
		
		ТолькоПросмотр = Истина;
		
	КонецЕсли; 
	
	Если ТолькоПросмотр Тогда
		СотрудникиКлиентСервер.УстановитьРежимТолькоПросмотрВФормеРедактированияИстории(ЭтотОбъект);
	КонецЕсли;
		
	Для Каждого ЗаписьНабора Из Параметры.МассивЗаписей Цикл
		ЗаполнитьЗначенияСвойств(НаборЗаписей.Добавить(), ЗаписьНабора);
	КонецЦикла;
	
	НаборЗаписей.Сортировать("Период");
	
	ЗарплатаКадрыКлиентСервер.ЗаполнитьМесяцПоДатеВТабличнойЧасти(НаборЗаписей, "Период", "ПериодСтрокой");
	ЗарплатаКадрыКлиентСервер.ЗаполнитьМесяцПоДатеВТабличнойЧасти(НаборЗаписей, "ДатаРегистрацииИзменений", "ДатаРегистрацииИзмененийСтрокой");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыНаборЗаписей

&НаКлиенте
Процедура НаборЗаписейПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Если Не ЗаблокироватьОбъектВФормеВладельце() Тогда
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НаборЗаписейПередНачаломИзменения(Элемент, Отказ)
	
	Если Не ЗаблокироватьОбъектВФормеВладельце() Тогда
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НаборЗаписейПередУдалением(Элемент, Отказ)
	
	Если Не ЗаблокироватьОбъектВФормеВладельце() Тогда
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НаборЗаписейПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	Если НоваяСтрока Тогда
		Если Элемент.ТекущиеДанные <> Неопределено Тогда
			Элемент.ТекущиеДанные.ФизическоеЛицо = ОбъектВладелец;
			Элемент.ТекущиеДанные.Инвалидность = Истина;
			Элемент.ТекущиеДанные.Период = ОбщегоНазначенияКлиент.ДатаСеанса();
			НовыйПериод = НачалоМесяца(ОбщегоНазначенияКлиент.ДатаСеанса());
			Если НаборЗаписей.Количество() > 1 Тогда
				ПоследнийПериод = НаборЗаписей.Получить(НаборЗаписей.Количество() - 2).Период;
			Иначе
				ПоследнийПериод = '00010101000000';
			КонецЕсли; 
			Если НовыйПериод <= ПоследнийПериод Тогда
				НовыйПериод = ДобавитьМесяц(ПоследнийПериод, 1);
			КонецЕсли; 
			Элемент.ТекущиеДанные.Период = НовыйПериод;
			Элемент.ТекущиеДанные.ДатаРегистрацииИзменений = НачалоМесяца(НовыйПериод);
			ЗарплатаКадрыКлиентСервер.ЗаполнитьМесяцПоДате(Элемент.ТекущиеДанные, "Период", "ПериодСтрокой");
			ЗарплатаКадрыКлиентСервер.ЗаполнитьМесяцПоДате(Элемент.ТекущиеДанные, "ДатаРегистрацииИзменений", "ДатаРегистрацииИзмененийСтрокой");
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура НаборЗаписейПередОкончаниемРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования, Отказ)
	
	Если НЕ ОтменаРедактирования Тогда
		
		Если Элемент.ТекущиеДанные <> Неопределено Тогда
			
			ОчиститьСообщения();
			
			Если НЕ ЗначениеЗаполнено(Элемент.ТекущиеДанные.Период) Тогда
				СообщениеОбОшибке = НСтр("ru = 'Необходимо указать месяц, с которого будет действовать запись сведений'");
				ОбщегоНазначенияКлиент.СообщитьПользователю(СообщениеОбОшибке,,"НаборЗаписей[" + Элемент.ТекущиеДанные.ИсходныйНомерСтроки + "].ПериодСтрокой", , Отказ);
			Иначе
				
				НайденныеСтроки = НаборЗаписей.НайтиСтроки(Новый Структура("Период", Элемент.ТекущиеДанные.Период));
				Для Каждого НайденнаяСтрока Из НайденныеСтроки Цикл
					Если НайденнаяСтрока <> Элемент.ТекущиеДанные Тогда
						СообщениеОбОшибке = НСтр("ru = 'Уже есть запись с указанным месяцем сведений'");
						ОбщегоНазначенияКлиент.СообщитьПользователю(СообщениеОбОшибке,,"НаборЗаписей[" + Элемент.ТекущиеДанные.ИсходныйНомерСтроки + "].ПериодСтрокой", , Отказ);
						Прервать;
					КонецЕсли;
				КонецЦикла;
				
			КонецЕсли;
			
			Если НЕ ЗначениеЗаполнено(Элемент.ТекущиеДанные.ДатаРегистрацииИзменений) Тогда
				СообщениеОбОшибке = НСтр("ru = 'Необходимо указать месяц регистрации изменений'");
				ОбщегоНазначенияКлиент.СообщитьПользователю(СообщениеОбОшибке,,"НаборЗаписей[" + Элемент.ТекущиеДанные.ИсходныйНомерСтроки + "].ДатаРегистрацииИзмененийСтрокой", , Отказ);
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НаборЗаписейПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	Если ОтменаРедактирования Тогда
		Возврат;
	КонецЕсли;
	
	РедактированиеПериодическихСведенийКлиент.УпорядочитьНаборЗаписейВФорме(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура НаборЗаписейПериодСтрокойПриИзменении(Элемент)
	
	ЗарплатаКадрыКлиент.ВводМесяцаПриИзменении(Элементы.НаборЗаписей.ТекущиеДанные, "Период", "ПериодСтрокой", Модифицированность);
	
	УстановитьДатуРегистрацииИзмененийПоПериоду();
КонецПроцедуры

&НаКлиенте
Процедура НаборЗаписейПериодСтрокойНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	Оповещение = Новый ОписаниеОповещения("УстановитьДатуРегистрацииИзмененийПоПериоду", ЭтотОбъект);
	
	ЗарплатаКадрыКлиент.ВводМесяцаНачалоВыбора(ЭтотОбъект, Элементы.НаборЗаписей.ТекущиеДанные, "Период", "ПериодСтрокой",, Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура НаборЗаписейПериодСтрокойРегулирование(Элемент, Направление, СтандартнаяОбработка)
	
	ЗарплатаКадрыКлиент.ВводМесяцаРегулирование(Элементы.НаборЗаписей.ТекущиеДанные, "Период", "ПериодСтрокой", Направление, Модифицированность);
	
	УстановитьДатуРегистрацииИзмененийПоПериоду();
КонецПроцедуры

&НаКлиенте
Процедура НаборЗаписейПериодСтрокойАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	
	ЗарплатаКадрыКлиент.ВводМесяцаАвтоПодборТекста(Текст, ДанныеВыбора, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура НаборЗаписейПериодСтрокойОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	
	ЗарплатаКадрыКлиент.ВводМесяцаОкончаниеВводаТекста(Текст, ДанныеВыбора, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура НаборЗаписейДатаРегистрацииИзмененийПриИзменении(Элемент)
	ЗарплатаКадрыКлиент.ВводМесяцаПриИзменении(Элементы.НаборЗаписей.ТекущиеДанные, "ДатаРегистрацииИзменений", "ДатаРегистрацииИзмененийСтрокой", Модифицированность);
КонецПроцедуры

&НаКлиенте
Процедура НаборЗаписейДатаРегистрацииИзмененийНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаНачалоВыбора(ЭтотОбъект, Элементы.НаборЗаписей.ТекущиеДанные, "ДатаРегистрацииИзменений", "ДатаРегистрацииИзмененийСтрокой");
КонецПроцедуры

&НаКлиенте
Процедура НаборЗаписейДатаРегистрацииИзмененийРегулирование(Элемент, Направление, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаРегулирование(Элементы.НаборЗаписей.ТекущиеДанные, "ДатаРегистрацииИзменений", "ДатаРегистрацииИзмененийСтрокой", Направление, Модифицированность);
КонецПроцедуры

&НаКлиенте
Процедура НаборЗаписейДатаРегистрацииИзмененийАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	
	ЗарплатаКадрыКлиент.ВводМесяцаАвтоПодборТекста(Текст, ДанныеВыбора, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура НаборЗаписейДатаРегистрацииИзмененийОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	
	ЗарплатаКадрыКлиент.ВводМесяцаОкончаниеВводаТекста(Текст, ДанныеВыбора, СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаОК(Команда)
	РедактированиеПериодическихСведенийКлиент.ОповеститьОЗавершении(ЭтотОбъект, "СведенияОбИнвалидностиФизическихЛиц", ОбъектВладелец);
КонецПроцедуры

&НаКлиенте
Процедура КомандаОтмена(Команда)
	Закрыть();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура УстановитьДатуРегистрацииИзмененийПоПериоду(Результат = Истина, Параметр = Неопределено) Экспорт
	ТекущиеДанные = Элементы.НаборЗаписей.ТекущиеДанные;
	
	Если ТекущиеДанные <> Неопределено Тогда
		ТекущиеДанные.ДатаРегистрацииИзменений = НачалоМесяца(ТекущиеДанные.Период);
		ЗарплатаКадрыКлиентСервер.ЗаполнитьМесяцПоДате(ТекущиеДанные, "ДатаРегистрацииИзменений", "ДатаРегистрацииИзмененийСтрокой");
	КонецЕсли;	
КонецПроцедуры	

&НаКлиенте
Функция ЗаблокироватьОбъектВФормеВладельце()
	
	Возврат СотрудникиКлиент.ЗаблокироватьОбъектВФормеВладельцеПриРедактированииИстории(ЭтотОбъект);
	
КонецФункции

#КонецОбласти
