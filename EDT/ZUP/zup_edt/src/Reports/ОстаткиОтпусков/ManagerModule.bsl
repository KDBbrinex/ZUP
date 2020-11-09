#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.ВариантыОтчетов

// См. ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов.
//
Процедура НастроитьВариантыОтчета(Настройки, НастройкиОтчета) Экспорт
	
	НастройкиОтчета.ОпределитьНастройкиФормы = Истина;
	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "ОстаткиОтпусковПоВидам");
	НастройкиВарианта.Описание =
		НСтр("ru = 'Сводная информация по остаткам отпусков сотрудников.
		|Выводится в разрезе видов отпусков.'");
	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "ОстаткиОтпусков");
	НастройкиВарианта.Описание =
		НСтр("ru = 'Информация об остатках отпусков сотрудников в разрезе рабочих лет.
		|В отчет так же выводится и информация о накопленных сотрудниками днях и часах отгулов.'");
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.ВариантыОтчетов

#КонецОбласти

#КонецОбласти

#КонецЕсли