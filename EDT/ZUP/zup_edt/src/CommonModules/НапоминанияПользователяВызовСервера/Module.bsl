///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Выполняет запрос по напоминаниям для текущего пользователя на момент времени ТекущаяДатаСеанса() + 30минут.
// Момент времени смещен от текущего для использования функции из модуля с повторным использованием
// возвращаемых значений.
// При обработке результата выполнения функции необходимо учитывать эту особенность.
//
// Возвращаемое значение:
//   см. НапоминанияПользователяСлужебный.СписокТекущихНапоминанийПользователя
//
Функция ПолучитьНапоминанияТекущегоПользователя() Экспорт
	
	Возврат НапоминанияПользователяСлужебный.СписокТекущихНапоминанийПользователя();
	
КонецФункции

// Создает новое напоминание на время, рассчитанное относительно времени в предмете.
Функция ПодключитьНапоминаниеДоВремениПредмета(Текст, Интервал, Предмет, ИмяРеквизита, ПовторятьЕжегодно = Ложь) Экспорт
	
	Возврат НапоминанияПользователяСлужебный.ПодключитьНапоминаниеДоВремениПредмета(
		Текст, Интервал, Предмет, ИмяРеквизита, ПовторятьЕжегодно);
	
КонецФункции

Функция ПодключитьНапоминание(Текст, ВремяСобытия, ИнтервалДоСобытия = 0, Предмет = Неопределено, Идентификатор = Неопределено) Экспорт
	
	Возврат НапоминанияПользователяСлужебный.ПодключитьПроизвольноеНапоминание(
		Текст, ВремяСобытия, ИнтервалДоСобытия, Предмет, Идентификатор);
	
КонецФункции

#КонецОбласти
