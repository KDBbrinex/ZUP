////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИК ИНТЕРФЕЙСА СООБЩЕНИЙ УПРАВЛЕНИЯ ПРИЛОЖЕНИЯМИ
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Возвращает пространство имен текущей (используемой вызывающим кодом) версии интерфейса сообщений.
Функция Пакет() Экспорт
	
	Возврат "http://www.1c.ru/1cFresh/ManageApplication/Messages/1.0";
	
КонецФункции

// Возвращает текущую (используемую вызывающим кодом) версию интерфейса сообщений.
Функция Версия() Экспорт
	
	Возврат "1.0.0.1";
	
КонецФункции

// Возвращает название программного интерфейса сообщений.
Функция ПрограммныйИнтерфейс() Экспорт
	
	Возврат "ManageApplicationMessages";
	
КонецФункции

// Выполняет регистрацию обработчиков сообщений в качестве обработчиков каналов обмена сообщениями.
//
// Параметры:
//  МассивОбработчиков - Массив - массив обработчиков.
//
//@skip-warning Пустой метод
Процедура ОбработчикиКаналовСообщений(Знач МассивОбработчиков) Экспорт
	
КонецПроцедуры

// Выполняет регистрацию обработчиков трансляции сообщений.
//
// Параметры:
//  МассивОбработчиков - Массив - массив обработчиков.
//
//@skip-warning Пустой метод
Процедура ОбработчикиТрансляцииСообщений(Знач МассивОбработчиков) Экспорт
	
КонецПроцедуры

// Возвращает тип сообщения {http://www.1c.ru/1cFresh/ManageApplication/Messages/a.b.c.d}RevokeUserAccess.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипЗначенияXDTO, ТипОбъектаXDTO - тип сообщения.
//
Функция СообщениеАннулироватьДоступПользователя(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "RevokeUserAccess");
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция СоздатьТипСообщения(Знач ИспользуемыйПакет, Знач Тип)
	
	Если ИспользуемыйПакет = Неопределено Тогда
		ИспользуемыйПакет = Пакет();
	КонецЕсли;
	
	Возврат ФабрикаXDTO.Тип(ИспользуемыйПакет, Тип);
	
КонецФункции

#КонецОбласти
