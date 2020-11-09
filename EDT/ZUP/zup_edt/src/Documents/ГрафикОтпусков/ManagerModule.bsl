#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ДляВсехСтрок( ЗначениеРазрешено(Сотрудники.ФизическоеЛицо, NULL КАК ИСТИНА)
	|	) И ЗначениеРазрешено(Организация)";
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает описание состава документа
//
// Возвращаемое значение:
//  Структура - см. ЗарплатаКадрыСоставДокументов.НовоеОписаниеСоставаОбъекта.
Функция ОписаниеСоставаОбъекта() Экспорт
	
	МетаданныеДокумента = Метаданные.Документы.ГрафикОтпусков;
	Возврат ЗарплатаКадрыСоставДокументов.ОписаниеСоставаОбъектаПоМетаданнымФизическиеЛицаВТабличныхЧастях(МетаданныеДокумента);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// СтандартныеПодсистемы.ВерсионированиеОбъектов

// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
//  Настройки - Структура - настройки подсистемы.
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт

КонецПроцедуры

// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов

Функция ДобавитьКомандыСозданияДокументов(КомандыСозданияДокументов, ДополнительныеПараметры) Экспорт
	
	ЗарплатаКадрыРасширенный.ДобавитьВКоллекциюКомандуСозданияДокументаПоМетаданнымДокумента(
		КомандыСозданияДокументов, Метаданные.Документы.ГрафикОтпусков);
	
КонецФункции

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.Обработчик = "УправлениеПечатьюБЗККлиент.ВыполнитьКомандуПечати";
	КомандаПечати.Идентификатор = "ПФ_MXL_Т7";
	КомандаПечати.Представление = НСтр("ru = 'График отпусков (Т-7)'");
	КомандаПечати.ПроверкаПроведенияПередПечатью = Истина;
	
КонецПроцедуры

Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ПФ_MXL_Т7") Тогда
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(КоллекцияПечатныхФорм, "ПФ_MXL_Т7", НСтр("ru='Форма Т-7'"), ПечатьТ7(МассивОбъектов, ОбъектыПечати), , "Отчет.ГрафикОтпусков.ПФ_MXL_Т7");	
	КонецЕсли;
	
КонецПроцедуры

Функция ПечатьТ7(МассивОбъектов, ОбъектыПечати)
	
	ТабличныйДокумент = Новый ТабличныйДокумент;
	ТабличныйДокумент.АвтоМасштаб = Истина;
	ТабличныйДокумент.КлючПараметровПечати = "ПАРАМЕТРЫ_ПЕЧАТИ_Унифицированная_форма_Т_7";
	НомерСтрокиНачало = ТабличныйДокумент.ВысотаТаблицы + 1;
	
	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ГрафикОтпусковСотрудники.Ссылка КАК Ссылка,
	|	ГрафикОтпусковСотрудники.Ссылка.Дата,
	|	ГрафикОтпусковСотрудники.Ссылка.Номер,
	|	МАКСИМУМ(ГрафикОтпусковСотрудники.ДатаОкончания) КАК ДатаОкончанияПериода,
	|	МИНИМУМ(ГрафикОтпусковСотрудники.ДатаНачала) КАК ДатаНачалаПериода,
	|	ГрафикОтпусковСотрудники.Ссылка.Руководитель КАК Руководитель,
	|	ГрафикОтпусковСотрудники.Ссылка.ДолжностьРуководителя КАК ДолжностьРуководителя,
	|	ГрафикОтпусковСотрудники.Ссылка.РуководительКадровойСлужбы КАК РуководительКадровойСлужбы,
	|	ГрафикОтпусковСотрудники.Ссылка.ДолжностьРуководителяКадровойСлужбы КАК ДолжностьРуководителяКадровойСлужбы
	|ИЗ
	|	Документ.ГрафикОтпусков.Сотрудники КАК ГрафикОтпусковСотрудники
	|ГДЕ
	|	ГрафикОтпусковСотрудники.Ссылка В(&МассивОбъектов)
	|
	|СГРУППИРОВАТЬ ПО
	|	ГрафикОтпусковСотрудники.Ссылка,
	|	ГрафикОтпусковСотрудники.Ссылка.Дата,
	|	ГрафикОтпусковСотрудники.Ссылка.Номер,
	|	ГрафикОтпусковСотрудники.Ссылка.РуководительКадровойСлужбы,
	|	ГрафикОтпусковСотрудники.Ссылка.ДолжностьРуководителяКадровойСлужбы,
	|	ГрафикОтпусковСотрудники.Ссылка.Руководитель,
	|	ГрафикОтпусковСотрудники.Ссылка.ДолжностьРуководителя";
				   
	Выборка = Запрос.Выполнить().Выбрать();			   
	
	ОтчетТ7 = Отчеты.ГрафикОтпусков.Создать();
	ОтчетТ7.КомпоновщикНастроек.ЗагрузитьНастройки(ОтчетТ7.СхемаКомпоновкиДанных.ВариантыНастроек.Т7.Настройки);
	ОтчетТ7.ИнициализироватьОтчет();
	ОтчетТ7.КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства.Вставить("КлючВарианта", "Т7");
	
	Пока Выборка.Следующий() Цикл 
		
		НомерСтрокиНачало = ТабличныйДокумент.ВысотаТаблицы + 1;
		
		ДокументРезультат = Новый ТабличныйДокумент;
			
		НастройкиОтчета = ОтчетТ7.КомпоновщикНастроек.Настройки;	
			
		ПараметрПериод = НастройкиОтчета.ПараметрыДанных.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных("Период"));
		Если ПараметрПериод <> Неопределено Тогда
			ПараметрПериод.Значение = Новый СтандартныйПериод(НачалоГода(Выборка.ДатаНачалаПериода), КонецГода(Выборка.ДатаОкончанияПериода));
			ПараметрПериод.Использование = Истина;
		КонецЕсли;
		
		ПараметрДатаОтчета = НастройкиОтчета.ПараметрыДанных.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных("ДатаДок"));
		Если ПараметрДатаОтчета <> Неопределено Тогда
			ОтчетТ7.КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства.Вставить("ВосстанавливатьПериод", Истина);
			ПараметрДатаОтчета.Значение = Выборка.Дата; 
			ПараметрДатаОтчета.Использование = Истина;
		Иначе	
			ОтчетТ7.КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства.Вставить("ВосстанавливатьПериод", Ложь);
		КонецЕсли;
		
		ПараметрДатаОтчета = НастройкиОтчета.ПараметрыДанных.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных("НомерДок"));
		Если ПараметрДатаОтчета <> Неопределено Тогда
			ПараметрДатаОтчета.Значение = Выборка.Номер; 
			ПараметрДатаОтчета.Использование = Истина;
		КонецЕсли;
		
		ОтчетТ7.КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства.Вставить(
			"Руководитель", Выборка.Руководитель);		
		ОтчетТ7.КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства.Вставить(
			"ДолжностьРуководителя", Выборка.ДолжностьРуководителя);		
		ОтчетТ7.КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства.Вставить(
			"РуководительКадровойСлужбы", Выборка.РуководительКадровойСлужбы);		
		ОтчетТ7.КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства.Вставить(
			"ДолжностьРуководителяКадровойСлужбы", Выборка.ДолжностьРуководителяКадровойСлужбы);		
		
		Отбор = НастройкиОтчета.Отбор;
		Отбор.Элементы.Очистить();
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "ДокументПланирования", ВидСравненияКомпоновкиДанных.Равно, Выборка.Ссылка);
		
		ОтчетТ7.СкомпоноватьРезультат(ДокументРезультат);
		
		ТабличныйДокумент.Вывести(ДокументРезультат);
		
		УправлениеПечатью.ЗадатьОбластьПечатиДокумента(ТабличныйДокумент, НомерСтрокиНачало, ОбъектыПечати, Выборка.Ссылка);
		
	КонецЦикла;
	
	Возврат ТабличныйДокумент;
	
КонецФункции

// Проверяет, что сотрудники, указанные в документе работает в периоды отсутствия.
//
// Параметры:
//		ДокументОбъект	- ДокументОбъект.ГрафикОтпусков
//		Отказ			- Булево
//
Процедура ПроверитьРаботающих(ДокументОбъект, Отказ) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	Запрос.УстановитьПараметр("Сотрудники", ДокументОбъект.Сотрудники.Выгрузить());
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Сотрудники.НомерСтроки,
	|	Сотрудники.Сотрудник,
	|	Сотрудники.ДатаНачала,
	|	Сотрудники.ДатаОкончания
	|ПОМЕСТИТЬ ВТСотрудникиПериоды
	|ИЗ
	|	&Сотрудники КАК Сотрудники";
	
	Запрос.Выполнить();
	
	УстановитьПривилегированныйРежим(Истина);
	КадровыйУчетРасширенный.СоздатьВТПериодыВКоторыхСотрудникНеРаботал(Запрос.МенеджерВременныхТаблиц);
	УстановитьПривилегированныйРежим(Ложь);
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ВТСотрудникиПериоды.НомерСтроки КАК НомерСтроки,
	|	ВТСотрудникиПериоды.Сотрудник,
	|	ВТСотрудникиПериоды.ДатаНачала,
	|	ВТСотрудникиПериоды.ДатаОкончания
	|ИЗ
	|	ВТСотрудникиПериоды КАК ВТСотрудникиПериоды
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТПериодыВКоторыхСотрудникНеРаботал КАК ВТПериоды
	|		ПО ВТСотрудникиПериоды.Сотрудник = ВТПериоды.Сотрудник
	|			И ВТСотрудникиПериоды.ДатаНачала = ВТПериоды.ДатаНачала
	|			И ВТСотрудникиПериоды.ДатаОкончания = ВТПериоды.ДатаОкончания
	|
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если НЕ РезультатЗапроса.Пустой() Тогда
		
		Выборка = РезультатЗапроса.Выбрать();
		Пока Выборка.Следующий() Цикл
			
			Если Выборка.ДатаНачала = Выборка.ДатаОкончания Тогда
				
				ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='Сотрудник %1 не работает в организации  %2г.'"),
				Выборка.Сотрудник,
				Формат(Выборка.ДатаНачала, "ДЛФ=Д"));
				
			Иначе
				
				ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='Сотрудник %1 не работает в организации в периоде с %2г. по %3г.'"),
				Выборка.Сотрудник,
				Формат(Выборка.ДатаНачала, "ДЛФ=Д"),
				Формат(Выборка.ДатаОкончания, "ДЛФ=Д"));
				
			КонецЕсли;
			
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, , "Сотрудники[" + Формат(Выборка.НомерСтроки - 1, "ЧГ=") + "].Сотрудник", "Объект", Отказ);
			
		КонецЦикла; 
		
	КонецЕсли; 

КонецПроцедуры

// Устанавливает параметры загрузки.
//
Процедура УстановитьПараметрыЗагрузкиИзФайлаВТЧ(Параметры) Экспорт
	
КонецПроцедуры

// Производит сопоставление данных, загружаемых в табличную часть ПолноеИмяТабличнойЧасти,
// с данными в ИБ, и заполняет параметры АдресТаблицыСопоставления и СписокНеоднозначностей.
//
// Параметры:
//   АдресЗагружаемыхДанных    - Строка - Адрес временного хранилища с таблицей значений, в которой
//                                        находятся загруженные данные из файла. Состав колонок:
//     * Идентификатор - Число - Порядковый номер строки;
//     * остальные колонки соответствуют колонкам макета ЗагрузкаИзФайла.
//   АдресТаблицыСопоставления - Строка - Адрес временного хранилища с пустой таблицей значений,
//                                        являющейся копией табличной части документа, 
//                                        которую необходимо заполнить из таблицы АдресЗагружаемыхДанных.
//   СписокНеоднозначностей - ТаблицаЗначений - Список неоднозначных значений, для которых в ИБ имеется несколько
//                                              подходящих вариантов.
//     * Колонка       - Строка - Имя колонки, в которой была обнаружена неоднозначность;
//     * Идентификатор - Число  - Идентификатор строки, в которой была обнаружена неоднозначность.
//   ПолноеИмяТабличнойЧасти   - Строка - Полное имя табличной части, в которую загружаются данные.
//   ДополнительныеПараметры   - ЛюбойТип - Любые дополнительные сведения.
//
Процедура СопоставитьЗагружаемыеДанные(АдресЗагружаемыхДанных, АдресТаблицыСопоставления, СписокНеоднозначностей, ПолноеИмяТабличнойЧасти, ДополнительныеПараметры) Экспорт
	
	Сотрудники =  ПолучитьИзВременногоХранилища(АдресТаблицыСопоставления);
	ЗагружаемыеДанные = ПолучитьИзВременногоХранилища(АдресЗагружаемыхДанных);
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	Запрос = Новый Запрос;
	
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	Запрос.УстановитьПараметр("ДанныеДляСопоставления", ЗагружаемыеДанные);
	Запрос.УстановитьПараметр("Период", ДополнительныеПараметры.ДатаДокумента);
	Запрос.УстановитьПараметр("Организация", ДополнительныеПараметры.Организация);
	
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВЫРАЗИТЬ(ДанныеДляСопоставления.Сотрудник КАК СТРОКА(100)) КАК Сотрудник,
		|	ВЫРАЗИТЬ(ДанныеДляСопоставления.ВидОтпуска КАК СТРОКА(100)) КАК ВидОтпуска,
		|	ДанныеДляСопоставления.Идентификатор КАК Идентификатор
		|ПОМЕСТИТЬ ВТДанныеДляСопоставления
		|ИЗ
		|	&ДанныеДляСопоставления КАК ДанныеДляСопоставления
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	Сотрудники.Ссылка КАК Сотрудник,
		|	ДанныеДляСопоставления.Идентификатор КАК Идентификатор,
		|	&Период КАК Период
		|ПОМЕСТИТЬ ВТСотрудники
		|ИЗ
		|	ВТДанныеДляСопоставления КАК ДанныеДляСопоставления
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Сотрудники КАК Сотрудники
		|		ПО ДанныеДляСопоставления.Сотрудник = Сотрудники.Наименование
		|			И (НЕ Сотрудники.ВАрхиве)";
		
	Запрос.Выполнить();
	
	ОписаниеВТ = КадровыйУчет.ОписательВременныхТаблицДляСоздатьВТКадровыеДанныеСотрудников(МенеджерВременныхТаблиц, "ВТСотрудники");
	КадровыйУчет.СоздатьВТКадровыеДанныеСотрудников(ОписаниеВТ, Истина, "Организация");
		
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	МАКСИМУМ(Сотрудники.Сотрудник) КАК Сотрудник,
		|	Сотрудники.Идентификатор КАК Идентификатор,
		|	КОЛИЧЕСТВО(Сотрудники.Идентификатор) КАК Количество
		|ИЗ
		|	ВТСотрудники КАК Сотрудники
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТКадровыеДанныеСотрудников КАК КадровыеДанныеСотрудников
		|		ПО Сотрудники.Сотрудник = КадровыеДанныеСотрудников.Сотрудник
		|			И (КадровыеДанныеСотрудников.Организация = &Организация)
		|
		|СГРУППИРОВАТЬ ПО
		|	Сотрудники.Идентификатор
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	МАКСИМУМ(ВидыОтпусков.Ссылка) КАК ВидОтпуска,
		|	ДанныеДляСопоставления.Идентификатор КАК Идентификатор,
		|	КОЛИЧЕСТВО(ДанныеДляСопоставления.Идентификатор) КАК Количество
		|ИЗ
		|	ВТДанныеДляСопоставления КАК ДанныеДляСопоставления
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ВидыОтпусков КАК ВидыОтпусков
		|		ПО (ВидыОтпусков.Наименование = ДанныеДляСопоставления.ВидОтпуска)
		|
		|СГРУППИРОВАТЬ ПО
		|	ДанныеДляСопоставления.Идентификатор";

	РезультатыЗапросов = Запрос.ВыполнитьПакет();
	
	ТаблицаСотрудники 	= РезультатыЗапросов[0].Выгрузить();
	ТаблицаВидыОтпусков = РезультатыЗапросов[1].Выгрузить();

	Для Каждого СтрокаТаблицы Из ЗагружаемыеДанные Цикл
		
		СтрокаСотрудник = Сотрудники.Добавить();
		СтрокаСотрудник.Идентификатор 	= СтрокаТаблицы.Идентификатор;
		СтрокаСотрудник.ДатаНачала 		= СтроковыеФункцииКлиентСервер.СтрокаВДату(СтрокаТаблицы.ДатаНачала);
		СтрокаСотрудник.ДатаОкончания 	= СтроковыеФункцииКлиентСервер.СтрокаВДату(СтрокаТаблицы.ДатаОкончания);
		
		СтрокаТаблицыСотрудник = ТаблицаСотрудники.Найти(СтрокаТаблицы.Идентификатор, "Идентификатор");
		Если СтрокаТаблицыСотрудник <> Неопределено Тогда 
			Если СтрокаТаблицыСотрудник.Количество = 1 Тогда 
				СтрокаСотрудник.Сотрудник = СтрокаТаблицыСотрудник.Сотрудник;
			ИначеЕсли СтрокаТаблицыСотрудник.Количество > 1 Тогда
				ЗаписьОНеоднозначности = СписокНеоднозначностей.Добавить();
				ЗаписьОНеоднозначности.Идентификатор = СтрокаТаблицы.Идентификатор; 
				ЗаписьОНеоднозначности.Колонка = "Сотрудник";
			КонецЕсли;
		КонецЕсли;
		
		СтрокаТаблицыВидыОтпусков = ТаблицаВидыОтпусков.Найти(СтрокаТаблицы.Идентификатор, "Идентификатор");
		Если СтрокаТаблицыВидыОтпусков <> Неопределено Тогда
			Если СтрокаТаблицыВидыОтпусков.Количество = 1 Тогда 
				СтрокаСотрудник.ВидОтпуска = СтрокаТаблицыВидыОтпусков.ВидОтпуска;
			ИначеЕсли СтрокаТаблицыВидыОтпусков.Количество > 1 Тогда
				ЗаписьОНеоднозначности = СписокНеоднозначностей.Добавить();
				ЗаписьОНеоднозначности.Идентификатор = СтрокаТаблицы.Идентификатор; 
				ЗаписьОНеоднозначности.Колонка = "ВидОтпуска";
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
	ПоместитьВоВременноеХранилище(Сотрудники, АдресТаблицыСопоставления);
	
КонецПроцедуры

// Возвращает список подходящих объектов ИБ для неоднозначного значения ячейки.
// 
// Параметры:
//   ПолноеИмяТабличнойЧасти  - Строка - Полное имя табличной части, в которую загружаются данные.
//  ИмяКолонки                - Строка - Имя колонки, в который возникла неоднозначность.
//  СписокНеоднозначностей    - Массив - Массив для заполнения с неоднозначными данными.
//  ЗагружаемыеЗначенияСтрока - Строка - Загружаемые данные на основании которых возникла неоднозначность.
//  ДополнительныеПараметры   - ЛюбойТип - Любые дополнительные сведения.
//
Процедура ЗаполнитьСписокНеоднозначностей(ПолноеИмяТабличнойЧасти, СписокНеоднозначностей, ИмяКолонки, ЗагружаемыеЗначенияСтрока, ДополнительныеПараметры) Экспорт
	
	Если ИмяКолонки = "Сотрудник" Тогда

		Запрос = Новый Запрос;
		Запрос.Текст = 
			"ВЫБРАТЬ
			|	Сотрудники.Ссылка
			|ИЗ
			|	Справочник.Сотрудники КАК Сотрудники
			|ГДЕ
			|	Сотрудники.Наименование = &Наименование";
			
		Запрос.УстановитьПараметр("Наименование", ЗагружаемыеЗначенияСтрока.Сотрудник);
		РезультатЗапроса = Запрос.Выполнить();
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			СписокНеоднозначностей.Добавить(ВыборкаДетальныеЗаписи.Ссылка);
		КонецЦикла;
		
	ИначеЕсли ИмяКолонки = "ВидОтпуска" Тогда

		Запрос = Новый Запрос;
		Запрос.Текст = 
			"ВЫБРАТЬ
			|	ВидыОтпусков.Ссылка
			|ИЗ
			|	Справочник.ВидыОтпусков КАК ВидыОтпусков
			|ГДЕ
			|	ВидыОтпусков.Наименование = &Наименование";
			
		Запрос.УстановитьПараметр("Наименование", ЗагружаемыеЗначенияСтрока.ВидОтпуска);
		РезультатЗапроса = Запрос.Выполнить();
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			СписокНеоднозначностей.Добавить(ВыборкаДетальныеЗаписи.Ссылка);
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

Функция ПараметрыЗаполненияОтпуска(ГрафикОтпусков, ДанныеСотрудника) Экспорт 
	
	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("Ссылка", ГрафикОтпусков);
	Запрос.УстановитьПараметр("Сотрудник", ДанныеСотрудника.Сотрудник);
	
	Запрос.Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ
	               |	ГрафикОтпусковСотрудники.НомерСтроки КАК НомерСтроки,
	               |	ГрафикОтпусковСотрудники.Сотрудник КАК Сотрудник,
	               |	ГрафикОтпусковСотрудники.ВидОтпуска КАК ВидОтпуска,
	               |	ГрафикОтпусковСотрудники.ДатаНачала КАК ДатаНачала,
	               |	ГрафикОтпусковСотрудники.ДатаОкончания КАК ДатаОкончания,
	               |	ГрафикОтпусковСотрудники.КоличествоДней КАК КоличествоДней
	               |ПОМЕСТИТЬ ВТДанныеДокумента
	               |ИЗ
	               |	Документ.ГрафикОтпусков.Сотрудники КАК ГрафикОтпусковСотрудники
	               |ГДЕ
	               |	ГрафикОтпусковСотрудники.Ссылка = &Ссылка
	               |	И ГрафикОтпусковСотрудники.Сотрудник = &Сотрудник
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ РАЗРЕШЕННЫЕ
	               |	ДанныеДокумента.НомерСтроки КАК НомерСтроки,
	               |	МАКСИМУМ(ПереносОтпуска.Ссылка) КАК Перенос
	               |ПОМЕСТИТЬ ВТПроведенныеПереносы
	               |ИЗ
	               |	ВТДанныеДокумента КАК ДанныеДокумента
	               |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ПереносОтпуска КАК ПереносОтпуска
	               |		ПО ДанныеДокумента.Сотрудник = ПереносОтпуска.Сотрудник
	               |			И ДанныеДокумента.ВидОтпуска = ПереносОтпуска.ВидОтпуска
	               |			И ДанныеДокумента.ДатаНачала = ПереносОтпуска.ИсходнаяДатаНачала
	               |			И (ПереносОтпуска.Проведен)
	               |
	               |СГРУППИРОВАТЬ ПО
	               |	ДанныеДокумента.НомерСтроки
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ РАЗРЕШЕННЫЕ
	               |	ПроведенныеПереносы.НомерСтроки КАК НомерСтроки,
	               |	ПереносОтпуска.Сотрудник КАК Сотрудник,
	               |	ПереносОтпуска.ВидОтпуска КАК ВидОтпуска,
	               |	ПереносОтпуска.Ссылка КАК Ссылка,
	               |	ПереносОтпуска.Проведен КАК Проведен,
	               |	ПереносОтпуска.ИсходнаяДатаНачала КАК ИсходнаяДатаНачала,
	               |	ПереносОтпускаПереносы.ДатаНачала КАК ДатаНачалаПеренесенногоОтпуска,
	               |	ПереносОтпускаПереносы.ДатаОкончания КАК ДатаОкончанияПеренесенногоОтпуска,
	               |	ПереносОтпускаПереносы.КоличествоДней КАК КоличествоДней
	               |ПОМЕСТИТЬ ВТПереносы
	               |ИЗ
	               |	ВТПроведенныеПереносы КАК ПроведенныеПереносы
	               |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ПереносОтпуска КАК ПереносОтпуска
	               |		ПО ПроведенныеПереносы.Перенос = ПереносОтпуска.Ссылка
	               |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ПереносОтпуска.Переносы КАК ПереносОтпускаПереносы
	               |		ПО ПроведенныеПереносы.Перенос = ПереносОтпускаПереносы.Ссылка
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	ДанныеДокумента.НомерСтроки КАК НомерСтроки,
	               |	ДанныеДокумента.Сотрудник КАК Сотрудник,
	               |	ДанныеДокумента.ВидОтпуска КАК ВидОтпуска,
	               |	ДОБАВИТЬКДАТЕ(ВЫБОР
	               |			КОГДА Переносы.Ссылка ЕСТЬ NULL
	               |				ТОГДА ДанныеДокумента.ДатаНачала
	               |			ИНАЧЕ Переносы.ДатаНачалаПеренесенногоОтпуска
	               |		КОНЕЦ, ДЕНЬ, -1) КАК ДатаНачалаФакта,
	               |	ДОБАВИТЬКДАТЕ(ВЫБОР
	               |			КОГДА Переносы.Ссылка ЕСТЬ NULL
	               |				ТОГДА ДанныеДокумента.ДатаНачала
	               |			ИНАЧЕ Переносы.ДатаНачалаПеренесенногоОтпуска
	               |		КОНЕЦ, ДЕНЬ, 1) КАК ДатаОкончанияФакта,
	               |	ВЫБОР
	               |		КОГДА Переносы.Ссылка ЕСТЬ NULL
	               |			ТОГДА ДанныеДокумента.ДатаНачала
	               |		ИНАЧЕ Переносы.ДатаНачалаПеренесенногоОтпуска
	               |	КОНЕЦ КАК ДатаНачала,
	               |	ВЫБОР
	               |		КОГДА Переносы.Ссылка ЕСТЬ NULL
	               |			ТОГДА ДанныеДокумента.ДатаОкончания
	               |		ИНАЧЕ Переносы.ДатаОкончанияПеренесенногоОтпуска
	               |	КОНЕЦ КАК ДатаОкончания,
	               |	ВЫБОР
	               |		КОГДА НЕ Переносы.Ссылка ЕСТЬ NULL
	               |			ТОГДА Переносы.КоличествоДней
	               |		ИНАЧЕ ДанныеДокумента.КоличествоДней
	               |	КОНЕЦ КАК КоличествоДней
	               |ПОМЕСТИТЬ ВТПлановыеОтпуска
	               |ИЗ
	               |	ВТДанныеДокумента КАК ДанныеДокумента
	               |		ЛЕВОЕ СОЕДИНЕНИЕ ВТПереносы КАК Переносы
	               |		ПО ДанныеДокумента.НомерСтроки = Переносы.НомерСтроки
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ РАЗРЕШЕННЫЕ
	               |	Отпуск.Ссылка КАК Ссылка,
	               |	Отпуск.Сотрудник КАК Сотрудник,
	               |	ОтпускДополнительныеОтпуска.ВидОтпуска КАК ВидОтпуска,
	               |	ОтпускДополнительныеОтпуска.ДатаНачала КАК ДатаНачала,
	               |	ОтпускДополнительныеОтпуска.ДатаОкончания КАК ДатаОкончания,
	               |	ОтпускДополнительныеОтпуска.КоличествоДней КАК КоличествоДней,
	               |	Отпуск.Проведен КАК Проведен,
	               |	ВЫБОР
	               |		КОГДА Отпуск.Проведен
	               |				И Отпуск.ДокументРассчитан
	               |			ТОГДА ИСТИНА
	               |		ИНАЧЕ ЛОЖЬ
	               |	КОНЕЦ КАК Рассчитан
	               |ПОМЕСТИТЬ ВТДополнительныеОтпуска
	               |ИЗ
	               |	Документ.Отпуск КАК Отпуск
	               |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.Отпуск.ДополнительныеОтпуска КАК ОтпускДополнительныеОтпуска
	               |		ПО Отпуск.Ссылка = ОтпускДополнительныеОтпуска.Ссылка
	               |			И (Отпуск.Сотрудник = &Сотрудник)
	               |			И (НЕ Отпуск.ПометкаУдаления)
	               |			И (Отпуск.ПредоставитьДополнительныйОтпуск)
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ РАЗРЕШЕННЫЕ
	               |	ПлановыеОтпуска.НомерСтроки КАК НомерСтроки,
	               |	Отпуск.Ссылка КАК Ссылка,
	               |	Отпуск.Сотрудник КАК Сотрудник,
	               |	ЗНАЧЕНИЕ(Справочник.ВидыОтпусков.Основной) КАК ВидОтпуска,
	               |	ПлановыеОтпуска.ДатаНачалаФакта КАК ДатаНачалаФакта,
	               |	Отпуск.ДатаНачалаОсновногоОтпуска КАК ДатаНачала,
	               |	Отпуск.ДатаОкончанияОсновногоОтпуска КАК ДатаОкончания,
	               |	Отпуск.КоличествоДнейОсновногоОтпуска КАК КоличествоДней,
	               |	Отпуск.Проведен КАК Проведен,
	               |	ВЫБОР
	               |		КОГДА Отпуск.Проведен
	               |				И Отпуск.ДокументРассчитан
	               |			ТОГДА ИСТИНА
	               |		ИНАЧЕ ЛОЖЬ
	               |	КОНЕЦ КАК Рассчитан
	               |ПОМЕСТИТЬ ВТОтпускаСотрудников
	               |ИЗ
	               |	ВТПлановыеОтпуска КАК ПлановыеОтпуска
	               |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.Отпуск КАК Отпуск
	               |		ПО ПлановыеОтпуска.Сотрудник = Отпуск.Сотрудник
	               |			И (Отпуск.ДатаНачалаОсновногоОтпуска МЕЖДУ ПлановыеОтпуска.ДатаНачалаФакта И ПлановыеОтпуска.ДатаОкончанияФакта)
	               |			И (Отпуск.ПредоставитьОсновнойОтпуск)
	               |			И (НЕ Отпуск.ПометкаУдаления)
	               |
	               |ОБЪЕДИНИТЬ ВСЕ
	               |
	               |ВЫБРАТЬ
	               |	ПлановыеОтпуска.НомерСтроки,
	               |	ДополнительныеОтпуска.Ссылка,
	               |	ДополнительныеОтпуска.Сотрудник,
	               |	ЗНАЧЕНИЕ(Справочник.ВидыОтпусков.Основной),
	               |	ПлановыеОтпуска.ДатаНачалаФакта,
	               |	ДополнительныеОтпуска.ДатаНачала,
	               |	ДополнительныеОтпуска.ДатаОкончания,
	               |	ДополнительныеОтпуска.КоличествоДней,
	               |	ДополнительныеОтпуска.Проведен,
	               |	ДополнительныеОтпуска.Рассчитан
	               |ИЗ
	               |	ВТПлановыеОтпуска КАК ПлановыеОтпуска
	               |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТДополнительныеОтпуска КАК ДополнительныеОтпуска
	               |		ПО ПлановыеОтпуска.Сотрудник = ДополнительныеОтпуска.Сотрудник
	               |			И (ДополнительныеОтпуска.ДатаНачала МЕЖДУ ПлановыеОтпуска.ДатаНачалаФакта И ПлановыеОтпуска.ДатаОкончанияФакта)
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	ОтпускаСотрудников.Сотрудник КАК Сотрудник,
	               |	ОтпускаСотрудников.ВидОтпуска КАК ВидОтпуска,
	               |	ОтпускаСотрудников.ДатаНачалаФакта КАК ДатаНачалаФакта,
	               |	МАКСИМУМ(ОтпускаСотрудников.Ссылка) КАК Ссылка
	               |ПОМЕСТИТЬ ВТПроведенныеОтпускаДокументы
	               |ИЗ
	               |	ВТОтпускаСотрудников КАК ОтпускаСотрудников
	               |ГДЕ
	               |	ОтпускаСотрудников.Проведен
	               |
	               |СГРУППИРОВАТЬ ПО
	               |	ОтпускаСотрудников.Сотрудник,
	               |	ОтпускаСотрудников.ВидОтпуска,
	               |	ОтпускаСотрудников.ДатаНачалаФакта
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	ОтпускаСотрудников.НомерСтроки КАК НомерСтроки,
	               |	ОтпускаСотрудников.Ссылка КАК Ссылка,
	               |	ОтпускаСотрудников.Сотрудник КАК Сотрудник,
	               |	ОтпускаСотрудников.ВидОтпуска КАК ВидОтпуска,
	               |	ОтпускаСотрудников.ДатаНачалаФакта КАК ДатаНачалаФакта,
	               |	ОтпускаСотрудников.ДатаНачала КАК ДатаНачала,
	               |	ОтпускаСотрудников.ДатаОкончания КАК ДатаОкончания,
	               |	ОтпускаСотрудников.КоличествоДней КАК КоличествоДней,
	               |	ОтпускаСотрудников.Рассчитан КАК Рассчитан
	               |ПОМЕСТИТЬ ВТПроведенныеОтпуска
	               |ИЗ
	               |	ВТОтпускаСотрудников КАК ОтпускаСотрудников
	               |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТПроведенныеОтпускаДокументы КАК ПроведенныеОтпускаДокументы
	               |		ПО ОтпускаСотрудников.Ссылка = ПроведенныеОтпускаДокументы.Ссылка
	               |			И ОтпускаСотрудников.Сотрудник = ПроведенныеОтпускаДокументы.Сотрудник
	               |			И ОтпускаСотрудников.ВидОтпуска = ПроведенныеОтпускаДокументы.ВидОтпуска
	               |			И ОтпускаСотрудников.ДатаНачалаФакта = ПроведенныеОтпускаДокументы.ДатаНачалаФакта
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	ОтпускаСотрудников.Сотрудник КАК Сотрудник,
	               |	ОтпускаСотрудников.ВидОтпуска КАК ВидОтпуска,
	               |	ОтпускаСотрудников.ДатаНачалаФакта КАК ДатаНачалаФакта,
	               |	МАКСИМУМ(ОтпускаСотрудников.Ссылка) КАК Ссылка
	               |ПОМЕСТИТЬ ВТНеПроведенныеОтпускаДокументы
	               |ИЗ
	               |	ВТОтпускаСотрудников КАК ОтпускаСотрудников
	               |		ЛЕВОЕ СОЕДИНЕНИЕ ВТПроведенныеОтпускаДокументы КАК ПроведенныеОтпускаДокументы
	               |		ПО ОтпускаСотрудников.Сотрудник = ПроведенныеОтпускаДокументы.Сотрудник
	               |			И ОтпускаСотрудников.ВидОтпуска = ПроведенныеОтпускаДокументы.ВидОтпуска
	               |			И ОтпускаСотрудников.ДатаНачалаФакта = ПроведенныеОтпускаДокументы.ДатаНачалаФакта
	               |			И (НЕ ОтпускаСотрудников.Проведен)
	               |ГДЕ
	               |	НЕ ОтпускаСотрудников.Проведен
	               |	И ПроведенныеОтпускаДокументы.Сотрудник ЕСТЬ NULL
	               |
	               |СГРУППИРОВАТЬ ПО
	               |	ОтпускаСотрудников.Сотрудник,
	               |	ОтпускаСотрудников.ВидОтпуска,
	               |	ОтпускаСотрудников.ДатаНачалаФакта
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	ПроведенныеОтпуска.НомерСтроки КАК НомерСтроки,
	               |	ПроведенныеОтпуска.Ссылка КАК Отпуск,
	               |	ПроведенныеОтпуска.Сотрудник КАК Сотрудник,
	               |	ПроведенныеОтпуска.ВидОтпуска КАК ВидОтпуска,
	               |	ПроведенныеОтпуска.ДатаНачалаФакта КАК ДатаНачалаФакта,
	               |	ПроведенныеОтпуска.ДатаНачала КАК ДатаНачала,
	               |	ПроведенныеОтпуска.ДатаОкончания КАК ДатаОкончания,
	               |	ПроведенныеОтпуска.КоличествоДней КАК КоличествоДней,
	               |	ИСТИНА КАК Проведен,
	               |	ПроведенныеОтпуска.Рассчитан КАК Рассчитан
	               |ПОМЕСТИТЬ ВТФактическиеОтпуска
	               |ИЗ
	               |	ВТПроведенныеОтпуска КАК ПроведенныеОтпуска
	               |
	               |ОБЪЕДИНИТЬ ВСЕ
	               |
	               |ВЫБРАТЬ
	               |	ОтпускаСотрудников.НомерСтроки,
	               |	ОтпускаСотрудников.Ссылка,
	               |	ОтпускаСотрудников.Сотрудник,
	               |	ОтпускаСотрудников.ВидОтпуска,
	               |	ОтпускаСотрудников.ДатаНачалаФакта,
	               |	ОтпускаСотрудников.ДатаНачала,
	               |	ОтпускаСотрудников.ДатаОкончания,
	               |	ОтпускаСотрудников.КоличествоДней,
	               |	ЛОЖЬ,
	               |	ОтпускаСотрудников.Рассчитан
	               |ИЗ
	               |	ВТОтпускаСотрудников КАК ОтпускаСотрудников
	               |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТНеПроведенныеОтпускаДокументы КАК НеПроведенныеОтпускаДокументы
	               |		ПО ОтпускаСотрудников.Ссылка = НеПроведенныеОтпускаДокументы.Ссылка
	               |			И ОтпускаСотрудников.Сотрудник = НеПроведенныеОтпускаДокументы.Сотрудник
	               |			И ОтпускаСотрудников.ВидОтпуска = НеПроведенныеОтпускаДокументы.ВидОтпуска
	               |			И ОтпускаСотрудников.ДатаНачалаФакта = НеПроведенныеОтпускаДокументы.ДатаНачалаФакта
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	ПлановыеОтпуска.НомерСтроки КАК НомерСтроки,
	               |	ПлановыеОтпуска.Сотрудник КАК Сотрудник,
	               |	ПлановыеОтпуска.ВидОтпуска КАК ВидОтпуска,
	               |	ВЫБОР
	               |		КОГДА ФактическиеОтпуска.Отпуск ЕСТЬ NULL
	               |			ТОГДА ЗНАЧЕНИЕ(Документ.Отпуск.ПустаяСсылка)
	               |		ИНАЧЕ ФактическиеОтпуска.Отпуск
	               |	КОНЕЦ КАК Отпуск,
	               |	ВЫБОР
	               |		КОГДА ФактическиеОтпуска.Отпуск ЕСТЬ NULL
	               |			ТОГДА ПлановыеОтпуска.ДатаНачала
	               |		ИНАЧЕ ФактическиеОтпуска.ДатаНачала
	               |	КОНЕЦ КАК ДатаНачала,
	               |	ВЫБОР
	               |		КОГДА ФактическиеОтпуска.Отпуск ЕСТЬ NULL
	               |			ТОГДА ПлановыеОтпуска.ДатаОкончания
	               |		ИНАЧЕ ФактическиеОтпуска.ДатаОкончания
	               |	КОНЕЦ КАК ДатаОкончания,
	               |	ВЫБОР
	               |		КОГДА ФактическиеОтпуска.Отпуск ЕСТЬ NULL
	               |			ТОГДА ПлановыеОтпуска.КоличествоДней
	               |		ИНАЧЕ ФактическиеОтпуска.КоличествоДней
	               |	КОНЕЦ КАК КоличествоДней
	               |ИЗ
	               |	ВТПлановыеОтпуска КАК ПлановыеОтпуска
	               |		ЛЕВОЕ СОЕДИНЕНИЕ ВТФактическиеОтпуска КАК ФактическиеОтпуска
	               |		ПО ПлановыеОтпуска.НомерСтроки = ФактическиеОтпуска.НомерСтроки
	               |			И ПлановыеОтпуска.ДатаНачалаФакта = ФактическиеОтпуска.ДатаНачалаФакта
	               |ГДЕ
	               |	ЕСТЬNULL(ФактическиеОтпуска.Рассчитан, ЛОЖЬ) = ЛОЖЬ
	               |
	               |УПОРЯДОЧИТЬ ПО
	               |	Сотрудник,
	               |	ДатаНачала";
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	НеоформленныеОтпуска = Новый Массив;
	ДатаНачала = Неопределено;
	ДатаОкончания = Неопределено;
	ПодходящийДокумент = Неопределено;
	
	ДатаНачалаЗаполняемогоОтпуска = ДанныеСотрудника.ДатаНачала;
	ДатаОкончанияЗаполняемогоОтпуска = ДанныеСотрудника.ДатаОкончания;
	
	Пока Выборка.Следующий() Цикл
		ДатаНачалаОтпуска = Выборка.ДатаНачала;
		ДатаОкончанияОтпуска = Выборка.ДатаОкончания;
		ДанныеОтпуска = Новый Структура("НомерСтроки,ВидОтпуска,ДатаНачала,ДатаОкончания,КоличествоДней");
		ЗаполнитьЗначенияСвойств(ДанныеОтпуска, Выборка);
		ДанныеОтпуска.Вставить("ВидОтпускаПрежний", ДанныеОтпуска.ВидОтпуска);
		ДанныеОтпуска.Вставить("ИндексСтрокиДокумента", ДанныеОтпуска.НомерСтроки - 1);
		Если ДатаНачала = Неопределено Тогда 
			ДатаНачала = ДатаНачалаОтпуска;
			ДатаОкончания = ДатаОкончанияОтпуска;
			ПодходящийДокумент = Выборка.Отпуск;
			НеоформленныеОтпуска.Добавить(ДанныеОтпуска);
			Продолжить;
		КонецЕсли;
		Если ДатаНачалаОтпуска = КонецДня(ДатаОкончания) + 1 
			И Выборка.ВидОтпуска <> ОбщегоНазначения.ПредопределенныйЭлемент("Справочник.ВидыОтпусков.Основной")
			И (Не ЗначениеЗаполнено(ПодходящийДокумент) Или ПодходящийДокумент = Выборка.Отпуск) Тогда 
			ДатаОкончания = ДатаОкончанияОтпуска;
			ПодходящийДокумент = Выборка.Отпуск;
			НеоформленныеОтпуска.Добавить(ДанныеОтпуска);
			Продолжить;
		ИначеЕсли ДатаНачала <= ДатаНачалаЗаполняемогоОтпуска И ДатаОкончания >= ДатаОкончанияЗаполняемогоОтпуска Тогда 
			Прервать;
		КонецЕсли;
		ДатаНачала = Выборка.ДатаНачала;
		ДатаОкончания = Выборка.ДатаОкончания;
		ПодходящийДокумент = Выборка.Отпуск;
		НеоформленныеОтпуска = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ДанныеОтпуска);
	КонецЦикла;
	
	ПараметрыЗаполнения = Новый Структура;
	ПараметрыЗаполнения.Вставить("Действие", "Заполнить");
	ПараметрыЗаполнения.Вставить("ДокументОтпуск", ПодходящийДокумент);
	ПараметрыЗаполнения.Вставить("Организация", ДанныеСотрудника.Организация);
	ПараметрыЗаполнения.Вставить("Сотрудник", ДанныеСотрудника.Сотрудник);
	ПараметрыЗаполнения.Вставить("Ссылка", ГрафикОтпусков);
	ПараметрыЗаполнения.Вставить("ДанныеОтпусков", НеоформленныеОтпуска);
	ПараметрыЗаполнения.Вставить("АвторасчетПериодаПредоставления", Истина);
	
	ПараметрыЗаполненияДокументов = Новый Массив;
	ПараметрыЗаполненияДокументов.Добавить(ПараметрыЗаполнения);
	
	Возврат ПараметрыЗаполненияДокументов;
	
КонецФункции

Функция РасчетныйДокументПоПараметрыЗаполнения(Сотрудник, ПараметрыЗаполнения) Экспорт 
	
	РезультатЗаполнения = Новый Структура("Рассчитан,Проведен,ОтпускРассчитал,Отпуск", Ложь, Ложь);
	УстановитьПривилегированныйРежим(Истина);
	
	ПодходящийДокумент = ПараметрыЗаполнения.ДокументОтпуск;
	
	Если ЗначениеЗаполнено(ПодходящийДокумент) Тогда
		ДокументОтпуск = ПодходящийДокумент.ПолучитьОбъект();
	Иначе
		ДокументОтпуск = Документы.Отпуск.СоздатьДокумент();
	КонецЕсли;
	
	ДокументОтпуск.Заполнить(ПараметрыЗаполнения);
	Если ПолучитьФункциональнуюОпцию("ИспользоватьМногофункциональностьДокументовЗарплатаКадры") Тогда
		ДокументОтпуск.ДокументРассчитан = Ложь;
	КонецЕсли;
	
	Отказ = Ложь;
	Документы.Отпуск.ПроверитьРаботающих(ДокументОтпуск, Отказ);
	
	Если Не Отказ Тогда
		
		ДокументОтпуск.Записать(РежимЗаписиДокумента.Запись);
		Если ПолучитьФункциональнуюОпцию("ИспользоватьМногофункциональностьДокументовЗарплатаКадры") Тогда
			Попытка
				Если Не ТранзакцияАктивна() Тогда
					ДокументОтпуск.Записать(РежимЗаписиДокумента.Проведение);
				КонецЕсли; 
			Исключение
				Инфо = ИнформацияОбОшибке();
				ВызватьИсключение НСтр("ru='Не удалось записать'") + " " + Строка(ДокументОтпуск.Ссылка);
			КонецПопытки;
		КонецЕсли;
			
	Иначе
		
		СообщенияПроверкиЗаполнения = ПолучитьСообщенияПользователю(Истина);
		Если СообщенияПроверкиЗаполнения <> Неопределено Тогда
			Для Каждого СообщениеПроверки Из СообщенияПроверкиЗаполнения Цикл
				Если СообщениеПроверки.Поле = "Сотрудник" Тогда
					СообщениеПроверки.Поле = "Отпуска";
				КонецЕсли;
				СообщениеПроверки.Сообщить();
			КонецЦикла;
		КонецЕсли; 
		
	КонецЕсли; 
	
	РезультатЗаполнения.Вставить("Отпуск", ДокументОтпуск.Ссылка);
	РезультатЗаполнения.Вставить("Рассчитан", ДокументОтпуск.ДокументРассчитан И ДокументОтпуск.Проведен);
	РезультатЗаполнения.Вставить("Проведен", ДокументОтпуск.Проведен);
	РезультатЗаполнения.Вставить("ОтпускРассчитал", ДокументОтпуск.Рассчитал);
	
	Возврат РезультатЗаполнения;
	
КонецФункции

#КонецОбласти

#КонецЕсли
