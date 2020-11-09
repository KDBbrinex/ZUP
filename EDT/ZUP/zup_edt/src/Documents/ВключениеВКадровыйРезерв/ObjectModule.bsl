#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроведения(Отказ, Режим)
	
	ПроведениеСервер.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);
	ДанныеДляПроведения = Документы.ВключениеВКадровыйРезерв.ПолучитьДанныеДляПроведения(Ссылка);
	КадровыйРезерв.СформироватьДвиженияИсторииКадровогоРезерва(Движения, ДанныеДляПроведения, "ДвиженияИсторииКадровогоРезерва");
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	ЗарплатаКадры.ПроверитьКорректностьДаты(Ссылка, ДатаРассмотрения, "Объект.ДатаРассмотрения", Отказ,
		НСтр("ru='Дата рассмотрения'"));
	
	МассивНепроверяемыхРеквизитов = Новый Массив();
	
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьКадровыйРезервПоВидам") Тогда
		МассивНепроверяемыхРеквизитов.Добавить("ВидРезерва");
	КонецЕсли;
		
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты,МассивНепроверяемыхРеквизитов);
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	ДатаРассмотрения = НачалоДня(ДатаРассмотрения) + КадровыйРезерв.ЗначениеВремениПоСтатусуРезерва(ПредопределенноеЗначение("Перечисление.СостоянияСогласования.Согласовано"));
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли