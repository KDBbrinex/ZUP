#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

Функция НормативныйДокумент(Значение) Экспорт
	
	Если Значение = ФЗ79 Тогда
		
		Возврат НСтр("ru = 'Федеральный закон от 27.07.2004 № 79-ФЗ ""О государственной гражданской службе Российской Федерации""'");
		
	ИначеЕсли Значение = ЗРФ31321 Тогда
		
		Возврат НСтр("ru = 'Закон РФ от 26.06.1992 № 3132-1 ""О статусе судей в Российской Федерации""'");
		
	ИначеЕсли Значение = ФЗ25 Тогда
		
		Возврат НСтр("ru = 'Федеральный закон от 02.03.2007 N 25-ФЗ ""О муниципальной службе в Российской Федерации""'");
		
	ИначеЕсли Значение = ФЗ41 Тогда
		
		Возврат НСтр("ru = 'Федеральный закон от 08.05.1996 N 41-ФЗ ""О производственных кооперативах""'");
		
	ИначеЕсли Значение = ФЗ328 Тогда
		
		Возврат НСтр("ru = 'Федеральный закон от 01.10.2019 N 328-ФЗ ""О службе в органах принудительного исполнения Российской Федерации и внесении изменений в отдельные законодательные акты Российской Федерации""'");
		
	ИначеЕсли Значение = ФЗ342 Тогда
		
		Возврат НСтр("ru = 'Федеральный закон от 30.11.2011 N 342-ФЗ ""О службе в органах внутренних дел Российской Федерации и внесении изменений в отдельные законодательные акты Российской Федерации""'");
		
	ИначеЕсли Значение = ФЗ113 Тогда
		
		Возврат НСтр("ru = 'Федеральный закон от 25.07.2002 № 113-ФЗ ""Об альтернативной гражданской службе""'");
		
	ИначеЕсли Значение = УИКРФ Тогда
		
		Возврат НСтр("ru = 'Уголовно-исполнительный кодекс Российской Федерации'");
		
	КонецЕсли;
	
	Возврат НСтр("ru = 'Трудовой кодекс Российской Федерации'");
	
КонецФункции

Функция НормативныйДокументВРодительномПадеже(Значение) Экспорт
	
	Если Значение = ФЗ79 Тогда
		
		Возврат НСтр("ru = 'Федерального закона от 27.07.2004 № 79-ФЗ ""О государственной гражданской службе Российской Федерации""'");
		
	ИначеЕсли Значение = ЗРФ31321 Тогда
		
		Возврат НСтр("ru = 'Закона РФ от 26.06.1992 № 3132-1 ""О статусе судей в Российской Федерации""'");
		
	ИначеЕсли Значение = ФЗ25 Тогда
		
		Возврат НСтр("ru = 'Федерального закона от 02.03.2007 N 25-ФЗ ""О муниципальной службе в Российской Федерации""'");
		
	ИначеЕсли Значение = ФЗ41 Тогда
		
		Возврат НСтр("ru = 'Федерального закона от 08.05.1996 N 41-ФЗ ""О производственных кооперативах""'");
		
	ИначеЕсли Значение = ФЗ328 Тогда
		
		Возврат НСтр("ru = 'Федерального закона от 01.10.2019 N 328-ФЗ ""О службе в органах принудительного исполнения Российской Федерации и внесении изменений в отдельные законодательные акты Российской Федерации""'");
		
	ИначеЕсли Значение = ФЗ342 Тогда
		
		Возврат НСтр("ru = 'Федерального закона от 30.11.2011 N 342-ФЗ ""О службе в органах внутренних дел Российской Федерации и внесении изменений в отдельные законодательные акты Российской Федерации""'");
		
	ИначеЕсли Значение = ФЗ113 Тогда
		
		Возврат НСтр("ru = 'Федерального закона от 25.07.2002 № 113-ФЗ ""Об альтернативной гражданской службе""'");
		
	ИначеЕсли Значение = УИКРФ Тогда
		
		Возврат НСтр("ru = 'Уголовно-исполнительного кодекса Российской Федерации'");
		
	КонецЕсли;
	
	Возврат НСтр("ru = 'Трудового кодекса Российской Федерации'");
	
КонецФункции

#КонецОбласти

#КонецЕсли