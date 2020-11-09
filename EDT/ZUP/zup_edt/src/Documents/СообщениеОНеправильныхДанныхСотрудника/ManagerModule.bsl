#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	// Ограничения доступа в ролях:
	// Чтение / Изменение
	// #ПоЗначениямРасширенный( "Документ.ЗаявкаНаЕдиновременнуюКомпенсацию", "", "",
	// "ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Пользователи КАК Т1 ПО Т1.ФизическоеЛицо = Т.ФизическоеЛицо",
	// "",
	// "ГруппыФизическихЛиц", "Т.ФизическоеЛицо","ИЛИ",
	// "Условие", "Т1.Ссылка = &АвторизованныйПользователь", "", "","","", "","","", "","","", "","","", "","","",
	// "","","", "","","", "","","", "","","", "","","", "","","", "","","", "","","", "","","")
	Ограничение.Текст =
	"ПрисоединитьДополнительныеТаблицы
	|ЭтотСписок КАК Т
	|
	|ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Пользователи КАК Т1
	|	ПО Т1.ФизическоеЛицо = Т.ФизическоеЛицо
	|;
	|РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Т.ФизическоеЛицо)
	|	ИЛИ ЭтоАвторизованныйПользователь(Т1.Ссылка)";
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает описание состава документа
//
// Возвращаемое значение:
//  Структура - см. ЗарплатаКадрыСоставДокументов.НовоеОписаниеСоставаОбъекта.
Функция ОписаниеСоставаОбъекта() Экспорт
	Возврат ЗарплатаКадрыСоставДокументов.ОписаниеСоставаОбъектаФизическоеЛицоВШапке("ФизическоеЛицо", "");
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Печать

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли