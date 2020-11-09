#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

Процедура НастроитьВариантыОтчета(Настройки, НастройкиОтчета) Экспорт
	
	НастройкиОтчета.ОпределитьНастройкиФормы = Истина;

	// По всем вопросам	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "СтатистикаОтветовНаВопросы");
	НастройкиВарианта.Описание = НСтр("ru = 'Сводная статистика ответов по всем тестовым вопросам.'");
	НастройкиВарианта.Включен = Ложь;	
	НастройкиВарианта.ВидимостьПоУмолчанию = Ложь;
	НастройкиВарианта.ФункциональныеОпции.Добавить("ИспользоватьЭлектронноеОбучение");
	
	// По темам вопросов	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "СтатистикаОтветовНаВопросыПоРубрикам");
	НастройкиВарианта.Включен = Ложь;
	НастройкиВарианта.ВидимостьПоУмолчанию = Ложь;
	НастройкиВарианта.ФункциональныеОпции.Добавить("ИспользоватьЭлектронноеОбучение");
	
	// По электронным курсам	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "СтатистикаОтветовНаВопросыПоЭлектроннымКурсам");
	НастройкиВарианта.Описание = НСтр("ru = 'Статистика ответов по тестовым вопросам электронных курсов.'");
	НастройкиВарианта.Включен = Ложь;	
	НастройкиВарианта.ВидимостьПоУмолчанию = Ложь;
	НастройкиВарианта.ФункциональныеОпции.Добавить("ИспользоватьЭлектронноеОбучение");
	
	// По учащимся	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "СтатистикаОтветовНаВопросыПоУчащимся");
	НастройкиВарианта.Описание = НСтр("ru = 'Статистика ответов учащихся на тестовые вопросы.'");
	НастройкиВарианта.Включен = Ложь;	
	НастройкиВарианта.ВидимостьПоУмолчанию = Ложь;
	НастройкиВарианта.ФункциональныеОпции.Добавить("ИспользоватьЭлектронноеОбучение");
	
	// По годам	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "СтатистикаОтветовНаВопросыПоГодам");
	НастройкиВарианта.Описание = НСтр("ru = 'Статистика ответов на тестовые вопросы по годам.'");
	НастройкиВарианта.ВидимостьПоУмолчанию = Ложь;
	НастройкиВарианта.ФункциональныеОпции.Добавить("ИспользоватьЭлектронноеОбучение");
	
	// По месяцам 	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "СтатистикаОтветовНаВопросыПоМесяцам");
	НастройкиВарианта.Описание = НСтр("ru = 'Статистика ответов на тестовые вопросы по месяцам.'");
	НастройкиВарианта.ВидимостьПоУмолчанию = Ложь;
	НастройкиВарианта.ФункциональныеОпции.Добавить("ИспользоватьЭлектронноеОбучение");
	
	// Выбранные варианты ответов	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "СтатистикаВыбораВариантовОтветов");
	НастройкиВарианта.Описание = НСтр("ru = 'Статистика выбора вариантов ответов в тестовых вопросах.'");
	НастройкиВарианта.ФункциональныеОпции.Добавить("ИспользоватьЭлектронноеОбучение");
	
	// Открытые вопросы	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "СтатистикаОтветовНаОткрытыеВопросы");
	НастройкиВарианта.Включен = Ложь;	
	НастройкиВарианта.ВидимостьПоУмолчанию = Ложь;
	НастройкиВарианта.ФункциональныеОпции.Добавить("ИспользоватьЭлектронноеОбучение");
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли