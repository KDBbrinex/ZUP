#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	НастройкиОтчета = КомпоновщикНастроек.ПолучитьНастройки();
	
	СтандартнаяОбработка = ложь;
	
	ДокументРезультат.Очистить();
	
	ПараметрПериодОтчета = НастройкиОтчета.ПараметрыДанных.Элементы.Найти("Период");
	Если НЕ ПараметрПериодОтчета .Использование Тогда
		ПараметрПериодОтчета .Значение = ТекущаяДатаСеанса();
		ПараметрПериодОтчета .Использование = Истина;
	КонецЕсли;
	
	ПараметрОрганизация = НастройкиОтчета.ПараметрыДанных.Элементы.Найти("Организация");
	ОтборОтчета = НастройкиОтчета.Отбор.Элементы;
	Если ПараметрОрганизация.Использование Тогда
		НовыйЭлементОтбора = ОтборОтчета.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		НовыйЭлементОтбора.Использование = Истина;
		НовыйЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ПозицияШтатногоРасписания.Владелец");
		НовыйЭлементОтбора.ПравоеЗначение = ПараметрОрганизация.Значение;
		НовыйЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	КонецЕсли;
	
	МакетКомпоновки = ЗарплатаКадрыОтчеты.МакетКомпоновкиДанных(СхемаКомпоновкиДанных, НастройкиОтчета, ДанныеРасшифровки);
	
	// Создадим и инициализируем процессор компоновки.
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки, , ДанныеРасшифровки, Истина);
	
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(ДокументРезультат);
	
	// Обозначим начало вывода.
	ПроцессорВывода.Вывести(ПроцессорКомпоновки, Истина);
	
	// Переопределение флага "ОтчетПустой", подсистема рассылки отчетов.
	ОтчетПустой = ОтчетыСервер.ОтчетПустой(ЭтотОбъект, ПроцессорКомпоновки);
	КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства.Вставить("ОтчетПустой", ОтчетПустой);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ИнициализироватьОтчет() Экспорт
	
	ЗарплатаКадрыОбщиеНаборыДанных.ЗаполнитьОбщиеИсточникиДанныхОтчета(ЭтотОбъект);
	
КонецПроцедуры

// Для общей формы "Форма отчета" подсистемы "Варианты отчетов".
Процедура ОпределитьНастройкиФормы(Форма, КлючВарианта, Настройки) Экспорт
	
	Настройки.События.ПередЗагрузкойНастроекВКомпоновщик = Истина;
	
КонецПроцедуры

// Вызывается перед загрузкой новых настроек. Используется для изменения схемы компоновки.
//
Процедура ПередЗагрузкойНастроекВКомпоновщик(Контекст, КлючСхемы, КлючВарианта, НовыеНастройкиКД, НовыеПользовательскиеНастройкиКД) Экспорт
	
	Если КлючСхемы <> КлючВарианта Тогда
		
		ИнициализироватьОтчет();
		ОтчетыСервер.ПодключитьСхему(ЭтотОбъект, Контекст, СхемаКомпоновкиДанных, КлючСхемы);
		
		КлючСхемы = КлючВарианта;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли