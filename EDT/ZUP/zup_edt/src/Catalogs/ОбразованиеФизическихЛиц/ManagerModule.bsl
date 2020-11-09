#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Владелец)";
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#КонецЕсли

#Область ОбработчикиСобытий

// Формирует представление об образовании физического лица.
Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ДополнительноеОбразование = ЗарплатаКадрыРасширенныйКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ДополнительноеПрофессиональноеОбразование");
	ПослевузовскоеОбразование = ЗарплатаКадрыРасширенныйКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ВысшееОбразованиеПодготовкаКадровВысшейКвалификации");
	
	Если ПослевузовскоеОбразование = Неопределено Тогда
		
		ПослевузовскоеОбразование = ЗарплатаКадрыРасширенныйКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ПослевузовскоеОбразование");
		Если ПослевузовскоеОбразование = Неопределено Тогда
			ПослевузовскоеОбразование = ПредопределенноеЗначение("Справочник.ВидыОбразованияФизическихЛиц.ПустаяСсылка");
		КонецЕсли;
		
	КонецЕсли;
	
	Если Данные.ВидОбразования = ПослевузовскоеОбразование Тогда
		Представление = Строка(Данные.ВидПослевузовскогоОбразования);
	ИначеЕсли ЗначениеЗаполнено(Данные.ВидДополнительногоОбучения)
		И (Данные.ВидДополнительногоОбучения = ПредопределенноеЗначение("Перечисление.ВидыПрофессиональнойПодготовки.ПовышениеКвалификации")
		ИЛИ Данные.ВидДополнительногоОбучения = ПредопределенноеЗначение("Перечисление.ВидыПрофессиональнойПодготовки.Переподготовка")) Тогда
		Представление = Строка(Данные.ВидДополнительногоОбучения);
	ИначеЕсли Не Данные.ВидОбразования = ДополнительноеОбразование Тогда 
		Представление = Строка(Данные.ВидОбразования);
	КонецЕсли;
	
	Представление = Представление + ?(ЗначениеЗаполнено(Данные.УчебноеЗаведение)," "+ Строка(Данные.УчебноеЗаведение), "")
		+ ?(ЗначениеЗаполнено(Данные.Окончание), " (" + Формат(Данные.Окончание, "ДФ=гггг") + ")", ""); 
	
	Если ПустаяСтрока(Представление) Тогда 
		Представление = НСтр("ru='Нет Данных'");
	КонецЕсли;

КонецПроцедуры

Процедура ОбработкаПолученияПолейПредставления(Поля, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Поля.Добавить("ВидОбразования");
	Поля.Добавить("ВидПослевузовскогоОбразования");
	Поля.Добавить("ВидДополнительногоОбучения");
	Поля.Добавить("УчебноеЗаведение");
	Поля.Добавить("Окончание");
	
КонецПроцедуры

#КонецОбласти

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Формирует представление об образовании физического лица, по переделанной коллекции записей.
//
// Параметры:
//		ЗаписиОбОбразовании - Коллекция записей с полями:
//				* ВидОбразования.
//				* ВидДополнительногоОбучения.
//				* УчебноеЗаведение.
//				* Окончание				- Дата
//				* Специальность
//				* Квалификация
//
// Возвращаемое значение:
//		Строка
//
Функция ПредставлениеСведенийОбОбразовании(ЗаписиОбОбразовании) Экспорт
	
	ПредставлениеСведенийОбОбразовании = НСтр("ru='Нет сведений'");
	
	ДанныеОбразования = Неопределено;
	Для Каждого СтрокаОбразование Из ЗаписиОбОбразовании Цикл
		
		Если СтрокаОбразование.ВидОбразования = ОбщегоНазначения.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ДополнительноеПрофессиональноеОбразование")
			Или СтрокаОбразование.ВидДополнительногоОбучения = ПредопределенноеЗначение("Перечисление.ВидыПрофессиональнойПодготовки.ПовышениеКвалификации")
			Или СтрокаОбразование.ВидДополнительногоОбучения = ПредопределенноеЗначение("Перечисление.ВидыПрофессиональнойПодготовки.Переподготовка") Тогда
			Продолжить;
		КонецЕсли; 
		
		Если ДанныеОбразования = Неопределено ИЛИ ДанныеОбразования.Окончание < СтрокаОбразование.Окончание Тогда
			ДанныеОбразования = СтрокаОбразование;
		КонецЕсли; 
		
	КонецЦикла;
	
	Если ДанныеОбразования <> Неопределено Тогда
		
		ПредставлениеСведенийОбОбразовании = ?(ЗначениеЗаполнено(ДанныеОбразования.ВидОбразования), Строка(ДанныеОбразования.ВидОбразования), "");
		
		ПредставлениеСведенийОбОбразовании = ?(ПустаяСтрока(ПредставлениеСведенийОбОбразовании), "", ПредставлениеСведенийОбОбразовании + Символы.ПС)
			+ ?(ЗначениеЗаполнено(ДанныеОбразования.УчебноеЗаведение), Строка(ДанныеОбразования.УчебноеЗаведение), "")
			+ ?(ЗначениеЗаполнено(ДанныеОбразования.Окончание), " (" + Формат(ДанныеОбразования.Окончание, "ДФ=гггг") + ")", ""); 
			
		ПредставлениеСведенийОбОбразовании = ?(ПустаяСтрока(ПредставлениеСведенийОбОбразовании), "", ПредставлениеСведенийОбОбразовании + Символы.ПС)
			+ ?(ЗначениеЗаполнено(ДанныеОбразования.Специальность), Строка(ДанныеОбразования.Специальность), "")
			+ ?(ЗначениеЗаполнено(ДанныеОбразования.Квалификация), ", " + Строка(ДанныеОбразования.Квалификация), "");
			
	КонецЕсли; 
		
	Возврат ПредставлениеСведенийОбОбразовании;
	
КонецФункции

// Формирует таблицу сведений об образовании физического лица.
//
Функция ОбразованиеФизическогоЛица(ФизическоеЛицо) Экспорт
	
	Запрос = Новый Запрос(
		"ВЫБРАТЬ
		|	ОбразованиеФизическихЛиц.Ссылка,
		|	ОбразованиеФизическихЛиц.ВидОбразования,
		|	ОбразованиеФизическихЛиц.ВидПослевузовскогоОбразования,
		|	ОбразованиеФизическихЛиц.УчебноеЗаведение,
		|	ОбразованиеФизическихЛиц.Специальность,
		|	ОбразованиеФизическихЛиц.ВидДокумента,
		|	ОбразованиеФизическихЛиц.Серия,
		|	ОбразованиеФизическихЛиц.Номер,
		|	ОбразованиеФизическихЛиц.ДатаВыдачи,
		|	ОбразованиеФизическихЛиц.Квалификация,
		|	ОбразованиеФизическихЛиц.Начало КАК Начало,
		|	ОбразованиеФизическихЛиц.Окончание,
		|	ОбразованиеФизическихЛиц.НаименованиеКурса,
		|	ОбразованиеФизическихЛиц.КоличествоЧасов,
		|	ОбразованиеФизическихЛиц.ВидДополнительногоОбучения,
		|	ВЫБОР
		|		КОГДА ОбразованиеФизическихЛиц.ВидОбразования <> ЗНАЧЕНИЕ(Справочник.ВидыОбразованияФизическихЛиц.ДополнительноеПрофессиональноеОбразование)
		|				И ОбразованиеФизическихЛиц.ВидДополнительногоОбучения <> ЗНАЧЕНИЕ(Перечисление.ВидыПрофессиональнойПодготовки.Переподготовка)
		|				И ОбразованиеФизическихЛиц.ВидДополнительногоОбучения <> ЗНАЧЕНИЕ(Перечисление.ВидыПрофессиональнойПодготовки.ПовышениеКвалификации)
		|			ТОГДА ИСТИНА
		|		ИНАЧЕ ЛОЖЬ
		|	КОНЕЦ КАК ОсновноеОбразование,
		|	ОбразованиеФизическихЛиц.Основание
		|ИЗ
		|	Справочник.ОбразованиеФизическихЛиц КАК ОбразованиеФизическихЛиц
		|ГДЕ
		|	ОбразованиеФизическихЛиц.Владелец = &ФизическоеЛицо
		|	И ОбразованиеФизическихЛиц.ПометкаУдаления = ЛОЖЬ
		|
		|УПОРЯДОЧИТЬ ПО
		|	ОсновноеОбразование УБЫВ,
		|	Начало");
		
	Запрос.УстановитьПараметр("ФизическоеЛицо", ФизическоеЛицо);
	
	Возврат Запрос.Выполнить().Выгрузить();
		
КонецФункции

#КонецОбласти

#КонецЕсли