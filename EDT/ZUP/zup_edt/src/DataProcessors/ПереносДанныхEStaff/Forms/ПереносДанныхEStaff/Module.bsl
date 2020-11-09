
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьВидимостьЭлементовФормы();
	УстановитьОрганизациюПоУмолчанию();
	УстановитьПодсказкиВвода();
	СценарийЗагрузкиДанныхИзEStaff();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьПорядковыйНомерПерехода(1);
	УстановитьДоступностьОрганизацииПоУмолчанию();
	
	Если Не ЗначениеЗаполнено(МесяцНачалаПереноса) Тогда
		МесяцНачалаПереноса = НачалоМесяца(ОбщегоНазначенияКлиент.ДатаСеанса());
	КонецЕсли;
	ЗарплатаКадрыКлиентСервер.ЗаполнитьМесяцПоДате(ЭтаФорма, "МесяцНачалаПереноса", "МесяцНачалаПереносаСтрокой");
	
	ОповещениеВопроса = Новый ОписаниеОповещения("ПриОткрытииЗавершение", ЭтотОбъект);
	ФайловаяСистемаКлиент.ПодключитьРасширениеДляРаботыСФайлами(ОповещениеВопроса);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Если Не ЗавершениеРаботы Тогда
		ПриЗакрытииНаСервере(ИдентификаторЗадания);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КаталогПрограммыEStaffНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	КаталогСФайламиНачалоВыбора(ДанныеВыбора, Элемент.Имя, НСтр("ru = 'Выберите каталог программы E-Staff Рекрутер'"));
	
КонецПроцедуры

&НаКлиенте
Процедура КаталогСДаннымиСправочниковНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	КаталогСФайламиНачалоВыбора(ДанныеВыбора, Элемент.Имя, НСтр("ru = 'Выберите каталог c данными справочников'"));
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновлятьСтруктуруПредприятияПриИзменении(Элемент)
	
	УстановитьДоступностьОрганизацииПоУмолчанию();
	
КонецПроцедуры

#Область РедактированиеМесяцаСтрокой

&НаКлиенте
Процедура МесяцНачалаПереносаСтрокойПриИзменении(Элемент)
	ЗарплатаКадрыКлиент.ВводМесяцаПриИзменении(ЭтотОбъект, "МесяцНачалаПереноса", "МесяцНачалаПереносаСтрокой");
КонецПроцедуры

&НаКлиенте
Процедура МесяцНачалаПереносаСтрокойНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаНачалоВыбора(ЭтотОбъект, ЭтотОбъект, "МесяцНачалаПереноса", "МесяцНачалаПереносаСтрокой", Ложь);
КонецПроцедуры

&НаКлиенте
Процедура МесяцНачалаПереносаСтрокойРегулирование(Элемент, Направление, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаРегулирование(ЭтотОбъект, "МесяцНачалаПереноса", "МесяцНачалаПереносаСтрокой", Направление);
КонецПроцедуры

&НаКлиенте
Процедура МесяцНачалаПереносаСтрокойАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаАвтоПодборТекста(Текст, ДанныеВыбора, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура МесяцНачалаПереносаСтрокойОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаОкончаниеВводаТекста(Текст, ДанныеВыбора, СтандартнаяОбработка);
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаДалее(Команда)
	
	Если ПорядковыйНомерПерехода < 6 Тогда
		ПерейтиДалее();
	Иначе
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаНазад(Команда)
	
	ПерейтиНазад();
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаОтмена(Команда)
	
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура НайтиКаталогПрограммы(Команда)
	
	ВозможныеКаталоги = ВозможныеКаталогиУстановкиПрограммы();
	ПроверитьСуществованиеКаталогаУстановкиПрограммы(ВозможныеКаталоги);
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьСуществованиеКаталогаУстановкиПрограммы(ВозможныеКаталоги)
	
	Если ВозможныеКаталоги.Количество() = 0 Тогда
		ТекстСообщения = НСтр("ru = 'Каталог программы E-Staff Рекрутер не найден.'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения, , "КаталогПрограммыEStaff");
		Возврат;
	КонецЕсли;
	
	ДополнительныеПараметры = Новый Структура("ВозможныеКаталоги");
	ДополнительныеПараметры.ВозможныеКаталоги = ВозможныеКаталоги;
	
	ОбработчикОповещения = Новый ОписаниеОповещения("ПроверитьСуществованиеКаталогаУстановкиПрограммыЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	
	КаталогНаДиске = Новый Файл(ВозможныеКаталоги[0]);
	КаталогНаДиске.НачатьПроверкуСуществования(ОбработчикОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьСуществованиеКаталогаУстановкиПрограммыЗавершение(Существует, ДополнительныеПараметры) Экспорт
	
	ВозможныеКаталоги = ДополнительныеПараметры.ВозможныеКаталоги;
	
	Если Не Существует Тогда
		ВозможныеКаталоги.Удалить(0);
		ПроверитьСуществованиеКаталогаУстановкиПрограммы(ВозможныеКаталоги);
		Возврат;
	КонецЕсли;
	
	КаталогПрограммыEStaff = ВозможныеКаталоги[0];
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ПоставляемаяЧасть

&НаКлиенте
Процедура ИзменитьПорядковыйНомерПерехода(Итератор)
	
	ОчиститьСообщения();
	
	УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода + Итератор);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПорядковыйНомерПерехода(Знач Значение)
	
	ЭтоПереходДалее = (Значение > ПорядковыйНомерПерехода);
	
	ПорядковыйНомерПерехода = Значение;
	
	Если ПорядковыйНомерПерехода < 0 Тогда
		
		ПорядковыйНомерПерехода = 0;
		
	КонецЕсли;
	
	ПорядковыйНомерПереходаПриИзменении(ЭтоПереходДалее);
	
КонецПроцедуры

&НаКлиенте
Процедура ПорядковыйНомерПереходаПриИзменении(Знач ЭтоПереходДалее)
	
	// Выполняем обработчики событий перехода.
	ВыполнитьОбработчикиСобытийПерехода(ЭтоПереходДалее);
	
	// Устанавливаем отображение страниц.
	СтрокиПереходаТекущие = ТаблицаПереходов.НайтиСтроки(Новый Структура("ПорядковыйНомерПерехода", ПорядковыйНомерПерехода));
	
	Если СтрокиПереходаТекущие.Количество() = 0 Тогда
		Закрыть();
	КонецЕсли;
	
	СтрокаПереходаТекущая = СтрокиПереходаТекущие[0];
	
	Элементы.Страницы.ТекущаяСтраница = Элементы[СтрокаПереходаТекущая.ИмяОсновнойСтраницы];
	
	НастроитьКнопкиКоманднойПанели();
	
	Если ЭтоПереходДалее И СтрокаПереходаТекущая.ДлительнаяОперация Тогда
		
		ПодключитьОбработчикОжидания("ВыполнитьОбработчикДлительнойОперации", 0.1, Истина);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьОбработчикиСобытийПерехода(Знач ЭтоПереходДалее)
	
	// Обработчики событий переходов
	Если ЭтоПереходДалее Тогда
		
		СтрокиПерехода = ТаблицаПереходов.НайтиСтроки(Новый Структура("ПорядковыйНомерПерехода", ПорядковыйНомерПерехода - 1));
		
		Если СтрокиПерехода.Количество() = 0 Тогда
			Возврат;
		КонецЕсли;
		
		СтрокаПерехода = СтрокиПерехода[0];
		
		// обработчик ПриПереходеДалее
		Если Не ПустаяСтрока(СтрокаПерехода.ИмяОбработчикаПриПереходеДалее)
			И Не СтрокаПерехода.ДлительнаяОперация Тогда
			
			ИмяПроцедуры = "Подключаемый_[ИмяОбработчика](Отказ)";
			ИмяПроцедуры = СтрЗаменить(ИмяПроцедуры, "[ИмяОбработчика]", СтрокаПерехода.ИмяОбработчикаПриПереходеДалее);
			
			Отказ = Ложь;
			РезультатВычисления = Вычислить(ИмяПроцедуры);
			
			Если Отказ Тогда
				
				УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода - 1);
				Возврат;
				
			КонецЕсли;
			
		КонецЕсли;
		
	Иначе
		
		СтрокиПерехода = ТаблицаПереходов.НайтиСтроки(Новый Структура("ПорядковыйНомерПерехода", ПорядковыйНомерПерехода + 1));
		
		Если СтрокиПерехода.Количество() = 0 Тогда
			Возврат;
		КонецЕсли;
		
		СтрокаПерехода = СтрокиПерехода[0];
		
		// обработчик ПриПереходеНазад
		Если Не ПустаяСтрока(СтрокаПерехода.ИмяОбработчикаПриПереходеНазад)
			И Не СтрокаПерехода.ДлительнаяОперация Тогда
			
			ИмяПроцедуры = "Подключаемый_[ИмяОбработчика](Отказ)";
			ИмяПроцедуры = СтрЗаменить(ИмяПроцедуры, "[ИмяОбработчика]", СтрокаПерехода.ИмяОбработчикаПриПереходеНазад);
			
			Отказ = Ложь;
			РезультатВычисления = Вычислить(ИмяПроцедуры);
			
			Если Отказ Тогда
				
				УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода + 1);
				Возврат;
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
	
	СтрокиПереходаТекущие = ТаблицаПереходов.НайтиСтроки(Новый Структура("ПорядковыйНомерПерехода", ПорядковыйНомерПерехода));
	
	Если СтрокиПереходаТекущие.Количество() = 0 Тогда
		ВызватьИсключение НСтр("ru = 'Не определена страница для отображения.'");
	КонецЕсли;
	
	СтрокаПереходаТекущая = СтрокиПереходаТекущие[0];
	
	Если СтрокаПереходаТекущая.ДлительнаяОперация И Не ЭтоПереходДалее Тогда
		
		УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода - 1);
		Возврат;
	КонецЕсли;
	
	// обработчик ПриОткрытии
	Если Не ПустаяСтрока(СтрокаПереходаТекущая.ИмяОбработчикаПриОткрытии) Тогда
		
		ИмяПроцедуры = "Подключаемый_[ИмяОбработчика](Отказ, ПропуститьСтраницу, ЭтоПереходДалее)";
		ИмяПроцедуры = СтрЗаменить(ИмяПроцедуры, "[ИмяОбработчика]", СтрокаПереходаТекущая.ИмяОбработчикаПриОткрытии);
		
		Отказ = Ложь;
		ПропуститьСтраницу = Ложь;
		
		РезультатВычисления = Вычислить(ИмяПроцедуры);
		
		Если Отказ Тогда
			
			УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода - 1);
			Возврат;
			
		ИначеЕсли ПропуститьСтраницу Тогда
			
			Если ЭтоПереходДалее Тогда
				
				УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода + 1);
				Возврат;
				
			Иначе
				
				УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода - 1);
				Возврат;
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьОбработчикДлительнойОперации()
	
	СтрокиПереходаТекущие = ТаблицаПереходов.НайтиСтроки(Новый Структура("ПорядковыйНомерПерехода", ПорядковыйНомерПерехода));
	
	Если СтрокиПереходаТекущие.Количество() = 0 Тогда
		ВызватьИсключение НСтр("ru = 'Не определена страница для отображения.'");
	КонецЕсли;
	
	СтрокаПереходаТекущая = СтрокиПереходаТекущие[0];
	
	// обработчик ОбработкаДлительнойОперации
	Если Не ПустаяСтрока(СтрокаПереходаТекущая.ИмяОбработчикаДлительнойОперации) Тогда
		
		ИмяПроцедуры = "Подключаемый_[ИмяОбработчика](Отказ, ПерейтиДалее)";
		ИмяПроцедуры = СтрЗаменить(ИмяПроцедуры, "[ИмяОбработчика]", СтрокаПереходаТекущая.ИмяОбработчикаДлительнойОперации);
		
		Отказ = Ложь;
		ПерейтиДалее = Истина;
		
		РезультатВычисления = Вычислить(ИмяПроцедуры);
		
		Если Отказ Тогда
			
			УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода - 1);
			Возврат;
			
		ИначеЕсли ПерейтиДалее Тогда
			
			УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода + 1);
			Возврат;
			
		КонецЕсли;
		
	Иначе
		
		УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода + 1);
		
		Возврат;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ТаблицаПереходовНоваяСтрока(ПорядковыйНомерПерехода,
									ИмяОсновнойСтраницы,
									ИмяСтраницыДекорации = "",
									ИмяОбработчикаПриОткрытии = "",
									ИмяОбработчикаПриПереходеДалее = "",
									ИмяОбработчикаПриПереходеНазад = "",
									ДлительнаяОперация = Ложь,
									ИмяОбработчикаДлительнойОперации = "")
	НоваяСтрока = ТаблицаПереходов.Добавить();
	
	НоваяСтрока.ПорядковыйНомерПерехода = ПорядковыйНомерПерехода;
	НоваяСтрока.ИмяОсновнойСтраницы     = ИмяОсновнойСтраницы;
	НоваяСтрока.ИмяСтраницыДекорации    = ИмяСтраницыДекорации;
	
	НоваяСтрока.ИмяОбработчикаПриПереходеДалее = ИмяОбработчикаПриПереходеДалее;
	НоваяСтрока.ИмяОбработчикаПриПереходеНазад = ИмяОбработчикаПриПереходеНазад;
	НоваяСтрока.ИмяОбработчикаПриОткрытии      = ИмяОбработчикаПриОткрытии;
	
	НоваяСтрока.ДлительнаяОперация = ДлительнаяОперация;
	НоваяСтрока.ИмяОбработчикаДлительнойОперации = ИмяОбработчикаДлительнойОперации;
	
КонецПроцедуры

#КонецОбласти

#Область ПереопределяемаяЧасть

#Область ПроцедурыИФункцииОбработки

#Область УправлениеФормой

&НаСервере
Процедура УстановитьВидимостьЭлементовФормы()
	
	УстановитьВидимостьКомандыПоискаКаталогаПрограммы();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьКомандыПоискаКаталогаПрограммы()
	
	ИскатьКаталогПрограммы = (ОбщегоНазначения.ЭтоВебКлиент()
		Или ОбщегоНазначения.ЭтоWindowsКлиент());
		
	Элементы.НайтиКаталогПрограммы.Видимость = ИскатьКаталогПрограммы;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьТекстЗагрузкаВыполнена(Выполнена = Истина, БезОшибок = Истина)
	
	Если Выполнена И БезОшибок Тогда
		Элементы.ТекстЗагрузкаВыполнена.Заголовок = НСтр("ru = 'Данные загружены. Для продолжения работы с программой нажмите «Готово».'");
	ИначеЕсли Не Выполнена Тогда
		УстановитьТекстЗагрузкаЗавершенаСОшибкой();
	Иначе
		УстановитьТекстЗагрузкаВыполненаСОшибками();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьТекстЗагрузкаЗавершенаСОшибкой()
	
	Элемент = Элементы.ТекстЗагрузкаВыполнена;
	
	ТекстНадписиНачало = НСтр("ru = 'При загрузке произошла ошибка (см.'") + " ";
	ТекстНадписиГиперссылка = Новый ФорматированнаяСтрока(НСтр("ru = 'Журнал регистрации'"), , ЦветаСтиля.ГиперссылкаЦвет, , "ОткрытьЖурналРегистрации");
	ТекстНадписиОкончание = НСтр("ru = '). Для завершения нажмите «Готово».'");
	
	ТекстНадписи = Новый ФорматированнаяСтрока(ТекстНадписиНачало, ТекстНадписиГиперссылка, ТекстНадписиОкончание);
	
	Элемент.Заголовок = ТекстНадписи;
	Элемент.УстановитьДействие("ОбработкаНавигационнойСсылки", "Подключаемый_ОткрытьЖурналРегистрации");
	
КонецПроцедуры

&НаСервере
Процедура УстановитьТекстЗагрузкаВыполненаСОшибками()
	
	Элемент = Элементы.ТекстЗагрузкаВыполнена;
	
	ТекстНадписиНачало = НСтр("ru = 'Данные загружены, но при загрузке произошли ошибки (см.'") + " ";
	ТекстНадписиГиперссылка = Новый ФорматированнаяСтрока(НСтр("ru = 'Журнал регистрации'"), , ЦветаСтиля.ГиперссылкаЦвет, , "ОткрытьЖурналРегистрации");
	ТекстНадписиОкончание = НСтр("ru = '). Для завершения нажмите «Готово».'");
	
	ТекстНадписи = Новый ФорматированнаяСтрока(ТекстНадписиНачало, ТекстНадписиГиперссылка, ТекстНадписиОкончание);
	
	Элемент.Заголовок = ТекстНадписи;
	Элемент.УстановитьДействие("ОбработкаНавигационнойСсылки", "Подключаемый_ОткрытьЖурналРегистрации");
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОткрытьЖурналРегистрации(Элемент, НавигационнаяСсылка, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ЖурналРегистрацииКлиент.ОткрытьЖурналРегистрации();
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьДоступностьОрганизацииПоУмолчанию()
	
	Элементы.ОрганизацияПоУмолчаниюГруппа.Доступность = ОбновлятьСтруктуруПредприятия;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьПодсказкиВвода()
	
	СисИнфо = Новый СистемнаяИнформация();
	Если (СисИнфо.ТипПлатформы = ТипПлатформы.Windows_x86) Или (СисИнфо.ТипПлатформы = ТипПлатформы.Windows_x86_64) Тогда
		Элементы.КаталогПрограммыEStaff.ПодсказкаВвода = "C:\Program Files\EStaff";
	КонецЕсли;
	
	ПримерИмениКаталогаСФайлами = "C:\Users\%UserName%\Documents\EStaff";
	Элементы.КаталогСДаннымиСправочников.ПодсказкаВвода = ПримерИмениКаталогаСФайлами;
	
КонецПроцедуры

&НаСервере
Процедура НастроитьКнопкиКоманднойПанели()
	
	ЭтоНачальнаяСтраница = (Элементы.Страницы.ТекущаяСтраница = Элементы.Начало);
	ЭтоСтраницаЗагрузки = (Элементы.Страницы.ТекущаяСтраница = Элементы.ЗагрузкаДанных);
	ЭтоСтраницаЗавершения = (Элементы.Страницы.ТекущаяСтраница = Элементы.Окончание);
	
	Элементы.КнопкаОтмена.Видимость = Не ЭтоСтраницаЗавершения;
	Элементы.КнопкаДалее.Видимость = Не ЭтоСтраницаЗагрузки;
	Элементы.КнопкаНазад.Видимость = Не ЭтоНачальнаяСтраница И Не ЭтоСтраницаЗагрузки И Не ЭтоСтраницаЗавершения;
	
	Элементы.КнопкаДалее.Заголовок = ?(ЭтоСтраницаЗавершения, НСтр("ru = 'Готово'"), НСтр("ru = 'Далее >'"));
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиДалее()
	
	ИзменитьПорядковыйНомерПерехода(1);
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиНазад()
	
	ИзменитьПорядковыйНомерПерехода(-1);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытииЗавершение(Результат, Параметры) Экспорт
	
	Если Результат <> Истина Тогда
		
		ТекстИсключения = НСтр("ru = 'Не подключено расширение работы с файлами. Дальнейшая работа не возможна.'");
		ПоказатьПредупреждение(, ТекстИсключения);
		
		Закрыть();
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область РаботаСФайламиИКаталогами

&НаКлиенте
Функция ВозможныеКаталогиУстановкиПрограммы()
	
	Каталоги = Новый Массив;
	Каталоги.Добавить("C:\Program Files\EStaff");
	Каталоги.Добавить("C:\Program Files\EStaff_Server");
	Каталоги.Добавить("C:\Program Files (x86)\EStaff");
	Каталоги.Добавить("C:\Program Files (x86)\EStaff_Server");
	
	Возврат Каталоги;
	
КонецФункции

&НаКлиенте
Процедура КаталогСФайламиНачалоВыбора(ДанныеВыбора, ИмяКаталога, Заголовок)
	
	ДиалогВыбора = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	ДиалогВыбора.Заголовок = Заголовок;
	
	Если Не ПустаяСтрока(ЭтотОбъект[ИмяКаталога]) Тогда
		ДиалогВыбора.Каталог = ЭтотОбъект[ИмяКаталога];
	КонецЕсли;
	
	ДополнительныеПараметры = Новый Структура("ИмяКаталога");
	ДополнительныеПараметры.ИмяКаталога = ИмяКаталога;
	
	ОбработчикОповещения = Новый ОписаниеОповещения("КаталогСФайламиВыборЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	ДиалогВыбора.Показать(ОбработчикОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура КаталогСФайламиВыборЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ИмяКаталога = ДополнительныеПараметры.ИмяКаталога;
	ЭтотОбъект[ИмяКаталога] = Результат;
	
КонецПроцедуры

&НаКлиенте
Процедура НачатьЗаписьСценарияВыгрузки()
	
	СценарийВыгрузкиЗаписан = Неопределено;
	
	КаталогСценариев = СтрШаблон("%1\data_rcr\obj\xml", КаталогПрограммыEStaff);
	
	НачатьПроверкуСуществованияКаталогаСценариев(КаталогСценариев);
	
КонецПроцедуры

&НаКлиенте
Процедура НачатьПроверкуСуществованияКаталогаСценариев(КаталогСценариев)
	
	ДополнительныеПараметры = Новый Структура("КаталогСценариев");
	ДополнительныеПараметры.КаталогСценариев = КаталогСценариев;
	
	ОбработчикОповещения = Новый ОписаниеОповещения("ПроверкаСуществованияКаталогаСценариевЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	
	КаталогНаДиске = Новый Файл(КаталогСценариев);
	КаталогНаДиске.НачатьПроверкуСуществования(ОбработчикОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверкаСуществованияКаталогаСценариевЗавершение(Существует, ДополнительныеПараметры) Экспорт
	
	Если Не Существует Тогда
		СценарийВыгрузкиЗаписан = Ложь;
		Возврат;
	КонецЕсли;
	
	НачатьПолучениеТолькоЧтенияКаталогаСценариев(ДополнительныеПараметры.КаталогСценариев);
	
КонецПроцедуры

&НаКлиенте
Процедура НачатьПолучениеТолькоЧтенияКаталогаСценариев(КаталогСценариев)
	
	ДополнительныеПараметры = Новый Структура("КаталогСценариев");
	ДополнительныеПараметры.КаталогСценариев = КаталогСценариев;
	
	ОбработчикОповещения = Новый ОписаниеОповещения("ПолучениеТолькоЧтенияКаталогаСценариевЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	
	КаталогНаДиске = Новый Файл(КаталогСценариев);
	КаталогНаДиске.НачатьПолучениеТолькоЧтения(ОбработчикОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолучениеТолькоЧтенияКаталогаСценариевЗавершение(ТолькоЧтение, ДополнительныеПараметры) Экспорт
	
	Если ТолькоЧтение Тогда
		СценарийВыгрузкиЗаписан = Ложь;
		Возврат;
	КонецЕсли;
		
	ФайлСценариев = СтрШаблон("%1\export_scenarios.xml", ДополнительныеПараметры.КаталогСценариев);
	НачатьПроверкуСуществованияФайлаСценариев(ФайлСценариев);
	
КонецПроцедуры

&НаКлиенте
Процедура НачатьПроверкуСуществованияФайлаСценариев(ФайлСценариев)
	
	ДополнительныеПараметры = Новый Структура("ФайлСценариев");
	ДополнительныеПараметры.ФайлСценариев = ФайлСценариев;
	
	ОбработчикОповещения = Новый ОписаниеОповещения("ПроверкаСуществованияФайлаСценариевЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	
	ФайлНаДиске = Новый Файл(ФайлСценариев);
	ФайлНаДиске.НачатьПроверкуСуществования(ОбработчикОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверкаСуществованияФайлаСценариевЗавершение(Существует, ДополнительныеПараметры) Экспорт
	
	ФайлСценариев = ДополнительныеПараметры.ФайлСценариев;
	
	Если Не Существует Тогда
		НачатьФормированиеФайлаСценариевИзМакета(ФайлСценариев);
		Возврат;
	КонецЕсли;
	
	НачатьЧтениеФайлаСценариев(ФайлСценариев);
	
КонецПроцедуры

&НаКлиенте
Процедура НачатьФормированиеФайлаСценариевИзМакета(ФайлСценариев)
	
	ОбработчикОповещения = Новый ОписаниеОповещения("ФормированиеФайлаСценариевИзМакетаЗавершение", ЭтотОбъект);
	
	СодержимоеФайла = СодержимоеФайлаСценариев(КаталогСДаннымиСправочников);
	
	ТекстовыйДокумент = Новый ТекстовыйДокумент;
	ТекстовыйДокумент.УстановитьТекст(СодержимоеФайла);
	ТекстовыйДокумент.НачатьЗапись(ОбработчикОповещения, ФайлСценариев, "windows-1251");
	
КонецПроцедуры

&НаКлиенте
Процедура ФормированиеФайлаСценариевИзМакетаЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СценарийВыгрузкиЗаписан = Результат;
	
КонецПроцедуры

&НаКлиенте
Процедура НачатьЧтениеФайлаСценариев(ФайлСценариев)
	
	ТекстовыйДокумент = Новый ТекстовыйДокумент;
	
	ДополнительныеПараметры = Новый Структура(
		"ФайлСценариев, 
		|ТекстовыйДокумент");
	ДополнительныеПараметры.ФайлСценариев = ФайлСценариев;
	ДополнительныеПараметры.ТекстовыйДокумент = ТекстовыйДокумент;
	
	ОбработчикОповещения = Новый ОписаниеОповещения("ЧтениеФайлаСценариевЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	
	ТекстовыйДокумент.НачатьЧтение(ОбработчикОповещения, ФайлСценариев, "windows-1251");
	
КонецПроцедуры

&НаКлиенте
Процедура ЧтениеФайлаСценариевЗавершение(ДополнительныеПараметры) Экспорт
	
	НачатьДополнениеФайлаСценариев(ДополнительныеПараметры.ФайлСценариев, ДополнительныеПараметры.ТекстовыйДокумент);
	
КонецПроцедуры

&НаКлиенте
Процедура НачатьДополнениеФайлаСценариев(ФайлСценариев, ТекстовыйДокумент)
	
	ТекстФорматаXML = ТекстовыйДокумент.ПолучитьТекст();
	
	ТекстФайлаСценариев = ТекстФорматаXML;
	
	Если Не ФайлСценариевДополнен(ТекстФайлаСценариев, КаталогСДаннымиСправочников) Тогда
		СценарийВыгрузкиЗаписан = Истина;
		Возврат;
	КонецЕсли;
		
	Если ТекстФайлаСценариев = ТекстФорматаXML Тогда
		СценарийВыгрузкиЗаписан = Истина;
		Возврат;
	КонецЕсли;
	
	ОбработчикОповещения = Новый ОписаниеОповещения("ДополнениеФайлаСценариевЗавершение", ЭтотОбъект);
	
	ТекстовыйДокумент.УстановитьТекст(ТекстФайлаСценариев);
	ТекстовыйДокумент.НачатьЗапись(ОбработчикОповещения, ФайлСценариев, "windows-1251");
	
КонецПроцедуры

&НаКлиенте
Процедура ДополнениеФайлаСценариевЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СценарийВыгрузкиЗаписан = Результат;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьЗаписанностьСценарияВыгрузки()
	
	Элементы.ПредупреждениеЭкспортаДанныхГруппа.Видимость = Ложь;
	
	Если СценарийВыгрузкиЗаписан = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Элементы.ПредупреждениеЭкспортаДанныхГруппа.Видимость = СценарийВыгрузкиЗаписан;
	ОтключитьОбработчикОжидания("ПроверитьЗаписанностьСценарияВыгрузки");
	
	Если СценарийВыгрузкиЗаписан = Истина Тогда
		ПерейтиДалее();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция СодержимоеФайлаСценариев(КаталогФайлов)
	
	Возврат Обработки.ПереносДанныхEStaff.СодержимоеФайлаСценариев(КаталогФайлов);
	
КонецФункции

&НаСервере
Функция ФайлСценариевДополнен(ТекстФорматаXML, КаталогФайлов)
	
	Возврат Обработки.ПереносДанныхEStaff.ФайлСценариевДополнен(ТекстФорматаXML, КаталогФайлов);
	
КонецФункции

#КонецОбласти

&НаКлиенте
Процедура ПодготовитьЗагружаемыеДанные()
	
	ДополнительныеПараметры = Новый Структура(
		"ОписанияОбъектов,
		|ОбработанныеОписания,
		|ИменаФайлов");
	ДополнительныеПараметры.ОписанияОбъектов = ПереносДанныхEStaffКлиентСервер.ОписанияЗагружаемыхОбъектов();
	ДополнительныеПараметры.ОбработанныеОписания = Новый Массив;
	ДополнительныеПараметры.ИменаФайлов = Новый Массив;
	
	НайтиФайлыПоОписаниюОбъектов(ДополнительныеПараметры);
	
КонецПроцедуры

&НаКлиенте
Процедура НайтиФайлыПоОписаниюОбъектов(ДополнительныеПараметры)
	
	ОписанияОбъектов = ДополнительныеПараметры.ОписанияОбъектов;
	ОбработанныеОписания = ДополнительныеПараметры.ОбработанныеОписания;
	
	Если ОписанияОбъектов.Количество() = 0 Тогда
		ПодготовитьОбъектыПоОписаниям(ОбработанныеОписания);
		Возврат;
	КонецЕсли;
	
	ТекущееОписание = ОписанияОбъектов[0];
	
	Маска = СтрШаблон("%1.XML", ТекущееОписание.Ключ);
	Если Не ТекущееОписание.ВОдномФайле Тогда
		Маска = СтрШаблон("%1-0x????????????????.XML", ТекущееОписание.Ключ);
	КонецЕсли;
	
	ОбработчикОповещения = Новый ОписаниеОповещения("НайтиФайлыПоОписаниюОбъектовЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	НачатьПоискФайлов(ОбработчикОповещения, КаталогСДаннымиСправочников, Маска, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура НайтиФайлыПоОписаниюОбъектовЗавершение(НайденныеФайлы, ДополнительныеПараметры) Экспорт
	
	Если НайденныеФайлы.Количество() = 0 Тогда
		ПродолжитьОбработкуОписанияОбъектов(ДополнительныеПараметры);
		Возврат;
	КонецЕсли;
	
	ПоместитьФайлыПоОписаниюОбъектов(НайденныеФайлы, ДополнительныеПараметры);
	
КонецПроцедуры

&НаКлиенте
Процедура ПродолжитьОбработкуОписанияОбъектов(ДополнительныеПараметры)
	
	ОписанияОбъектов = ДополнительныеПараметры.ОписанияОбъектов;
	ОбработанныеОписания = ДополнительныеПараметры.ОбработанныеОписания;
	
	ОбработанныеОписания.Добавить(ОписанияОбъектов[0]);
	ОписанияОбъектов.Удалить(0);
	
	НайтиФайлыПоОписаниюОбъектов(ДополнительныеПараметры);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоместитьФайлыПоОписаниюОбъектов(НайденныеФайлы, ДополнительныеПараметры)
	
	ИменаФайлов = ДополнительныеПараметры.ИменаФайлов;
	
	ПомещаемыеФайлы = Новый Массив;
	
	Для Каждого Файл Из НайденныеФайлы Цикл
		Если ИменаФайлов.Найти(Файл.ИмяБезРасширения) = Неопределено Тогда
			ИменаФайлов.Добавить(Файл.ИмяБезРасширения);
			ПомещаемыеФайлы.Добавить(Новый ОписаниеПередаваемогоФайла(Файл.ПолноеИмя));
		КонецЕсли;
	КонецЦикла;
	
	ОбработчикОповещения = Новый ОписаниеОповещения("ПоместитьФайлыПоОписаниюОбъектовЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	НачатьПомещениеФайлов(ОбработчикОповещения, ПомещаемыеФайлы, , Ложь, УникальныйИдентификатор);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоместитьФайлыПоОписаниюОбъектовЗавершение(ПомещенныеФайлы, ДополнительныеПараметры) Экспорт
	
	ТекущееОписание = ДополнительныеПараметры.ОписанияОбъектов[0];
	
	Если ПомещенныеФайлы <> Неопределено Тогда
		ТекущееОписание.ОписаниеФайлов = ПомещенныеФайлы;
	КонецЕсли;
	
	ПродолжитьОбработкуОписанияОбъектов(ДополнительныеПараметры);
	
КонецПроцедуры

&НаСервере
Процедура ПодготовитьОбъектыПоОписаниям(ОписанияОбъектов)
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИменаВременныхФайлов", ИменаВременныхФайлов);
	ДополнительныеПараметры.Вставить("УникальныйИдентификатор", УникальныйИдентификатор);
	ДополнительныеПараметры.Вставить("МесяцНачалаПереноса", МесяцНачалаПереноса);
	
	Результат = Обработки.ПереносДанныхEStaff.ПодготовитьОбъектыПоОписаниям(ОписанияОбъектов, ДополнительныеПараметры);
	
	КлючиОписанийОбъектов = Результат.КлючиОписаний;
	АдресОписанийИОбъектов = Результат.АдресОписанийИОбъектов;
	
КонецПроцедуры

&НаКлиенте
Процедура СопоставитьОбъектыОдногоТипа(ДополнительныеПараметры)
	
	КлючиОписаний = ДополнительныеПараметры.КлючиОписаний;
	
	Если КлючиОписаний.Количество() = 0 Тогда
		ПерейтиДалее();
		Возврат;
	КонецЕсли;
	
	Ключ = КлючиОписаний[0];
	КлючиОписаний.Удалить(0);
	
	ОткрыватьФормуСопоставления = Ложь;
	АдресТаблицыСоответствия = "";
	
	СопоставитьОбъектыНаСервере(Ключ, ОткрыватьФормуСопоставления, АдресТаблицыСоответствия);
	
	Если ОткрыватьФормуСопоставления Тогда
		
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("ОставшиесяКлючиОписаний", КлючиОписаний);
		ДополнительныеПараметры.Вставить("АдресТаблицыСоответствия", АдресТаблицыСоответствия);
		
		ПоказатьФормуСопоставления(Ключ, АдресОписанийИОбъектов, ДополнительныеПараметры);
		
	Иначе
		
		СопоставитьОбъектыОдногоТипа(ДополнительныеПараметры);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СопоставитьОбъектыНаСервере(КлючОписания, ОткрыватьФормуСопоставления, АдресТаблицыСоответствия)
	
	ОписанияИОбъекты = ПолучитьИзВременногоХранилища(АдресОписанийИОбъектов);
	ОписаниеИОбъектыПоКлючу = ОписанияИОбъекты[КлючОписания];
	Описание = ОписаниеИОбъектыПоКлючу.Описание;
	
	ТаблицаСоответствия = Обработки.ПереносДанныхEStaff.ТаблицаСоответствияОбъектов(ОписаниеИОбъектыПоКлючу);
	
	ОткрыватьФормуСопоставления = Описание.СопоставляетсяПользователем;
	
	Если Не ОткрыватьФормуСопоставления Тогда
		Обработки.ПереносДанныхEStaff.СохранитьТаблицуСоответствий(ТаблицаСоответствия, АдресОписанийИОбъектов, КлючОписания);
	Иначе
		АдресТаблицыСоответствия = ПоместитьВоВременноеХранилище(ТаблицаСоответствия);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьФормуСопоставления(КлючОписания, АдресОписанийИОбъектов, ДополнительныеПараметры)
	
	СоздаватьНовые = Истина;
	
	Если Не ОбновлятьСтруктуруПредприятия 
		И (КлючОписания = ПереносДанныхEStaffКлиентСервер.КлючОрганизации() 
		Или КлючОписания = ПереносДанныхEStaffКлиентСервер.КлючПодразделения()
		Или КлючОписания = ПереносДанныхEStaffКлиентСервер.КлючПозиции()) Тогда
		СоздаватьНовые = Ложь;
	КонецЕсли;
	
	Если Не ОбновлятьФизическихЛиц 
		И КлючОписания = ПереносДанныхEStaffКлиентСервер.КлючФизическогоЛица() Тогда
		СоздаватьНовые = Ложь;
	КонецЕсли;
	
	Если КлючОписания = ПереносДанныхEStaffКлиентСервер.КлючПользователя() Тогда
		СоздаватьНовые = Ложь;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("КлючОписания", КлючОписания);
	ПараметрыФормы.Вставить("АдресОписанийИОбъектов", АдресОписанийИОбъектов);
	ПараметрыФормы.Вставить("АдресТаблицыСоответствия", ДополнительныеПараметры.АдресТаблицыСоответствия);
	ПараметрыФормы.Вставить("СоздаватьНовые", СоздаватьНовые);
	
	ПараметрыОповещения = Новый Структура;
	ПараметрыОповещения.Вставить("КлючиОписаний", ДополнительныеПараметры.ОставшиесяКлючиОписаний);
	
	Оповещение = Новый ОписаниеОповещения("ЗавершениеПоказаФормыСопоставления", ЭтотОбъект, ПараметрыОповещения);
	
	ОткрытьФорму("Обработка.ПереносДанныхEStaff.Форма.СопоставлениеОбъектов", ПараметрыФормы, ЭтотОбъект, , , , Оповещение, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗавершениеПоказаФормыСопоставления(Результат, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(Результат) = Тип("Структура") 
		И Результат.Свойство("ВернутьсяВНачало") Тогда
		
		ПерейтиНазад();
		
	Иначе
		СопоставитьОбъектыОдногоТипа(ДополнительныеПараметры);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗадатьСоответствиеОбъектам()
	
	Если ЗначениеЗаполнено(КлючиОписанийОбъектов) Тогда
		Ключи = Новый Массив(КлючиОписанийОбъектов);
		СопоставитьОбъектыОдногоТипа(Новый Структура("КлючиОписаний", Ключи));
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОрганизациюПоУмолчанию()
	
	ОрганизацияПоУмолчанию = Справочники.Организации.ОрганизацияПоУмолчанию();
	
КонецПроцедуры

&НаСервере
Функция ФоновоеЗаданиеЗапуститьНаСервере(Отказ)
	
	ПараметрыЗадания = Новый Структура;
	
	ПараметрыЗадания.Вставить("ОписанияИОбъекты", ПолучитьИзВременногоХранилища(АдресОписанийИОбъектов));
	ПараметрыЗадания.Вставить("ОрганизацияПоУмолчанию", ОрганизацияПоУмолчанию);
	
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(УникальныйИдентификатор);
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = НСтр("ru = 'Запись объектов'");
	
	Результат = ДлительныеОперации.ВыполнитьВФоне(
		"Обработки.ПереносДанныхEStaff.ЗаписатьСопоставленныеДанные",
		ПараметрыЗадания,
		ПараметрыВыполнения);
		
	Если Результат = Неопределено Тогда
		Отказ = Истина;
		Возврат Неопределено;
	КонецЕсли;
	
	ИдентификаторЗадания     = Результат.ИдентификаторЗадания;
	АдресВременногоХранилища = Результат.АдресРезультата;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура ЗавершениеФоновогоЗадания(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		
		// Фоновое задание аварийно отменилось.
		ЗаписатьОшибкуВЖурнал(НСтр("ru = 'Фоновое задание аварийно отменилось.'"));
		ПерейтиНазад();
		
	ИначеЕсли Результат.Статус = "Отменено" Тогда
		
		ЗаписатьОшибкуВЖурнал(Результат.ПодробноеПредставлениеОшибки);
		ПерейтиНазад();
		
	ИначеЕсли Результат.Статус = "Ошибка" Тогда
		
		ЗаписатьОшибкуВЖурнал(Результат.ПодробноеПредставлениеОшибки);
		УстановитьТекстЗагрузкаВыполнена(Ложь);
		ПерейтиДалее();
		
	ИначеЕсли Результат.Статус = "Выполнено" Тогда
		
		Если ПолучитьИзВременногоХранилища(Результат.АдресРезультата).ПропущеноСОшибкой > 0 Тогда
			УстановитьТекстЗагрузкаВыполнена(Истина, Ложь);
		КонецЕсли;
		
		ПерейтиДалее();
		
	Иначе
		
		ПерейтиДалее();
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПрогрессВыполненияФоновогоЗадания(Прогресс, ДополнительныеПараметры) Экспорт
	
	Если Прогресс = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Прогресс.Прогресс <> Неопределено Тогда
		СтруктураПрогресса = Прогресс.Прогресс;
		ТекстПрогресс = СтруктураПрогресса.Текст;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЗакрытииНаСервере(Знач ИдентификаторОтменяемогоЗадания)
	
	ДлительныеОперации.ОтменитьВыполнениеЗадания(ИдентификаторОтменяемогоЗадания);
	Обработки.ПереносДанныхEStaff.УдалитьВременныеФайлы(ИменаВременныхФайлов);
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьОшибкуВЖурнал(ПодробноеПредставлениеОшибки)
	
	Обработки.ПереносДанныхEStaff.ЗаписатьОшибкуВЖурнал(ПодробноеПредставлениеОшибки);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийПереходов

&НаКлиенте
Функция Подключаемый_СценарийЭкспорта_ПриОткрытии(Отказ, ПропуститьСтраницу, ЭтоПереходДалее)
	
	СценарийВыгрузкиЗаписан = Неопределено;
	
	НачатьЗаписьСценарияВыгрузки();
	ПодключитьОбработчикОжидания("ПроверитьЗаписанностьСценарияВыгрузки", 1, Ложь);
	
КонецФункции

&НаКлиенте
Функция Подключаемый_ПроверкаПройдена_ПриОткрытии(Отказ, ПропуститьСтраницу, ЭтоПереходДалее)
	
	Если Не ЭтоПереходДалее Тогда 
		Возврат Неопределено;
	КонецЕсли;
	
	НайтиФайлыВакансий();
	НайтиФайлыФизическихЛиц();
	НайтиФайлыКандидатов();
	НайтиФайлыОбщихДанных();
	
КонецФункции

&НаКлиенте
Процедура НайтиФайлыВакансий()
	
	Ключ = ПереносДанныхEStaffКлиентСервер.КлючВакансии();
	ТекстСообщенияОбОшибке = НСтр("ru = 'Файлы с данными о вакансиях не найдены.'");
	
	НачатьПоискФайловПоКлючу(Ключ, ТекстСообщенияОбОшибке);
	
КонецПроцедуры

&НаКлиенте
Процедура НайтиФайлыФизическихЛиц()
	
	Ключ = ПереносДанныхEStaffКлиентСервер.КлючФизическогоЛица();
	ТекстСообщенияОбОшибке = НСтр("ru = 'Файлы с данными о физических лицах не найдены. Пример файла: person-0x5809E0E97CEB792F.xml
                                   |Убедитесь, что файлы выгружены и находятся в указанных каталогах.'");
	
	НачатьПоискФайловПоКлючу(Ключ, ТекстСообщенияОбОшибке);
	
КонецПроцедуры

&НаКлиенте
Процедура НайтиФайлыКандидатов()
	
	Ключ = ПереносДанныхEStaffКлиентСервер.КлючКандидата();
	ТекстСообщенияОбОшибке = НСтр("ru = 'Файлы с данными о кандидатах не найдены. Пример файла: candidate-0x5809E0E97CEB792F.xml
                                   |Убедитесь, что файлы выгружены и находятся в указанных каталогах.'");
	
	НачатьПоискФайловПоКлючу(Ключ, ТекстСообщенияОбОшибке);
	
КонецПроцедуры

&НаКлиенте
Процедура НайтиФайлыОбщихДанных()
	
	Ключ = ПереносДанныхEStaffКлиентСервер.КлючСтраны();
	ТекстСообщенияОбОшибке = НСтр("ru = 'Файлы с данными общих справочников не найдены.
                                   |Не все реквизиты вакансий и кандидатов будут заполнены.'");
	
	НачатьПоискФайловПоКлючу(Ключ, ТекстСообщенияОбОшибке);
	
КонецПроцедуры

&НаКлиенте
Процедура НачатьПоискФайловПоКлючу(Ключ, ТекстСообщенияОбОшибке)
	
	ДополнительныеПараметры = Новый Структура("ТекстСообщенияОбОшибке");
	ДополнительныеПараметры.ТекстСообщенияОбОшибке = ТекстСообщенияОбОшибке;
	
	ОбработчикОповещения = Новый ОписаниеОповещения("ЗавершитьПоискФайловПоКлючу", ЭтотОбъект, ДополнительныеПараметры);
	
	Маска = СтрШаблон("%1-0x????????????????.XML", Ключ);
	НачатьПоискФайлов(ОбработчикОповещения, КаталогСДаннымиСправочников, Маска, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗавершитьПоискФайловПоКлючу(НайденныеФайлы, ДополнительныеПараметры) Экспорт
	
	Если НайденныеФайлы.Количество() = 0 Тогда
		ТекстСообщения = ДополнительныеПараметры.ТекстСообщенияОбОшибке;
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция Подключаемый_ПроверкаПройдена_ПриПереходеДалее(Отказ)
	
	ПодготовитьЗагружаемыеДанные();
	ЗадатьСоответствиеОбъектам();
	
КонецФункции

&НаКлиенте
Функция Подключаемый_ЗагрузкаДанных_ОбработкаДлительнойОперации(Отказ, ПерейтиДалее)
	
	ИдентификаторЗадания = Неопределено;
	
	Результат = ФоновоеЗаданиеЗапуститьНаСервере(Отказ);
	
	Если Результат = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Если Результат.Статус = "Выполняется" Тогда
		
		ПерейтиДалее = Ложь;
		
		ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
		ПараметрыОжидания.ВыводитьОкноОжидания = Ложь;
		ПараметрыОжидания.ВыводитьСообщения    = Истина;
		
		ПараметрыОжидания.ВыводитьПрогрессВыполнения     = Истина;
		ПараметрыОжидания.ОповещениеОПрогрессеВыполнения = Новый ОписаниеОповещения("ПрогрессВыполненияФоновогоЗадания", ЭтотОбъект);
		ПараметрыОжидания.Интервал                       = 1;
		
		ОповещениеОЗавершении = Новый ОписаниеОповещения("ЗавершениеФоновогоЗадания", ЭтотОбъект);
		ДлительныеОперацииКлиент.ОжидатьЗавершение(Результат, ОповещениеОЗавершении, ПараметрыОжидания);
		
	ИначеЕсли Результат.Статус = "Ошибка" Тогда
		
		ЗаписатьОшибкуВЖурнал(Результат.ПодробноеПредставлениеОшибки);
		УстановитьТекстЗагрузкаВыполнена(Ложь);
		
	ИначеЕсли Результат.Статус = "Выполнено" Тогда
		
		Если ПолучитьИзВременногоХранилища(Результат.АдресРезультата).ПропущеноСОшибкой > 0 Тогда
			УстановитьТекстЗагрузкаВыполнена(Истина, Ложь);
		КонецЕсли;
		
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#Область ТаблицаПереходов

&НаСервере
Процедура СценарийЗагрузкиДанныхИзEStaff()
	
	ТаблицаПереходов.Очистить();
	
	ТаблицаПереходовНоваяСтрока(1, "Начало");
	ТаблицаПереходовНоваяСтрока(2, "ЭкспортОбщихДанных");
	ТаблицаПереходовНоваяСтрока(3, "СценарийЭкспорта", , "СценарийЭкспорта_ПриОткрытии");
	ТаблицаПереходовНоваяСтрока(4, "ЭкспортДанныхПоСценарию");
	ТаблицаПереходовНоваяСтрока(5, "ПроверкаПройдена", , "ПроверкаПройдена_ПриОткрытии", "ПроверкаПройдена_ПриПереходеДалее");
	ТаблицаПереходовНоваяСтрока(6, "СопоставлениеОбъектов");
	ТаблицаПереходовНоваяСтрока(7, "ЗагрузкаДанных", , , , , Истина, "ЗагрузкаДанных_ОбработкаДлительнойОперации");
	ТаблицаПереходовНоваяСтрока(8, "Окончание");
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецОбласти