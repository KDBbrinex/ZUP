#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

Процедура НастроитьВариантыОтчета(Настройки, НастройкиОтчета) Экспорт
	
	НастройкиОтчета.ОпределитьНастройкиФормы = Истина;
	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "СотрудникиНаИспытательномСроке");
	НастройкиВарианта.Описание = НСтр("ru = 'Сотрудники, находящиеся на испытательном сроке.'");
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли