
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(ФизическоеЛицо)";
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область РегистрацияФизическихЛиц

Функция РеквизитГоловнаяОрганизация() Экспорт
	Возврат Метаданные.РегистрыСведений.ВременноПребывающиеПринятыеПоДолгосрочнымДоговорам.Измерения.ГоловнаяОрганизация.Имя;
КонецФункции

Функция РеквизитФизическоеЛицо() Экспорт
	Возврат Метаданные.РегистрыСведений.ВременноПребывающиеПринятыеПоДолгосрочнымДоговорам.Измерения.ФизическоеЛицо.Имя;
КонецФункции

#КонецОбласти

#КонецОбласти

#КонецЕсли
