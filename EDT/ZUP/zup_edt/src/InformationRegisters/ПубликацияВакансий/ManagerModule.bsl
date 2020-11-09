#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

Процедура ЗаполнитьАдресПубликацииЗаписи(ЗаписьОПубликации) Экспорт
	
	ИдентификаторВакансии = ЗаписьОПубликации.ИдентификаторВакансии;
	
	Если ЗаписьОПубликации.МестоПубликации = ИнтеграцияРекрутинговыхСайтовКлиентСервер.HeadHunter() Тогда
		ЗаписьОПубликации.АдресПубликации = ИнтеграцияРекрутинговыхСайтов.АдресВакансииHeadHunter(ИдентификаторВакансии);
	ИначеЕсли ЗаписьОПубликации.МестоПубликации = ИнтеграцияРекрутинговыхСайтовКлиентСервер.SuperJob() Тогда
		ЗаписьОПубликации.АдресПубликации = ИнтеграцияРекрутинговыхСайтов.АдресВакансииSuperJob(ИдентификаторВакансии);
	ИначеЕсли ЗаписьОПубликации.МестоПубликации = ИнтеграцияРекрутинговыхСайтовКлиентСервер.Rabota() Тогда
		ЗаписьОПубликации.АдресПубликации = ИнтеграцияРекрутинговыхСайтов.АдресВакансииRabota(ИдентификаторВакансии)
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли

