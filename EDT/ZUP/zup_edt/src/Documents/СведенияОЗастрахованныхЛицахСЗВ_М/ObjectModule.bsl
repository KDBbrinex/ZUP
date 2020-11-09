#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	ОкончаниеОтчетногоПериода = КонецМесяца(ОтчетныйПериод);
		
	Если НЕ ЗначениеЗаполнено(ИмяФайлаДляПФР) Тогда
		ИмяФайлаДляПФР = Документы.СведенияОЗастрахованныхЛицахСЗВ_М.ИмяФайла(Организация, Дата);
	Иначе		
		УИДИзИмениФайла = Прав(ИмяФайлаДляПФР, 36);
		
		Если Не СтроковыеФункцииКлиентСервер.ЭтоУникальныйИдентификатор(УИДИзИмениФайла) Тогда
			УИДИзИмениФайла = Строка(Новый УникальныйИдентификатор);	
		КонецЕсли;	
		
		ИмяФайлаДляПФР = Документы.СведенияОЗастрахованныхЛицахСЗВ_М.ИмяФайла(Организация, Дата, УИДИзИмениФайла);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	ИмяФайлаДляПФР = "";
	ДокументПринятВПФР = Ложь;
	ФайлСформирован = Ложь;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Ошибки = Неопределено;
	ДополнительныеСвойства.Свойство("Ошибки", Ошибки);
	
	ПерсонифицированныйУчет.ПроверитьДанныеОрганизации(ЭтотОбъект, Организация, Отказ, КонецМесяца(ОтчетныйПериод), Ошибки);
	
	УникальныеИНН = Новый Соответствие;
	УникальныеСтраховыеНомера = Новый Соответствие;
	
	Для Каждого ДанныеСотрудника Из Сотрудники Цикл 
		ПерсонифицированныйУчет.ПроверитьДанныеСтрокиСотрудника(ДанныеСотрудника, УникальныеИНН, УникальныеСтраховыеНомера, Отказ, "ИНН", Ошибки);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПроверитьОбязательныеПоля(Отказ) Экспорт
	
	Если Не ЗначениеЗаполнено(Организация) Тогда
		ОбщегоНазначения.СообщитьПользователю(НСтр("ru = 'Не указана организация.'"), ЭтотОбъект, "Организация", "Объект", Отказ);	
		Возврат;
	КонецЕсли;
	
	ДанныеОрганизации = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Организация, "РегистрационныйНомерПФР, КодОрганаПФР");

	Если Не ЗначениеЗаполнено(ДанныеОрганизации.РегистрационныйНомерПФР) Тогда
		ТекстСообщения = НСтр("ru = 'У организации не заполнен регистрационный номер ПФР.'");
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, Организация, "РегистрационныйНомерПФР", , Отказ);
	ИначеЕсли СтрДлина(ДанныеОрганизации.РегистрационныйНомерПФР) <> 14 Тогда
		ТекстСообщения = НСтр("ru = 'У организации не верно заполнен регистрационный номер ПФР.'");
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, Организация, "РегистрационныйНомерПФР", , Отказ);
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(ДанныеОрганизации.КодОрганаПФР) Тогда
		ТекстСообщения = НСтр("ru = 'У организации не заполнен код органа ПФР '");
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, Организация, "КодОрганаПФР", , Отказ);
	КонецЕсли;
	
КонецПроцедуры	

Процедура ПроверитьДанныеДокумента(Отказ) Экспорт
	
	Если Не ПроверитьЗаполнение() Тогда
		Отказ = Истина;
	КонецЕсли;
	
	Ошибки = Неопределено;
	ДополнительныеСвойства.Свойство("Ошибки", Ошибки);
	
	ВыборкаДляПроверки = ВыборкаДанныхФизическихЛицДляПроверки();
	
	Пока ВыборкаДляПроверки.Следующий() Цикл
		Если Не ЗначениеЗаполнено(ВыборкаДляПроверки.Сотрудник) Тогда
			Продолжить;
		КонецЕсли;
		
		ПутьКДаннымСтроки = "Сотрудники[" + Формат(ВыборкаДляПроверки.НомерСтроки - 1, "ЧГ=") + "]"; 
		
		ТекстСообщения = "";
		Если Не РегламентированныеДанныеКлиентСервер.СтраховойНомерПФРСоответствуетТребованиям(ВыборкаДляПроверки.СтраховойНомерПФР, ТекстСообщения) Тогда		
			ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Сотрудник %1: %2'"),
				ВыборкаДляПроверки.Наименование,
				ТекстСообщения);
			ОбщегоНазначенияБЗК.ДобавитьОшибкуЗаполненияДокумента(Ошибки, ТекстОшибки, ЭтотОбъект, ПутьКДаннымСтроки + ".СтраховойНомерПФР", "Объект", Отказ);		
		КонецЕсли;
		
		Если ВыборкаДляПроверки.ЕстьДубль Тогда
			ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Сотрудник %1 был введен в документе ранее'"),
				ВыборкаДляПроверки.Наименование);
			ОбщегоНазначенияБЗК.ДобавитьОшибкуЗаполненияДокумента(Ошибки, ТекстОшибки, ЭтотОбъект, ПутьКДаннымСтроки + ".Сотрудник", "Объект", Отказ);
		КонецЕсли;
		
		Если ВыборкаДляПроверки.ЕстьДубльСтраховогоНомераПФР Тогда
			ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'СНИЛС %1 был введен в документе ранее'"),
				ВыборкаДляПроверки.СтраховойНомерПФР);
			ОбщегоНазначенияБЗК.ДобавитьОшибкуЗаполненияДокумента(Ошибки, ТекстОшибки, ЭтотОбъект, ПутьКДаннымСтроки + ".СтраховойНомерПФР", "Объект", Отказ);
		КонецЕсли;
		
		Если Не ВыборкаДляПроверки.РаботаетВОрганизации И Не ТипФормы = Перечисления.ТипыСведенийСЗВ_М.Отменяющая Тогда
			ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Сотрудник %1 не работает в организации'"),
				ВыборкаДляПроверки.Наименование);
			ОбщегоНазначенияБЗК.ДобавитьОшибкуЗаполненияДокумента(Ошибки, ТекстОшибки, ЭтотОбъект, ПутьКДаннымСтроки + ".Сотрудник", "Объект", Отказ);
		КонецЕсли;
		
		Если ВыборкаДляПроверки.ЯвляетсяВоеннослужащим И Не ТипФормы = Перечисления.ТипыСведенийСЗВ_М.Отменяющая Тогда
			ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Сотрудник %1 не должен включаться в СВЗ-М, т.к. является военнослужащим'"),
				ВыборкаДляПроверки.Наименование);
			ОбщегоНазначенияБЗК.ДобавитьОшибкуЗаполненияДокумента(Ошибки, ТекстОшибки, ЭтотОбъект, ПутьКДаннымСтроки + ".Сотрудник", "Объект", Отказ);
		КонецЕсли;
		
		Если ВыборкаДляПроверки.РаботаетВСтуденческомОтряде И Не ТипФормы = Перечисления.ТипыСведенийСЗВ_М.Отменяющая Тогда
			ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Сотрудник %1 не должен включаться в СВЗ-М, т.к. работает в студенческом отряде'"),
				ВыборкаДляПроверки.Наименование);
			ОбщегоНазначенияБЗК.ДобавитьОшибкуЗаполненияДокумента(Ошибки, ТекстОшибки, ЭтотОбъект, ПутьКДаннымСтроки + ".Сотрудник", "Объект", Отказ);
		КонецЕсли;
		
		Если ВыборкаДляПроверки.ЗастрахованПФР = Ложь 
			И Не ТипФормы = Перечисления.ТипыСведенийСЗВ_М.Отменяющая Тогда
			ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Сотрудник %1 не должен включаться в СВЗ-М, т.к. на него не распространяется пенсионное страхование'"),
				ВыборкаДляПроверки.Наименование);
			ОбщегоНазначенияБЗК.ДобавитьОшибкуЗаполненияДокумента(Ошибки, ТекстОшибки, ЭтотОбъект, ПутьКДаннымСтроки + ".Сотрудник", "Объект", Отказ);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Функция ВыборкаДанныхФизическихЛицДляПроверки()
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	СписокФизическихЛиц = Сотрудники.ВыгрузитьКолонку("Сотрудник");
	
	Документы.СведенияОЗастрахованныхЛицахСЗВ_М.СоздатьВТФизическиеЛицаОрганизации(Запрос.МенеджерВременныхТаблиц, ЭтотОбъект, СписокФизическихЛиц);
	
	Запрос.УстановитьПараметр("ТаблицаСотрудники", Сотрудники);
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	СведенияОЗастрахованныхЛицахСЗВ_МСотрудники.Сотрудник,
	|	СведенияОЗастрахованныхЛицахСЗВ_МСотрудники.Фамилия,
	|	СведенияОЗастрахованныхЛицахСЗВ_МСотрудники.Имя,
	|	СведенияОЗастрахованныхЛицахСЗВ_МСотрудники.Отчество,
	|	СведенияОЗастрахованныхЛицахСЗВ_МСотрудники.ИНН,
	|	СведенияОЗастрахованныхЛицахСЗВ_МСотрудники.СтраховойНомерПФР,
	|	СведенияОЗастрахованныхЛицахСЗВ_МСотрудники.НомерСтроки
	|ПОМЕСТИТЬ ВТСотрудники
	|ИЗ
	|	&ТаблицаСотрудники КАК СведенияОЗастрахованныхЛицахСЗВ_МСотрудники
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Сотрудники.НомерСтроки
	|ПОМЕСТИТЬ ВТДублиСтрок
	|ИЗ
	|	ВТСотрудники КАК Сотрудники
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТСотрудники КАК СотрудникиДубль
	|		ПО Сотрудники.Сотрудник = СотрудникиДубль.Сотрудник
	|			И Сотрудники.НомерСтроки > СотрудникиДубль.НомерСтроки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Сотрудники.НомерСтроки
	|ПОМЕСТИТЬ ВТДублиСтраховыхНомеровПФР
	|ИЗ
	|	ВТСотрудники КАК Сотрудники
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТСотрудники КАК СотрудникиДубль
	|		ПО Сотрудники.СтраховойНомерПФР = СотрудникиДубль.СтраховойНомерПФР
	|			И Сотрудники.НомерСтроки > СотрудникиДубль.НомерСтроки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Сотрудники.Сотрудник,
	|	Сотрудники.Фамилия,
	|	Сотрудники.Имя,
	|	Сотрудники.Отчество,
	|	Сотрудники.ИНН,
	|	Сотрудники.СтраховойНомерПФР,
	|	Сотрудники.НомерСтроки КАК НомерСтроки,
	|	ВЫБОР
	|		КОГДА ДублиСтрок.НомерСтроки ЕСТЬ NULL
	|			ТОГДА ЛОЖЬ
	|		ИНАЧЕ ИСТИНА
	|	КОНЕЦ КАК ЕстьДубль,
	|	ВЫБОР
	|		КОГДА ДублиСтраховыхНомеровПФР.НомерСтроки ЕСТЬ NULL
	|			ТОГДА ЛОЖЬ
	|		ИНАЧЕ ИСТИНА
	|	КОНЕЦ КАК ЕстьДубльСтраховогоНомераПФР,
	|	ЕСТЬNULL(ФизическиеЛицаОрганизации.ЯвляетсяПрокурором, ЛОЖЬ) КАК ЯвляетсяПрокурором,
	|	ЕСТЬNULL(ФизическиеЛицаОрганизации.ЯвляетсяВоеннослужащим, ЛОЖЬ) КАК ЯвляетсяВоеннослужащим,
	|	ЕСТЬNULL(ФизическиеЛицаОрганизации.РаботаетВСтуденческомОтряде, ЛОЖЬ) КАК РаботаетВСтуденческомОтряде,
	|	ФизическиеЛицаОрганизации.ВидЗастрахованногоЛица,
	|	ВЫБОР
	|		КОГДА ФизическиеЛицаОрганизации.ФизическоеЛицо ЕСТЬ NULL
	|			ТОГДА ЛОЖЬ
	|		ИНАЧЕ ИСТИНА
	|	КОНЕЦ КАК РаботаетВОрганизации,
	|	ФизическиеЛица.Наименование,
	|	ФизическиеЛицаОрганизации.ЗастрахованПФР
	|ИЗ
	|	ВТСотрудники КАК Сотрудники
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТДублиСтрок КАК ДублиСтрок
	|		ПО Сотрудники.НомерСтроки = ДублиСтрок.НомерСтроки
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТДублиСтраховыхНомеровПФР КАК ДублиСтраховыхНомеровПФР
	|		ПО Сотрудники.НомерСтроки = ДублиСтраховыхНомеровПФР.НомерСтроки
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТФизическиеЛицаОрганизации КАК ФизическиеЛицаОрганизации
	|		ПО Сотрудники.Сотрудник = ФизическиеЛицаОрганизации.ФизическоеЛицо
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ФизическиеЛица КАК ФизическиеЛица
	|		ПО Сотрудники.Сотрудник = ФизическиеЛица.Ссылка
	|
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки";
	
	Возврат Запрос.Выполнить().Выбрать();
	
КонецФункции

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли