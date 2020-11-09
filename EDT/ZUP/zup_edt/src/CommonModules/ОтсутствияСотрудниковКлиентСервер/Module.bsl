#Область СлужебныеПроцедурыИФункции

Функция ПредставлениеПериодаОтсутствия(Знач ДатаНачала, Знач ДатаОкончания, Знач ЧастьСмены, Знач КоличествоЧасов, ЧасыНаОтдельнойСтроке = Ложь) Экспорт
	
	Представление = "";
	
	Если ЧастьСмены Тогда
		
		Если КоличествоЧасов = 0 Тогда
			КоличествоЧасов = 8;
		КонецЕсли;
		
		Представление = СтрШаблон("%1 " + НСтр("ru='не полный день'")
			+ ?(ЧасыНаОтдельнойСтроке, Символы.ПС + "(", " ") + "%2 " + НСтр("ru='ч.'")
			+ ?(ЧасыНаОтдельнойСтроке, ")", ""),
			Формат(ДатаНачала, "ДЛФ=D"), КоличествоЧасов);
		
	Иначе
		
		Если ДатаНачала = ДатаОкончания Тогда
			
			Представление = СтрШаблон("%1 " + НСтр("ru='весь день'"),
				Формат(ДатаНачала, "ДЛФ=D"));
			
		Иначе
			
			Представление = СтрШаблон("%1 - %2",
				Формат(ДатаНачала, "ДЛФ=D"),
				Формат(ДатаОкончания, "ДЛФ=D"));
			
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Представление;
	
КонецФункции

Функция ПериодВводаДокумента(ПериодВвода, ПериодРегистрации) Экспорт
	
	ПериодыВводаДокумента = Новый Структура("НачалоПериода,ОкончаниеПериода");
	
	Если ПериодВвода = ПредопределенноеЗначение("Перечисление.ПериодыВводаДанныхОВремени.ПерваяПоловинаТекущегоМесяца") Тогда
		
		ПериодыВводаДокумента.НачалоПериода = НачалоМесяца(ПериодРегистрации);
		ПериодыВводаДокумента.ОкончаниеПериода = ЗарплатаКадрыКлиентСервер.ДобавитьДней(НачалоМесяца(ПериодРегистрации), + 15);
		
	ИначеЕсли ПериодВвода = ПредопределенноеЗначение("Перечисление.ПериодыВводаДанныхОВремени.ВтораяПоловинаТекущегоМесяца") Тогда
		
		ПериодыВводаДокумента.НачалоПериода = ЗарплатаКадрыКлиентСервер.ДобавитьДней(НачалоМесяца(ПериодРегистрации), + 16);
		ПериодыВводаДокумента.ОкончаниеПериода = КонецМесяца(ПериодРегистрации);
		
	Иначе
		
		ПериодыВводаДокумента.НачалоПериода = НачалоМесяца(ПериодРегистрации);
		ПериодыВводаДокумента.ОкончаниеПериода = КонецМесяца(ПериодРегистрации);
		
	КонецЕсли;
	
	Возврат ПериодыВводаДокумента;
	
КонецФункции

Функция ИменаДокументовВидовОтсутствия() Экспорт
	
	ИменаДокументов = Новый Соответствие;
	
	ДокументыВидыПериодов = ДокументыВидыПериодовОтсутствия();
	Для Каждого ОписаниеДокументаВидаПериода Из ДокументыВидыПериодов Цикл
		
		Если ОписаниеДокументаВидаПериода.ВидПериодаОтсутствия <> ПредопределенноеЗначение("Перечисление.ВидыПериодовОтсутствияСотрудников.ПустаяСсылка") Тогда
			ИменаДокументов.Вставить(ОписаниеДокументаВидаПериода.ВидПериодаОтсутствия, ОписаниеДокументаВидаПериода.ПолноеИмяОбъектаМетаданных);
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат ИменаДокументов;
	
КонецФункции

Функция ДокументыВидыПериодовОтсутствия() Экспорт
	
	СписокИменМетаданныхДокументов = Новый Массив;
	
	СписокИменМетаданныхДокументов.Добавить(
		Новый Структура("ПолноеИмяОбъектаМетаданных,ВидПериодаОтсутствия",
		"Документ.БольничныйЛист",
		ПредопределенноеЗначение("Перечисление.ВидыПериодовОтсутствияСотрудников.Больничный")));
	
	СписокИменМетаданныхДокументов.Добавить(
		Новый Структура("ПолноеИмяОбъектаМетаданных,ВидПериодаОтсутствия",
		"Документ.ПрогулНеявка",
		ПредопределенноеЗначение("Перечисление.ВидыПериодовОтсутствияСотрудников.Прогул")));
	
	СписокИменМетаданныхДокументов.Добавить(
		Новый Структура("ПолноеИмяОбъектаМетаданных,ВидПериодаОтсутствия",
		"Документ.ПрогулНеявка",
		ПредопределенноеЗначение("Перечисление.ВидыПериодовОтсутствияСотрудников.ПричинаНеИзвестна")));
	
	СписокИменМетаданныхДокументов.Добавить(
		Новый Структура("ПолноеИмяОбъектаМетаданных,ВидПериодаОтсутствия",
		"Документ.Отгул",
		ПредопределенноеЗначение("Перечисление.ВидыПериодовОтсутствияСотрудников.Отгул")));
	
	СписокИменМетаданныхДокументов.Добавить(
		Новый Структура("ПолноеИмяОбъектаМетаданных,ВидПериодаОтсутствия",
		"Документ.Отпуск",
		ПредопределенноеЗначение("Перечисление.ВидыПериодовОтсутствияСотрудников.Отпуск")));
	
	СписокИменМетаданныхДокументов.Добавить(
		Новый Структура("ПолноеИмяОбъектаМетаданных,ВидПериодаОтсутствия",
		"Документ.Командировка",
		ПредопределенноеЗначение("Перечисление.ВидыПериодовОтсутствияСотрудников.Командировка")));
	
	СписокИменМетаданныхДокументов.Добавить(
		Новый Структура("ПолноеИмяОбъектаМетаданных,ВидПериодаОтсутствия",
		"Документ.ОтпускБезСохраненияОплаты",
		ПредопределенноеЗначение("Перечисление.ВидыПериодовОтсутствияСотрудников.ПустаяСсылка")));
	
	СписокИменМетаданныхДокументов.Добавить(
		Новый Структура("ПолноеИмяОбъектаМетаданных,ВидПериодаОтсутствия",
		"Документ.ОтпускПоУходуЗаРебенком",
		ПредопределенноеЗначение("Перечисление.ВидыПериодовОтсутствияСотрудников.ПустаяСсылка")));
	
	СписокИменМетаданныхДокументов.Добавить(
		Новый Структура("ПолноеИмяОбъектаМетаданных,ВидПериодаОтсутствия",
		"Документ.ОплатаПоСреднемуЗаработку",
		ПредопределенноеЗначение("Перечисление.ВидыПериодовОтсутствияСотрудников.ПустаяСсылка")));
	
	// Документы на список сотрудников
	
	СписокИменМетаданныхДокументов.Добавить(
		Новый Структура("ПолноеИмяОбъектаМетаданных,ВидПериодаОтсутствия",
		"Документ.ПростойСотрудников",
		ПредопределенноеЗначение("Перечисление.ВидыПериодовОтсутствияСотрудников.Простой")));
	
	СписокИменМетаданныхДокументов.Добавить(
		Новый Структура("ПолноеИмяОбъектаМетаданных,ВидПериодаОтсутствия",
		"Документ.ОтгулСписком",
		ПредопределенноеЗначение("Перечисление.ВидыПериодовОтсутствияСотрудников.ПустаяСсылка")));
	
	СписокИменМетаданныхДокументов.Добавить(
		Новый Структура("ПолноеИмяОбъектаМетаданных,ВидПериодаОтсутствия",
		"Документ.ОтпускБезСохраненияОплатыСписком",
		ПредопределенноеЗначение("Перечисление.ВидыПериодовОтсутствияСотрудников.ПустаяСсылка")));
	
	Возврат СписокИменМетаданныхДокументов;
	
КонецФункции

Функция ОписаниеОтсутствия() Экспорт
	
	Описание = Новый Структура;
	
	Описание.Вставить("Сотрудник");
	Описание.Вставить("ВидОтсутствия");
	Описание.Вставить("Организация");
	Описание.Вставить("ПериодРегистрации");
	Описание.Вставить("Начало");
	Описание.Вставить("Окончание");
	Описание.Вставить("ЧастьСмены");
	Описание.Вставить("КоличествоЧасов");
	
	Возврат Описание;
	
КонецФункции

Функция ЗначенияЗаполненияДокумента(ИмяМетаданныхДокумента, ОписаниеОтсутствия) Экспорт
	
	ЗначенияЗаполнения = Новый Структура;
	
	ЗначенияЗаполнения.Вставить("ПериодРегистрации", ОписаниеОтсутствия.ПериодРегистрации);
	ЗначенияЗаполнения.Вставить("Организация", ОписаниеОтсутствия.Организация);
	ЗначенияЗаполнения.Вставить("Сотрудник", ОписаниеОтсутствия.Сотрудник);
	
	Если ИмяМетаданныхДокумента = "Документ.Отпуск" Тогда
		
		ЗначенияЗаполнения.Вставить("ПредоставитьОсновнойОтпуск", Истина);
		ЗначенияЗаполнения.Вставить("ДатаНачалаОсновногоОтпуска", ОписаниеОтсутствия.Начало);
		ЗначенияЗаполнения.Вставить("ДатаОкончанияОсновногоОтпуска", ОписаниеОтсутствия.Окончание);
		
	Иначе
		
		ЗначенияЗаполнения.Вставить("ДатаНачала", ОписаниеОтсутствия.Начало);
		ЗначенияЗаполнения.Вставить("ДатаОкончания", ОписаниеОтсутствия.Окончание);
		
	КонецЕсли;
	
	Если ОписаниеОтсутствия.ЧастьСмены И ИмяМетаданныхДокумента = "Документ.Командировка" Тогда
		
		ЗначенияЗаполнения.Вставить("ВнутрисменнаяКомандировка", Истина);
		ЗначенияЗаполнения.Вставить("ДатаКомандировки", ОписаниеОтсутствия.Начало);
		ЗначенияЗаполнения.Вставить("ОплачиватьЧасов", ОписаниеОтсутствия.КоличествоЧасов);
		
	ИначеЕсли ОписаниеОтсутствия.ЧастьСмены И ИмяМетаданныхДокумента = "Документ.Отгул" Тогда
		
		ЗначенияЗаполнения.Вставить("ОтсутствиеВТечениеЧастиСмены", Истина);
		ЗначенияЗаполнения.Вставить("ДатаОтсутствия", ОписаниеОтсутствия.Начало);
		ЗначенияЗаполнения.Вставить("КоличествоЧасовОтгула", ОписаниеОтсутствия.КоличествоЧасов);
		
	ИначеЕсли ОписаниеОтсутствия.ЧастьСмены И ИмяМетаданныхДокумента = "Документ.ПростойСотрудников" Тогда
		
		ЗначенияЗаполнения.Вставить("ВнутрисменныйПростой", Истина);
		ЗначенияЗаполнения.Вставить("ДатаПростоя", ОписаниеОтсутствия.Начало);
		ЗначенияЗаполнения.Вставить("ЧасыПростоя", ОписаниеОтсутствия.КоличествоЧасов);
		ЗначенияЗаполнения.Вставить("ВремяВЧасах", Истина);
		ЗначенияЗаполнения.Вставить("ОтработаноЧасов", ОписаниеОтсутствия.КоличествоЧасов);
		
	ИначеЕсли ОписаниеОтсутствия.ЧастьСмены И ИмяМетаданныхДокумента = "Документ.ПрогулНеявка" Тогда
		
		ЗначенияЗаполнения.Вставить("ОтсутствиеВТечениеЧастиСмены", Истина);
		ЗначенияЗаполнения.Вставить("ДатаОтсутствия", ОписаниеОтсутствия.Начало);
		ЗначенияЗаполнения.Вставить("ЧасовОтсутствия", ОписаниеОтсутствия.КоличествоЧасов);
		
	КонецЕсли;
	
	Если ИмяМетаданныхДокумента = "Документ.Командировка" Тогда
		ЗначенияЗаполнения.Вставить("ЗаполнитьПоПараметрамЗаполнения", Истина);
	ИначеЕсли ИмяМетаданныхДокумента = "Документ.ПрогулНеявка" Тогда
		
		Если ОписаниеОтсутствия.ВидОтсутствия = ПредопределенноеЗначение("Перечисление.ВидыПериодовОтсутствияСотрудников.Прогул") Тогда
			ЗначенияЗаполнения.Вставить("СостояниеСотрудника", ПредопределенноеЗначение("Перечисление.СостоянияСотрудника.Прогул"));
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат ЗначенияЗаполнения;
	
КонецФункции

Процедура УстановитьОтображениеКомандСозданияДокументовНачисленияКонтекстногоМеню(Форма, ТекущийВидОтсутствия) Экспорт
	
	ДокументыВидыПериодов = ДокументыВидыПериодовОтсутствия();
	Для Каждого ОписаниеДокументаВидаПериода Из ДокументыВидыПериодов Цикл
		
		ИмяДокумента = СтрЗаменить(ОписаниеДокументаВидаПериода.ПолноеИмяОбъектаМетаданных, "Документ.", "");
		УстановитьДоступностьКомандыОформленияОтсутствия(Форма, ИмяДокумента, ОписаниеДокументаВидаПериода.ВидПериодаОтсутствия, ТекущийВидОтсутствия);
		
	КонецЦикла;
	
КонецПроцедуры

Процедура УстановитьДоступностьКомандыОформленияОтсутствия(Форма, ИмяДокумента, ВидОтсутствияПоУмолчанию, ТекущийВидОтсутствия)
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		ИмяДокумента + "ПоУмолчанию",
		"Видимость",
		ВидОтсутствияПоУмолчанию = ТекущийВидОтсутствия);
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		ИмяДокумента,
		"Видимость",
		ВидОтсутствияПоУмолчанию <> ТекущийВидОтсутствия);
	
КонецПроцедуры

#КонецОбласти