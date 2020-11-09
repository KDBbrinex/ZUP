#Область СлужебныйПрограммныйИнтерфейс

Процедура ЗаполнитьВторичныеРеквизитыПрограммыОбучения(Форма, ИдентификаторТекущейСтроки = Неопределено, СтруктураИменРеквизитов = Неопределено) Экспорт
	
	Если СтруктураИменРеквизитов = Неопределено Тогда
		СтруктураИменРеквизитов = ОбучениеРазвитиеКлиентСервер.ОписаниеСтруктурыИменРеквизитовПрограммыОбучения();
	КонецЕсли;
	
	ОбучениеРазвитиеКлиентСервер.УстановитьЗначенияПериодовПрограммыОбучения(Форма, СтруктураИменРеквизитов);
	ЗаполнитьУчебныеЧасыПланаОбучения(Форма, ИдентификаторТекущейСтроки, СтруктураИменРеквизитов.ИмяРеквизитаПрограммаОбучения);
	
КонецПроцедуры

Процедура СоздатьИЗаполнитьРеквизитыПланаОбучения(Форма, СтруктураИменРеквизитов = Неопределено) Экспорт
	
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьОбучениеРазвитиеСотрудников")
		ИЛИ Не ПравоДоступа("Просмотр", Метаданные.Справочники.ПрофилиДолжностей.ТабличныеЧасти.ПрограммаОбучения) Тогда
	
		Возврат;
	КонецЕсли;
	
	УдалитьЭлементыКолонкиПериодовПлана(Форма);
	
	СоздатьКолонкиПериодовПрограммыОбучения(Форма, СтруктураИменРеквизитов);
	ОбучениеРазвитиеКлиентСервер.УстановитьЗаголовкиКолонкамПрограммыОбучения(Форма, СтруктураИменРеквизитов);
	
	ЗаполнитьВторичныеРеквизитыПрограммыОбучения(Форма,, СтруктураИменРеквизитов);
	
КонецПроцедуры

Процедура СоздатьКолонкиПериодовПрограммыОбучения(Форма, СтруктураИменРеквизитов = Неопределено) Экспорт
	
	Если СтруктураИменРеквизитов = Неопределено Тогда
		СтруктураИменРеквизитов = ОбучениеРазвитиеКлиентСервер.ОписаниеСтруктурыИменРеквизитовПрограммыОбучения();
	КонецЕсли;

	СоздатьРеквизитыКолонкиПериодовПлана(Форма, СтруктураИменРеквизитов);
	СоздатьЭлементыКолонкиПериодовПлана(Форма, СтруктураИменРеквизитов);
	
	ОбучениеРазвитиеКлиентСервер.УстановитьЗаголовкиКолонкамПрограммыОбучения(Форма, СтруктураИменРеквизитов);

КонецПроцедуры

Процедура УдалитьЭлементыКолонкиПериодовПлана(Форма) Экспорт
	
	ГруппаФормы = Форма.Элементы.Найти("ПрограммаОбученияПериодыОбученияГруппа");
	Если ГруппаФормы = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЗарплатаКадры.УдалитьПодчиненныеЭлементыГруппы(Форма, ГруппаФормы);
	
КонецПроцедуры

Процедура ЗаполнитьУчебныеЧасыПланаОбучения(Форма, ИдентификаторТекущейСтроки = Неопределено, ИмяРеквизитаПрограммаОбучения = "Объект.ПрограммаОбучения") Экспорт
	
	Если ИдентификаторТекущейСтроки = Неопределено Тогда
		ЗаполнитьКоличествоУчебныхЧасовПланаОбучения(Форма, ИмяРеквизитаПрограммаОбучения);
	Иначе
		ЗаполнитьКоличествоУчебныхЧасовПланаОбученияВСтроке(Форма, ИдентификаторТекущейСтроки, ИмяРеквизитаПрограммаОбучения);
	КонецЕсли; 
	
	ОбучениеРазвитиеКлиентСервер.ЗаполнитьВсегоУчебныхЧасов(Форма, ИмяРеквизитаПрограммаОбучения);
	
КонецПроцедуры

Процедура ЗаполнитьОтветственногоВСтрокеПрограммыОбучения(Форма, ИдентификаторТекущейСтроки, ИмяРеквизитаПрограммаОбучения = "Объект.ПрограммаОбучения") Экспорт
	
	Если ИдентификаторТекущейСтроки = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПрограммаОбучения = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ИмяРеквизитаПрограммаОбучения);
	ТекущаяСтрока = ПрограммаОбучения.НайтиПоИдентификатору(ИдентификаторТекущейСтроки);
	
	Если ТекущаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
	Если ЗначениеЗаполнено(ТекущаяСтрока.Ответственный) Тогда
		Возврат;
	КонецЕсли;
	
	ТекущаяСтрока.Ответственный = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ТекущаяСтрока.Мероприятие, "Ответственный");
	
КонецПроцедуры

Процедура ЗагрузитьПрограммуОбучения(Форма, СтруктураАдресовРезультата, ИмяРеквизитаПрограммаОбучения = "Объект.ПрограммаОбучения") Экспорт

	ПрограммаОбучения = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ИмяРеквизитаПрограммаОбучения);
	
	СтараяПрограммаОбучения = ПрограммаОбучения.Выгрузить();
	ПрограммаОбучения.Загрузить(ПолучитьИзВременногоХранилища(СтруктураАдресовРезультата.АдресПрограммыОбучения));
	
	Для каждого СтрокаПрограммыОбучения Из ПрограммаОбучения Цикл
		НайденныеСтроки = СтараяПрограммаОбучения.НайтиСтроки(Новый Структура("Мероприятие", СтрокаПрограммыОбучения.Мероприятие));
		Если НайденныеСтроки.Количество() = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		ЗаполнитьЗначенияСвойств(СтрокаПрограммыОбучения, НайденныеСтроки[0],, "Мероприятие,Ответственный");
	КонецЦикла; 
	
	ЗаполнитьУчебныеЧасыПланаОбучения(Форма,, ИмяРеквизитаПрограммаОбучения);
	
	Если СтруктураАдресовРезультата.Свойство("АдресХарактеристикиОбучение") Тогда
		УстановитьПризнакОбучениеХарактеристикам(Форма, СтруктураАдресовРезультата.АдресХарактеристикиОбучение);
	КонецЕсли;

КонецПроцедуры

Процедура ЗаполнитьПрограммуОбученияИзПозицииШР(ПрограммаОбучения, ПозицияШР, ДатаПриема) Экспорт

	Если Не ЗначениеЗаполнено(ПозицияШР) Тогда
		ПрограммаОбучения.Очистить();
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	НастройкиПрограммОбученияПозицийШтатногоРасписания.РазмерностьПродолжительностиПланаОбучения КАК РазмерностьПродолжительностиПланаОбучения
		|ИЗ
		|	РегистрСведений.НастройкиПрограммОбученияПозицийШтатногоРасписания КАК НастройкиПрограммОбученияПозицийШтатногоРасписания
		|ГДЕ
		|	НастройкиПрограммОбученияПозицийШтатногоРасписания.ПозицияШтатногоРасписания = &ПозицияШтатногоРасписания
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ПрограммыОбученияПозицийШтатногоРасписания.Мероприятие КАК Мероприятие,
		|	ПрограммыОбученияПозицийШтатногоРасписания.Ответственный КАК Ответственный,
		|	ПрограммыОбученияПозицийШтатногоРасписания.Начало КАК Начало,
		|	ПрограммыОбученияПозицийШтатногоРасписания.Окончание КАК Окончание,
		|	ПрограммыОбученияПозицийШтатногоРасписания.Мероприятие.КоличествоУчебныхЧасов КАК КоличествоУчебныхЧасов,
		|	ВЫБОР
		|		КОГДА ПрограммыОбученияПозицийШтатногоРасписания.Мероприятие.СпособОпределенияСтоимости = ЗНАЧЕНИЕ(Перечисление.СпособыРасчетаСуммыРасходовНаПерсонал.СуммаКратнаКоличествуСотрудников)
		|			ТОГДА ПрограммыОбученияПозицийШтатногоРасписания.Мероприятие.Стоимость
		|		ИНАЧЕ ВЫБОР
		|				КОГДА ПрограммыОбученияПозицийШтатногоРасписания.Мероприятие.КоличествоСлушателей = 0
		|					ТОГДА ПрограммыОбученияПозицийШтатногоРасписания.Мероприятие.Стоимость
		|				ИНАЧЕ ПрограммыОбученияПозицийШтатногоРасписания.Мероприятие.Стоимость / ПрограммыОбученияПозицийШтатногоРасписания.Мероприятие.КоличествоСлушателей
		|			КОНЕЦ
		|	КОНЕЦ КАК СуммаРасходов
		|ИЗ
		|	РегистрСведений.ПрограммыОбученияПозицийШтатногоРасписания КАК ПрограммыОбученияПозицийШтатногоРасписания
		|ГДЕ
		|	ПрограммыОбученияПозицийШтатногоРасписания.ПозицияШтатногоРасписания = &ПозицияШтатногоРасписания";
	
	Запрос.УстановитьПараметр("ПозицияШтатногоРасписания", ПозицияШР);
	
	УстановитьПривилегированныйРежим(Истина);
	РезультатыЗапроса = Запрос.ВыполнитьПакет();
	УстановитьПривилегированныйРежим(Ложь);
	
	РезультатЗапросаПараметры = РезультатыЗапроса[РезультатыЗапроса.Количество() - 2];
	РезультатЗапросаПрограмма = РезультатыЗапроса[РезультатыЗапроса.Количество() - 1];
	
	ВыборкаПараметры = РезультатЗапросаПараметры.Выбрать();
	ВыборкаПараметры.Следующий();
	
	ПрограммаОбученияИзПозиции = РезультатЗапросаПрограмма.Выгрузить();
	
	ПрограммаОбучения.Загрузить(
		ОбучениеРазвитие.ПрограммаОбученияПоДатам(ДатаПриема, ПрограммаОбученияИзПозиции, ВыборкаПараметры.РазмерностьПродолжительностиПланаОбучения));
		
	ЗаполнитьРеквизитыМероприятий(ПрограммаОбучения, ПрограммаОбученияИзПозиции);

КонецПроцедуры

#Область ШтатноеРасписание

Процедура ДополнитьФормуШтатногоРасписания(Форма) Экспорт

	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьОбучениеРазвитиеСотрудников")
		ИЛИ Не ПравоДоступа("Чтение", Метаданные.РегистрыСведений.ПрограммыОбученияПозицийШтатногоРасписания) Тогда
		
		Возврат;
	КонецЕсли;
	
	ДополнитьФормуШтатногоРасписанияПрограммойОбучения(Форма);
	
	ПараметрыФормы = Форма.Параметры;
	Если ПараметрыФормы.Ключ.Пустая() Тогда
		ШтатноеРасписаниеОбработкаЗаполнения(Форма);
	Иначе
		ПрочитатьДанныеПрограммыОбученияШтатногоРасписания(Форма);
	КонецЕсли;
	
	СтруктураИменРеквизитов = ОбучениеРазвитиеКлиентСервер.ОписаниеСтруктурыИменРеквизитовПрограммыОбученияШтатногоРасписания();
	СоздатьИЗаполнитьРеквизитыПланаОбучения(Форма, СтруктураИменРеквизитов);
	
	ОбучениеРазвитиеКлиентСервер.ШтатноеРасписаниеУстановитьДоступностьЭлементовПрограммыОбучения(Форма);

КонецПроцедуры

Процедура ШтатноеРасписаниеПриЗаписиНаСервере(Форма) Экспорт 
	
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьОбучениеРазвитиеСотрудников")
		ИЛИ Не ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "ПрограммаОбучения") Тогда
		
		Возврат;
	КонецЕсли;
	
	ЗаписатьДанныеПрограммыОбученияШтатногоРасписания(Форма);
	
КонецПроцедуры

Процедура ШтатноеРасписаниеЗаполнитьПрограммуОбученияИзПрофиляНаСервере(Форма) Экспорт

	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьОбучениеРазвитиеСотрудников")
		ИЛИ Не ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "ПрограммаОбучения") Тогда
		
		Возврат;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Форма.ПрофильДолжности) Тогда
		Возврат;
	КонецЕсли;
	
	ДанныеПрофиляДолжности = ОбучениеРазвитие.ПрограммаОбученияПрофиляДолжности(Форма.ПрофильДолжности);
	
	// Настройки.
	НастройкиПрограммыОбучения = ДанныеПрофиляДолжности.НастройкиПрограммыОбучения;
	ЗаполнитьЗначенияСвойств(Форма, НастройкиПрограммыОбучения, "ПродолжительностьПланаОбучения, РазмерностьПродолжительностиПланаОбучения");
	
	// Программа.
	ТаблицаОбучения = Форма.ПрограммаОбучения;
	ТаблицаОбучения.Очистить();
	Для каждого СтрокаОбучения Из ДанныеПрофиляДолжности.ПрограммаОбучения Цикл
		ЗаполнитьЗначенияСвойств(ТаблицаОбучения.Добавить(), СтрокаОбучения);
	КонецЦикла; 
	
	СтруктураИменРеквизитов = ОбучениеРазвитиеКлиентСервер.ОписаниеСтруктурыИменРеквизитовПрограммыОбученияШтатногоРасписания();
	СоздатьИЗаполнитьРеквизитыПланаОбучения(Форма, СтруктураИменРеквизитов);
	
КонецПроцедуры

Процедура ШтатноеРасписаниеЗаполнитьВторичныеДанныеОбученияНаСервере(Форма, ИдентификаторТекущейСтроки) Экспорт

	ЗаполнитьУчебныеЧасыПланаОбучения(Форма, ИдентификаторТекущейСтроки, "ПрограммаОбучения");
	ЗаполнитьОтветственногоВСтрокеПрограммыОбучения(Форма, ИдентификаторТекущейСтроки, "ПрограммаОбучения");

КонецПроцедуры

Функция ШтатноеРасписаниеАдресХарактеристикПерсонала(Форма) Экспорт
	Возврат ПоместитьВоВременноеХранилище(Форма.Характеристики.Выгрузить(, "Характеристика,ТребуетсяОбучение,КартинкаВида"), Форма.УникальныйИдентификатор);
КонецФункции

Функция ШтатноеРасписаниеАдресПрограммыОбучения(Форма) Экспорт
	Возврат ПоместитьВоВременноеХранилище(Форма.ПрограммаОбучения.Выгрузить(, "Мероприятие,Ответственный"), Форма.УникальныйИдентификатор);
КонецФункции

Процедура ШтатноеРасписаниеПересоздатьКолонкиПериодовПрограммыОбучения(Форма) Экспорт

	УдалитьЭлементыКолонкиПериодовПлана(Форма);
	
	СтруктураИменРеквизитов = ОбучениеРазвитиеКлиентСервер.ОписаниеСтруктурыИменРеквизитовПрограммыОбученияШтатногоРасписания();
	СоздатьКолонкиПериодовПрограммыОбучения(Форма, СтруктураИменРеквизитов);

КонецПроцедуры

Процедура ШтатноеРасписаниеЗагрузитьПрограммуОбучения(Форма, Результат) Экспорт
	ЗагрузитьПрограммуОбучения(Форма, Результат, "ПрограммаОбучения");
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ШтатноеРасписание

Процедура ДополнитьФормуШтатногоРасписанияПрограммойОбучения(Форма)

	СоздатьРеквизитыПрограммыОбучения(Форма);
	СоздатьКомандыПрограммыОбучения(Форма);
	
	СоздатьЭлементыФормыПрограммыОбучения(Форма);

КонецПроцедуры

Процедура ПрочитатьДанныеПрограммыОбученияШтатногоРасписания(Форма)

	ПрочитатьНастройкиПрограммыОбученияПозицииШтатногоРасписания(Форма);
	ПрочитатьПрограммуОбученияПозицииШтатногоРасписания(Форма);

КонецПроцедуры

Процедура ПрочитатьНастройкиПрограммыОбученияПозицииШтатногоРасписания(Форма)

	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	НастройкиПрограммОбученияПозицийШтатногоРасписания.ПродолжительностьПланаОбучения КАК ПродолжительностьПланаОбучения,
		|	НастройкиПрограммОбученияПозицийШтатногоРасписания.РазмерностьПродолжительностиПланаОбучения КАК РазмерностьПродолжительностиПланаОбучения,
		|	ВЫБОР
		|		КОГДА НастройкиПрограммОбученияПозицийШтатногоРасписания.СоответствуютПрофилюДолжности = ИСТИНА
		|			ТОГДА 1
		|		ИНАЧЕ 0
		|	КОНЕЦ КАК ПрограммаОбученияСоответствуютПрофилюДолжностиЧисло
		|ИЗ
		|	РегистрСведений.НастройкиПрограммОбученияПозицийШтатногоРасписания КАК НастройкиПрограммОбученияПозицийШтатногоРасписания
		|ГДЕ
		|	НастройкиПрограммОбученияПозицийШтатногоРасписания.ПозицияШтатногоРасписания = &ПозицияШтатногоРасписания";
	
	Запрос.УстановитьПараметр("ПозицияШтатногоРасписания", Форма.Объект.Ссылка);
	
	УстановитьПривилегированныйРежим(Истина);
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат;
	КонецЕсли;
	
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	
	ЗаполнитьЗначенияСвойств(Форма, Выборка);

КонецПроцедуры

Процедура ПрочитатьПрограммуОбученияПозицииШтатногоРасписания(Форма)

	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ПрограммыОбученияПозицийШтатногоРасписания.Мероприятие КАК Мероприятие,
		|	ПрограммыОбученияПозицийШтатногоРасписания.Ответственный КАК Ответственный,
		|	ПрограммыОбученияПозицийШтатногоРасписания.Начало КАК Начало,
		|	ПрограммыОбученияПозицийШтатногоРасписания.Окончание КАК Окончание
		|ИЗ
		|	РегистрСведений.ПрограммыОбученияПозицийШтатногоРасписания КАК ПрограммыОбученияПозицийШтатногоРасписания
		|ГДЕ
		|	ПрограммыОбученияПозицийШтатногоРасписания.ПозицияШтатногоРасписания = &ПозицияШтатногоРасписания";
	
	Запрос.УстановитьПараметр("ПозицияШтатногоРасписания", Форма.Объект.Ссылка);
	
	УстановитьПривилегированныйРежим(Истина);
	РезультатЗапроса = Запрос.Выполнить();
	
	Форма.ПрограммаОбучения.Загрузить(РезультатЗапроса.Выгрузить());

КонецПроцедуры

Процедура ЗаписатьДанныеПрограммыОбученияШтатногоРасписания(Форма)

	МассивИменРеквизитовФормы = Новый Массив;
	ЗарплатаКадры.ЗаполнитьМассивИменРеквизитовФормы(Форма, МассивИменРеквизитовФормы);
	
	Если МассивИменРеквизитовФормы.Найти("ПрограммаОбучения") = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЗаписатьНастройкиПрограммыОбученияПозицииШтатногоРасписания(Форма);
	ЗаписатьПрограммуОбученияПозицииШтатногоРасписания(Форма);

КонецПроцедуры

Процедура ЗаписатьНастройкиПрограммыОбученияПозицииШтатногоРасписания(Форма)

	УстановитьПривилегированныйРежим(Истина);
	
	НаборЗаписей = РегистрыСведений.НастройкиПрограммОбученияПозицийШтатногоРасписания.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.ПозицияШтатногоРасписания.Установить(Форма.Объект.Ссылка);
	
	НоваяЗапись = НаборЗаписей.Добавить();
	НоваяЗапись.ПозицияШтатногоРасписания = Форма.Объект.Ссылка;
	НоваяЗапись.ПродолжительностьПланаОбучения = Форма.ПродолжительностьПланаОбучения;
	НоваяЗапись.РазмерностьПродолжительностиПланаОбучения = Форма.РазмерностьПродолжительностиПланаОбучения;
	НоваяЗапись.СоответствуютПрофилюДолжности = (Форма.ПрограммаОбученияСоответствуютПрофилюДолжностиЧисло = 1);
	
	НаборЗаписей.Записать(Истина);
	
КонецПроцедуры

Процедура ЗаписатьПрограммуОбученияПозицииШтатногоРасписания(Форма)

	УстановитьПривилегированныйРежим(Истина);
	
	НаборЗаписей = РегистрыСведений.ПрограммыОбученияПозицийШтатногоРасписания.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.ПозицияШтатногоРасписания.Установить(Форма.Объект.Ссылка);
	
	Для каждого СтрокаПрограммы Из Форма.ПрограммаОбучения Цикл
		НоваяЗапись = НаборЗаписей.Добавить();
		НоваяЗапись.ПозицияШтатногоРасписания = Форма.Объект.Ссылка;
		ЗаполнитьЗначенияСвойств(НоваяЗапись, СтрокаПрограммы);
	КонецЦикла; 
	
	НаборЗаписей.Записать(Истина);
	
КонецПроцедуры

Процедура ШтатноеРасписаниеОбработкаЗаполнения(Форма)

	Форма.ПродолжительностьПланаОбучения = 8;
	Форма.РазмерностьПродолжительностиПланаОбучения = ПредопределенноеЗначение("Перечисление.Периодичность.Неделя");

КонецПроцедуры

#КонецОбласти

#Область ПрограммаОбучения

Процедура СоздатьРеквизитыПрограммыОбучения(Форма)

	ДобавляемыеРеквизиты = Новый Массив;
	
	// Тумблер
	ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы("ПрограммаОбученияСоответствуютПрофилюДолжностиЧисло", ОбщегоНазначения.ОписаниеТипаЧисло(1,0),,, Истина));
	// Календарь обучения
	ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы("ВсегоУчебныхЧасов", ОбщегоНазначения.ОписаниеТипаЧисло(5,0)));
	ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы("ПродолжительностьПланаОбучения", ОбщегоНазначения.ОписаниеТипаЧисло(3,0),, НСтр("ru = 'Продолжительность плана обучения'")));
	ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы("РазмерностьПродолжительностиПланаОбучения", Новый ОписаниеТипов("ПеречислениеСсылка.Периодичность")));
	
	// ПрограммаОбучения
	ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы("ПрограммаОбучения",	Новый ОписаниеТипов("ТаблицаЗначений"),,, Истина));
	ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы("Мероприятие", Новый ОписаниеТипов("СправочникСсылка.МероприятияОбученияРазвития"), "ПрограммаОбучения"));
	ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы("Ответственный", Новый ОписаниеТипов("СправочникСсылка.ФизическиеЛица"), "ПрограммаОбучения"));
	ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы("Начало", ОбщегоНазначения.ОписаниеТипаЧисло(5,0), "ПрограммаОбучения"));
	ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы("Окончание", ОбщегоНазначения.ОписаниеТипаЧисло(5,0), "ПрограммаОбучения"));
	ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы("КоличествоУчебныхЧасов", ОбщегоНазначения.ОписаниеТипаЧисло(8,2), "ПрограммаОбучения", НСтр("ru = 'Учебных часов'")));
	ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы("НачалоУказанияИнтервала", Новый ОписаниеТипов("Булево"), "ПрограммаОбучения"));
	
	МассивИменРеквизитовФормы = Новый Массив;
	ЗарплатаКадры.ЗаполнитьМассивИменРеквизитовФормы(Форма, МассивИменРеквизитовФормы);
	
	ЗарплатаКадры.ИзменитьРеквизитыФормы(Форма, ДобавляемыеРеквизиты, МассивИменРеквизитовФормы);

КонецПроцедуры

Процедура СоздатьКомандыПрограммыОбучения(Форма)

	Если Форма.Команды.Найти("ПодборПрограммыОбученияПоХарактеристикам") = Неопределено Тогда
		// Добавляем команду формы
		КомандаПодбораПрограммыОбучения = Форма.Команды.Добавить("ПодборПрограммыОбученияПоХарактеристикам");
		КомандаПодбораПрограммыОбучения.Действие = "Подключаемый_ОткрытьПодборПрограммыОбученияПоХарактеристикам";
		КомандаПодбораПрограммыОбучения.Заголовок = НСтр("ru = 'Подобрать по характеристикам'");
	КонецЕсли;

КонецПроцедуры

Процедура СоздатьЭлементыФормыПрограммыОбучения(Форма)

	Элементы = Форма.Элементы;
	
	ГруппаФормы = Элементы.Найти("ПрограммаОбученияГруппаОбщая");
	Если ГруппаФормы = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	// ДействияХарактеристикиСоответствуютПрофилюДолжностиЧисло
	ЭлементТумблер = Элементы.Найти("ПрограммаОбученияСоответствуютПрофилюДолжностиЧисло");
	Если ЭлементТумблер = Неопределено Тогда
		ЭлементТумблер = Элементы.Добавить("ПрограммаОбученияСоответствуютПрофилюДолжностиЧисло", Тип("ПолеФормы"), ГруппаФормы);
		ЭлементТумблер.ПутьКДанным = "ПрограммаОбученияСоответствуютПрофилюДолжностиЧисло";
		ЭлементТумблер.Вид = ВидПоляФормы.ПолеПереключателя;
		ЭлементТумблер.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Нет;
		ЭлементТумблер.ВидПереключателя = ВидПереключателя.Тумблер;
		ЭлементТумблер.СписокВыбора.Добавить(0, НСтр("ru = 'Произвольная'"));
		ЭлементТумблер.СписокВыбора.Добавить(1, НСтр("ru = 'Из профиля'"));
		ЭлементТумблер.УстановитьДействие("ПриИзменении", "Подключаемый_ПрограммаОбученияСоответствуютПрофилюДолжностиЧислоПриИзменении");
	КонецЕсли;
	
	// ПрограммаОбученияНастройкиГруппа
	ПрограммаОбученияНастройкиГруппа = Элементы.Найти("ПрограммаОбученияНастройкиГруппа");
	Если ПрограммаОбученияНастройкиГруппа = Неопределено Тогда
		ПрограммаОбученияНастройкиГруппа = Элементы.Добавить("ПрограммаОбученияНастройкиГруппа", Тип("ГруппаФормы"), ГруппаФормы);
		ПрограммаОбученияНастройкиГруппа.Вид = ВидГруппыФормы.ОбычнаяГруппа;
		ПрограммаОбученияНастройкиГруппа.Отображение = ОтображениеОбычнойГруппы.Нет;
		ПрограммаОбученияНастройкиГруппа.ОтображатьЗаголовок = Ложь;
		ПрограммаОбученияНастройкиГруппа.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Вертикальная;
	КонецЕсли;
	
	// НастройкиПрограммыОбученияГруппа
	НастройкиПрограммыОбученияГруппа = Элементы.Найти("НастройкиПрограммыОбученияГруппа");
	Если НастройкиПрограммыОбученияГруппа = Неопределено Тогда
		НастройкиПрограммыОбученияГруппа = Элементы.Добавить("НастройкиПрограммыОбученияГруппа", Тип("ГруппаФормы"), ПрограммаОбученияНастройкиГруппа);
		НастройкиПрограммыОбученияГруппа.Вид = ВидГруппыФормы.ОбычнаяГруппа;
		НастройкиПрограммыОбученияГруппа.Отображение = ОтображениеОбычнойГруппы.Нет;
		НастройкиПрограммыОбученияГруппа.ОтображатьЗаголовок = Ложь;
		НастройкиПрограммыОбученияГруппа.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Горизонтальная;
	КонецЕсли;
	// ПрограммаОбученияГруппа
	ПрограммаОбученияГруппа = Элементы.Найти("ПрограммаОбученияГруппа");
	Если ПрограммаОбученияГруппа = Неопределено Тогда
		ПрограммаОбученияГруппа = Элементы.Добавить("ПрограммаОбученияГруппа", Тип("ГруппаФормы"), ПрограммаОбученияНастройкиГруппа);
		ПрограммаОбученияГруппа.Вид = ВидГруппыФормы.ОбычнаяГруппа;
		ПрограммаОбученияГруппа.Отображение = ОтображениеОбычнойГруппы.Нет;
		ПрограммаОбученияГруппа.ОтображатьЗаголовок = Ложь;
		ПрограммаОбученияГруппа.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Вертикальная;
	КонецЕсли;
	
	//ПродолжительностьПланаОбучения
	Если Элементы.Найти("ПродолжительностьПланаОбучения") = Неопределено Тогда
		ПродолжительностьПланаОбучения = Элементы.Добавить("ПродолжительностьПланаОбучения", Тип("ПолеФормы"), НастройкиПрограммыОбученияГруппа);
		ПродолжительностьПланаОбучения.Вид = ВидПоляФормы.ПолеВвода;
		ПродолжительностьПланаОбучения.ПутьКДанным = "ПродолжительностьПланаОбучения";
		ПродолжительностьПланаОбучения.УстановитьДействие("ПриИзменении", "Подключаемый_ПродолжительностьПланаОбученияПриИзменении");
	КонецЕсли;
	Если Элементы.Найти("РазмерностьПродолжительностиПланаОбучения") = Неопределено Тогда
		РазмерностьПродолжительностиПланаОбучения = Элементы.Добавить("РазмерностьПродолжительностиПланаОбучения", Тип("ПолеФормы"), НастройкиПрограммыОбученияГруппа);
		РазмерностьПродолжительностиПланаОбучения.Вид = ВидПоляФормы.ПолеВвода;
		РазмерностьПродолжительностиПланаОбучения.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Нет;
		РазмерностьПродолжительностиПланаОбучения.ПутьКДанным = "РазмерностьПродолжительностиПланаОбучения";
		РазмерностьПродолжительностиПланаОбучения.РастягиватьПоГоризонтали = Ложь;
		РазмерностьПродолжительностиПланаОбучения.УстановитьДействие("ПриИзменении", "Подключаемый_РазмерностьПродолжительностиПланаОбученияПриИзменении");
	КонецЕсли;
	
	// ПрограммаОбучения
	ПрограммаОбучения = Элементы.Найти("ПрограммаОбучения");
	Если ПрограммаОбучения = Неопределено Тогда
		ПрограммаОбучения = Элементы.Добавить("ПрограммаОбучения", Тип("ТаблицаФормы"), ПрограммаОбученияГруппа);
		ПрограммаОбучения.ПутьКДанным = "ПрограммаОбучения";
		ПрограммаОбучения.Отображение = ОтображениеТаблицы.Список;
		ПрограммаОбучения.РасширеннаяПодсказка.Заголовок = НСтр("ru = 'Список мероприятий обучения, который может автоматически назначаться каждому сотруднику, принимаемому на эту должность.'");
		ПрограммаОбучения.ОтображениеПодсказки = ОтображениеПодсказки.ОтображатьСнизу;
		ПрограммаОбучения.РасширеннаяПодсказка.АвтоМаксимальнаяШирина = Ложь;
		// Обработчики
		ПрограммаОбучения.УстановитьДействие("ПриИзменении", "Подключаемый_ПрограммаОбученияПриИзменении");
	КонецЕсли;
	Если Элементы.Найти("ПрограммаОбученияМероприятие") = Неопределено Тогда
		ПолеТаблицы = Элементы.Добавить("ПрограммаОбученияМероприятие", Тип("ПолеФормы"), ПрограммаОбучения);
		ПолеТаблицы.ПутьКДанным = "ПрограммаОбучения.Мероприятие";
		ПолеТаблицы.Вид = ВидПоляФормы.ПолеВвода;
		ПолеТаблицы.УстановитьДействие("ПриИзменении", "Подключаемый_ПрограммаОбученияМероприятиеПриИзменении");
	КонецЕсли;
	Если Элементы.Найти("ПрограммаОбученияОтветственный") = Неопределено Тогда
		ПолеТаблицы = Элементы.Добавить("ПрограммаОбученияОтветственный", Тип("ПолеФормы"), ПрограммаОбучения);
		ПолеТаблицы.ПутьКДанным = "ПрограммаОбучения.Ответственный";
		ПолеТаблицы.Вид = ВидПоляФормы.ПолеВвода;
	КонецЕсли;
	Если Элементы.Найти("ПрограммаОбученияКоличествоУчебныхЧасов") = Неопределено Тогда
		ПолеТаблицы = Элементы.Добавить("ПрограммаОбученияКоличествоУчебныхЧасов", Тип("ПолеФормы"), ПрограммаОбучения);
		ПолеТаблицы.ПутьКДанным = "ПрограммаОбучения.КоличествоУчебныхЧасов";
		ПолеТаблицы.Вид = ВидПоляФормы.ПолеВвода;
	КонецЕсли;
	Если Элементы.Найти("ПрограммаОбученияПериодыОбученияГруппа") = Неопределено Тогда
		ПолеТаблицы = Элементы.Добавить("ПрограммаОбученияПериодыОбученияГруппа", Тип("ГруппаФормы"), ПрограммаОбучения);
		ПолеТаблицы.Вид = ВидГруппыФормы.ГруппаКолонок;
		ПолеТаблицы.Группировка = ГруппировкаКолонок.Горизонтальная;
	КонецЕсли;

	// Команда подбора
	Если Форма.Элементы.Найти("ПрограммаОбученияПодборПрограммыОбученияПоХарактеристикам") = Неопределено Тогда
		Элемент = Форма.Элементы.Вставить("ПрограммаОбученияПодборПрограммыОбученияПоХарактеристикам", Тип("КнопкаФормы"), ПрограммаОбучения.КоманднаяПанель);
		Элемент.Вид = ВидКнопкиФормы.ОбычнаяКнопка;
		Элемент.ИмяКоманды = "ПодборПрограммыОбученияПоХарактеристикам"; 
	КонецЕсли;
	
КонецПроцедуры

Процедура СоздатьРеквизитыКолонкиПериодовПлана(Форма, СтруктураИменРеквизитов)

	МассивРеквизитов = Новый Массив;
	
	ЧислоКолонок = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, СтруктураИменРеквизитов.ИмяРеквизитаЧислаКолонок);
	Для Сч = 1 По ЧислоКолонок Цикл
		НоваяКолонкаРеквизит = Новый РеквизитФормы("ПериодПлана" + Строка(Сч), Новый ОписаниеТипов("Булево"), СтруктураИменРеквизитов.ИмяРеквизитаПрограммаОбучения);
		МассивРеквизитов.Добавить(НоваяКолонкаРеквизит);
	КонецЦикла; 
	
	МассивИменРеквизитовФормы = Новый Массив;
	ЗарплатаКадры.ЗаполнитьМассивИменРеквизитовФормы(Форма, МассивИменРеквизитовФормы, СтруктураИменРеквизитов.ИмяРеквизитаПрограммаОбучения);
	ЗарплатаКадры.ИзменитьРеквизитыФормы(Форма, МассивРеквизитов, МассивИменРеквизитовФормы);

КонецПроцедуры

Процедура СоздатьЭлементыКолонкиПериодовПлана(Форма, СтруктураИменРеквизитов)

	ГруппаФормы = Форма.Элементы.Найти("ПрограммаОбученияПериодыОбученияГруппа");
	Если ГруппаФормы = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЧислоКолонок = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, СтруктураИменРеквизитов.ИмяРеквизитаЧислаКолонок);
	Для Сч = 1 По ЧислоКолонок Цикл
		ИмяКолонки = "ПериодПлана" + Строка(Сч);
		КолонкаЭлемент = Форма.Элементы.Найти(ИмяКолонки);
		Если КолонкаЭлемент <> Неопределено Тогда
			Продолжить;
		КонецЕсли;
		ЭлементФормы = Форма.Элементы.Вставить(ИмяКолонки, Тип("ПолеФормы"), ГруппаФормы);
		ЭлементФормы.ПутьКДанным = СтруктураИменРеквизитов.ИмяРеквизитаПрограммаОбучения + "." + ИмяКолонки;
		ЭлементФормы.Вид = ВидПоляФормы.ПолеФлажка;
		ЭлементФормы.Заголовок = Строка(Сч);
	КонецЦикла; 
	
КонецПроцедуры

Процедура ЗаполнитьКоличествоУчебныхЧасовПланаОбучения(Форма, ИмяРеквизитаПрограммаОбучения)
	
	ПрограммаОбучения = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ИмяРеквизитаПрограммаОбучения);
	СоответствиеКоличествоУчебныхЧасов = ОбщегоНазначения.ЗначениеРеквизитаОбъектов(ПрограммаОбучения.Выгрузить(, "Мероприятие").ВыгрузитьКолонку("Мероприятие"), "КоличествоУчебныхЧасов");
	Для каждого СтрокаПлана Из ПрограммаОбучения Цикл
		СтрокаПлана.КоличествоУчебныхЧасов = СоответствиеКоличествоУчебныхЧасов[СтрокаПлана.Мероприятие];
	КонецЦикла; 

КонецПроцедуры

Процедура ЗаполнитьКоличествоУчебныхЧасовПланаОбученияВСтроке(Форма, ИдентификаторТекущейСтроки, ИмяРеквизитаПрограммаОбучения)
	
	Если ИдентификаторТекущейСтроки = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПрограммаОбучения = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ИмяРеквизитаПрограммаОбучения);
	
	ТекущаяСтрока = ПрограммаОбучения.НайтиПоИдентификатору(ИдентификаторТекущейСтроки);
	Если ТекущаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТекущаяСтрока.КоличествоУчебныхЧасов = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ТекущаяСтрока.Мероприятие, "КоличествоУчебныхЧасов");
	
КонецПроцедуры

Процедура ЗаполнитьСтрокиХарактеристикВТаблицеПрограммаОбучения(ПрограммаОбучения, Характеристики, ТаблицаХарактеристикиМероприятия, ЗаполнятьСтрокаХарактеристикОчистилась = Ложь) Экспорт 

	Для каждого СтрокаПрограммыОбучения Из ПрограммаОбучения Цикл
		ЗаполнитьСтрокуХарактеристикВТаблицеПрограммаОбучения(СтрокаПрограммыОбучения, Характеристики, ТаблицаХарактеристикиМероприятия, ЗаполнятьСтрокаХарактеристикОчистилась);
	КонецЦикла; 
	
КонецПроцедуры

Процедура ЗаполнитьСтрокуХарактеристикВТаблицеПрограммаОбучения(СтрокаПрограммыОбучения, Характеристики, ТаблицаХарактеристикиМероприятия, ЗаполнятьСтрокаХарактеристикОчистилась = Ложь) Экспорт 
	
	Если СтрокаПрограммыОбучения = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СтрокаХарактеристик = "";

	НайденныеСтроки = ТаблицаХарактеристикиМероприятия.НайтиСтроки(Новый Структура("Мероприятие", СтрокаПрограммыОбучения.Мероприятие));
	Для каждого НайденнаяСтрока Из НайденныеСтроки Цикл
		НайденныеСтрокиХарактеристик = Характеристики.НайтиСтроки(Новый Структура("Характеристика, ТребуетсяОбучение", НайденнаяСтрока.Характеристика, Истина));
		Если НайденныеСтрокиХарактеристик.Количество() = 0 Тогда
			Продолжить;
		КонецЕсли;
		Аппендикс = ?(ПустаяСтрока(СтрокаХарактеристик), "", ", ");
		СтрокаХарактеристик = СтрокаХарактеристик + Аппендикс + НайденнаяСтрока.Характеристика;
	КонецЦикла; 

	Если ЗаполнятьСтрокаХарактеристикОчистилась Тогда
		СтрокаПрограммыОбучения.СтрокаХарактеристикОчистилась = ПустаяСтрока(СтрокаХарактеристик) И Не ПустаяСтрока(СтрокаПрограммыОбучения.СтрокаХарактеристик);
	КонецЕсли;
	
	СтрокаПрограммыОбучения.СтрокаХарактеристик = СтрокаХарактеристик;
	
КонецПроцедуры

Процедура ЗаполнитьРеквизитыМероприятий(ТаблицаПриемник, ТаблицаИсточник)

	Для каждого СтрокаПриемника Из ТаблицаПриемник Цикл
		СтрокаИсточника = ТаблицаИсточник.Найти(СтрокаПриемника.Мероприятие, "Мероприятие");
		Если СтрокаИсточника = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		ЗаполнитьЗначенияСвойств(СтрокаПриемника, СтрокаИсточника, "Ответственный, КоличествоУчебныхЧасов, СуммаРасходов");
	КонецЦикла; 
	
КонецПроцедуры

#КонецОбласти

Процедура ЗаполнитьКэшХарактеристикиМероприятияПоХарактеристикам(КэшХарактеристикиМероприятия, МассивХарактеристик) Экспорт

	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	МероприятияОбученияРазвитияХарактеристикиПерсонала.Ссылка КАК Мероприятие,
		|	МероприятияОбученияРазвитияХарактеристикиПерсонала.Характеристика КАК Характеристика
		|ИЗ
		|	Справочник.МероприятияОбученияРазвития.ХарактеристикиПерсонала КАК МероприятияОбученияРазвитияХарактеристикиПерсонала
		|ГДЕ
		|	МероприятияОбученияРазвитияХарактеристикиПерсонала.Характеристика В(&МассивХарактеристик)
		|
		|УПОРЯДОЧИТЬ ПО
		|	Мероприятие";
	
	Запрос.УстановитьПараметр("МассивХарактеристик", МассивХарактеристик);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	КэшХарактеристикиМероприятия.Загрузить(РезультатЗапроса.Выгрузить());

КонецПроцедуры

Процедура ОбновитьКэшХарактеристикиМероприятияДляМероприятия(КэшХарактеристикиМероприятия, Мероприятие) Экспорт

	Если Мероприятие = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	// Удаление текущих строк.
	УдаляемыеСтроки = КэшХарактеристикиМероприятия.НайтиСтроки(Новый Структура("Мероприятие", Мероприятие));
	Для каждого УдаляемаяСтрока Из УдаляемыеСтроки Цикл
		КэшХарактеристикиМероприятия.Удалить(УдаляемаяСтрока);
	КонецЦикла; 
	
	// Добавление новых.
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	МероприятияОбученияРазвитияХарактеристикиПерсонала.Ссылка КАК Мероприятие,
		|	МероприятияОбученияРазвитияХарактеристикиПерсонала.Характеристика КАК Характеристика
		|ИЗ
		|	Справочник.МероприятияОбученияРазвития.ХарактеристикиПерсонала КАК МероприятияОбученияРазвитияХарактеристикиПерсонала
		|ГДЕ
		|	МероприятияОбученияРазвитияХарактеристикиПерсонала.Ссылка = &Мероприятие";
	Запрос.УстановитьПараметр("Мероприятие", Мероприятие);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл
		ЗаполнитьЗначенияСвойств(КэшХарактеристикиМероприятия.Добавить(), Выборка);
	КонецЦикла;

КонецПроцедуры

Процедура УстановитьПризнакОбучениеХарактеристикам(Форма, АдресХарактеристикиОбучение)

	Характеристики = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, "Характеристики");
	ЗагруженныеХарактеристики = ПолучитьИзВременногоХранилища(АдресХарактеристикиОбучение);
	
	Для каждого СтрокаХарактеристики Из Характеристики Цикл
		НайденныеСтроки = ЗагруженныеХарактеристики.НайтиСтроки(Новый Структура("Характеристика", СтрокаХарактеристики.Характеристика));
		Если НайденныеСтроки.Количество() = 0 Тогда
			Продолжить;
		КонецЕсли;
		СтрокаХарактеристики.ТребуетсяОбучение = НайденныеСтроки[0].ТребуетсяОбучение;
	КонецЦикла; 

КонецПроцедуры

#КонецОбласти
