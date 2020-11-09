#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОписаниеПеременных

Перем ЗависимыеДанные;
Перем ДанныеРегистрации;

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ПриПолученииДанныхОтПодчиненного(ЭлементДанных, ПолучениеЭлемента, ОтправкаНазад)
	
	Если ТипЗнч(ЭлементДанных) = Тип("УдалениеОбъекта") Тогда
		ОбъектМетаданных = ЭлементДанных.Ссылка.Метаданные();
	Иначе
		ОбъектМетаданных = ЭлементДанных.Метаданные();
	КонецЕсли;
	
	Если ОбщегоНазначения.ЭтоРегистр(ОбъектМетаданных) И ЭлементДанных.Количество() = 0 Тогда
		// Это удаление набора записей, чтобы не было коллизии принимаем пустой набор.
		ПолучениеЭлемента = ПолучениеЭлементаДанных.Принять;
	КонецЕсли;
	
	ПриПолученииДанныхФайла(ЭлементДанных, ПолучениеЭлемента, Ложь);
	
КонецПроцедуры

Процедура ПриПолученииДанныхОтГлавного(ЭлементДанных, ПолучениеЭлемента, ОтправкаНазад)
	
	Если ТипЗнч(ЭлементДанных) = Тип("УдалениеОбъекта") Тогда
		ДанныеВБазе = ЭлементДанных.Ссылка.ПолучитьОбъект();
		
		Если ДанныеВБазе = Неопределено Тогда
			Возврат;
		КонецЕсли;
		
		ДанныеВБазе.ПометкаУдаления = Истина;
		
		Если ОбщегоНазначения.ЭтоДокумент(ДанныеВБазе.Метаданные()) Тогда
			ДанныеВБазе.Проведен = Ложь;
		КонецЕсли;
		
		ОбновлениеИнформационнойБазы.ЗаписатьДанные(ДанныеВБазе);
		
		ПолучениеЭлемента = ПолучениеЭлементаДанных.Игнорировать;
	КонецЕсли;
	
	ПриПолученииДанныхФайла(ЭлементДанных, ПолучениеЭлемента, Истина);
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ЭтоНовый() Тогда
		
		Если НЕ ИспользоватьОтборПоОрганизациям И Организации.Количество() <> 0 Тогда
			Организации.Очистить();
		ИначеЕсли Организации.Количество() = 0 И ИспользоватьОтборПоОрганизациям Тогда
			ИспользоватьОтборПоОрганизациям = Ложь;
		КонецЕсли;
		
	КонецЕсли;
	
	Если Ссылка <> ПланыОбмена.АвтономнаяРабота.ЭтотУзел() Тогда
		
		Если ОбменДаннымиСервер.НадоВыполнитьОбработчикПослеЗагрузкиДанных(ЭтотОбъект, Ссылка) Тогда
			ПослеЗагрузкиДанных();
		КонецЕсли;
		
	КонецЕсли;
	
	ДополнительныеСвойства.Вставить("ИспользуетсяОтборПоОрганизациям", СинхронизацияДанныхЗарплатаКадрыСервер.ИспользуютсяУзлыРИБСОтборомПоОрганизациям(Ссылка));
	ДополнительныеСвойства.Вставить("ИспользуетсяОтборПоПодразделениям", СинхронизацияДанныхЗарплатаКадрыСервер.ИспользуютсяУзлыРИБСОтборомПоПодразделениям(Ссылка));
	
	// /Выполняется после, т.к. АРМ записывается ОбменДанными.Загрузка = Истина
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередУдалением(Отказ)
	
	// Проверка значения свойства ОбменДанными.Загрузка отсутствует по причине того, что в расположенным ниже коде,
	// реализована логика, которая должна выполняться в том числе при установке этого свойства равным Истина
	// (на стороне кода, который выполняет попытку записи в данный план обмена).
	
	// Для плана обмена используется безопасное хранилище,
	// поэтому при удалении узла обмена необходимо также удалять соответствующую запись из хранилища
	// (в соответствии с документацией по подсистеме базовой функциональности).
	
	УстановитьПривилегированныйРежим(Истина);
	ОбщегоНазначения.УдалитьДанныеИзБезопасногоХранилища(Ссылка);
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ИспользоватьОтборПоОрганизациям И СинхронизироватьДанныеПоОрганизациям
		И Не ДополнительныеСвойства.ИспользуетсяОтборПоОрганизациям
		И Не СинхронизацияДанныхЗарплатаКадрыСервер.ОрганизацииФизическихЛицЗаполняются()
		И Не СинхронизацияДанныхЗарплатаКадрыСервер.ОрганизацииСотрудниковЗаполняются() Тогда
		
		ДополнительныеСвойства.Вставить("ЗарегистрироватьУтраченныхФизическихЛицОрганизаций", Истина);
		ДополнительныеСвойства.Вставить("ЗарегистрироватьПринадлежностьФизическихЛицОрганизаций", Истина);
		
		ДополнительныеСвойства.Вставить("ЗарегистрироватьУтраченныеОрганизацииСотрудников", Истина);
		ДополнительныеСвойства.Вставить("ЗарегистрироватьОрганизацииСотрудников", Истина);
		
	КонецЕсли;
	
	Если ИспользоватьОтборПоПодразделениям И СинхронизироватьДанныеПоПодразделениям
		И Не ДополнительныеСвойства.ИспользуетсяОтборПоПодразделениям
		И Не СинхронизацияДанныхЗарплатаКадрыСервер.ПодразделенияФизическихЛицЗаполняются()
		И Не СинхронизацияДанныхЗарплатаКадрыСервер.ПодразделенияСотрудниковЗаполняются() Тогда
		
		ДополнительныеСвойства.Вставить("ЗарегистрироватьУтраченныхФизическихЛицПодразделений", Истина);
		ДополнительныеСвойства.Вставить("ЗарегистрироватьПринадлежностьФизическихЛицПодразделений", Истина);
		
		ДополнительныеСвойства.Вставить("ЗарегистрироватьУтраченныеПодразделенияСотрудников", Истина);
		ДополнительныеСвойства.Вставить("ЗарегистрироватьПодразделенияСотрудников", Истина);
		
	КонецЕсли;
	
	Если ДополнительныеСвойства.Свойство("ЗаписьИзФормы") И ДополнительныеСвойства.ЗаписьИзФормы Тогда
		// На форме обработчики запускаются в ПослеЗаписиНаСервере
	Иначе
		ОбновитьПовторноИспользуемыеЗначения();
		СинхронизацияДанныхЗарплатаКадры.ЗапуститьОтложеннуюОбработкуЗаполненияДанныхПоФизическимЛицам(ЭтотОбъект, Ложь);
		СинхронизацияДанныхЗарплатаКадры.ЗапуститьОтложеннуюОбработкуЗаполненияДанныхПоСотрудникам(ЭтотОбъект, Ложь);
	КонецЕсли;
	
	// /Выполняется после, т.к. АРМ записывается ОбменДанными.Загрузка = Истина
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Переопределяет стандартное поведение при загрузке данных;
//
Процедура ПриПолученииДанныхФайла(ЭлементДанных, ПолучениеЭлемента, ЭтоПолучениеОтГлавного)
	
	// СтандартныеПодсистемы.Взаимодействия
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.СинхронизацияДанныхЗарплатаКадрыВзаимодействия") Тогда
		МодульВзаимодействия = ОбщегоНазначения.ОбщийМодуль("СинхронизацияДанныхЗарплатаКадрыВзаимодействия");
		МодульВзаимодействия.ПриПолученииДанныхФайла(ЭтотОбъект, ЭлементДанных);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Взаимодействия
	
	ЕстьКоллизия = ПланыОбмена.ИзменениеЗарегистрировано(Ссылка, ЭлементДанных);
	
	ПолучениеЭлементаРасчетное = ПолучениеЭлементаДанных.Авто;
	Если ЕстьКоллизия Тогда
		Если ПолучениеЭлемента = ПолучениеЭлементаДанных.Авто Тогда
			ПолучениеЭлементаРасчетное = ?(ЭтоПолучениеОтГлавного, ПолучениеЭлементаДанных.Принять, ПолучениеЭлементаДанных.Игнорировать);
		КонецЕсли;
	КонецЕсли;
	
	Если ЕстьКоллизия И ПолучениеЭлементаРасчетное = ПолучениеЭлементаДанных.Игнорировать Тогда
		// Объекты не загружаются из-за коллизии, поэтому вторичные данные по ним не требуется пересчитывать
		Возврат;
	КонецЕсли;
	
	СинхронизацияДанныхЗарплатаКадрыСервер.ПриПолученииЗависимыхДанных(ЭлементДанных, ЗависимыеДанные);
	СинхронизацияДанныхЗарплатаКадрыСервер.ПриПолученииОбъектовРегистрирующихЗависимыеОбъекты(ЭлементДанных, ДанныеРегистрации);
	
КонецПроцедуры

Процедура ПослеЗагрузкиДанных()
	
	// СтандартныеПодсистемы.Взаимодействия
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.СинхронизацияДанныхЗарплатаКадрыВзаимодействия") Тогда
		МодульВзаимодействия = ОбщегоНазначения.ОбщийМодуль("СинхронизацияДанныхЗарплатаКадрыВзаимодействия");
		МодульВзаимодействия.ПослеЗагрузкиДанных(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Взаимодействия
	
	// СтандартныеПодсистемы.ЗащитаПерсональныхДанных
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ЗащитаПерсональныхДанных") Тогда
		МодульЗащитаПерсональныхДанных = ОбщегоНазначения.ОбщийМодуль("ЗащитаПерсональныхДанных");
		МодульЗащитаПерсональныхДанных.ПослеЗагрузкиДанных(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.ЗащитаПерсональныхДанных
	
	СинхронизацияДанныхЗарплатаКадрыСервер.ПослеЗагрузкиЗависимыхДанных(ЗависимыеДанные);
	СинхронизацияДанныхЗарплатаКадрыСервер.ПослеЗагрузкиОбъектовРегистрирующихЗависимыеОбъекты(ДанныеРегистрации);
	
КонецПроцедуры

#КонецОбласти

#Область Инициализация

ЗависимыеДанные = Неопределено;
ДанныеРегистрации = Неопределено;

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли