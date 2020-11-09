///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

Процедура ОбновитьНастройки(УзелИнформационнойБазы, ВидНастройки, ЗначениеНастройки) Экспорт
	
	ОбновитьЗапись(УзелИнформационнойБазы, "Настройки", ВидНастройки, ЗначениеНастройки);
	
КонецПроцедуры

Процедура ОбновитьНастройкиКорреспондента(УзелИнформационнойБазы, ВидНастройки, ЗначениеНастройки) Экспорт
	
	ОбновитьЗапись(УзелИнформационнойБазы, "НастройкиКорреспондента", ВидНастройки, ЗначениеНастройки);
	
КонецПроцедуры

Функция ЗначениеНастройки(УзелИнформационнойБазы, ВидНастройки) Экспорт
	
	Результат = Неопределено;
	
	ПрочитатьЗапись(УзелИнформационнойБазы, "Настройки", ВидНастройки, Результат);
	
	Возврат Результат;
	
КонецФункции

Функция ЗначениеНастройкиКорреспондента(УзелИнформационнойБазы, ВидНастройки) Экспорт
	
	Результат = Неопределено;
	
	ПрочитатьЗапись(УзелИнформационнойБазы, "НастройкиКорреспондента", ВидНастройки, Результат);
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти
	
#Область СлужебныеПроцедурыИФункции

Процедура ОбновитьЗапись(УзелИнформационнойБазы, ИмяИзмерения, ВидНастройки, ЗначениеНастройки)
	
	Менеджер = СоздатьМенеджерЗаписи();
	Менеджер.УзелИнформационнойБазы = УзелИнформационнойБазы;
	
	Менеджер.Прочитать();
	
	НовыеНастройки = Новый Структура;
	
	Если Менеджер.Выбран() Тогда
		ТекущиеНастройки = Менеджер[ИмяИзмерения].Получить();
		
		Если ТипЗнч(ТекущиеНастройки) = Тип("ТаблицаЗначений") Тогда
			
			НовыеНастройки.Вставить("ПоддерживаемыеОбъекты", ТекущиеНастройки);
			
		ИначеЕсли ТипЗнч(ТекущиеНастройки) = Тип("Структура") Тогда
			
			Для Каждого ЭлементНастройки Из ТекущиеНастройки Цикл
				
				НовыеНастройки.Вставить(ЭлементНастройки.Ключ, ЭлементНастройки.Значение);
				
			КонецЦикла;
			
		КонецЕсли;
		
	КонецЕсли;
	
	НовыеНастройки.Вставить(ВидНастройки, ЗначениеНастройки);
	
	СтруктураЗаписи = Новый Структура;
	СтруктураЗаписи.Вставить("УзелИнформационнойБазы", УзелИнформационнойБазы);
	СтруктураЗаписи.Вставить(ИмяИзмерения, Новый ХранилищеЗначения(НовыеНастройки, Новый СжатиеДанных(9)));
	
	ОбменДаннымиСлужебный.ОбновитьЗаписьВРегистрСведений(СтруктураЗаписи, "НастройкиОбменаДаннымиXDTO");
	
КонецПроцедуры

Процедура ПрочитатьЗапись(УзелИнформационнойБазы, ИмяИзмерения, ВидНастройки, Результат)
	
	Менеджер = СоздатьМенеджерЗаписи();
	Менеджер.УзелИнформационнойБазы = УзелИнформационнойБазы;
	
	Менеджер.Прочитать();
	
	СтруктураНастройки = Новый Структура;
	
	Если Менеджер.Выбран() Тогда
		ТекущиеНастройки = Менеджер[ИмяИзмерения].Получить();
		
		Если ТипЗнч(ТекущиеНастройки) = Тип("ТаблицаЗначений") Тогда
			
			СтруктураНастройки.Вставить("ПоддерживаемыеОбъекты", ТекущиеНастройки);
			
		ИначеЕсли ТипЗнч(ТекущиеНастройки) = Тип("Структура") Тогда
			
			Для Каждого ЭлементНастройки Из ТекущиеНастройки Цикл
				
				СтруктураНастройки.Вставить(ЭлементНастройки.Ключ, ЭлементНастройки.Значение);
				
			КонецЦикла;
			
		КонецЕсли;
	КонецЕсли;
	
	СтруктураНастройки.Свойство(ВидНастройки, Результат);
	
КонецПроцедуры

#Область ОбработчикиОбновления

Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ДополнительныеПараметры = ОбновлениеИнформационнойБазы.ДополнительныеПараметрыОтметкиОбработки();
	ДополнительныеПараметры.ЭтоНезависимыйРегистрСведений = Истина;
	ДополнительныеПараметры.ПолноеИмяРегистра             = "РегистрСведений.НастройкиОбменаДаннымиXDTO";
	
	ПланыОбменаXDTO = Новый Массив;
	Для Каждого ПланОбмена Из ОбменДаннымиПовтИсп.ПланыОбменаБСП() Цикл
		Если Не ОбменДаннымиПовтИсп.ЭтоПланОбменаXDTO(ПланОбмена) Тогда
			Продолжить;
		КонецЕсли;
		ПланыОбменаXDTO.Добавить(ПланОбмена);
	КонецЦикла;
	
	Если ПланыОбменаXDTO.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыЗапроса = Новый Структура;
	ПараметрыЗапроса.Вставить("ПланыОбменаМассив",                 ПланыОбменаXDTO);
	ПараметрыЗапроса.Вставить("ДополнительныеСвойстваПланаОбмена", "");
	ПараметрыЗапроса.Вставить("РезультатВоВременнуюТаблицу",       Истина);
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	ЗапросУзлыОбмена = Новый Запрос(ОбменДаннымиСервер.ТекстЗапросаПланыОбменаДляМонитора(ПараметрыЗапроса, Ложь));
	ЗапросУзлыОбмена.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	ЗапросУзлыОбмена.Выполнить();
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	ПланыОбменаКонфигурации.УзелИнформационнойБазы КАК УзелИнформационнойБазы
	|ИЗ
	|	ПланыОбменаКонфигурации КАК ПланыОбменаКонфигурации
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.НастройкиОбменаДаннымиXDTO КАК НастройкиОбменаДаннымиXDTO
	|		ПО (НастройкиОбменаДаннымиXDTO.УзелИнформационнойБазы = ПланыОбменаКонфигурации.УзелИнформационнойБазы)
	|ГДЕ
	|	(НастройкиОбменаДаннымиXDTO.УзелИнформационнойБазы ЕСТЬ NULL
	|			ИЛИ НастройкиОбменаДаннымиXDTO.ИмяПланаОбменаКорреспондента = """")");
	
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	Результат = Запрос.Выполнить().Выгрузить();
	
	ОбновлениеИнформационнойБазы.ОтметитьКОбработке(Параметры, Результат, ДополнительныеПараметры);
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ОбработкаЗавершена = Истина;
	
	МетаданныеРегистра    = Метаданные.РегистрыСведений.НастройкиОбменаДаннымиXDTO;
	ПолноеИмяРегистра     = МетаданныеРегистра.ПолноеИмя();
	ПредставлениеРегистра = МетаданныеРегистра.Представление();
	ПредставлениеОтбора   = НСтр("ru = 'УзелИнформационнойБазы = ""%1""'");
	
	ДополнительныеПараметрыВыборкиДанныхДляОбработки = ОбновлениеИнформационнойБазы.ДополнительныеПараметрыВыборкиДанныхДляОбработки();
	
	Выборка = ОбновлениеИнформационнойБазы.ВыбратьИзмеренияНезависимогоРегистраСведенийДляОбработки(
		Параметры.Очередь, ПолноеИмяРегистра, ДополнительныеПараметрыВыборкиДанныхДляОбработки);
	
	Обработано = 0;
	Проблемных = 0;
	
	Пока Выборка.Следующий() Цикл
		
		Попытка
			
			ОбновитьНастройкиОбменаДаннымиXDTOКорреспондента(Выборка.УзелИнформационнойБазы);
			Обработано = Обработано + 1;
			
		Исключение
			
			Проблемных = Проблемных + 1;
			
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Не удалось обработать набор записей регистра ""%1"" с отбором %2 по причине:
				|%3'"), ПредставлениеРегистра, ПредставлениеОтбора, ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
				
			ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(), УровеньЖурналаРегистрации.Предупреждение,
				МетаданныеРегистра, , ТекстСообщения);
			
		КонецПопытки;
		
	КонецЦикла;
	
	Если Не ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(Параметры.Очередь, ПолноеИмяРегистра) Тогда
		ОбработкаЗавершена = Ложь;
	КонецЕсли;
	
	Если Обработано = 0 И Проблемных <> 0 Тогда
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Процедуре РегистрыСведений.НастройкиОбменаДаннымиXDTO.ОбработатьДанныеДляПереходаНаНовуюВерсию не удалось обработать некоторые записи узлов обмена (пропущены): %1'"), 
			Проблемных);
		ВызватьИсключение ТекстСообщения;
	Иначе
		ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(), УровеньЖурналаРегистрации.Информация,
			, ,
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Процедура РегистрыСведений.НастройкиОбменаДаннымиXDTO.ОбработатьДанныеДляПереходаНаНовуюВерсию обработала очередную порцию записей: %1'"),
			Обработано));
	КонецЕсли;
	
	Параметры.ОбработкаЗавершена = ОбработкаЗавершена;
	
КонецПроцедуры

Процедура ОбновитьНастройкиОбменаДаннымиXDTOКорреспондента(УзелИнформационнойБазы) Экспорт
	
	НачатьТранзакцию();
	Попытка
		
		Блокировка = Новый БлокировкаДанных;
		
		ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.НастройкиОбменаДаннымиXDTO");
		ЭлементБлокировки.УстановитьЗначение("УзелИнформационнойБазы", УзелИнформационнойБазы);
		
		Блокировка.Заблокировать();
		
		НаборЗаписей = СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.УзелИнформационнойБазы.Установить(УзелИнформационнойБазы);
		
		НаборЗаписей.Прочитать();
		
		Если НаборЗаписей.Количество() > 0 Тогда
			ТекущаяЗапись = НаборЗаписей[0];
		Иначе
			ТекущаяЗапись = НаборЗаписей.Добавить();
			ТекущаяЗапись.УзелИнформационнойБазы = УзелИнформационнойБазы;
		КонецЕсли;
		
		ТекущаяЗапись.ИмяПланаОбменаКорреспондента = ОбменДаннымиПовтИсп.ПолучитьИмяПланаОбмена(УзелИнформационнойБазы);
		
		ОбновлениеИнформационнойБазы.ЗаписатьНаборЗаписей(НаборЗаписей);
		
		ЗафиксироватьТранзакцию();
		
	Исключение
		
		ОтменитьТранзакцию();
		ВызватьИсключение;
		
	КонецПопытки;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли