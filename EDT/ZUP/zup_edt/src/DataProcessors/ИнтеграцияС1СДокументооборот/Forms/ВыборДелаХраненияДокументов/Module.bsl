
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Документ = Параметры.Документ;
	ДокументID = Параметры.ДокументID;
	ДокументТип = Параметры.ДокументТип;
	
	ДатаРегистрации = Параметры.ДатаРегистрации;
	
	ВидДокумента = Параметры.ВидДокумента;
	ВидДокументаID = Параметры.ВидДокументаID;
	ВидДокументаТип = Параметры.ВидДокументаТип;
	
	Дело = Параметры.Дело;
	ДелоID = Параметры.ДелоID;
	ДелоТип = Параметры.ДелоТип;
	
	НоменклатураДел = Параметры.НоменклатураДел;
	НоменклатураДелID = Параметры.НоменклатураДелID;
	НоменклатураДелТип = Параметры.НоменклатураДелТип;
	
	Контрагент = Параметры.Контрагент;
	КонтрагентID = Параметры.КонтрагентID;
	КонтрагентТип = Параметры.КонтрагентТип;
	
	Организация = Параметры.Организация;
	ОрганизацияID = Параметры.ОрганизацияID;
	ОрганизацияТип = Параметры.ОрганизацияТип;
	
	Подразделение = Параметры.Подразделение;
	ПодразделениеID = Параметры.ПодразделениеID;
	ПодразделениеТип = Параметры.ПодразделениеТип;
	
	ПрочитатьДеревоДелВФорму();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Выбрать();
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	Строка = Элемент.ТекущиеДанные;
	Если Строка = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТекущееДело = Строка.Представление;
	ТекущееДелоID = Строка.ID;
	ТекущееДелоТип = Строка.Тип;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаВыбрать(Команда)
	
	Выбрать();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПрочитатьДеревоДелВФорму()
	
	Прокси = ИнтеграцияС1СДокументооборотПовтИсп.ПолучитьПрокси();
	
	Запрос = ИнтеграцияС1СДокументооборот.СоздатьОбъект(Прокси, "DMGetCaseFilesDossiersRequest");
	
	Запрос.company = ИнтеграцияС1СДокументооборот.СоздатьОбъект(Прокси, "DMOrganization");
	Запрос.company.name = Организация;
	Запрос.company.objectID = ИнтеграцияС1СДокументооборот.СоздатьОбъект(Прокси, "DMObjectID");
	Запрос.company.objectID.id = ОрганизацияID;
	Запрос.company.objectID.type = ОрганизацияТип;
	
	Запрос.department = ИнтеграцияС1СДокументооборот.СоздатьОбъект(Прокси, "DMSubdivision");
	Запрос.department.name = Подразделение;
	Запрос.department.objectID = ИнтеграцияС1СДокументооборот.СоздатьОбъект(Прокси, "DMObjectID");
	Запрос.department.objectID.id = ПодразделениеID;
	Запрос.department.objectID.type = ПодразделениеТип;
	
	Запрос.regDate = ДатаРегистрации;
	
	Запрос.caseFilesCatalog = ИнтеграцияС1СДокументооборот.СоздатьОбъект(Прокси, "DMCaseFilesCatalog");
	Запрос.caseFilesCatalog.name = НоменклатураДел;
	Запрос.caseFilesCatalog.objectID = ИнтеграцияС1СДокументооборот.СоздатьОбъект(Прокси, "DMObjectID");
	Запрос.caseFilesCatalog.objectID.id = НоменклатураДелID;
	Запрос.caseFilesCatalog.objectID.type = НоменклатураДелТип;
	
	Запрос.documentType = ИнтеграцияС1СДокументооборот.СоздатьОбъект(Прокси, "DMObject");
	Запрос.documentType.name = ВидДокумента;
	Запрос.documentType.objectID = ИнтеграцияС1СДокументооборот.СоздатьОбъект(Прокси, "DMObjectID");
	Запрос.documentType.objectID.id = ВидДокументаID;
	Запрос.documentType.objectID.type = ВидДокументаТип;
	
	Запрос.correspondent = ИнтеграцияС1СДокументооборот.СоздатьОбъект(Прокси, "DMCorrespondent");
	Запрос.correspondent.name = Контрагент;
	Запрос.correspondent.objectID = ИнтеграцияС1СДокументооборот.СоздатьОбъект(Прокси, "DMObjectID");
	Запрос.correspondent.objectID.id = КонтрагентID;
	Запрос.correspondent.objectID.type = КонтрагентТип;
	
	Запрос.activityMatter = ИнтеграцияС1СДокументооборот.СоздатьОбъект(Прокси, "DMActivityMatter");
	Запрос.activityMatter.name = ВопросДеятельности;
	Запрос.activityMatter.objectID = ИнтеграцияС1СДокументооборот.СоздатьОбъект(Прокси, "DMObjectID");
	Запрос.activityMatter.objectID.id = ВопросДеятельностиID;
	Запрос.activityMatter.objectID.type = ВопросДеятельностиТип;
	
	РезультатСписокДел = Прокси.execute(Запрос);
	ИнтеграцияС1СДокументооборот.ПроверитьВозвратВебСервиса(Прокси, РезультатСписокДел);
	
	ЗаполнитьСписокДел(РезультатСписокДел.сaseFilesDossiers);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокДел(сaseFilesDossiers)
	
	ДеревоДел = РеквизитФормыВЗначение("Список");
	ДеревоДел.Строки.Очистить();
	
	ТаблицаДел = Новый ТаблицаЗначений;
	ТаблицаДел.Колонки.Добавить("name", Новый ОписаниеТипов("Строка"));
	ТаблицаДел.Колонки.Добавить("presentation", Новый ОписаниеТипов("Строка"));
	ТаблицаДел.Колонки.Добавить("ID", Новый ОписаниеТипов("Строка"));
	ТаблицаДел.Колонки.Добавить("type", Новый ОписаниеТипов("Строка"));
	ТаблицаДел.Колонки.Добавить("index", Новый ОписаниеТипов("Строка"));
	ТаблицаДел.Колонки.Добавить("startDate", Новый ОписаниеТипов("Дата"));
	ТаблицаДел.Колонки.Добавить("endDate", Новый ОписаниеТипов("Дата"));
	ТаблицаДел.Колонки.Добавить("comment", Новый ОписаниеТипов("Строка"));
	ТаблицаДел.Колонки.Добавить("year", Новый ОписаниеТипов("Число"));
	ТаблицаДел.Колонки.Добавить("section", Новый ОписаниеТипов("Строка"));
	Для Каждого ДелоХраненияДокументов Из сaseFilesDossiers Цикл
		НоваяСтрока = ТаблицаДел.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, ДелоХраненияДокументов);
		НоваяСтрока.ID = ДелоХраненияДокументов.objectID.id;
		НоваяСтрока.type = ДелоХраненияДокументов.objectID.type;
		НоваяСтрока.presentation = ДелоХраненияДокументов.objectID.presentation;
		НоваяСтрока.year = ДелоХраненияДокументов.caseFilesCatalog.year;
		НоваяСтрока.index = ДелоХраненияДокументов.caseFilesCatalog.index;
		Если ИнтеграцияС1СДокументооборот.СвойствоУстановлено(ДелоХраненияДокументов.caseFilesCatalog, "section") Тогда
			НоваяСтрока.section = ДелоХраненияДокументов.caseFilesCatalog.section.name;
		КонецЕсли;
	КонецЦикла;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	CaseFilesDossiers.name КАК Наименование,
		|	CaseFilesDossiers.presentation КАК Представление,
		|	CaseFilesDossiers.ID КАК ID,
		|	CaseFilesDossiers.type КАК Тип,
		|	CaseFilesDossiers.index КАК Индекс,
		|	CaseFilesDossiers.startDate КАК Начато,
		|	CaseFilesDossiers.endDate КАК Окончено,
		|	CaseFilesDossiers.comment КАК Комментарий,
		|	CaseFilesDossiers.year КАК Год,
		|	CaseFilesDossiers.section КАК Раздел
		|ПОМЕСТИТЬ ДелаХраненияДокументов
		|ИЗ
		|	&CaseFilesDossiers КАК CaseFilesDossiers
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ДелаХраненияДокументов.Год КАК Год,
		|	ВЫРАЗИТЬ(ДелаХраненияДокументов.Раздел КАК СТРОКА(1000)) КАК Раздел,
		|	ВЫРАЗИТЬ(ДелаХраненияДокументов.Наименование КАК СТРОКА(1000)) КАК Наименование,
		|	ДелаХраненияДокументов.Представление КАК Представление,
		|	ДелаХраненияДокументов.ID КАК ID,
		|	ДелаХраненияДокументов.Тип КАК Тип,
		|	ДелаХраненияДокументов.Индекс КАК Индекс,
		|	ДелаХраненияДокументов.Начато КАК Начато,
		|	ДелаХраненияДокументов.Окончено КАК Окончено,
		|	ДелаХраненияДокументов.Комментарий КАК Комментарий
		|ИЗ
		|	ДелаХраненияДокументов КАК ДелаХраненияДокументов
		|
		|УПОРЯДОЧИТЬ ПО
		|	Год,
		|	Раздел,
		|	Наименование
		|ИТОГИ ПО
		|	Год,
		|	Раздел";
	Запрос.УстановитьПараметр("CaseFilesDossiers", ТаблицаДел);
	
	ВыборкаГод = Запрос.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Пока ВыборкаГод.Следующий() Цикл
		СтрокаГод = ДеревоДел.Строки.Добавить();
		СтрокаГод.Наименование = ВыборкаГод.Год;
		СтрокаГод.ИндексКартинки = 2;
		
		ВыборкаРаздел = ВыборкаГод.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
		Пока ВыборкаРаздел.Следующий() Цикл
			СтрокаРаздел = СтрокаГод.Строки.Добавить();
			СтрокаРаздел.Наименование = ВыборкаРаздел.Раздел;
			СтрокаРаздел.ИндексКартинки = 2;
			
			Выборка = ВыборкаРаздел.Выбрать();
			Пока Выборка.Следующий() Цикл
				Строка = СтрокаРаздел.Строки.Добавить();
				ЗаполнитьЗначенияСвойств(Строка, Выборка);
				Строка.ИндексКартинки = -1;
			КонецЦикла;
			
		КонецЦикла;
		
	КонецЦикла;
	
	ЗначениеВРеквизитФормы(ДеревоДел, "Список");
	
КонецПроцедуры

&НаКлиенте
Процедура Выбрать()
	
	ОчиститьСообщения();
	Если ТекущееДелоID = "" Тогда
		ПоказатьПредупреждение(,
			НСтр("ru = 'Выберите элемент, а не группу!
						|Для раскрытия групп используйте ""Ctrl"" и стрелки вниз/вверх
						|или клавиши ""+"" и ""-"" на дополнительной клавиатуре.'"));
		Возврат;
	КонецЕсли;
	
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	
	Результат = Новый Структура;
	Результат.Вставить("Дело", ТекущееДело);
	Результат.Вставить("ДелоID", ТекущееДелоID);
	Результат.Вставить("ДелоТип", ТекущееДелоТип);
	
	Закрыть(Результат);
	
КонецПроцедуры

#КонецОбласти
