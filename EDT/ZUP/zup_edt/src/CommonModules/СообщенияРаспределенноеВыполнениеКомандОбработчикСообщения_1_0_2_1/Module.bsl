////////////////////////////////////////////////////////////////////////////////
// СообщенияРаспределенноеВыполнениеКомандОбработчикСообщения_1_0_1_1: 
// обработка сообщений подсистемы РаспределенноеВыполнениеКоманд.
////////////////////////////////////////////////////////////////////////////////

// Экспортные процедуры и функции для вызова из других подсистем
// 
#Область ПрограммныйИнтерфейс

// Возвращает номер текущей версии программного интерфейса.
//
// Возвращаемое значение:
//   Строка   - Номер версии интерфейса
//
Функция Версия() Экспорт

	Возврат "1.0.2.1";

КонецФункции // Версия() 

// Возвращает пространство имен текущей (используемой вызывающим кодом) версии интерфейса сообщений.
//
// Возвращаемое значение:
//   Строка   - Пространство имен интерфейса
//
Функция Пакет() Экспорт

	Возврат Метаданные.ПакетыXDTO.RemoteProcedureCall_v2.ПространствоИмен;

КонецФункции // Пакет() 

// Возвращает название программного интерфейса сообщений.
//
// Возвращаемое значение:
//   Строка   - Имя интерфейса
//
Функция ПрограммныйИнтерфейс() Экспорт

	Возврат "RemoteProcedureCall";

КонецФункции // ПрограммныйИнтерфейс() 

// Возвращает базовый тип для сообщений версии.
//
Функция БазовыйТип() Экспорт
	
	Возврат СообщенияВМоделиСервисаПовтИсп.ТипТело();
	
КонецФункции // БазовыйТип()

// Выполняет обработку входящих сообщений модели сервиса.
//
// Параметры:
//  Сообщение - ОбъектXDTO - входящее сообщение
//  Отправитель - ПланОбменаСсылка.ОбменСообщениями - узел плана обмена, соответствующий отправителю сообщения.
//  СообщениеОбработано - Булево - флаг успешной обработки сообщения. Значение данного параметра необходимо
//    установить равным Истина в том случае, если сообщение было успешно прочитано в данном обработчике.
//
Процедура ОбработатьСообщениеМоделиСервиса(Сообщение, Отправитель, СообщениеОбработано) Экспорт
	
	ТипСообщения = Сообщение.Body.Тип();
	ТипПрямойВызов = СообщенияРаспределенноеВыполнениеКомандИнтерфейс.ТипПрямойВызов();
	ТипЗапросПередачиФайла = СообщенияРаспределенноеВыполнениеКомандИнтерфейс.ТипПередачаФайлаЗапрос();
	ТипОтветПередачиФайла = СообщенияРаспределенноеВыполнениеКомандИнтерфейс.ТипПередачаФайлаОтвет();
	
	Если ТипСообщения = ТипПрямойВызов Тогда
		СообщениеОбработано = СообщенияРаспределенноеВыполнениеКомандРеализация.ОтработатьПрямойВызов(Сообщение);
		
	ИначеЕсли ТипСообщения = ТипЗапросПередачиФайла Тогда
		СообщениеОбработано = СообщенияРаспределенноеВыполнениеКомандРеализация.ОтработатьПолучениеФайла(Сообщение);
		
	ИначеЕсли ТипСообщения = ТипОтветПередачиФайла Тогда
		СообщениеОбработано = СообщенияРаспределенноеВыполнениеКомандРеализация.ОтработатьКвитанциюПередачиФайла(Сообщение);
		
	Иначе
		Возврат;		
	КонецЕсли; 
		
КонецПроцедуры

#КонецОбласти  