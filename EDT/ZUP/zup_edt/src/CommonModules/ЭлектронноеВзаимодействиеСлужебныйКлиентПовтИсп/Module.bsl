////////////////////////////////////////////////////////////////////////////////
// ЭлектронноеВзаимодействиеСлужебныйКлиентПовтИсп: общий механизм обмена электронными документами.
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает текст сообщения пользователю о необходимости  настройки системы.
//
// Параметры:
//  ВидОперации - Строка - признак выполняемой операции.
//
// Возвращаемое значение:
//  ТекстСообщения - Строка - Строка сообщения.
//
Функция ТекстСообщенияОНеобходимостиНастройкиСистемы(ВидОперации) Экспорт
	
	Возврат ЭлектронноеВзаимодействиеСлужебныйВызовСервера.ТекстСообщенияОНеобходимостиНастройкиСистемы(ВидОперации);
	
КонецФункции

// Возвращает имя прикладного справочника по имени библиотечного справочника.
//
// Параметры:
//  ИмяСправочника - строка - название справочника из библиотеки.
//
// Возвращаемое значение:
//  ИмяПрикладногоСправочника - строковое имя прикладного справочника.
//
Функция ИмяПрикладногоСправочника(ИмяСправочника) Экспорт
	
	Возврат ЭлектронноеВзаимодействиеСлужебныйВызовСервера.ИмяПрикладногоСправочника(ИмяСправочника);
	
КонецФункции

Функция ЗначениеФункциональнойОпции(НаименованиеФО) Экспорт
	Возврат ЭлектронноеВзаимодействиеСлужебныйВызовСервера.ЗначениеФункциональнойОпции(НаименованиеФО);
КонецФункции

#КонецОбласти