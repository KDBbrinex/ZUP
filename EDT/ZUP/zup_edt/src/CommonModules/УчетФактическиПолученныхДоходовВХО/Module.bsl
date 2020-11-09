
#Область СлужебныйПрограммныйИнтерфейс

#Область Свойства

// См. УправлениеСвойствамиПереопределяемый.ПриПолученииПредопределенныхНаборовСвойств.
Процедура ПриПолученииПредопределенныхНаборовСвойств(Наборы) Экспорт
	
	УправлениеСвойствамиБЗК.ЗарегистрироватьНаборСвойств(Наборы, "d42dbfd7-9802-11e9-80cd-4cedfb43b11a", Метаданные.Документы.ПодтверждениеВыплатыДоходов);
	
КонецПроцедуры

#КонецОбласти

#Область УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииСписковСОграничениемДоступа(Списки) Экспорт
	
	Списки.Вставить(Метаданные.Документы.ПодтверждениеВыплатыДоходов, Истина);
	Списки.Вставить(Метаданные.Справочники.ПодтверждениеВыплатыДоходовПрисоединенныеФайлы, Истина);
	Списки.Вставить(Метаданные.РегистрыСведений.ДатыВыплатыДоходов, Истина);
	
КонецПроцедуры

#КонецОбласти

#Область НастройкаПодсистемыПечать

// Определяет объекты, в которых есть процедура ДобавитьКомандыПечати().
// Подробнее см. УправлениеПечатьюПереопределяемый.
//
// Параметры:
//  СписокОбъектов - Массив - список менеджеров объектов.
//
Процедура ПриОпределенииОбъектовСКомандамиПечати(СписокОбъектов) Экспорт
	
	СписокОбъектов.Добавить(Документы.ПодтверждениеВыплатыДоходов);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПроверитьНаличиеПодтвержденияОплатыОбработчик(Источник, Отказ) Экспорт
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(Источник) Тогда
		Возврат;
	КонецЕсли;
	
	Если РегистрыСведений.ДатыВыплатыДоходов.ЕстьПоВедомости(Источник.Ссылка) Тогда
		СообщениеОбОшибке = 
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='По ведомости номер %1 от %2 зарегистрировано подтверждение выплаты доходов, изменения запрещены'"), 
				Источник.Номер, 
				Формат(Источник.Дата, "ДЛФ=D"));
		ОбщегоНазначения.СообщитьПользователю(СообщениеОбОшибке, Источник);
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
