
#Область СлужебныйПрограммныйИнтерфейс

// Обработчик события "ОбработкаОповещения" форм,
//   в которых присутствует клиентская процедура "Подключаемый_ОбновитьЭлементыПособийНаКлиенте",
//   из которой в серверном контексте формы производится
//   вызов процедуры "УчетПособийСоциальногоСтрахованияРасширенный.ОбновитьФорму".
//
// Параметры:
//   Форма      - ФормаКлиентскогоПриложения - Форма, в которой сработало событие.
//   ИмяСобытия - Строка       - См. описание одноименного параметра в синтакс-помощнике
//                               "ФормаКлиентскогоПриложения.ОбработкаОповещения".
//   Параметр   - Произвольный - См. описание одноименного параметра в синтакс-помощнике
//                               "ФормаКлиентскогоПриложения.ОбработкаОповещения".
//   Источник   - Произвольный - См. описание одноименного параметра в синтакс-помощнике
//                               "ФормаКлиентскогоПриложения.ОбработкаОповещения".
//
Процедура ОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник) Экспорт
	Если СЭДОФССКлиент.ТребуетсяОбновитьНапоминаниеОбОтключенииПодпискиНаЭЛН(ИмяСобытия) Тогда
		Форма.ОтключитьОбработчикОжидания("Подключаемый_ОбновитьЭлементыПособийНаКлиенте");
		Форма.ПодключитьОбработчикОжидания("Подключаемый_ОбновитьЭлементыПособийНаКлиенте", 0.2, Истина);
	КонецЕсли;
КонецПроцедуры

// Обработчик процедуры "Подключаемый_ЭлементыПособийОбработкаНавигационнойСсылки" форм,
//   в которых присутствует вызов процедуры "УчетПособийСоциальногоСтрахованияРасширенный.ОбновитьФорму"
//   с параметрами "Сотрудники" и "ДатаУвольнения".
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - Форма, в которой сработало событие.
//   Элемент              - Произвольный - Стандартный параметр №1 обработчика события "ОбработкаНавигационнойСсылки".
//   Адрес                - Произвольный - Стандартный параметр №2 обработчика события "ОбработкаНавигационнойСсылки".
//   СтандартнаяОбработка - Произвольный - Стандартный параметр №3 обработчика события "ОбработкаНавигационнойСсылки".
//   Сотрудники           - СправочникСсылка.Сотрудники, Массив из СправочникСсылка.Сотрудники
//
Процедура ОбработкаНавигационнойСсылки(Форма, Элемент, Адрес, СтандартнаяОбработка, Сотрудники) Экспорт
	СтандартнаяОбработка = Ложь;
	СЭДОФССКлиент.ОтключитьПодписку(Сотрудники);
КонецПроцедуры

#КонецОбласти
