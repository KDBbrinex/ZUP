////////////////////////////////////////////////////////////////////////////////
// Подсистема "Синхронизация данных"
// Серверные процедуры, обслуживающие правила регистрации объектов.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.ОбменДанными

// См. ОбменДаннымиПереопределяемый.РегистрацияИзмененийНачальнойВыгрузкиДанных
Процедура РегистрацияИзмененийНачальнойВыгрузкиДанных(Знач Получатель, СтандартнаяОбработка, Отбор) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ОбменЗарплата3Бухгалтерия3") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("ОбменДаннымиЗарплата3Бухгалтерия3");
		Модуль.ОбработкаРегистрацииНачальнойВыгрузкиДанных(Получатель, СтандартнаяОбработка, Отбор);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ОбменЗГУБГУ1") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("ОбменЗГУБГУ1");
		Модуль.ОбработкаРегистрацииНачальнойВыгрузкиДанных(Получатель, СтандартнаяОбработка, Отбор);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ОбменЗГУБГУ2") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("ОбменЗГУБГУ2");
		Модуль.ОбработкаРегистрацииНачальнойВыгрузкиДанных(Получатель, СтандартнаяОбработка, Отбор);
	КонецЕсли;
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.ОбменДанными

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Процедура обновляет вторичные данные использования обмена данными
// Параметры
//	ИмяПланаОбмена - имя плана обмена для которого выполняется запись вторичных данных
//	КонстантаМенеджер - тип КонстантаМенеджер, в которой хранится настройка использования обмена по всем организациям
//	НаборЗаписей - набор записей регистра сведений, в котором хранятся настройки использования обмена в разрезе организаций
//	СсылкаНаУдаляемыйУзел - ссылка на узел плана обмена при обработке удаления которого вызвана эта процедура.
//
Процедура ОбновитьНастройкиИспользованияОбменаДанными(ИмяПланаОбмена, КонстантаМенеджер, НаборЗаписей, СсылкаНаУдаляемыйУзел = Неопределено) Экспорт
	
	ПолноеИмяПланаОбмена = "ПланОбмена."+ИмяПланаОбмена;
	
	ИсключаемыеУзлы = Новый Массив;
	ИсключаемыеУзлы.Добавить(ПланыОбмена[ИмяПланаОбмена].ЭтотУзел());
	Если СсылкаНаУдаляемыйУзел <> Неопределено Тогда
		ИсключаемыеУзлы.Добавить(СсылкаНаУдаляемыйУзел);
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ИсключаемыеУзлы", ИсключаемыеУзлы);
	Запрос.Текст =
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	ПланыОбменов.ИспользоватьОтборПоОрганизациям
	|ИЗ
	|	#ПолноеИмяПланаОбмена КАК ПланыОбменов
	|ГДЕ
	|	НЕ ПланыОбменов.Ссылка В (&ИсключаемыеУзлы)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	МИНИМУМ(ПланыОбменов.ИспользоватьОтборПоОрганизациям) КАК ИспользоватьОтборПоОрганизациям
	|ИЗ
	|	#ПолноеИмяПланаОбмена КАК ПланыОбменов
	|ГДЕ
	|	НЕ ПланыОбменов.Ссылка В (&ИсключаемыеУзлы)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Организации.Организация,
	|	ИСТИНА КАК Используется
	|ИЗ
	|	#ТаблицаОрганизации КАК Организации
	|ГДЕ
	|	НЕ Организации.Ссылка В (&ИсключаемыеУзлы)";
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "#ПолноеИмяПланаОбмена", ПолноеИмяПланаОбмена);
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "#ТаблицаОрганизации", ПолноеИмяПланаОбмена + ".Организации");
	Результат = Запрос.ВыполнитьПакет();
	
	Выборка = Результат[1].Выбрать();
	Выборка.Следующий();
	
	ЗначениеОтборПоВсемОрганизациям = Ложь;
	
	Если Результат[0].Пустой() Тогда
		// нет настроенных узлов обмена, не меняем значения по умолчанию
	ИначеЕсли Не Выборка.ИспользоватьОтборПоОрганизациям Тогда
		ЗначениеОтборПоВсемОрганизациям = Истина;
	Иначе
		// включен отбор по организациям, заполним список выбранных организаций
		НаборЗаписей.Загрузить(Результат[2].Выгрузить());
	КонецЕсли;
	
	КонстантаМенеджер.Установить(ЗначениеОтборПоВсемОрганизациям);
	НаборЗаписей.Записать();
	
КонецПроцедуры

Функция НеобходимоОбновлениеВторичныхДанных(НаборЗаписей) Экспорт
	
	НеобходимоОбновлениеВторичныхДанных = Истина;
	Если НаборЗаписей.ДополнительныеСвойства.Свойство("ПодготовитьОбновлениеВторичныхДанных") Тогда
		Возврат НаборЗаписей.ДополнительныеСвойства.ПодготовитьОбновлениеВторичныхДанных;
	КонецЕсли;
	
	Возврат НеобходимоОбновлениеВторичныхДанных;
	
КонецФункции

Процедура ЗапуститьОтложеннуюОбработкуЗаполненияДанныхПоФизическимЛицам(ТекущийОбъект, ЗапуститьВФоне = Истина) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.СинхронизацияДанных") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("СинхронизацияДанныхЗарплатаКадрыСервер");
		Модуль.ЗапуститьОтложеннуюОбработкуЗаполненияДанныхПоФизическимЛицам(ТекущийОбъект, ЗапуститьВФоне);
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗапуститьОтложеннуюОбработкуЗаполненияДанныхПоСотрудникам(ТекущийОбъект, ЗапуститьВФоне = Истина) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.СинхронизацияДанных") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("СинхронизацияДанныхЗарплатаКадрыСервер");
		Модуль.ЗапуститьОтложеннуюОбработкуЗаполненияДанныхПоСотрудникам(ТекущийОбъект, ЗапуститьВФоне);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОграничитьРегистрациюОбъектаОтборомПоГоловнымОрганизациям(ИмяПланаОбмена, Отказ, ТекстЗапроса, ПараметрыЗапроса, ИспользоватьКэш, Объект, Ссылка) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.СинхронизацияДанных") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("СинхронизацияДанныхЗарплатаКадрыСервер");
		Модуль.ОграничитьРегистрациюОбъектаОтборомПоГоловнымОрганизациям(ИмяПланаОбмена, Отказ, ТекстЗапроса, ПараметрыЗапроса, ИспользоватьКэш, Объект, Ссылка);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОграничитьРегистрациюОбъектаОтборомПоОрганизациям(ИмяПланаОбмена, Отказ, ТекстЗапроса, ПараметрыЗапроса, ИспользоватьКэш, Объект, Ссылка) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.СинхронизацияДанных") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("СинхронизацияДанныхЗарплатаКадрыСервер");
		Модуль.ОграничитьРегистрациюОбъектаОтборомПоОрганизациям(ИмяПланаОбмена, Отказ, ТекстЗапроса, ПараметрыЗапроса, ИспользоватьКэш, Объект, Ссылка);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОграничитьРегистрациюОбъектаОтборомПоСотруднику(ИмяПланаОбмена, Отказ, ТекстЗапроса, ПараметрыЗапроса, ИспользоватьКэш, Объект, Сотрудник) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.СинхронизацияДанных") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("СинхронизацияДанныхЗарплатаКадрыСервер");
		Модуль.ОграничитьРегистрациюОбъектаОтборомПоСотруднику(ИмяПланаОбмена, Отказ, ТекстЗапроса, ПараметрыЗапроса, ИспользоватьКэш, Объект, Сотрудник);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОграничитьРегистрациюОбъектаОтборомПоФизическимЛицам(ИмяПланаОбмена, Отказ, ТекстЗапроса, ПараметрыЗапроса, ИспользоватьКэш, Объект, Ссылка) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.СинхронизацияДанных") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("СинхронизацияДанныхЗарплатаКадрыСервер");
		Модуль.ОграничитьРегистрациюОбъектаОтборомПоФизическимЛицам(ИмяПланаОбмена, Отказ, ТекстЗапроса, ПараметрыЗапроса, ИспользоватьКэш, Объект, Ссылка);
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗарегистрироватьСвязанныеРегистрыСведенийОбъекта(ИмяПланаОбмена, Отказ, ГоловнаяОрганизация, Выгрузка, Получатели) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.СинхронизацияДанных") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("СинхронизацияДанныхЗарплатаКадрыСервер");
		Модуль.ЗарегистрироватьСвязанныеРегистрыСведенийОбъекта(ИмяПланаОбмена, Отказ, ГоловнаяОрганизация, Выгрузка, Получатели);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПринадлежностьФизлицаОрганизацииПриЗаписи(ДокументОбъект) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.СинхронизацияДанных") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("СинхронизацияДанныхЗарплатаКадрыСервер");
		Модуль.ПринадлежностьФизлицаОрганизацииПриЗаписи(ДокументОбъект);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОрганизацииСотрудниковПриЗаписи(ДокументОбъект) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.СинхронизацияДанных") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("СинхронизацияДанныхЗарплатаКадрыСервер");
		Модуль.ОрганизацииСотрудниковПриЗаписи(ДокументОбъект);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбновитьЗависимыеДанныеТекущиеКадровыеДанныеСотрудников(ЗависимыеДанные) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.СинхронизацияДанных") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("СинхронизацияДанныхЗарплатаКадрыСервер");
		Модуль.ОбновитьЗависимыеДанныеТекущиеКадровыеДанныеСотрудников(ЗависимыеДанные);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
