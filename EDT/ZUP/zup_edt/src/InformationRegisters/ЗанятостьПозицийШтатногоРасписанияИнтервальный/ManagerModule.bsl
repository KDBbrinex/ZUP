
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	Ограничение.Текст =
	"ПрисоединитьДополнительныеТаблицы
	|ЭтотСписок КАК Т
	|ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПодчиненностьПодразделенийОрганизаций КАК Т2 
	|	ПО Т2.Подразделение = Т.ПозицияШтатногоРасписания.Подразделение
	|;
	|РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Т2.ВышестоящееПодразделение)
	|	И ЗначениеРазрешено(Т.ПозицияШтатногоРасписания.Владелец)";
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область ОбменДанными

// Пересчитывает зависимые данные после загрузки сообщения обмена
//
// Параметры:
//		ЗависимыеДанные - ТаблицаЗначений:
//			* ВедущиеМетаданные - ОбъектМетаданных - Метаданные ведущих данных
//			* ЗависимыеМетаданные - ОбъектМетаданных - Метаданные текущего объекта
//			* ВедущиеДанные - Массив объектов, заполненный при загрузке сообщения обмена
//				по этим объектам требуется обновить зависимые данные
//
Процедура ОбновитьЗависимыеДанныеПослеЗагрузкиОбменаДанными(ЗависимыеДанные) Экспорт
	
	ЗарплатаКадрыПериодическиеРегистры.ОбновитьИнтервальныйРегистрПослеЗагрузкиПервичныхДанных(
		Метаданные.РегистрыСведений.ЗанятостьПозицийШтатногоРасписания.Имя, ЗависимыеДанные);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли
