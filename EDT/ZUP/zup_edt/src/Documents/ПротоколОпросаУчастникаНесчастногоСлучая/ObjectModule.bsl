#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		МетаданныеОбъекта = Метаданные();
		Для Каждого ПараметрЗаполнения Из ДанныеЗаполнения Цикл
			Если МетаданныеОбъекта.Реквизиты.Найти(ПараметрЗаполнения.Ключ)<>Неопределено Тогда
				ЭтотОбъект[ПараметрЗаполнения.Ключ] = ПараметрЗаполнения.Значение;
			Иначе
				Если ОбщегоНазначения.ЭтоСтандартныйРеквизит(МетаданныеОбъекта.СтандартныеРеквизиты, ПараметрЗаполнения.Ключ) Тогда
					ЭтотОбъект[ПараметрЗаполнения.Ключ] = ПараметрЗаполнения.Значение;
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.НесчастныйСлучайНаПроизводстве") Тогда
		
		ДанныеДокументаОснования = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ДанныеЗаполнения, "Организация, Подразделение, Ссылка");
		Организация = ДанныеДокументаОснования.Организация;
		Подразделение = ДанныеДокументаОснования.Подразделение;
		ДокументОснование = ДанныеДокументаОснования.Ссылка;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	ДатаПроисшествия = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ДокументОснование, "ДатаПроисшествия");
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", ДокументОснование);
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	НесчастныйСлучайНаПроизводствеПострадавшие.Пострадавший
	|ИЗ
	|	Документ.НесчастныйСлучайНаПроизводстве.Пострадавшие КАК НесчастныйСлучайНаПроизводствеПострадавшие
	|ГДЕ
	|	НесчастныйСлучайНаПроизводствеПострадавшие.Ссылка = &Ссылка
	|	И НесчастныйСлучайНаПроизводствеПострадавшие.Пострадавший <> ЗНАЧЕНИЕ(Справочник.ФизическиеЛица.ПустаяСсылка)";
	
	Пострадавшие.Очистить();
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		НоваяСтрока = Пострадавшие.Добавить();
		НоваяСтрока.Пострадавший = Выборка.Пострадавший;
	КонецЦикла;
	КраткийСоставПострадавшие = ЗарплатаКадры.КраткийСоставФизЛиц(Пострадавшие.ВыгрузитьКолонку("Пострадавший"), ДатаПроисшествия);
	
	МассивУчастников = Новый Массив;
	СтрокаУчастников = "";
	Для каждого СтрокаУчастника Из УчастникиОпроса Цикл
		Если Не ЗначениеЗаполнено(СтрокаУчастника.Участник) Тогда
			Продолжить;
		ИначеЕсли ТипЗнч(СтрокаУчастника.Участник) = Тип("СправочникСсылка.ФизическиеЛица") Тогда
			МассивУчастников.Добавить(СтрокаУчастника.Участник);
		Иначе
			СтрокаУчастников = СтрокаУчастников + СтрокаУчастника.Участник + ", ";
		КонецЕсли;
	КонецЦикла;
	СтроковыеФункцииКлиентСервер.УдалитьПоследнийСимволВСтроке(СтрокаУчастников, 2);
	
	КраткийСоставУчастники = ЗарплатаКадры.КраткийСоставФизЛиц(МассивУчастников, ДатаПроисшествия);
	Если Не ПустаяСтрока(СтрокаУчастников) Тогда
		КраткийСоставУчастники = КраткийСоставУчастники + ", " + СтрокаУчастников;
		СтрокаПостфикс = "";
		Если СтрДлина(КраткийСоставУчастники) > (100 - 3) Тогда
			СтрокаПостфикс = "...";
		КонецЕсли;
		КраткийСоставУчастники = Лев(КраткийСоставУчастники, 100 - 3) + СтрокаПостфикс;
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	ЗарплатаКадры.ПроверитьКорректностьДаты(Ссылка, ДатаСоставленияПротоколаОпроса, "Объект.ДатаСоставленияПротоколаОпроса", Отказ, НСтр("ru='Дата составления'"), , , Ложь);
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли