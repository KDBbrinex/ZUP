///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

////////////////////////////////////////////////////////////////////////////////
// Обработчики событий подсистем конфигурации.

// Параметры:
//  Обработчики - см. ОбновлениеИнформационнойБазы.НоваяТаблицаОбработчиковОбновления
//
Процедура ПриДобавленииОбработчиковОбновления(Обработчики) Экспорт
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "2.4.1.1";
	Обработчик.НачальноеЗаполнение = Истина;
	Обработчик.Процедура = "УдалениеПомеченныхОбъектовСлужебный.ВключитьУдалениеПомеченныхОбъектов";
	Обработчик.РежимВыполнения = "Оперативно";
	
КонецПроцедуры

// Обработчик обновления на версию 2.4.1.1.
//
Процедура ВключитьУдалениеПомеченныхОбъектов() Экспорт
	
	Константы.ИспользоватьУдалениеПомеченныхОбъектов.Установить(Истина);
	
КонецПроцедуры

// Параметры:
//  ШаблоныЗаданий - см. ОчередьЗаданийПереопределяемый.ПриПолученииСпискаШаблонов.ШаблоныЗаданий
//
Процедура ПриПолученииСпискаШаблонов(ШаблоныЗаданий) Экспорт
	
	ШаблоныЗаданий.Добавить("УдалениеПомеченных");
	
КонецПроцедуры

// Параметры:
//  Зависимости - см. РегламентныеЗаданияПереопределяемый.ПриОпределенииНастроекРегламентныхЗаданий.Настройки
//
Процедура ПриОпределенииНастроекРегламентныхЗаданий(Зависимости) Экспорт
	
	Зависимость = Зависимости.Добавить();
	Зависимость.РегламентноеЗадание = Метаданные.РегламентныеЗадания.УдалениеПомеченных;
	Зависимость.ФункциональнаяОпция = Метаданные.ФункциональныеОпции.ИспользоватьУдалениеПомеченныхОбъектов;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Точка входа регламентного задания.
//
Процедура УдалениеПомеченныхПоРасписанию() Экспорт
	
	ОбщегоНазначения.ПриНачалеВыполненияРегламентногоЗадания(Метаданные.РегламентныеЗадания.УдалениеПомеченных);
	
	Обработки.УдалениеПомеченныхОбъектов.УдалитьПомеченныеОбъектыИзРегламентногоЗадания();
	
КонецПроцедуры

#КонецОбласти