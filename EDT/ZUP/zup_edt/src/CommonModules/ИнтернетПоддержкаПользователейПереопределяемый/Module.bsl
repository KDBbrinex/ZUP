///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Подсистема "Интернет-поддержка пользователей".
// ОбщийМодуль.ИнтернетПоддержкаПользователейПереопределяемый.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#Область ОбщегоНазначения

// В процедуре заполняется код языка интерфейса конфигурации (Метаданные.Языки),
// который передается сервисам Интернет-поддержки.
// Код языка заполняется в формате ISO-639-1.
// Если коды языков интерфейса конфигурации определены в формате ISO-639-1,
// тогда тело метода заполнять не нужно.
//
// Параметры:
//	КодЯзыка - Строка - в параметре передается код языка, указанный в
//		Метаданные.Языки;
//	КодЯзыкаВФорматеISO639_1 - Строка - в параметре возвращается
//		код языка в формате ISO-639-1.
//
// Пример:
//	Если КодЯзыка = "rus" Тогда
//		КодЯзыкаВФорматеISO639_1 = "ru";
//	ИначеЕсли КодЯзыка = "english" Тогда
//		КодЯзыкаВФорматеISO639_1 = "en";
//	КонецЕсли;
//
//@skip-warning
Процедура ПриОпределенииКодаЯзыкаИнтерфейсаКонфигурации(КодЯзыка, КодЯзыкаВФорматеISO639_1) Экспорт
	
	
	
КонецПроцедуры

// В процедуре необходимо указать номер версии программы, который будет
//  передаваться в сервисы Интернет-поддержки пользователей. Если номер версии
// не указан, информация будет получена из свойств метаданных конфигурации.
//
// Параметры:
//  ВерсияПрограммы - Строка - номер версии программы.
//
// Пример:
//	КомпонентыВерсии = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ВерсияПрограммы, "/");
//	Если ВерсияПрограммы.Количество() > 0 Тогда
//		ВерсияПрограммы = КомпонентыВерсии[0];
//	КонецЕсли;
//
//@skip-warning
Процедура ПриОпределенииНомераВерсииПрограммы(ВерсияПрограммы) Экспорт
	
	
	
КонецПроцедуры

#КонецОбласти

#Область ОбработкаСобытийБиблиотеки

// Реализует обработку события сохранения в информационной базе данных
// аутентификации пользователя Интернет-поддержки - логина и пароля
// для подключения к сервисам Интернет-поддержки.
//
// Параметры:
//  ДанныеПользователя - Структура, Неопределено - структура с полями. Если в метод передано значение
//                       Неопределено, данные аутентификации были удалены.
//    * Логин - Строка - логин пользователя;
//    * Пароль - Строка - пароль пользователя;
//
//@skip-warning
Процедура ПриИзмененииДанныхАутентификацииИнтернетПоддержки(ДанныеПользователя) Экспорт
	
	
	
КонецПроцедуры

#КонецОбласти

#Область УстаревшиеПроцедурыИФункции

// Устарела. Следует использовать ПодключениеСервисовСопровожденияПереопределяемый.ПриОпределенииСервисовСопровождения.
// Определяет список модулей библиотек и конфигурации, которые предоставляют
// основные сведения о сервисах: идентификатор, наименование, описание и картинка.
// Модуль должен обязательно содержать процедуру ПриДобавленииОписанийСервисовСопровождения. Пример см.
// процедуру СПАРКРиски.ПриДобавленииОписанийСервисовСопровождения.
//
// Параметры:
//  МодулиСервисов - Массив из Строка - имена серверных общих модулей библиотек и конфигурации.
//
// Пример:
//  МодулиСервисов.Добавить("СПАРКРиски");
//  МодулиСервисов.Добавить("РаботаСКонтрагентами");
//
//@skip-warning
Процедура ПриОпределенииСервисовСопровождения(МодулиСервисов) Экспорт
	
	
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
